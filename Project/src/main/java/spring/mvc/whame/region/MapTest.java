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
		
	    //반경 m이내의 위도차(degree)
	    public double LatitudeInDifference(int diff){
	        //지구반지름
	        final int earth = 6371000;    //단위m
	 
	        return (diff*360.0) / (2*Math.PI*earth);
	    }
	 
	    //반경 m이내의 경도차(degree)
	    public double LongitudeInDifference(double _latitude, int diff){
	        //지구반지름
	        final int earth = 6371000;    //단위m
	 
	        double ddd = Math.cos(0);
	        double ddf = Math.cos(Math.toRadians(_latitude));
	 
	        return (diff*360.0) / (2*Math.PI*earth*Math.cos(Math.toRadians(_latitude)));
	    }
	

}