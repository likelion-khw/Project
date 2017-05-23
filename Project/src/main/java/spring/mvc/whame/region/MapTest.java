package spring.mvc.whame.region;

import java.util.ArrayList;
import java.util.List;

public class MapTest  {
		 
		
		public List<Double> run(double lat, int m){
			
			List<Double> list = new ArrayList<Double>();
			
			double diffLatitude = LatitudeInDifference(m);
			double diffLongitude = LongitudeInDifference(lat, m);
			
			list.add(diffLatitude);
			list.add(diffLongitude);
			
			return list;
		}
		
	    //�ݰ� m�̳��� ������(degree)
	    public double LatitudeInDifference(int diff){
	        //����������
	        final int earth = 6371000;    //����m
	 
	        return (diff*360.0) / (2*Math.PI*earth);
	    }
	 
	    //�ݰ� m�̳��� �浵��(degree)
	    public double LongitudeInDifference(double _latitude, int diff){
	        //����������
	        final int earth = 6371000;    //����m
	 
	        double ddd = Math.cos(0);
	        double ddf = Math.cos(Math.toRadians(_latitude));
	 
	        return (diff*360.0) / (2*Math.PI*earth*Math.cos(Math.toRadians(_latitude)));
	    }
	

}
