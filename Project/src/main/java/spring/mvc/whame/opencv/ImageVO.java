package spring.mvc.whame.opencv;

public class ImageVO {
	private String root;
	private String one;
	private String two;
	private String three;
	private String four;
	
	private String one_xy[];
	private String two_xy[];
	private String three_xy[];
	private String four_xy[];
	
	
	public String getRoot() {
		return root;
	}
	public void setRoot(String root) {
		this.root = root;
	}
	
	public String getOne() {
		return one;
	}
	public void setOne(String one) {
		this.one = one;
		this.one_xy = one.split(":");
	}
	public String getTwo() {
		return two;
	}
	public void setTwo(String two) {
		this.two = two;
		this.two_xy = two.split(":");
	}
	public String getThree() {
		return three;
	}
	public void setThree(String three) {
		this.three = three;
		this.three_xy = three.split(":");
	}
	public String getFour() {
		return four;
	}
	public void setFour(String four) {
		this.four = four;
		this.four_xy = four.split(":");
	}
	public String[] getOne_xy() {
		return one_xy;
	}
	public void setOne_xy(String[] one_xy) {
		this.one_xy = one_xy;
	}
	public String[] getTwo_xy() {
		return two_xy;
	}
	public void setTwo_xy(String[] two_xy) {
		this.two_xy = two_xy;
	}
	public String[] getThree_xy() {
		return three_xy;
	}
	public void setThree_xy(String[] three_xy) {
		this.three_xy = three_xy;
	}
	public String[] getFour_xy() {
		return four_xy;
	}
	public void setFour_xy(String[] four_xy) {
		this.four_xy = four_xy;
	}
	
	
	
}
