package spring.mvc.whame.login;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("loginService")
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	LoginDAO dao;
	
	public ArrayList login(LoginVO loginvo)
	{
		return dao.login(loginvo);
	}
	
	public void signnew(MemberVO membervo){
		dao.signnew(membervo);
	}
	
	public int idcheck(String userid){
		return dao.idcheck(userid);
	}
	public int nncheck(String nickname){
		return dao.nncheck(nickname);
	}
	
	public int renickname(MemberVO membervo){
		return dao.renickname(membervo);
	}
	
	public int repw(MemberVO membervo){
		return dao.repw(membervo);
	}
	
	public MemberVO kakao(KakaoVO kvo){
		return dao.kakao(kvo);
	}
}
