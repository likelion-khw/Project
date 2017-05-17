package spring.mvc.whame.aws;

import java.util.UUID;

import org.springframework.stereotype.Component;

@Component
public class CommonUtils {
	public static String getRandomString(){
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
