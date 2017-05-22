package spring.mvc.whame.login;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class LoginDAO {
	
	@Autowired
	SqlSession session;
	
	@Autowired
	MemberVO mvo;
	
	public int login(MemberVO membervo)
	{
		System.out.println("login");
		mvo = null;
		mvo = session.selectOne("login.login", membervo);
		if(mvo == null)
		{
			return 0; // 해당 아이디 없음
		}else{
			if(mvo.getPw().equals(membervo.getPw()))
			{
				return 2; // 로그인 성공
			}else
			{
				return 1; // 패스워드 틀림
			}
		}
	}

}
