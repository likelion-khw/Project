package spring.mvc.whame;

import java.util.List;

import spring.mvc.whame.color.ColorVO;
import spring.mvc.whame.history.HistoryVO;
import spring.mvc.whame.region.LocationVO;
import spring.mvc.whame.region.RegionVO;
import spring.mvc.whame.store.MenuVO;
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
	
	public void setLocation(LocationVO lvo);
	
	public List<HistoryVO> getHistoryList(String userid);
	public void setHistory(HistoryVO historyvo);
	public List<LocationVO> getHistotyLoc(String userid);
	
}
