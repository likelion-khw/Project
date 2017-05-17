package spring.mvc.whame.store;

public class MenuVO {
	
	private int store_code;
	private String menu_name;
	private int menu_price;
	private String menu_type;
	
	
	
/*	public MenuVO(int store_code, String menu_name, int menu_price, String menu_type) {
		this.store_code = store_code;
		this.menu_name = menu_name;
		this.menu_price = menu_price;
		this.menu_type = menu_type;
	}
	*/
	public int getStore_code() {
		return store_code;
	}
	public void setStore_code(int menu_code) {
		this.store_code = menu_code;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public int getMenu_price() {
		return menu_price;
	}
	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}
	public String getMenu_type() {
		return menu_type;
	}
	public void setMenu_type(String menu_type) {
		this.menu_type = menu_type;
	}
	
	
}
