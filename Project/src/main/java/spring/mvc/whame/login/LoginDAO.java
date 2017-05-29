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
	
	ArrayList result;
	
	public ArrayList login(LoginVO loginvo)
	{
		result = new ArrayList();
		
		mvo = null;
		mvo = session.selectOne("login.login", loginvo);
		result.add(mvo);
		if(mvo == null)
		{
			result.add(0);
		}else{
			if(mvo.getPw().equals(loginvo.getPw()))
			{
				result.add(2); // ï¿½Î±ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
			}else
			{
				result.add(1); // ï¿½Ð½ï¿½ï¿½ï¿½ï¿½ï¿½ Æ²ï¿½ï¿½
			}
		}
		
		return result;
	}
	
	public void signnew(MemberVO membervo){
		session.selectOne("login.signnew", membervo);
	}
	
	public int idcheck(String userid){
		return session.selectOne("login.idcheck", userid);
	}
	public int nncheck(String nickname){
		return session.selectOne("login.nncheck", nickname);
	}
	
	public int renickname(MemberVO membervo){
		return session.update("login.re_nickname", membervo);
	}
	
	public int repw(MemberVO membervo){
		return session.update("login.re_pw",membervo);
	}

	public int kakaoLogin(KakaoVO kakaovo) {

		int resultNumber=9;
		
		KakaoVO outputId = session.selectOne("login.kakaologin", kakaovo);
		
		if(outputId.getUserid()==null)
		{
			resultNumber=0;
		} else {
			resultNumber=2;
		}
		return resultNumber;
	}
	
	public int kakaoEnroll(KakaoVO kakaovo){
		KakaoVO outputId = session.selectOne("login.kakaoenroll", kakaovo);
		if(outputId.getUserid()==null){
			System.out.println("¾ÆÀÌµð°¡ Àß¸øµÇ¾ú½À´Ï´Ù");
		}
		int result = 2;
		return result;
	}
}
