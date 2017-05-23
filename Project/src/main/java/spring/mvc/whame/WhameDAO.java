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
import spring.mvc.whame.history.HistoryVO;
import spring.mvc.whame.login.MemberVO;
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
		
/*		for(int listnum=0; listnum<whamevo.getText().size(); listnum++){
			for(int i=0; i < whamevo.getText().get(listnum).getText().length()-2 ; i++){
				String twotext = whamevo.getText().get(listnum).getText().substring(i, i+2);
				codeList = session.selectList("whame.searchInfoText", twotext);
				for(Integer ii : codeList){
					System.out.println(ii);
					count.add(ii);				
				}
			}
			
		}
		
		for(TextVO text : whamevo.getText()){
			String textString = text.getText();
			codeList = session.selectList("whame.searchInfoText", textString);
			if(codeList != null){
				for(Integer i : codeList){
					count.add(i);				
				}
			}
		}
		SearchVO searchvo = new SearchVO();
		searchvo.setColor(whamevo.getColor());
		searchvo.setRcode(whamevo.getRcode());
		for(TextVO text : whamevo.getText()){
			searchvo.setText(text.getText());
			codeList = session.selectList("whame.searchInfoColor", searchvo);
			System.out.println(codeList);
			if(codeList != null){
				for(Integer i : codeList){
					count.add(i);				
				}
			}
		}*/
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
	public List<HistoryVO> getHistory(String userid){
		return session.selectList("whame.getHistory",userid);
	}
}
