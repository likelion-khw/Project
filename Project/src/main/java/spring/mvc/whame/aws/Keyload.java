package spring.mvc.whame.aws;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import org.springframework.stereotype.Component;

public class Keyload {

	private String accessKey = "";
	private String secretKey = "";
	private String accessFile = "D:/GeonS/amazon/keys/accessFile.txt";
	private String secretFile = "D:/GeonS/amazon/keys/secretFile.txt";

	public Keyload(){
	        try {
	            this.accessKey = readContentFrom(accessFile);
	            this.secretKey = readContentFrom(secretFile);
	        }
	        catch (FileNotFoundException e) {
	            e.printStackTrace();
	        }
	        catch (IOException e) {
	            e.printStackTrace();
	        }
	}

	public static String readContentFrom(String textFileName) throws IOException {
		BufferedReader bufferedTextFileReader = new BufferedReader(new FileReader(textFileName));
		StringBuilder contentReceiver = new StringBuilder();
		char[] buf = new char[1024];
		while (bufferedTextFileReader.read(buf) > 0) {
			contentReceiver.append(buf);
		}

		return contentReceiver.toString();
	}

	public String getAccessKey() {
		return accessKey;
	}

	public String getSecretKey() {
		return secretKey;
	}

}
