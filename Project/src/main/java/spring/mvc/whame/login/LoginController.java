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
	
	// ���̵� �α��� �����ÿ� ���� �޼ҵ�( ���ǿ� �����ϱ� ���� )
	@ModelAttribute("memberVO")
	public MemberVO setSession(MemberVO vo){
		return vo;
	}
	
	// �ʱ� �α��� ȭ��
	@RequestMapping(value = "login.whame", method = RequestMethod.GET)
	public ModelAndView loginform() {
		mav.setViewName("login/loginform");
		return mav;
	}

	// Ajax ������� �α��� ��� ����( 2 �� ���� ��� �α��� �������� setSession �޼ҵ� ���� )
	@ResponseBody
	@RequestMapping(value = "login.whame", method = RequestMethod.POST)
	public int loginsuccess(MemberVO vo){
		int result = service.login(vo);
		if(result == 2)
		{
			setSession(vo);
		}
		return result;
	}
	
	// �α׾ƿ� �޼ҵ�
	@RequestMapping(value = "logout.whame")
	public String logout(SessionStatus session){
		session.setComplete();
		return "redirect:main.whame";
	}
	
}
