package spring.mvc.whame;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.mvc.whame.color.ColorVO;
import spring.mvc.whame.region.RegionVO;
import spring.mvc.whame.store.MenuVO;
import spring.mvc.whame.store.StoreVO;
import spring.mvc.whame.store.TypeVO;

@Service("whameService")
public class WhameServiceImpl implements WhameService{

	
	@Autowired
	WhameDAO dao;
	
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
	
	
	
	
}
