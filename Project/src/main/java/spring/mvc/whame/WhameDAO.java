package spring.mvc.whame;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import spring.mvc.whame.color.ColorClass;
import spring.mvc.whame.color.ColorVO;
import spring.mvc.whame.history.HistoryVO;
import spring.mvc.whame.region.LocationVO;
import spring.mvc.whame.region.RegionVO;
import spring.mvc.whame.store.CouponVO;
import spring.mvc.whame.store.MenuVO;
import spring.mvc.whame.store.ReMenuVO;
import spring.mvc.whame.store.StoreInitVO;
import spring.mvc.whame.store.StoreVO;
import spring.mvc.whame.store.TypeVO;
import spring.mvc.whame.vision.TextApp;


@Component
public class WhameDAO {

	@Autowired
	SqlSession session;
	
	@Autowired
	StoreInitVO storeinitvo;
	
	TextApp ocr;
	ColorClass color;
		
	public List<TextVO> ocr(String filename){
		List<TextVO> result=new ArrayList<TextVO>();
		try {
			result = ocr.run(filename);
		} catch (IOException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public ColorVO color(String filename){
		return color.run(filename);
	}
	
	public List<RegionVO> getrcode(){
		List<RegionVO> result = session.selectList("whame.getgu");
		return result;
	}
	
	public List<RegionVO> getrcode2(String gu){
		List<RegionVO> result = session.selectList("whame.getrcode", gu);
		return result;
	}
	
	public int getrcodeNum(String rname){
		int result =  session.selectOne("whame.getrcodeNum", rname);
		return result;
	}
	
	public int enroll(StoreVO storevo, String filename){
		List<TextVO> ocr_result = new ArrayList<TextVO>();
		session.insert("whame.enroll", storevo);
		int store_code = session.selectOne("whame.getstore_code",storevo.getBusiness_code());
		try {
			ocr_result = ocr.run2(filename, store_code);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ColorVO color_result = color.run2(filename, store_code);
		session.insert("whame.setColor", color_result);
		for(TextVO vo : ocr_result){			
			session.insert("whame.setText", vo);
		}
		return store_code;
	}
	
	public void setLocation(LocationVO lvo){
		session.insert("whame.setLocation", lvo);
	}
	
	public List<TypeVO> getType(){
		List<TypeVO> test = session.selectList("whame.getType");
		System.out.println(test.size());
		return test;
	}
	
	public int insertmeun(List<MenuVO> menulist){
		for(MenuVO vo : menulist){
			session.insert("whame.setMenu", vo);			
		}
		
		return menulist.size();
	}
	
	public int searchInfo(WhameVO whamevo){
		List<Integer> codeList = new ArrayList<Integer>();
		List<Integer> count = new ArrayList<Integer>();
		System.out.println("whameText: " +whamevo.getText().get(0).getText());
		
		List<Integer> l_code = session.selectList("whame.searchLoc", whamevo);
		for(Integer vo : l_code){
			System.out.println("location범위 " + vo);
		}
			
		if(whamevo.getText().get(0).getText().equals("")){
			codeList = session.selectList("whame.searchColor", whamevo);
			if(codeList.size() != 0){
				System.out.println("color에 접근");
				for(Integer i : codeList){
					System.out.println(i);
					count.add(i);				
				}
			}
		}
		else{
			codeList = session.selectList("whame.searchText", whamevo);
			System.out.println(codeList);
			if(codeList.size() != 0){
				System.out.println("text에접근");
				for(Integer i : codeList){
					System.out.println(i);
					count.add(i);				
				}
			}
			else{
				System.out.println("name에접근");
				codeList = session.selectList("whame.searchTextName", whamevo);
				for(Integer i : codeList){
					System.out.println(i);
					count.add(i);				
				}
				if(codeList.size() == 0){
					System.out.println("namecut에 접근");
					whamevo.setTextString(whamevo.getText());
					System.out.println("whametext붙이기:::"+whamevo.getTextString());
					codeList = session.selectList("whame.searchTextNameCut", whamevo);
					for(Integer i : codeList){
						System.out.println(i);
						count.add(i);
					}
					/*
					 * System.out.println("color에 접근");
					codeList = session.selectList("whame.searchColor", whamevo);
					for(Integer i : codeList){
						System.out.println(i);
						count.add(i);				
					*/
				}
			}
		}
		if(count.size() == 0){
			return 0;
		}
		return count.get(0);
	}
	
	public List<MenuVO> getMenu(int store_code) {
		
		List<MenuVO> result = session.selectList("whame.getMenu", store_code);
		return result;
	}
	
	
	public StoreVO getStore_info(int store_code){
		StoreVO result = session.selectOne("whame.getstore_info", store_code);
		return result;
	}
	
	public LocationVO getLocation_info(int store_code){
		LocationVO result = session.selectOne("whame.getlocation_info", store_code);
		return result;
	}
	
	public List<StoreVO> getStoreList(String userid){
		List<StoreVO> result = session.selectList("whame.getStore", userid);
		if(result.isEmpty())
		{
			result = null;
		}
		return result;
	}
	
	public int getStoreCount(){
		return session.selectOne("whame.getStoreCount");
	}
	
	public int remenu(ReMenuVO rmvo){
		return session.update("whame.reMenu", rmvo);
	}
	public int delmenu(ReMenuVO rmvo){
		return session.delete("whame.delMenu",rmvo);
	}
	
	public int addmenu(MenuVO mvo){
		return session.delete("whame.setMenu",mvo);
	}
	
	public int deleteStore(int store_code){
		session.delete("whame.delstore0",store_code);
		session.delete("whame.delstore1",store_code);
		session.delete("whame.delstore2",store_code);
		session.delete("whame.delstore3",store_code);
		session.delete("whame.delstore4",store_code);
		
		return session.delete("whame.delstore5",store_code);
	}
	
	public List<HistoryVO> getHistoryListGroup(int store_code, String userid){
		HistoryVO vo = new HistoryVO();
		vo.setUserid(userid);
		vo.setStore_code(store_code);
		List<HistoryVO> result = session.selectList("history.getlistGroup", vo);
		return result;
	}
	
	public List<Integer> gethstore_code(String userid) {
		return session.selectList("history.gethstore_code", userid);
	}
	
	public List<LocationVO> getlocation_list(){
		return session.selectList("whame.getlocationList");
	}
	
	public List<String> getMenuDistinct(int store_code){
		return session.selectList("whame.getMenuTypeDistinct",store_code);
	}
	
	public List<CouponVO> getCoupon(int store_code){
		Date date = new Date();
		 List<CouponVO> clist = session.selectList("whame.getCoupon" , store_code);
		 for(CouponVO cvo : clist){
				if(date.before(cvo.getS_time())){
					cvo.setState("예정");
				}
				else if(date.after(cvo.getE_time())){
					cvo.setState("종료");
				}
				else{
					cvo.setState("진행중");
				}
		 }
		 return clist;
	}
	
	public List<CouponVO> getNowCoupon(int store_code){
		 List<CouponVO> result = session.selectList("whame.getNowCoupon", store_code);
		 for(CouponVO cvo : result){
			 cvo.setState("진행중");
		 }
		 return result;
	}	
	
	public void storeUpdate(StoreVO svo, LocationVO lvo) {
		session.update("whame.storeUpdate_store", svo);
		session.update("whame.storeUpdate_loc", lvo);
	}
	
	public void couponInsert(CouponVO cvo){
		session.insert("whame.setCoupon", cvo);
	}
	
	public void recoupon(CouponVO cvo){
		session.update("whame.reCoupon",cvo);
	}

	public void delcoupon(CouponVO cvo){
		session.delete("whame.delCoupon", cvo);
	}
	
	public void viewcount(int store_code) {
		session.update("whame.viewcount", store_code);
	}

	public List<String> getCategoryDetail(int store_category){	
		return session.selectList("whame.getCategory", store_category);
	}
	
	public List<StoreVO> getTagStore(String tagClick){
		return session.selectList("whame.getTagStore", tagClick);
	}
	
	public List<StoreVO> getCountRanklist(){
		return session.selectList("whame.getCountRanklist");
	}
	
	public List<StoreInitVO> getAllinitData(){
		return session.selectList("whame.initAllData");
	}
	public List<MenuVO> getAllMenu(){
		return session.selectList("whame.initAllMenu");
	}
	
	public List<StoreVO> getNewStore(){
		return session.selectList("whame.getNewStore");
	}
	
	public List<Integer> getCategoryLoc(WhameVO wvo){
		return session.selectList("whame.searchLoc", wvo);
	}
}
