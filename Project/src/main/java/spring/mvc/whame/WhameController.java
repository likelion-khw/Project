package spring.mvc.whame;

import java.awt.image.BufferedImage;
import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import spring.mvc.whame.aws.S3Util;
import spring.mvc.whame.color.ColorVO;
import spring.mvc.whame.history.HistoryVO;
import spring.mvc.whame.login.MemberVO;
import spring.mvc.whame.opencv.ImageVO;
import spring.mvc.whame.opencv.Opencv;
import spring.mvc.whame.region.LocationVO;
import spring.mvc.whame.region.MapTest;
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

	@Autowired
	HistoryVO history;

	String filepath = "";
	String address = "";

	double lat, lon;

	List<Double> difflal = new ArrayList<Double>();

	// 占싱뱄옙占쏙옙占쏙옙 占쏙옙占쏙옙 OCR 占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙
	@RequestMapping(value = "showinfo.whame")
	public ModelAndView getimage(HttpSession session) throws Exception {
		WhameVO whame = new WhameVO();
		ModelAndView mav = new ModelAndView();
		List<TextVO> result = service.ocr(filepath);
		ColorVO color = service.color(filepath);

		whame.setColor(color);
		whame.setText(result);
		whame.setLat(lat);
		whame.setLon(lon);
		whame.setDifflat(difflal.get(0));
		whame.setDifflon(difflal.get(1));
		mav.setViewName("body/signinfo");

		int store_code = service.searchInfo(whame);

		// history insert
		MemberVO membervo = (MemberVO) session.getAttribute("memberVO");

		if (store_code == 0) {
			mav.addObject("error", "�벑濡앸맂 媛�寃� �젙蹂닿� �뾾�뒿�땲�떎.");
			return mav;
		} else {
			history.setStore_code(store_code);
			history.setUserid(membervo.getUserid());
			service.setHistory(history);

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
		if (vo.getUserid() == null) {
			mav.setViewName("login/loginform");
		} else {

			List<RegionVO> gu = service.getrcode();
			mav.addObject("region", gu);
			mav.setViewName("body/enrollform");
		}
		return mav;
	}

	@RequestMapping(value = "enrollconnect.whame", method = RequestMethod.POST)
	public ModelAndView enrollconnect(@ModelAttribute(value = "storevo") StoreVO storevo, HttpServletRequest request)
			throws Exception {
		String rcode1 = (String) request.getParameter("rcode1");
		String rcode2 = (String) request.getParameter("rcode2");
		String detail = (String) request.getParameter("detail");
		address = rcode1 + " " + rcode2 + " " + detail;
		System.out.println("rcode占쏙옙 : " + rcode1 + " " + rcode2);
		int rcode = service.getrcodeNum(rcode1 + " " + rcode2);
		storevo.setRcode(rcode);

		String bucketName = "whame01/StoreTitle";
		MultipartFile imagefile = storevo.getImagefile();
		File convFile = new File(imagefile.getOriginalFilename());
		imagefile.transferTo(convFile);

		// 占쏙옙占쏙옙 占쏙옙占싸듸옙
		filepath = s3.fileUpload(bucketName, convFile);
		String imgurl = s3.getFileURL(bucketName, filepath).split("AWSAccessKeyId")[0];
		System.out.println("=========enrollconnect imgurl=======" + imgurl);
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
		mav.setViewName("body/enrollsuccess");
		System.out.println("enrollsuccess占쏙옙 占싱듸옙");
		return mav;
	}

	@RequestMapping(value = "menuUpload.whame", method = RequestMethod.POST)
	public ModelAndView menuUpload(HttpServletRequest request, @ModelAttribute("locationVO") LocationVO lvo) {
		String[] menulist = request.getParameterValues("menulist");
		int store_code = Integer.parseInt(request.getParameter("store_code"));

		lvo.setRcode(enrollStore.getRcode());
		lvo.setStore_code(store_code);
		System.out.println("menuupload==>" + lvo.getAddress());
		System.out.println("lal ?�??=>" + lvo.getLat() + ":::" + lvo.getLon());
		service.setLocation(lvo);
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
		mav.setViewName("body/enrollcomplete");
		return mav;
	}

	// 占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占싸듸옙첼占� 占쏙옙占쏙옙풔占� 占쌨소듸옙 ( AWS 클占쏙옙占쏙옙 占쏙옙占� )
	@RequestMapping(value = "image.whame", method = RequestMethod.POST)
	public ModelAndView test(MultipartFile imagefile, HttpServletRequest request) throws Exception {
		lat = Double.parseDouble(request.getParameter("lat"));
		lon = Double.parseDouble(request.getParameter("lon"));
		System.out.println("lal" + lat + ":" + lon);

		MapTest mt = new MapTest();
		difflal = mt.run(lat, 2000);

		ModelAndView mav = new ModelAndView();
		String bucketName = "whame01/StoreTitle";
		File convFile = new File(imagefile.getOriginalFilename());
		imagefile.transferTo(convFile);

		// 占쏙옙占쏙옙 占쏙옙占싸듸옙
		filepath = s3.fileUpload(bucketName, convFile);
		// history 媛꾪뙋�씠誘몄� �뙆�씪紐�
		history.setSignimage(filepath);
		String imgurl = s3.getFileURL(bucketName, filepath).split("AWSAccessKeyId")[0];
		mav.addObject("imgurl", imgurl);
		mav.setViewName("body/image");
		return mav;
	}

	// 占쏙옙占싸듸옙 占싱뱄옙占쏙옙占쏙옙 占쌨아쇽옙 Opencv 占쏙옙占쏙옙 占쏙옙 占싱뱄옙占쏙옙 占쏙옙占� 占쏙옙환 ( filename )
	@RequestMapping(value = "result.whame", method = RequestMethod.POST)
	public void test1(ImageVO imagevo, String imgurl) throws Exception {
		Opencv ivo = new Opencv();
		System.out.println("run占쏙옙占쏙옙載�---------" + imgurl);
		BufferedImage img = ImageIO.read(new URL(imgurl));
		filepath = ivo.runOpencv(img, imagevo, imgurl);
	}

	@RequestMapping(value = "history.whame", method = RequestMethod.GET)
	public ModelAndView history(HttpSession session) {
		MemberVO membervo = (MemberVO)session.getAttribute("memberVO");
		ModelAndView mav = new ModelAndView();
		List<HistoryVO> list = service.getHistoryList(membervo.getUserid());
		
		List<LocationVO> historyLoc = service.getHistotyLoc(membervo.getUserid());
		
		mav.addObject("historylist", list);
		mav.addObject("latalon", historyLoc.toString());
		mav.addObject("length",historyLoc.size());
		mav.setViewName("body/history"); 
		return mav; 
	  }
	
	@RequestMapping(value="historyInfo.whame", method=RequestMethod.GET)
	public ModelAndView historyInfo(int store_code){
		StoreVO storevo = service.getStore_info(store_code);
		List<MenuVO> menulist = service.getMenu(store_code);
		LocationVO locationvo = service.getLocation_info(store_code);
		ModelAndView mav = new ModelAndView();
		mav.addObject("storevo", storevo);
		mav.addObject("locationvo", locationvo);
		mav.addObject("menulist", menulist);
		mav.setViewName("body/historyInfo");
		return mav;
	}
	
	@RequestMapping(value = "store.whame", method = RequestMethod.GET)
	public ModelAndView storeinfo(HttpSession session) {
		MemberVO membervo = (MemberVO) session.getAttribute("memberVO");
		ModelAndView mav = new ModelAndView();
		List<StoreVO> ls = service.getStoreList(membervo.getUserid());
		HashMap<Integer, List<MenuVO>> menulist = new HashMap<Integer, List<MenuVO>>();

		if (ls != null) {
			for (int i = 0; i < ls.size(); i++) {
				List<MenuVO> list = service.getMenu(ls.get(i).getStore_code());
				menulist.put(ls.get(i).getStore_code(), list);
			}
		}

		mav.addObject("menulist", menulist);
		mav.addObject("storelist", ls);
		mav.setViewName("body/storeform");

		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="storeCount.whame", method=RequestMethod.POST)
	public int storeCount(){
		return service.getStoreCount();
	}
}
