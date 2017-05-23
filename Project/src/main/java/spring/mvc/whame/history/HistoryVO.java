package spring.mvc.whame.history;

import org.springframework.stereotype.Component;

@Component
public class HistoryVO {
	
	private int historyid;
	private int store_code;
	private String userid;
	private String signimage;	//파일이름
	
	public int getHistoryid() {
		return historyid;
	}
	public void setHistoryid(int historyid) {
		this.historyid = historyid;
	}
	public int getStore_code() {
		return store_code;
	}
	public void setStore_code(int store_code) {
		this.store_code = store_code;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSignimage() {
		return signimage;
	}
	public void setSignimage(String signimage) {
		this.signimage = signimage;
	}
	
	
	
}
