package spring.mvc.whame.history;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import spring.mvc.whame.region.LocationVO;

@Component
public class HistoryDAO {

	@Autowired
	SqlSession session;
	
	public List<HistoryVO> getHistoryList(String userid){
		List<HistoryVO> result = session.selectList("history.getlist", userid);
		return result;
	}
	
	public List<HistoryVO> getHistoryListGroup(int store_code, String userid){
		HistoryVO vo = new HistoryVO();
		vo.setUserid(userid);
		vo.setStore_code(store_code);
		List<HistoryVO> result = session.selectList("history.getlistGroup", vo);
		return result;
	}
	
	public void setHistory(HistoryVO historyvo){
		session.insert("history.sethistory", historyvo);
	}
	
	public List<LocationVO> getHistoryLoc(String userid){
		return session.selectList("history.getLoc",userid);
	}
	
	public List<Integer> gethstore_code(String userid) {
		return session.selectList("history.gethstore_code", userid);
	}
	
	public void removeHistory(HistoryVO historyvo){
		session.delete("history.removehistory", historyvo);
	}
}