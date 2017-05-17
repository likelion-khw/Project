package spring.mvc.whame;

import java.util.List;

import spring.mvc.whame.color.ColorVO;

public class WhameVO {
	
	private List<TextVO> text;
	private ColorVO color;
	private int rcode;
	
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
	
	
}
