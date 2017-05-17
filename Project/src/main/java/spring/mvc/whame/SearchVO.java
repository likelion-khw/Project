package spring.mvc.whame;

import spring.mvc.whame.color.ColorVO;

public class SearchVO {
	private String text;
	private ColorVO color;
	private int rcode;
	
	public String getText() {
		return text;
	}
	public void setText(String text) {
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
	
	
}
