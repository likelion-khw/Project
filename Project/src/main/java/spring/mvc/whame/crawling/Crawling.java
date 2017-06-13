package spring.mvc.whame.crawling;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.impl.client.HttpClientBuilder;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Component;

@Component
public class Crawling {

	public String[] run(String address, String store_name) throws ClientProtocolException, IOException {
		String[] temp = store_name.split("\\(")[0].split(" ");
		
		String store ="";
		
		for(String t: temp){
			store += t+"%20";
		}
		
		store += "+\"" + store + "\"";
		
	    Document doc2 = Jsoup.connect("https://search.naver.com/search.naver?where=post&sm=tab_pge&query="+address+"%20"+store+"&st=sim&date_option=0&date_from=&date_to=&dup_remove=1&post_blogurl=&post_blogurl_without=&srchby=all&nso=&ie=utf8&start=1").get();
	    Document doc3 = Jsoup.connect("https://search.naver.com/search.naver?where=post&sm=tab_pge&query="+address+"%20"+store+"&st=sim&date_option=0&date_from=&date_to=&dup_remove=1&post_blogurl=&post_blogurl_without=&srchby=all&nso=&ie=utf8&start=11").get();
	    Elements el = doc2.select("div.blog ul.type01");
	    Elements el1 = doc3.select("div.blog ul.type01");
	    
	    String result[] = new String[2];
	    
	    if(el.html().split("</li>").length == 10)
	    {
	    result[0] = el.html();
	    result[1] = el1.html();
	    }else{
	    	result[0] = el.html();
	 	    result[1] = "";
	    }
	    return result;

	}

}


