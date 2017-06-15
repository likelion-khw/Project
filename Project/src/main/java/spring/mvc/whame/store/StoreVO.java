package spring.mvc.whame.store;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;


@Component
public class StoreVO {
	
		//store
		private int store_code;	
		private String business_code;
		private String userid;
		private String operating_time;
		private String store_name;
		private String store_category;
		private String store_image;
		private int view_count;
		
		private int rcode;//r
		private String address;//l
		private String dong;
		private MultipartFile imagefile;//	//���ε����� ��������
		private String image;
		int store_text;
		int store_color;
		
		public int getStore_code() {
			return store_code;
		}
		public void setStore_code(int store_code) {
			this.store_code = store_code;
		}
		public String getBusiness_code() {
			return business_code;
		}
		public void setBusiness_code(String business_code) {
			this.business_code = business_code;
		}
		public int getRcode() {
			return rcode;
		}
		public void setRcode(int rcode) {
			this.rcode = rcode;
		}
		public String getUserid() {
			return userid;
		}
		public void setUserid(String userid) {
			this.userid = userid;
		}
		public String getStore_category() {
			return store_category;
		}
		public void setStore_category(String store_category) {
			this.store_category = store_category;
		}
		public String getOperating_time() {
			return operating_time;
		}
		public void setOperating_time(String operating_time) {
			this.operating_time = operating_time;
		}
		public String getStore_name() {
			return store_name;
		}
		public void setStore_name(String store_name) {
			this.store_name = store_name;
		}
		public int getView_count() {
			return view_count;
		}
		public void setView_count(int view_count) {
			this.view_count = view_count;
		}
		
		
		public MultipartFile getImagefile() {
			return imagefile;
		}
		public void setImagefile(MultipartFile imagefile) {
			this.imagefile = imagefile;
			setImage(imagefile.getOriginalFilename());
		}
		public String getImage() {
			return image;
		}
		public void setImage(String image) {
			this.image = image;
		}
		public int getStore_text() {
			return store_text;
		}
		public void setStore_text(int store_text) {
			this.store_text = store_text;
		}
		public int getStore_color() {
			return store_color;
		}
		public void setStore_color(int store_color) {
			this.store_color = store_color;
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
		
		public String getStore_image() {
			return store_image;
		}
		public void setStore_image(String store_image) {
			this.store_image = store_image;
		}
		@Override
		public String toString() {
			return store_code+"";
		}		
		
	
}
