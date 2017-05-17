package spring.mvc.whame.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("loginService")
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	LoginDAO dao;
	
	public int login(MemberVO membervo)
	{
		return dao.login(membervo);
	}
}
