package spring.mvc.whame.login;

import java.util.ArrayList;

public interface LoginService {
	public ArrayList login(LoginVO loginvo);
	public void signnew(MemberVO membervo);
}
