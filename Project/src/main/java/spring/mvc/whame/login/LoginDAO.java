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

	public ArrayList login(LoginVO loginvo) {
		ArrayList result = new ArrayList();

		mvo = null;
		mvo = session.selectOne("login.login", loginvo);
		result.add(mvo);
		if (mvo == null) {
			result.add(0);
		} else {
			if (mvo.getPw().equals(loginvo.getPw())) {
				result.add(2); // �α��� ����
			} else {
				result.add(1); // �н����� Ʋ��
			}
		}

		return result;
	}

	public void signnew(MemberVO membervo) {
		session.selectOne("login.signnew", membervo);
	}

	public int idcheck(String userid) {
		return session.selectOne("login.idcheck", userid);
	}

	public int nncheck(String nickname) {
		return session.selectOne("login.nncheck", nickname);
	}

	public int renickname(MemberVO membervo) {
		return session.update("login.re_nickname", membervo);
	}

	public int repw(MemberVO membervo) {
		return session.update("login.re_pw", membervo);
	}
	
	public void re_img(MemberVO membervo){
		session.update("login.re_img",membervo);
	}

	public MemberVO kakao(KakaoVO kvo) {
		int same = session.selectOne("login.get_kakao", kvo);
		if (same != 1) {
			session.insert("login.new_kakao", kvo);
		}
		mvo = session.selectOne("login.login_kakao", kvo);
		
		return mvo;
	}
	
	public MemberVO facebook(FaceBookVO fvo){
		int same = session.selectOne("login.get_facebook", fvo);
		if (same != 1) {
			System.out.println(fvo.getUserid());
			session.insert("login.new_facebook", fvo);
		}
		mvo = session.selectOne("login.login_facebook", fvo);
		
		return mvo;
	}

}
