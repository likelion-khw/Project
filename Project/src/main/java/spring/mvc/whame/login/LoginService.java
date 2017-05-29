package spring.mvc.whame.login;

import java.util.ArrayList;

public interface LoginService {
	public ArrayList login(LoginVO loginvo);
	public void signnew(MemberVO membervo);
	
	public int idcheck(String userid);
	public int nncheck(String nickname);
	
	public int renickname(MemberVO membervo);
	public int repw(MemberVO membervo);
	
	public int kakaoLogin(KakaoVO kakaovo);
	public int kakaoEnroll(KakaoVO kakaovo);
}
