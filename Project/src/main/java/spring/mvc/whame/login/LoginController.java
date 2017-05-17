package spring.mvc.whame.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

@Controller
@SessionAttributes("memberVO")
public class LoginController {

	@Autowired
	LoginService service;
	ModelAndView mav = new ModelAndView();
	
	// 아이디 로그인 성공시에 사용될 메소드( 세션에 저장하기 위함 )
	@ModelAttribute("memberVO")
	public MemberVO setSession(MemberVO vo){
		return vo;
	}
	
	// 초기 로그인 화면
	@RequestMapping(value = "start.whame", method = RequestMethod.GET)
	public ModelAndView loginform() {
		mav.setViewName("login/loginform");
		return mav;
	}

	// Ajax 방식으로 로그인 결과 전송( 2 값 나올 경우 로그인 성공으로 setSession 메소드 실행 )
	@ResponseBody
	@RequestMapping(value = "start.whame", method = RequestMethod.POST)
	public int loginsuccess(MemberVO vo){
		int result = service.login(vo);
		if(result == 2)
		{
			setSession(vo);
		}
		return result;
	}
	
	// 로그아웃 메소드
	@RequestMapping(value = "logout.whame")
	public String logout(SessionStatus session){
		session.setComplete();
		return "redirect:start.whame";
	}
	
}
