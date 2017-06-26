package spring.mvc.whame.login;

public class KakaoVO {
	private String userid;
	private String kakaoauth;
	private String nickname;
	private String userimage;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getKakaoauth() {
		return kakaoauth;
	}
	public void setKakaoauth(String kakaoauth) {
		this.kakaoauth = kakaoauth;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getUserimage() {
		return userimage;
	}
	public void setUserimage(String userimage) {
		this.userimage = userimage;
	}
	
	
}
