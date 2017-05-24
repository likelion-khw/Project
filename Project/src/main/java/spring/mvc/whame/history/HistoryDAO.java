package spring.mvc.whame.history;

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
		System.out.println(userid);
		List<HistoryVO> result = session.selectList("history.getlist", userid);
		return result;
	}
	
	public void setHistory(HistoryVO historyvo){
		session.insert("history.sethistory", historyvo);
	}
	
	public List<LocationVO> getHistoryLoc(String userid){
		return session.selectList("history.getLoc",userid);
	}
}