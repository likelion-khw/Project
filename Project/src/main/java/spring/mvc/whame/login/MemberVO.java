package spring.mvc.whame.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import spring.mvc.whame.aws.S3Util;

@Component
public class MemberVO {

	private String userid;
	private String pw;
	private String userimage;
	private String nickname;
	
	public MemberVO() {
	}

	public MemberVO(String userid, String pw) {
		super();
		this.userid = userid;
		this.pw = pw;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getUserimage() {
		return userimage;
	}

	public void setUserimage(String userimage) {
		this.userimage = userimage;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}


}
