package spring.mvc.whame.login;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	// 로그인 완료시에 실행되는 세션 저장 메소드
	@RequestMapping(value="success.whame", method=RequestMethod.POST)
	public String setSession2(MemberVO vo, HttpServletRequest request, HttpServletResponse response) {
		String idsave = (String)request.getParameter("cookie");
		System.out.println("saveid : "+idsave);
		if(idsave != null && idsave.equals("true")){
			System.out.println("id:"+vo.getUserid());
			Cookie cookie = new Cookie("userid", vo.getUserid());
			Cookie cookie2 = new Cookie("pw", vo.getPw());
			cookie.setMaxAge(60*365);
			response.addCookie(cookie);
			response.addCookie(cookie2);
		}else{
			Cookie[] cookies = request.getCookies();
			if(cookies != null){
		        for(int i=0; i < cookies.length; i++){
		            // 쿠키의 유효시간을 0으로 설정하여 만료시킨다
		            cookies[i].setMaxAge(0) ;
		            // 응답 헤더에 추가한다
		            response.addCookie(cookies[i]) ;
		        }
		    }
		    // 특정 쿠키만 삭제하기
		    /*Cookie kc = new Cookie("memberNo", null) ;
		    kc.setMaxAge(0) ;
		    response.addCookie(kc) ;*/
			
		}
		return "main/main";
	}
	
	// �ʱ� �α��� ȭ��
	@RequestMapping(value = "login.whame", method = RequestMethod.GET)
	public ModelAndView loginform() {
		mav.setViewName("login/loginform");
		return mav;
	}

	// Ajax ������� �α��� ��� ����( 2 �� ���� ��� �α��� �������� setSession �޼ҵ�
	// ���� )
	@ResponseBody
	@RequestMapping(value = "login.whame", method = RequestMethod.POST)
	public ArrayList loginsuccess(LoginVO vo, HttpSession session) {
		result = service.login(vo);
		return result;
	}

	// �α׾ƿ� �޼ҵ�
	@RequestMapping(value = "logout.whame")
	public String logout(SessionStatus session) {
		session.setComplete();
		return "redirect:/";
	}

	@RequestMapping(value = "sign.whame", method = RequestMethod.POST)
	public String signnew(MemberVO vo, MultipartFile image) throws Exception{
		if(image.getSize() != 0){
			String bucketName = "whame/Userimage";
			File convFile = new File(image.getOriginalFilename());
			image.transferTo(convFile);
			String filepath = s3.fileUpload(bucketName, convFile);
			String imgurl = s3.getFileURL(bucketName, filepath).split("AWSAccessKeyId")[0];
			vo.setUserimage(imgurl);
		}
		service.signnew(vo);
		
		return "redirect:/";

	}
	
	@RequestMapping(value="remember.whame", method=RequestMethod.GET)
	public String re_member(HttpSession session){
		mvo = (MemberVO)session.getAttribute("memberVO");
		String path = "";
		if (mvo != null) {
			path = "login/re_member";
			if (mvo.getUserid() != null) {
				path ="login/re_member";
			}else{
				path = "redirect:/login.whame";
			}
		}else{
			path = "redirect:/login.whame";
		}
		return path;
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
	
	@RequestMapping(value="re_img.whame", method=RequestMethod.POST)
	public String reimg(MultipartFile re_userimg, HttpSession session) throws Exception{
		mvo = (MemberVO)session.getAttribute("memberVO");
		if(re_userimg.getSize() != 0){
			String bucketName = "whame/Userimage";
			File convFile = new File(re_userimg.getOriginalFilename());
			re_userimg.transferTo(convFile);
			String filepath = s3.fileUpload(bucketName, convFile);
			String imgurl = s3.getFileURL(bucketName, filepath).split("AWSAccessKeyId")[0];
			mvo.setUserimage(imgurl);
		}
		service.re_img(mvo);
		
		return "redirect:/remember.whame";
	}
	
	@ResponseBody
	@RequestMapping(value="kakao.whame", method=RequestMethod.POST)
	public MemberVO kakao(KakaoVO kvo){
		mvo = service.kakao(kvo);
		return mvo;
	}
	
	
	@RequestMapping(value="searchMember.whame", method=RequestMethod.GET)
	public String search(){
		return "body/searchMember";
	}
	
	/*@RequestMapping(value="searchMember.whame", method=RequestMethod.POST)
	public ModelAndView search(MemberVO mvo){
		return "body/searchMember";
	}*/

}
