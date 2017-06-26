package spring.mvc.whame.region;

public class LocationVO {
	private int store_code;
	private int rcode;
	private double lat;
	private double lon;
	private String address;
	private String dong;
	
	public int getStore_code() {
		return store_code;
	}
	public void setStore_code(int store_code) {
		this.store_code = store_code;
	}
	public int getRcode() {
		return rcode;
	}
	public void setRcode(int rcode) {
		this.rcode = rcode;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLon() {
		return lon;
	}
	public void setLon(double lon) {
		this.lon = lon;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getDong() {
		return dong;
	}
	
	public void setDong(String dong) {
		this.dong = dong;
	}
	@Override
	public String toString() {
		return store_code + "," +lat+","+lon;
	}
}
