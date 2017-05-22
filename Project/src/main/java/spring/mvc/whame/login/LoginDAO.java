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
			return 0; // �ش� ���̵� ����
		}else{
			if(mvo.getPw().equals(membervo.getPw()))
			{
				return 2; // �α��� ����
			}else
			{
				return 1; // �н����� Ʋ��
			}
		}
	}

}
