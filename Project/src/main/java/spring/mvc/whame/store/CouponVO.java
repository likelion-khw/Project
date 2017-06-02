package spring.mvc.whame.store;

import java.sql.Date;

public class CouponVO {
	
	private int store_code;
	private int coupon_code;
	private String contents;
	private Date s_time;
	private Date e_time;
	private String state;
	
	public int getStore_code() {
		return store_code;
	}
	
	
	public int getCoupon_code() {
		return coupon_code;
	}


	public void setCoupon_code(int coupon_code) {
		this.coupon_code = coupon_code;
	}


	public void setStore_code(int store_code) {
		this.store_code = store_code;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getS_time() {
		return s_time;
	}
	public void setS_time(Date s_time) {
		this.s_time = s_time;
	}
	public Date getE_time() {
		return e_time;
	}
	public void setE_time(Date e_time) {
		this.e_time = e_time;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	
}