package spring.mvc.whame;

import java.util.List;

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

public interface WhameService {
	public List<TextVO> ocr(String filename);/*StoreVO storevo*/
	public ColorVO color(String filename);/*StoreVO storevo*/
	
	public List<RegionVO> getrcode();
	public List<RegionVO> getrcode2(String gu);
	public int getrcodeNum(String rname);

	public int enroll(StoreVO storevo, String filename);
	public List<TypeVO> getType();
	public int insertmenu(List<MenuVO> menuList);
	public int searchInfo(WhameVO whamevo);
	public List<MenuVO> getMenu(int store_code);
	public StoreVO getStore_info(int store_code);
	public LocationVO getLocation_info(int store_code);
	
	public void setLocation(LocationVO lvo);
	
	public List<HistoryVO> getHistoryList(String userid);
	public void setHistory(HistoryVO historyvo);
	public List<LocationVO> getHistoryLoc(String userid);
	
	public List<StoreVO> getStoreList(String userid);
	public int getStoreCount();
	
	public int remenu(ReMenuVO rmvo);
	public int delmenu(ReMenuVO rmvo);
	public int addmenu(MenuVO mvo);
	
	public int deleteStore(int store_code);
	
	public List<HistoryVO> getHistoryListGroup(int store_code, String userid);
	public List<Integer> gethstore_code(String userid);
	
	public List<LocationVO> getlocation_list();
	
	public List<String> getMenuDistinct(int store_code);
	
	public List<CouponVO> getCoupon(int store_code);
	public List<CouponVO> getNowCoupon(int store_code);
	
	public void storeUpdate(StoreVO svo, LocationVO lvo);
	public void couponInsert(CouponVO cvo);
	
	public void recoupon(CouponVO cvo);
	public void delcoupon(CouponVO cvo);
	public void viewcount(int store_code);
	
	public List<String> getCategoryDetail(int store_category);
	public List<StoreVO> getTagStore(String tagClick);
	
	public List<StoreVO> getCountRanklist();
	
	public void removeHistory(HistoryVO historyvo);
	
	public List<StoreInitVO> tagResult(String menuSearch, String choice, WhameVO wvo);
	
	public List<StoreVO> getNewStore();
	
	public List<String> getMenuAuto();
}
