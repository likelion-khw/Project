package spring.mvc.whame.login;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class LoginDAO {
	
	@Autowired
	SqlSession session;
	
	@Autowired
	MemberVO mvo;
	
	public ArrayList login(LoginVO loginvo)
	{
		ArrayList result = new ArrayList();
		
		mvo = null;
		mvo = session.selectOne("login.login", loginvo);
		result.add(mvo);
		if(mvo == null)
		{
			result.add(0);
		}else{
			if(mvo.getPw().equals(loginvo.getPw()))
			{
				result.add(2); // �α��� ����
			}else
			{
				result.add(1); // �н����� Ʋ��
			}
		}
		
		return result;
	}
	
	public void signnew(MemberVO membervo){
		session.selectOne("login.signnew", membervo);
	}

}
