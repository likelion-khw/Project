package spring.mvc.whame;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
import spring.mvc.whame.crawling.Crawling;
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
import spring.mvc.whame.store.StoreInitVO;
import spring.mvc.whame.store.StoreVO;
import spring.mvc.whame.store.TypeVO;

@Controller
public class WhameController {

	@Autowired
	S3Util s3;
	
	@Autowired
	StoreInitVO storeinitvo;

	@Autowired
	WhameService service;

	@Autowired
	StoreVO enrollStore;

	@Autowired
	HistoryVO history;
	
	@Autowired
	Crawling craw;

	String filepath = "";
	String address = "";

	double lat, lon;

	List<Double> difflal = new ArrayList<Double>();
	
	@RequestMapping(value = "/test")
	public ModelAndView test() throws Exception {
		System.out.println("mong테스트중_mong");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("body/test");
		return mav;
	}

	@RequestMapping(value = "/")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		int count = service.getStoreCount();
		List<LocationVO> locationlist = service.getlocation_list();
		List<StoreVO> countrank = service.getCountRanklist();
		List<StoreVO> getNewStore = service.getNewStore();
		List<String> getMenuAuto = service.getMenuAuto();
		
		mav.setViewName("main/main");
		mav.addObject("count", count);
		mav.addObject("getNewStore",getNewStore);
		mav.addObject("countrank",countrank);
		mav.addObject("getMenuAuto", getMenuAuto);
		mav.addObject("locationlist", locationlist);
		return mav;
	}

	// 占싱뱄옙占쏙옙占쏙옙 占쏙옙占쏙옙 OCR 占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙
	@RequestMapping(value = "forkakao.whame")
	public ModelAndView getshow(int store_code) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("body/forkakao");

		List<MenuVO> menuList = service.getMenu(store_code);
		LocationVO location = service.getLocation_info(store_code);
		StoreVO store = service.getStore_info(store_code);
		List<String> menutype = service.getMenuDistinct(store_code);
		List<CouponVO> couponlist = service.getCoupon(store_code); 
		String[] craws = craw.run(location.getDong(), store.getStore_name());
		String[] crawl = craws[0].split("</li>");
		String[] crawl1 = craws[1].split("</li>");
		String crawl2 = craws[2];
		
		mav.addObject("couponlist", couponlist);
		mav.addObject("crawl", crawl);
		mav.addObject("crawl1", crawl1);
		mav.addObject("crawl2", crawl2);
		mav.addObject("menutype",menutype);
		mav.addObject("menuList", menuList);
		mav.addObject("location", location);
		mav.addObject("store", store);
		return mav;
	}
	
	@RequestMapping(value = "showinfo.whame")
	public ModelAndView getimage(HttpSession session) throws Exception {
		WhameVO whame = new WhameVO();
		ModelAndView mav = new ModelAndView();
		List<TextVO> result = service.ocr(filepath);
		ColorVO color = service.color(filepath);
		System.out.println(color.getRed() +":" + color.getBlue() + ":"+ color.getGreen());
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
			mav.addObject("error", "등록된 상가가 아직 없네요 ㅠㅠ");
			return mav;
		} else {
			if(membervo != null){
				if (membervo.getUserid() != null) {
					history.setStore_code(store_code);
					history.setUserid(membervo.getUserid());
					service.setHistory(history);
				}
			}
			service.viewcount(store_code);
			List<MenuVO> menuList = service.getMenu(store_code);
			LocationVO location = service.getLocation_info(store_code);
			StoreVO store = service.getStore_info(store_code);
			List<String> menutype = service.getMenuDistinct(store_code);
			List<CouponVO> couponlist = service.getCoupon(store_code); 
			String[] craws = craw.run(location.getDong(), store.getStore_name());
			String[] crawl = craws[0].split("</li>");
			String[] crawl1 = craws[1].split("</li>");
			String crawl2 = craws[2];

			mav.addObject("crawl", crawl);
			mav.addObject("crawl1", crawl1);
			mav.addObject("crawl2", crawl2);
			mav.addObject("imgurl", history.getSignimage());
			mav.addObject("result", result);
			mav.addObject("menutype", menutype);
			mav.addObject("color", color);
			mav.addObject("menuList", menuList);
			mav.addObject("location", location);
			mav.addObject("couponlist", couponlist);
			mav.addObject("store", store);
		}
		return mav;
	}

	@RequestMapping(value = "enroll.whame", method = RequestMethod.GET)
	public ModelAndView enrollform(HttpSession session) {
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		ModelAndView mav = new ModelAndView();
		if (vo != null) {
			if (vo.getUserid() != null) {
				List<RegionVO> gu = service.getrcode();
				mav.addObject("region", gu);
				mav.setViewName("body/enrollform");
			} else {
				mav.setViewName("redirect:/");
			}
		} else {
			mav.setViewName("redirect:/");
		}
		return mav;
	}

	@RequestMapping(value = "enrollconnect.whame", method = RequestMethod.POST)
	public ModelAndView enrollconnect(@ModelAttribute(value = "storevo") StoreVO storevo, String en_address, String en_dong,
			HttpSession session) throws Exception {
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		ModelAndView mav = new ModelAndView();
		if (vo != null) {
			if (vo.getUserid() != null) {
				this.address = en_address;
				String s_rcode[] = en_address.split(" ");
				storevo.setDong(en_dong.replaceAll("[\\(\\)]", ""));
				int rcode = service.getrcodeNum(s_rcode[0] + " " + s_rcode[1]);
				storevo.setRcode(rcode);

				String bucketName = "whame/StoreMain";
				MultipartFile imagefile = storevo.getImagefile();
				File convFile = new File(imagefile.getOriginalFilename());
				imagefile.transferTo(convFile);

				// 占쏙옙占쏙옙 占쏙옙占싸듸옙
				filepath = s3.fileUpload(bucketName, convFile);
				String imgurl = s3.getFileURL(bucketName, filepath).split("AWSAccessKeyId")[0];
				System.out.println("=========enrollconnect imgurl=======" + imgurl);
				storevo.setStore_image(imgurl);
				enrollStore = storevo;
				mav.addObject("imgurl", imgurl);
				mav.setViewName("body/image_e");
			} else {
				mav.setViewName("redirect:/");
			}
		} else {
			mav.setViewName("redirect:/");
		}
		return mav;
	}

	@RequestMapping(value = "enrollsuccess.whame")
	public ModelAndView enrollsuccess(HttpSession session) {
		MemberVO vo = (MemberVO) session.getAttribute("memberVO");
		ModelAndView mav = new ModelAndView();
		if (vo != null) {
			if (vo.getUserid() != null) {
				int store_code = service.enroll(enrollStore, filepath);
				List<TypeVO> typelist = service.getType();
				mav.addObject("store_code", store_code);
				mav.addObject("typelist", typelist);
				System.out.println(address);
				mav.addObject("address", address);
				mav.setViewName("body/enrollsuccess");
				System.out.println("enrollsuccess占쏙옙 占싱듸옙");
			} else {
				mav.setViewName("redirect:/");
			}
		} else {
			mav.setViewName("redirect:/");
		}
		return mav;
	}

	@RequestMapping(value = "menuUpload.whame", method = RequestMethod.POST)
	public ModelAndView menuUpload(HttpServletRequest request, @ModelAttribute("locationVO") LocationVO lvo) {
		System.out.println(lvo.getAddress());
		ModelAndView mav = new ModelAndView();
		int store_code = Integer.parseInt(request.getParameter("store_code"));
		lvo.setRcode(enrollStore.getRcode());
		lvo.setStore_code(store_code);
		lvo.setDong(enrollStore.getDong());
		service.setLocation(lvo);
		
		String[] menulist = request.getParameterValues("menulist");

		if(menulist != null){
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
			
			mav.addObject("menuNum", menuNum);
		}
		mav.setViewName("redirect:/");
		return mav;
	}

	// 占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占싸듸옙첼占� 占쏙옙占쏙옙풔占� 占쌨소듸옙 ( AWS 클占쏙옙占쏙옙 占쏙옙占� )
	@RequestMapping(value = "image.whame", method = RequestMethod.POST)
	public ModelAndView test(MultipartFile imagefile, Double lat, Double lon) throws Exception {
		this.lat = lat;
		this.lon = lon;
		System.out.println("lal" + lat + ":" + lon);
		MapTest mt = new MapTest();
		difflal = mt.run(lat, 1000);

		ModelAndView mav = new ModelAndView();
		String bucketName = "whame/StoreTitle";
		File convFile = new File(imagefile.getOriginalFilename());
		imagefile.transferTo(convFile);

		// 占쏙옙占쏙옙 占쏙옙占싸듸옙
		filepath = s3.fileUpload(bucketName, convFile);
		// history 媛꾪뙋�씠誘몄� �뙆�씪紐�
		history.setSignimage(filepath);
		String imgurl = s3.getFileURL(bucketName, filepath).split("AWSAccessKeyId")[0];
		mav.addObject("imgurl", imgurl);
		mav.addObject("lat",lat);
		mav.addObject("lon",lon);
		mav.setViewName("body/image");
		return mav;
	}

	// 占쏙옙占싸듸옙 占싱뱄옙占쏙옙占쏙옙 占쌨아쇽옙 Opencv 占쏙옙占쏙옙 占쏙옙 占싱뱄옙占쏙옙 占쏙옙占� 占쏙옙환 ( filename
	// )
	@ResponseBody
	@RequestMapping(value = "result.whame", method = RequestMethod.POST)
	public void openCV(ImageVO imagevo, String imgurl) throws Exception {
		Opencv ivo = new Opencv();
		imagevo.sortXY();
		System.out.println("run占쏙옙占쏙옙載�---------" + imgurl);
		BufferedImage img = ImageIO.read(new URL(imgurl));
		filepath = ivo.runOpencv(img, imagevo, imgurl);
	}
	

	@RequestMapping(value = "history.whame", method = RequestMethod.GET)
	public ModelAndView history(HttpSession session) {
		MemberVO membervo = (MemberVO) session.getAttribute("memberVO");
		ModelAndView mav = new ModelAndView();
		if (membervo != null) {
			if (membervo.getUserid() != null) {
				List<HistoryVO> list = service.getHistoryList(membervo.getUserid());
				System.out.println(list.size());
				List<LocationVO> historyLoc = service.getHistoryLoc(membervo.getUserid());
				List<Integer> hstore_code = service.gethstore_code(membervo.getUserid());
				HashMap<Integer, List<HistoryVO>> hList = new LinkedHashMap<Integer, List<HistoryVO>>();
				HashMap<Integer, List<String>> menutype = new HashMap<Integer, List<String>>();
				
				mav.addObject("historylist", list);
				mav.addObject("latalon", historyLoc.toString());
				mav.addObject("length", historyLoc.size());

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
						menutype.put(hstore_code.get(i), service.getMenuDistinct(hstore_code.get(i)));
					}
				}

				mav.addObject("hMap", hList);
				mav.addObject("storelist", sList);
				mav.addObject("locationlist", lList);
				mav.addObject("menulist", mList);
				mav.addObject("menutype",menutype);

				mav.setViewName("body/history");
			} else {
				mav.setViewName("redirect:/");
			}
		} else {
			mav.setViewName("redirect:/");
		}
		return mav;
	}


	@RequestMapping(value = "store.whame", method = RequestMethod.GET)
	public ModelAndView storeinfo(HttpSession session) {
		MemberVO membervo = (MemberVO) session.getAttribute("memberVO");
		ModelAndView mav = new ModelAndView();
		if (membervo != null) {
			if (membervo.getUserid() != null) {
				List<StoreVO> storelist = service.getStoreList(membervo.getUserid());
				HashMap<Integer, StoreVO> storemap = new HashMap<Integer, StoreVO>();
				HashMap<Integer, List<MenuVO>> menulist = new HashMap<Integer, List<MenuVO>>();
				HashMap<Integer, LocationVO> loclist = new HashMap<Integer, LocationVO>();
				List<TypeVO> typelist = service.getType();
				HashMap<Integer, List<String>> menutype = new HashMap<Integer, List<String>>();
				HashMap<Integer, List<CouponVO>> couponlist = new HashMap<Integer, List<CouponVO>>();
				
				if (storelist != null) {
					for (int i = 0; i < storelist.size(); i++) {
						List<MenuVO> mlist = service.getMenu(storelist.get(i).getStore_code());
						List<CouponVO> clist = service.getCoupon(storelist.get(i).getStore_code());
						LocationVO locaion = service.getLocation_info(storelist.get(i).getStore_code());
						StoreVO svo = service.getStore_info(storelist.get(i).getStore_code());
						storemap.put(storelist.get(i).getStore_code(), svo);
						menulist.put(storelist.get(i).getStore_code(), mlist);
						loclist.put(storelist.get(i).getStore_code(), locaion);
						couponlist.put(storelist.get(i).getStore_code(), clist);
						menutype.put(storelist.get(i).getStore_code(), service.getMenuDistinct(storelist.get(i).getStore_code()));
					}
				}
				
				mav.addObject("storeMap", storemap);
				mav.addObject("couponlist", couponlist);
				mav.addObject("menutype", menutype);
				mav.addObject("menulist", menulist);
				mav.addObject("storelist", storelist);
				mav.addObject("typelist", typelist);
				mav.addObject("loclist", loclist);
				mav.setViewName("body/storeform");
			} else {
				mav.setViewName("redirect:/");
			}
		} else {
			mav.setViewName("redirect:/");
		}
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "remenu.whame", method = RequestMethod.POST)
	public int re_menu(ReMenuVO rmvo) {
		return service.remenu(rmvo);
	}

	@ResponseBody
	@RequestMapping(value = "delmenu.whame", method = RequestMethod.POST)
	public int del_menu(ReMenuVO rmvo) {
		return service.delmenu(rmvo);
	}

	@ResponseBody
	@RequestMapping(value = "addmenu.whame", method = RequestMethod.POST)
	public int add_menu(MenuVO mvo) {
		return service.addmenu(mvo);
	}

	@ResponseBody
	@RequestMapping(value = "deleteStore.whame", method = RequestMethod.POST)
	public int deleteStore(int store_code) {
		return service.deleteStore(store_code);
	}
	
	@ResponseBody
	@RequestMapping(value="categoryDetail.whame", method=RequestMethod.POST)
	public List<String> getCategoryDetail(int store_category){
		List<String> result = service.getCategoryDetail(store_category);
		return result;
	}
	
	@RequestMapping(value = "getCategory.whame", method=RequestMethod.GET)
	public String getCategoryScreen1() {
		return "body/categoryview";
	}
	
	@ResponseBody
	@RequestMapping(value= "getTagStore.whame", method=RequestMethod.POST)
	public List<StoreVO> getTgStore(String tagClick){
		List<StoreVO> result = service.getTagStore(tagClick);
		return result;
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
	@RequestMapping(value="recoupon.whame", method=RequestMethod.POST)
	public void re_coupon(CouponVO cvo){
		service.recoupon(cvo);
	}
	
	@ResponseBody
	@RequestMapping(value="delcoupon.whame", method=RequestMethod.POST)
	public void del_coupon(CouponVO cvo){
		service.delcoupon(cvo);
	}
	
	@ResponseBody
	@RequestMapping(value="removeHistory.whame", method=RequestMethod.POST)
	public void removehistory(HistoryVO historyvo){
		service.removeHistory(historyvo);
	}
	
	@ResponseBody
	@RequestMapping(value="search.whame", method=RequestMethod.POST)
	public List<StoreInitVO> getSearchStore(String menuSearch, String choice, double clat, double clon, int meter){
		System.out.println(meter);
		MapTest mt = new MapTest();
		difflal = mt.run(clat, meter);
		WhameVO wvo = new WhameVO();
		wvo.setLat(clat);
		wvo.setLon(clon);
		wvo.setDifflat(difflal.get(0));
		wvo.setDifflon(difflal.get(1));
		List<StoreInitVO> result = service.tagResult(menuSearch, choice, wvo);
		
		for(StoreInitVO svo : result){
			svo.setMeter(mt.distance(clat, clon, svo.getLat(), svo.getLon(), "meter"));
		}
		return result;
	}
	@RequestMapping(value = "qna.whame", method = RequestMethod.GET)
	public String qna (){
		return "qna/qna";
	}
	@RequestMapping(value = "email.whame", method = RequestMethod.GET)
	public String email (HttpServletRequest request) throws IOException{
		String title = request.getParameter("title");
		String name = request.getParameter("name");
		String pw = request.getParameter("pw");
		String memo = request.getParameter("memo");
		String email = request.getParameter("email");
		
/*		System.out.println(title);
		System.out.println(name);
		System.out.println(pw);
		System.out.println(memo);
		System.out.println(email);*/
		
		Mail mail = new Mail();
		mail.sendmail(title, name, pw, memo,email);
		return "qna/qna";
	}
}
