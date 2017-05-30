package spring.mvc.whame.login;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import spring.mvc.whame.aws.S3Util;

@Controller
@SessionAttributes("memberVO")
public class LoginController {

	@Autowired
	LoginService service;
	
	@Autowired
	S3Util s3;
	
	@Autowired
	MemberVO mvo;
	
	ArrayList result;
	
	ModelAndView mav = new ModelAndView();
	
	String filepath="";

	@ModelAttribute("memberVO")
	public MemberVO setSession(MemberVO vo) {
		return vo;
	}
	
	@RequestMapping(value="success.whame", method=RequestMethod.POST)
	public String setSession2(MemberVO vo) {
		return "main/main";
	}
	
	@RequestMapping(value = "/")
	public String main() {
		return "main/main";
	}
	
	@RequestMapping(value = "login.whame", method = RequestMethod.GET)
	public ModelAndView loginform() {
		mav.setViewName("login/loginform");
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "login.whame", method = RequestMethod.POST)
	public ArrayList loginsuccess(LoginVO vo, HttpSession session) {
		result = service.login(vo);
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "kakao.whame", method = RequestMethod.POST)
	public int kakaoLoginsuccess(KakaoVO kakaovo){
		int result = service.kakaoLogin(kakaovo);

		if(result==0)
		{
			result = service.kakaoEnroll(kakaovo);
		}
		return result;
	}
	
	
	// 占싸그아울옙 占쌨소듸옙
	@RequestMapping(value = "logout.whame")
	public String logout(SessionStatus session) {
		session.setComplete();
		return "redirect:/";
	}

	@RequestMapping(value = "sign.whame", method = RequestMethod.POST)
	public String signnew(MemberVO vo, MultipartFile image) throws Exception{
		String bucketName = "whame01/Userimage";
		
		File convFile = new File(image.getOriginalFilename());
		image.transferTo(convFile);
		String filepath = s3.fileUpload(bucketName, convFile);
		String imgurl = s3.getFileURL(bucketName, filepath).split("AWSAccessKeyId")[0];
		vo.setUserimage(imgurl);
		
		service.signnew(vo);
		
		return "redirect:/";

	}
	
	@RequestMapping(value="remember.whame", method=RequestMethod.GET)
	public String re_member(){
		return "login/re_member";
	}
	
	@ResponseBody
	@RequestMapping(value="idcheck.whame", method=RequestMethod.POST)
	public int idcheck(String userid){
		return service.idcheck(userid);
	}
	
	@ResponseBody
	@RequestMapping(value="nncheck.whame", method=RequestMethod.POST)
	public int nncheck(String nickname){
		return service.nncheck(nickname);
	}
	
	@ResponseBody
	@RequestMapping(value="re_nickname.whame", method=RequestMethod.POST)
	public int renickname(String nickname, HttpSession session){
		mvo = (MemberVO)session.getAttribute("memberVO");
		mvo.setNickname(nickname);
		
		return service.renickname(mvo);
	}
	
	@ResponseBody
	@RequestMapping(value="re_pw.whame", method=RequestMethod.POST)
	public int repw(String pw, HttpSession session){
		mvo = (MemberVO)session.getAttribute("memberVO");
		mvo.setPw(pw);
		
		return service.repw(mvo);
	}

}
