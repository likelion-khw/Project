package spring.mvc.whame.opencv;

import java.util.ArrayList;

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
	
	public void sortXY(){
		int temp[] = new int[5];
		temp[0] = Integer.parseInt(one_xy[0]) + Integer.parseInt(one_xy[1]);
		temp[1] = Integer.parseInt(two_xy[0]) + Integer.parseInt(two_xy[1]);
		temp[2] = Integer.parseInt(three_xy[0]) + Integer.parseInt(three_xy[1]);
		temp[3] = Integer.parseInt(four_xy[0]) + Integer.parseInt(four_xy[1]);
		ArrayList<String[]> templist = new ArrayList<String[]>();
		templist.add(this.one_xy);
		templist.add(this.two_xy);
		templist.add(this.three_xy);
		templist.add(this.four_xy);
		String temp2[];
		
		for(int i=0; i<3; i++)
		{
			for(int j=i+1; j<4; j++)
			{
				if(temp[i] > temp[j])
				{
					temp[4] = temp[i];
					temp[i] = temp[j];
					temp[j] = temp[4];
					
					temp2 = templist.get(i);
					templist.set(i,templist.get(j));
					templist.set(j,temp2);
				}
			}
		}
		
		this.one_xy = templist.get(0);
		this.two_xy = templist.get(1);
		this.three_xy = templist.get(3);
		this.four_xy = templist.get(2);
		
	}
	
	
	
}
