package spring.mvc.whame;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.mvc.whame.color.ColorVO;
import spring.mvc.whame.history.HistoryDAO;
import spring.mvc.whame.history.HistoryVO;
import spring.mvc.whame.region.LocationVO;
import spring.mvc.whame.region.RegionVO;
import spring.mvc.whame.store.CouponVO;
import spring.mvc.whame.store.MenuVO;
import spring.mvc.whame.store.ReMenuVO;
import spring.mvc.whame.store.StoreInitVO;
import spring.mvc.whame.store.StoreVO;
import spring.mvc.whame.store.TypeVO;

@Service("whameService")
public class WhameServiceImpl implements WhameService{

	
	@Autowired
	WhameDAO dao;
	
	@Autowired
	HistoryDAO hdao;
	
	private List<StoreInitVO> storeInit;
	private List<MenuVO> menuInit;
	
	@PostConstruct
	public void init(){
		System.out.println("init생성");
		storeInit = dao.getAllinitData();
		menuInit = dao.getAllMenu();
	}
	
	@Override
	public List<TextVO> ocr(String filename) {
		List<TextVO> result = dao.ocr(filename);
		return result;
	}

	@Override
	public ColorVO color(String filename) {
		ColorVO result = dao.color(filename);
		return result;
	}

	@Override
	public List<RegionVO> getrcode() {
		List<RegionVO> result =  dao.getrcode();
		return result;
	}
	

	@Override
	public List<RegionVO> getrcode2(String gu) {
		List<RegionVO> result = dao.getrcode2(gu);
		return result;
	}

	@Override
	public int getrcodeNum(String rname) {
		int result = dao.getrcodeNum(rname);
		return result;
	}

	@Override
	public int enroll(StoreVO storevo, String filename) {
		int result = dao.enroll(storevo, filename);
		return result;
	}

	@Override
	public List<TypeVO> getType() {
		return dao.getType();
	}

	@Override
	public int insertmenu(List<MenuVO> menuList) {
		return dao.insertmeun(menuList);
	}

	@Override
	public int searchInfo(WhameVO whamevo) {
		return dao.searchInfo(whamevo);
	}

	@Override
	public List<MenuVO> getMenu(int store_code) {
		return dao.getMenu(store_code);
	}
	
	@Override
	public StoreVO getStore_info(int store_code) {
		return dao.getStore_info(store_code);
	}

	@Override
	public LocationVO getLocation_info(int store_code) {
		return dao.getLocation_info(store_code);
	}

	public void setLocation(LocationVO lvo) {
		dao.setLocation(lvo);
	}
	
	@Override
	public List<HistoryVO> getHistoryList(String userid) {
		return hdao.getHistoryList(userid);
	}

	@Override
	public void setHistory(HistoryVO historyvo) {
		hdao.setHistory(historyvo);		
	}
	
	@Override
	public List<LocationVO> getHistoryLoc(String userid){
		return hdao.getHistoryLoc(userid);
	}
	
	public List<StoreVO> getStoreList(String userid){
		return dao.getStoreList(userid);
	}
	
	public int getStoreCount(){
		return dao.getStoreCount();
	}
	
	public int remenu(ReMenuVO rmvo){
		return dao.remenu(rmvo);
	}
	public int delmenu(ReMenuVO rmvo){
		return dao.delmenu(rmvo);
	}
	
	public int addmenu(MenuVO mvo){
		return dao.addmenu(mvo);
	}
	
	public int deleteStore(int store_code){
		return dao.deleteStore(store_code);
	}
	
	@Override
	public List<HistoryVO> getHistoryListGroup(int store_code, String userid) {
		return hdao.getHistoryListGroup(store_code, userid);
	}

	@Override
	public List<Integer> gethstore_code(String userid) {
		return hdao.gethstore_code(userid);
	}
	
	public List<LocationVO> getlocation_list(){
		return dao.getlocation_list();
	}
	
	public List<String> getMenuDistinct(int store_code){
		return dao.getMenuDistinct(store_code);
	}
	
	public List<CouponVO> getCoupon(int store_code){
		return dao.getCoupon(store_code);
	}
	
	
	public void storeUpdate(StoreVO svo, LocationVO lvo) {
		dao.storeUpdate(svo, lvo);
	}

	public void couponInsert(CouponVO cvo){
		dao.couponInsert(cvo);
	}
	
	public List<CouponVO> getNowCoupon(int store_code){
		return dao.getNowCoupon(store_code);
	}
	public void recoupon(CouponVO cvo){
		dao.recoupon(cvo);
	}
	
	public void delcoupon(CouponVO cvo){
		dao.delcoupon(cvo);
	}
	
	@Override
	public void viewcount(int store_code) {
		dao.viewcount(store_code);
	}
	
	public List<String> getCategoryDetail(int store_category){	
		return dao.getCategoryDetail(store_category);
	}
	
	public List<StoreVO> getTagStore(String tagClick){
		System.out.println(tagClick);
		return dao.getTagStore(tagClick);
	}
	
	public List<StoreVO> getCountRanklist(){
		return dao.getCountRanklist();
	}
	
	public void removeHistory(HistoryVO historyvo){
		hdao.removeHistory(historyvo);
	}
	
	public List<StoreInitVO> tagResult(String menuSearch, String choice, WhameVO wvo){
		//중복체크
		List<Integer> scodeCheck = new ArrayList<Integer>();
		List<StoreInitVO> result = new ArrayList<StoreInitVO>();
		List<Integer> cloc_code = dao.getCategoryLoc(wvo);
		if(choice.equals("tag")){
			for(int i = 0; i < storeInit.size(); i++){
				if(menuSearch.equals(storeInit.get(i).getStore_category())){
					for(Integer j : cloc_code){
						if(j == storeInit.get(i).getStore_code()){
							result.add(storeInit.get(i));						
						}
					}
				}
			}
		}else if(choice.equals("search")){
			for(int i = 0; i < menuInit.size(); i++){
				if(menuInit.get(i).getMenu_name().contains(menuSearch)){
					for(int j = 0; j<storeInit.size(); j++){
						for(Integer jj : cloc_code){
							if(menuInit.get(i).getStore_code() == storeInit.get(j).getStore_code() 
									&& jj == storeInit.get(j).getStore_code() && result.contains(storeInit.get(j)) == false){
								result.add(storeInit.get(j));
							}
						}
						
					}
				}
			}
		}
		return result;
	}
	
	public List<StoreVO> getNewStore(){
		return dao.getNewStore();
	}
	
	public List<String> getMenuAuto(){
		List<String> menu = new ArrayList<String>();
		
		for(MenuVO mvo : menuInit){
			int check = 0;
			for(String s: menu){
				if(s.equals(mvo.getMenu_name().split("\\(")[0].replace(" ", "")))
				{
					check++;
				}
			}
			
			if(check == 0){menu.add(mvo.getMenu_name().split("\\(")[0].replace(" ", ""));}
		}
		
		System.out.println(menu.size());
		
		return menu;
	}
}
