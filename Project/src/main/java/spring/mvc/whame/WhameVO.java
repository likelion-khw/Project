package spring.mvc.whame;

import java.util.List;

import spring.mvc.whame.color.ColorVO;

public class WhameVO {
	
	private List<TextVO> text;
	private ColorVO color;
	private int rcode;
	private double lat;
	private double lon;
	private double difflat;
	private double difflon;
	
	public List<TextVO> getText() {
		return text;
	}
	public void setText(List<TextVO> text) {
		this.text = text;
	}
	public ColorVO getColor() {
		return color;
	}
	public void setColor(ColorVO color) {
		this.color = color;
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
	public double getDifflat() {
		return difflat;
	}
	public void setDifflat(double difflat) {
		this.difflat = difflat;
	}
	public double getDifflon() {
		return difflon;
	}
	public void setDifflon(double difflon) {
		this.difflon = difflon;
	}
	
	
}
