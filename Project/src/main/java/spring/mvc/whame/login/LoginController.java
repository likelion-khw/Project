package spring.mvc.whame.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@SessionAttributes("memberVO")
public class LoginController {

	@Autowired
	LoginService service;
	ModelAndView mav = new ModelAndView();
	
	// 占쏙옙占싱듸옙 占싸깍옙占쏙옙 占쏙옙占쏙옙占시울옙 占쏙옙占쏙옙 占쌨소듸옙( 占쏙옙占실울옙 占쏙옙占쏙옙占싹깍옙 占쏙옙占쏙옙 )
	@ModelAttribute("memberVO")
	public MemberVO setSession(MemberVO vo){
		return vo;
	}
	
	@RequestMapping(value="/")
	public String main() {
		System.out.println("test");
		return "main/main";
	}
	
	@RequestMapping(value="main.whame")
	public String mainform() {
		return "main/main";
	}
	
	// 占십깍옙 占싸깍옙占쏙옙 화占쏙옙
	@RequestMapping(value = "login.whame", method = RequestMethod.GET)
	public ModelAndView loginform() {
		mav.setViewName("login/loginform");
		System.out.println("test23242");
		return mav;
	}

	// Ajax 占쏙옙占쏙옙占쏙옙占� 占싸깍옙占쏙옙 占쏙옙占� 占쏙옙占쏙옙( 2 占쏙옙 占쏙옙占쏙옙 占쏙옙占� 占싸깍옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 setSession 占쌨소듸옙 占쏙옙占쏙옙 )
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
	
	// 占싸그아울옙 占쌨소듸옙
	@RequestMapping(value = "logout.whame")
	public String logout(SessionStatus session){
		session.setComplete();
		return "redirect:main.whame";
	}
	
	@RequestMapping(value="sign.whame", method=RequestMethod.POST)
	public void signnew(MemberVO vo, MultipartFile image){
		System.out.println(vo.getUserid() + " /" + vo.getPw());
		System.out.println(image.getOriginalFilename());
	}
	
}
