package spring.mvc.whame;

import java.awt.image.BufferedImage;
import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
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
import spring.mvc.whame.store.CouponVO;
import spring.mvc.whame.store.MenuVO;
import spring.mvc.whame.store.ReMenuVO;
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

	// �뜝�떛諭꾩삕�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕 OCR �뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕
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
			mav.addObject("error", "일치하는 상가정보가 없습니다.");
			return mav;
		} else {
			if(membervo.getUserid() != null){
				service.viewcount(store_code);
				history.setStore_code(store_code);
				history.setUserid(membervo.getUserid());
				service.setHistory(history);
			}
			List<MenuVO> menuList = service.getMenu(store_code);
			LocationVO location = service.getLocation_info(store_code);
			StoreVO store = service.getStore_info(store_code);
			
			
			mav.addObject("result", result);
			mav.addObject("color", color);
			mav.addObject("menuList", menuList);
			mav.addObject("location", location);
			mav.addObject("store", store);
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
		System.out.println("rcode�뜝�룞�삕 : " + rcode1 + " " + rcode2);
		int rcode = service.getrcodeNum(rcode1 + " " + rcode2);
		storevo.setRcode(rcode);

		String bucketName = "whame01/StoreMain";
		MultipartFile imagefile = storevo.getImagefile();
		File convFile = new File(imagefile.getOriginalFilename());
		imagefile.transferTo(convFile);

		// �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�떥�벝�삕
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
		System.out.println(address);
		mav.addObject("address", address);
		mav.setViewName("body/enrollsuccess");
		System.out.println("enrollsuccess�뜝�룞�삕 �뜝�떛�벝�삕");
		return mav;
	}

	@RequestMapping(value = "menuUpload.whame", method = RequestMethod.POST)
	public ModelAndView menuUpload(HttpServletRequest request, @ModelAttribute("locationVO") LocationVO lvo) {
		System.out.println(lvo.getAddress());
		String[] menulist = request.getParameterValues("menulist");
		int store_code = Integer.parseInt(request.getParameter("store_code"));

		lvo.setRcode(enrollStore.getRcode());
		lvo.setStore_code(store_code);
		System.out.println("menuupload==>" + lvo.getAddress());
		System.out.println("lal ?占�??=>" + lvo.getLat() + ":::" + lvo.getLon());
		service.setLocation(lvo);
		System.out.println(menulist.length);

		int[] menuListInt = new int[menulist.length];
		List<MenuVO> menuList = new ArrayList<MenuVO>();

		for (int i = 0; i < menulist.length; i++) {
			System.out.println(menulist[i]);
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
		mav.setViewName("redirect:/store.whame");
		return mav;
	}

	// �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�떥�벝�삕泥쇔뜝占� �뜝�룞�삕�뜝�룞�삕�뮅�뜝占� �뜝�뙣�냼�벝�삕 ( AWS �겢�뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝占� )
	@RequestMapping(value = "image.whame", method = RequestMethod.POST)
	public ModelAndView test(MultipartFile imagefile, HttpServletRequest request) throws Exception {
		lat = Double.parseDouble(request.getParameter("lat"));
		lon = Double.parseDouble(request.getParameter("lon"));
		System.out.println("lal" + lat + ":" + lon);
		MapTest mt = new MapTest();
		difflal = mt.run(lat, 550);

		ModelAndView mav = new ModelAndView();
		String bucketName = "whame01/StoreTitle";
		File convFile = new File(imagefile.getOriginalFilename());
		imagefile.transferTo(convFile);

		// �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕�뜝�떥�벝�삕
		filepath = s3.fileUpload(bucketName, convFile);
		// history 揶쏄쑵�솇占쎌뵠沃섎챷占� 占쎈솁占쎌뵬筌륅옙
		history.setSignimage(filepath);
		String imgurl = s3.getFileURL(bucketName, filepath).split("AWSAccessKeyId")[0];
		mav.addObject("imgurl", imgurl);
		mav.setViewName("body/image");
		return mav;
	}

	// �뜝�룞�삕�뜝�떥�벝�삕 �뜝�떛諭꾩삕�뜝�룞�삕�뜝�룞�삕 �뜝�뙣�븘�눦�삕 Opencv �뜝�룞�삕�뜝�룞�삕 �뜝�룞�삕 �뜝�떛諭꾩삕�뜝�룞�삕 �뜝�룞�삕�뜝占� �뜝�룞�삕�솚 ( filename )
	@ResponseBody
	@RequestMapping(value = "result.whame", method = RequestMethod.POST)
	public void openCV(ImageVO imagevo, String imgurl) throws Exception {
		Opencv ivo = new Opencv();
		imagevo.sortXY();
		System.out.println("run�뜝�룞�삕�뜝�룞�삕雍됵옙---------" + imgurl);
		BufferedImage img = ImageIO.read(new URL(imgurl));
		filepath = ivo.runOpencv(img, imagevo, imgurl);
	}

	@RequestMapping(value = "history.whame", method = RequestMethod.GET)
	public ModelAndView history(HttpSession session) {
		MemberVO membervo = (MemberVO)session.getAttribute("memberVO");
		ModelAndView mav = new ModelAndView();
		if(membervo != null)
		{
			if(membervo.getUserid() != null)
			{
				List<HistoryVO> list = service.getHistoryList(membervo.getUserid());
				System.out.println(list.size());
				List<LocationVO> historyLoc = service.getHistotyLoc(membervo.getUserid());
				List<Integer> hstore_code = service.gethstore_code(membervo.getUserid());
				HashMap<Integer, List<HistoryVO>> hList = new HashMap<Integer, List<HistoryVO>>();
				
				mav.addObject("historylist", list);
				mav.addObject("latalon", historyLoc.toString());
				mav.addObject("length",historyLoc.size());
				
				HashMap<Integer, List<MenuVO>> mList = new HashMap<Integer, List<MenuVO>>();
				List<StoreVO> sList = new ArrayList<StoreVO>();
				HashMap<Integer, LocationVO> lList = new HashMap<Integer, LocationVO>();
				
				if (list != null) {
					for (int i = 0; i < hstore_code.size(); i++) {
						StoreVO storevo = service.getStore_info(hstore_code.get(i));
						LocationVO locationvo = service.getLocation_info(hstore_code.get(i));
						List<MenuVO> menu = service.getMenu(hstore_code.get(i));
						List<HistoryVO> history = service.getHistoryListGroup(hstore_code.get(i), membervo.getUserid());
						
						hList.put(hstore_code.get(i), history);
						sList.add(storevo);
						lList.put(hstore_code.get(i), locationvo);
						mList.put(hstore_code.get(i), menu);
					}
				}
				
				mav.addObject("hMap", hList);
				mav.addObject("storelist", sList);
				mav.addObject("locationlist", lList);
				mav.addObject("menulist", mList);
				
				mav.setViewName("body/history"); 
			}else
			{
				mav.setViewName("redirect:/login.whame");
			}
		}else{
			mav.setViewName("redirect:/login.whame");
		}
		return mav; 
	  }
	
	@RequestMapping(value="historyInfo.whame")
	public String historyInfo(){
		/*StoreVO storevo = service.getStore_info(store_code);
		List<MenuVO> menulist = service.getMenu(store_code);
		LocationVO locationvo = service.getLocation_info(store_code);
		ModelAndView mav = new ModelAndView();
		mav.addObject("storevo", storevo);
		mav.addObject("locationvo", locationvo);
		mav.addObject("menulist", menulist);
		mav.setViewName("body/test");*/
		return "test";
	}
	
	@RequestMapping(value = "store.whame", method = RequestMethod.GET)
	public ModelAndView storeinfo(HttpSession session) {
		MemberVO membervo = (MemberVO) session.getAttribute("memberVO");
		ModelAndView mav = new ModelAndView();
		if(membervo != null){
			if(membervo.getUserid() != null){
				List<StoreVO> storelist = service.getStoreList(membervo.getUserid());
				HashMap<Integer, List<StoreVO>> storemap = new HashMap<Integer, List<StoreVO>>();
				HashMap<Integer, List<MenuVO>> menulist = new HashMap<Integer, List<MenuVO>>();
				HashMap<Integer, LocationVO> loclist = new HashMap<Integer, LocationVO>();
				HashMap<Integer, List<CouponVO>> couponlist = new HashMap<Integer, List<CouponVO>>();
				List<TypeVO> typelist = service.getType();
				
				if (storelist != null) {
					for (int i = 0; i < storelist.size(); i++) {
						List<MenuVO> mlist = service.getMenu(storelist.get(i).getStore_code());
						List<CouponVO> clist = service.getCoupon(storelist.get(i).getStore_code());
						LocationVO locaion = service.getLocation_info(storelist.get(i).getStore_code());
						storemap.put(storelist.get(i).getStore_code(), storelist);
						menulist.put(storelist.get(i).getStore_code(), mlist);
						couponlist.put(storelist.get(i).getStore_code(), clist);
						loclist.put(storelist.get(i).getStore_code(), locaion);
					}
				}
				
				mav.addObject("storeMap", storemap);
				mav.addObject("menulist", menulist);
				mav.addObject("couponlist", couponlist);
				mav.addObject("storelist", storelist);
				mav.addObject("typelist", typelist);
				mav.addObject("loclist",loclist);
				mav.setViewName("body/storeform");
			}else
			{
				mav.setViewName("redirect:/login.whame");
			}
		}else{
			mav.setViewName("redirect:/login.whame");
		}
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="storeUpdate.whame", method=RequestMethod.POST)
	public void storeUpdate(@ModelAttribute("storevo") StoreVO svo , @ModelAttribute("locationvo") LocationVO lvo){
		System.out.println(lvo.getStore_code()+"LLLLLL"+lvo.getLat());
		String region[] = lvo.getAddress().split(" ");
		System.out.println("rcode수정 : " + region[0] + " " + region[1]);
		int rcode = service.getrcodeNum(region[0] + " " + region[1]);
		lvo.setRcode(rcode);
		service.storeUpdate(svo, lvo);
	}
	
	@ResponseBody
	@RequestMapping(value="addcoupon.whame", method=RequestMethod.POST)
	public int storeUpdate(@ModelAttribute("couponvo") CouponVO cvo){
		Date date = new Date();
		if(date.before(cvo.getS_time())){
			cvo.setState("예정");
		}
		else if(date.after(cvo.getE_time())){
			cvo.setState("종료");
		}
		else{
			cvo.setState("진행중");
		}
		service.couponInsert(cvo);
		
		List<CouponVO> acvo = service.getCoupon(cvo.getStore_code());
		for(CouponVO vo: acvo){
			if(vo.getContents().equals(cvo.getContents())){
				return vo.getCoupon_code();
			}
		};
		return 0;
	}
	
	@ResponseBody
	@RequestMapping(value="storeCount.whame", method=RequestMethod.POST)
	public int storeCount(){
		return service.getStoreCount();
	}
	
	@ResponseBody
	@RequestMapping(value="remenu.whame", method=RequestMethod.POST)
	public int re_menu(ReMenuVO rmvo){
		return service.remenu(rmvo);
	}
	
	@ResponseBody
	@RequestMapping(value="delmenu.whame", method=RequestMethod.POST)
	public int del_menu(ReMenuVO rmvo){
		return service.delmenu(rmvo);
	}
	
	@ResponseBody
	@RequestMapping(value="addmenu.whame", method=RequestMethod.POST)
	public int add_menu(MenuVO mvo){
		return service.addmenu(mvo);
	}
	
	@ResponseBody
	@RequestMapping(value="deleteStore.whame", method=RequestMethod.POST)
	public int deleteStore(int store_code){
		return service.deleteStore(store_code);
	}
	
	@ResponseBody
	@RequestMapping(value="recoupon.whame", method=RequestMethod.POST)
	public void re_coupon(CouponVO cvo){
		service.recoupon(cvo);
	}
	
	@ResponseBody
	@RequestMapping(value="delcoupon.whame", method=RequestMethod.POST)
	public void del_coupon(CouponVO cvo){
		service.delcoupon(cvo);
	}
}
