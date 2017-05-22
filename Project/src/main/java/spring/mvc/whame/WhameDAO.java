package spring.mvc.whame;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import spring.mvc.whame.color.ColorClass;
import spring.mvc.whame.color.ColorVO;
import spring.mvc.whame.region.LocationVO;
import spring.mvc.whame.region.RegionVO;
import spring.mvc.whame.store.MenuVO;
import spring.mvc.whame.store.StoreVO;
import spring.mvc.whame.store.TypeVO;
import spring.mvc.whame.vision.TextApp;


@Component
public class WhameDAO {

	@Autowired
	SqlSession session;
	
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
			System.out.println("dao 위도경도 결과 " + vo);
		}
		if(whamevo.getText().get(0).getText().equals("")){
			codeList = session.selectList("whame.searchColor", whamevo);
			if(codeList.size() != 0){
				System.out.println("color접근");
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
				System.out.println("text접근");
				for(Integer i : codeList){
					System.out.println();
					count.add(i);				
				}
			}
			else{
				System.out.println("name접근");
				codeList = session.selectList("whame.searchTextName", whamevo);
				for(Integer i : codeList){
					count.add(i);				
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
}
