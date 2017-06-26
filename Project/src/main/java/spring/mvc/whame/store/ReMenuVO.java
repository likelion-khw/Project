package spring.mvc.whame.store;

public class ReMenuVO {
	private int store_code;
	private String ori_name;
	private String new_name;
	private int new_price;
	private String new_type;
	
	public int getStore_code() {
		return store_code;
	}
	public void setStore_code(int store_code) {
		this.store_code = store_code;
	}
	public String getOri_name() {
		return ori_name;
	}
	public void setOri_name(String ori_name) {
		this.ori_name = ori_name;
	}
	public String getNew_name() {
		return new_name;
	}
	public void setNew_name(String new_name) {
		this.new_name = new_name;
	}
	public int getNew_price() {
		return new_price;
	}
	public void setNew_price(int new_price) {
		this.new_price = new_price;
	}
	public String getNew_type() {
		return new_type;
	}
	public void setNew_type(String new_type) {
		this.new_type = new_type;
	}
	
	
}
