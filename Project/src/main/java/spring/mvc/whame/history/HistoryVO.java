package spring.mvc.whame.history;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class HistoryVO {
	
	private int historyid;
	private int store_code;
	private String userid;
	private String signimage;	//ÆÄÀÏÀÌ¸§
	private Date h_date;
	
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
	public Date getH_date() {
		return h_date;
	}
	public void setH_date(Date h_date) {
		this.h_date = h_date;
	}
	
	
	
}