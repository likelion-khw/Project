package spring.mvc.whame.history;

public class HistoryVO {
	private int store_code;
	private float lat;
	private float lon;
	public int getStore_code() {
		return store_code;
	}
	public void setStore_code(int store_code) {
		this.store_code = store_code;
	}
	public float getLat() {
		return lat;
	}
	public void setLat(float lat) {
		this.lat = lat;
	}
	public float getLon() {
		return lon;
	}
	public void setLon(float lon) {
		this.lon = lon;
	}
	@Override
	public String toString() {
		return +lat+","+lon ;
	}
}
