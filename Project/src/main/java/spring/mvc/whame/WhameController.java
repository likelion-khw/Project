package spring.mvc.whame;

import java.awt.image.BufferedImage;
import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tiles.request.collection.MapEntryArrayValues;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import spring.mvc.whame.aws.S3Util;
import spring.mvc.whame.color.ColorVO;
import spring.mvc.whame.login.MemberVO;
import spring.mvc.whame.opencv.ImageVO;
import spring.mvc.whame.opencv.Opencv;
import spring.mvc.whame.region.RegionVO;
import spring.mvc.whame.store.MenuVO;
import spring.mvc.whame.store.StoreVO;
import spring.mvc.whame.store.TypeVO;

@Controller
public class WhameController {

	@Autowired
	S3Util s3;
	
	@Autowired
	WhameService service;
	
	@Autowired
	StoreVO enrollStore;
	
	String filepath = "";
	String address="";
	
	//�̹����� ���� OCR �� ���� ����
	@RequestMapping(value = "showinfo.whame")
	public ModelAndView getimage() throws Exception{/*@ModelAttribute(value = "storevo") StoreVO storevo*/
		WhameVO whame = new WhameVO();
		ModelAndView mav = new ModelAndView();
		List<TextVO> result = service.ocr(filepath);
		ColorVO color = service.color(filepath);

		whame.setColor(color);
		whame.setText(result);
		mav.setViewName("body/showinfo");

		int store_code = service.searchInfo(whame);
		if (store_code == 0) {
			mav.addObject("error", "등록된 가게 정보가 없습니다.");
			return mav;
		} else {
			List<MenuVO> menuList = service.getMenu(store_code);
			System.out.println(menuList.size());
			mav.addObject("result", result);
			mav.addObject("color", color);
			mav.addObject("whame", whame);
			mav.addObject("menuList", menuList);
		}
		return mav;
	}

	@RequestMapping(value = "enroll.whame", method = RequestMethod.GET)
	public ModelAndView enrollform(HttpSession session) {
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		ModelAndView mav = new ModelAndView();
		if(vo.getUserid() == null)
		{
			mav.setViewName("login/loginform");
		}else{
			
			List<RegionVO> gu = service.getrcode();
			mav.addObject("region", gu);
			mav.setViewName("body/enrollform");
		}
		return mav;
	}

	@RequestMapping(value = "enrollconnect.whame", method = RequestMethod.POST)
	public ModelAndView enrollconnect(@ModelAttribute(value = "storevo") StoreVO storevo, HttpServletRequest request) throws Exception{
		String rcode1 = (String) request.getParameter("rcode1");
		String rcode2 = (String) request.getParameter("rcode2");
		String detail = (String) request.getParameter("detail");
		address = rcode1 +" " + rcode2 + " " + detail;
		System.out.println("rcode�� : " + rcode1 + " " + rcode2);
		int rcode = service.getrcodeNum(rcode1 + " " + rcode2);
		storevo.setRcode(rcode);
		
		String bucketName = "whame01/StoreMain";
		MultipartFile imagefile = storevo.getImagefile();
		File convFile = new File(imagefile.getOriginalFilename());
		imagefile.transferTo(convFile);

		// ���� ���ε�
		filepath = s3.fileUpload(bucketName, convFile);
		String imgurl = s3.getFileURL(bucketName, filepath).split("AWSAccessKeyId")[0];
		System.out.println("=========enrollconnect imgurl======="+imgurl);
		ModelAndView mav = new ModelAndView();
		mav.addObject("imgurl", imgurl);
		enrollStore = storevo;
		mav.setViewName("body/image_e");
		return mav;
	}

	@RequestMapping(value = "enrollsuccess.whame")
	public ModelAndView enrollsuccess() {
		int store_code = service.enroll(enrollStore, filepath);
		List<TypeVO> typelist = service.getType();
		ModelAndView mav = new ModelAndView();
		mav.addObject("store_code", store_code);
		mav.addObject("typelist", typelist);
		mav.addObject("address", address);
		mav.setViewName("enrollsuccess");
		System.out.println("enrollsuccess�� �̵�");
		return mav;
	}

	@RequestMapping(value = "menuUpload.whame", method = RequestMethod.POST)
	public ModelAndView menuUpload(HttpServletRequest request) {
		String[] menulist = request.getParameterValues("menulist");
		String lat =  (String) request.getParameter("latitude");
		String longi =  (String) request.getParameter("longitude");
		System.out.println("�����浵"+lat+":"+longi);
		int store_code = Integer.parseInt(request.getParameter("store_code"));

		System.out.println(menulist.length);

		int[] menuListInt = new int[menulist.length];
		List<MenuVO> menuList = new ArrayList<MenuVO>();

		for (int i = 0; i < menulist.length; i++) {
			String menuval[] = menulist[i].split(":");
			menuListInt[i] = Integer.parseInt(menuval[1]);

			MenuVO menu = new MenuVO();
			menu.setStore_code(store_code);
			menu.setMenu_name(menuval[0]);
			menu.setMenu_price(menuListInt[i]);
			menu.setMenu_type(menuval[2]);
			menuList.add(menu);
		}

		int menuNum = service.insertmenu(menuList);

		ModelAndView mav = new ModelAndView();
		mav.addObject("menuNum", menuNum);
		mav.setViewName("enrollcomplete");
		return mav;
	}

	// ���� ���� ���ε�ÿ� ����Ǵ� �޼ҵ� ( AWS Ŭ���� ��� )
	@RequestMapping(value = "image.whame", method = RequestMethod.POST)
	public ModelAndView test(MultipartFile imagefile) throws Exception {
		ModelAndView mav = new ModelAndView();
		String bucketName = "whame01/StoreTitle";
		
		File convFile = new File(imagefile.getOriginalFilename());
		imagefile.transferTo(convFile);
		
//		File imgfile = new File("test.jpg");
//		imgtest.resizeImageAsJPEG(convFile, imgfile, 700);

		// Bucket ����(�빮�ڴ� ���ԵǸ� �ȵ�.)
		// s3.createBucket("whame00");

		// s3.createFolder(bucketName, "testfol1");

		// ���� ���ε�
		filepath = s3.fileUpload(bucketName, convFile);
		String imgurl = s3.getFileURL(bucketName, filepath).split("AWSAccessKeyId")[0];
		mav.addObject("imgurl", imgurl);
		mav.setViewName("body/image");
		return mav;
	}

	// ���ε� �̹����� �޾Ƽ� Opencv ���� �� �̹��� ��� ��ȯ ( filename )
	@RequestMapping(value = "result.whame", method = RequestMethod.POST)
	public void test1(ImageVO imagevo, String imgurl) throws Exception {
		Opencv ivo = new Opencv();
		System.out.println("run����---------"+imgurl);
		BufferedImage img = ImageIO.read(new URL(imgurl));
		filepath = ivo.runOpencv(img,imagevo,imgurl);
	}

	
	@RequestMapping(value="map.whame", method=RequestMethod.GET) 
	public  ModelAndView mapform(String userid){ 
		ModelAndView mav = new ModelAndView();
		mav.setViewName("map"); 
		return mav; 
	  }
	
	@RequestMapping(value="map.whame", method=RequestMethod.POST) 
	public  ModelAndView mapsuccess(HttpServletRequest request){ 
		String lal = (String) request.getParameter("lal");
		System.out.println(lal);
		String[] lalSplit = lal.split("[(]|, |[)]");
		System.out.println("split-----" + lalSplit[1] +":"+lalSplit[2]);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("lal", lal);
		mav.setViewName("map2"); 
		return mav; 
	  }
	 

}
