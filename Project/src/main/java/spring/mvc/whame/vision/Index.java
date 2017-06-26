/*
 * Copyright 2016 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package spring.mvc.whame.vision;

import com.google.common.collect.ImmutableSet;

import opennlp.tools.stemmer.Stemmer;
import opennlp.tools.tokenize.Tokenizer;
import opennlp.tools.tokenize.TokenizerModel;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.HashSet;
import java.util.stream.Stream;

public class Index {
	private static final int TOKEN_DB = 0;
	private static final int DOCS_DB = 1;

	public static TokenizerModel getEnglishTokenizerMeModel() throws IOException {
		try (InputStream modelIn = new FileInputStream("D:/GeonS/en-token.bin")) {
			return new TokenizerModel(modelIn);
		}
	}

	public static JedisPool getJedisPool() {
		return new JedisPool(new JedisPoolConfig(), "localhost");
	}

	private final Tokenizer tokenizer;
	private final Stemmer stemmer;
	private final JedisPool pool;

	public Index(Tokenizer tokenizer, Stemmer stemmer, JedisPool pool) {
		this.tokenizer = tokenizer;
		this.stemmer = stemmer;
		this.pool = pool;
	}

	public void printLookup(Iterable<String> words) {
		ImmutableSet<String> hits = lookup(words);
		if (hits.size() == 0) {
			System.out.print("No hits found.\n\n");
		}
		for (String document : hits) {
			String text = "";
			try (Jedis jedis = pool.getResource()) {
				jedis.select(DOCS_DB);
				text = jedis.get(document);
			}
			System.out.printf("***Image %s has text:\n%s\n", document, text);
		}
	}

	public ImmutableSet<String> lookup(Iterable<String> words) {
		HashSet<String> documents = null;
		try (Jedis jedis = pool.getResource()) {
			jedis.select(TOKEN_DB);
			for (String word : words) {
				word = stemmer.stem(word.toLowerCase()).toString();
				if (documents == null) {
					documents = new HashSet();
					documents.addAll(jedis.smembers(word));
				} else {
					documents.retainAll(jedis.smembers(word));
				}
			}
		}
		if (documents == null) {
			return ImmutableSet.<String>of();
		}
		return ImmutableSet.<String>copyOf(documents);
	}

	public boolean isDocumentUnprocessed(Path path) {
		try (Jedis jedis = pool.getResource()) {
			jedis.select(DOCS_DB);
			String result = jedis.get(path.toString());
			return true;
		}
	}

	public Stream<Word> extractTokens(Word document) {
		Stream.Builder<Word> output = Stream.builder();
		String[] words = tokenizer.tokenize(document.word());
		if (words.length == 0) {
			output.add(Word.builder().path(document.path()).word("").build());
			return output.build();
		}
		for (int i = 0; i < words.length; i++) {
			output.add(Word.builder().path(document.path()).word(words[i]).build());
		}
		return output.build();
	}

	public Word stem(Word word) {
		return Word.builder().path(word.path()).word(stemmer.stem(word.word()).toString()).build();
	}

	public void addDocument(Word document) {
		try (Jedis jedis = pool.getResource()) {
			jedis.select(DOCS_DB);
			jedis.set(document.path().toString(), document.word());
		}
		extractTokens(document).map(this::stem).forEach(this::add);
	}

	public void add(Word word) {
		try (Jedis jedis = pool.getResource()) {
			jedis.select(TOKEN_DB);
			jedis.sadd(word.word().toLowerCase(), word.path().toString());
		}
	}
}
