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
		System.out.println("test");
		dao.signnew(membervo);
	}
}
