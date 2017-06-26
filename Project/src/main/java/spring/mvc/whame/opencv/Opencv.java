package spring.mvc.whame.opencv;

import java.awt.image.BufferedImage;

import org.bytedeco.javacpp.FloatPointer;
import org.bytedeco.javacpp.opencv_core;
import org.bytedeco.javacpp.opencv_imgcodecs;
import org.bytedeco.javacpp.opencv_imgproc;
import org.bytedeco.javacpp.indexer.UByteIndexer;
import org.bytedeco.javacv.Java2DFrameConverter;
import org.bytedeco.javacv.OpenCVFrameConverter;
import org.springframework.stereotype.Component;

@Component
public class Opencv {

	public String runOpencv(BufferedImage imgurl, ImageVO tvo, String imgurlString) throws Exception {
		String filename = imgurlString.split("whame/")[1].split("/|[?]")[1];
		opencv_core.Mat img = Mat2(imgurl);

		// ���� ���
		opencv_core.Point p0 = new opencv_core.Point(Integer.parseInt(tvo.getOne_xy()[0]),
				Integer.parseInt(tvo.getOne_xy()[1]));
		// ������ ���
		opencv_core.Point p1 = new opencv_core.Point(Integer.parseInt(tvo.getFour_xy()[0]),
				Integer.parseInt(tvo.getFour_xy()[1]));
		// ���� �ϴ�
		opencv_core.Point p2 = new opencv_core.Point(Integer.parseInt(tvo.getTwo_xy()[0]),
				Integer.parseInt(tvo.getTwo_xy()[1]));
		// ������ �ϴ�
		opencv_core.Point p3 = new opencv_core.Point(Integer.parseInt(tvo.getThree_xy()[0]),
				Integer.parseInt(tvo.getThree_xy()[1]));

		double w1 = Math.sqrt(Math.pow(p3.x() - p2.x(), 2) + Math.pow(p3.x() - p2.x(), 2));
		double w2 = Math.sqrt(Math.pow(p1.x() - p0.x(), 2) + Math.pow(p1.x() - p0.x(), 2));
		double h1 = Math.sqrt(Math.pow(p1.y() - p3.y(), 2) + Math.pow(p1.y() - p3.y(), 2));
		double h2 = Math.sqrt(Math.pow(p0.y() - p2.y(), 2) + Math.pow(p0.y() - p2.y(), 2));

		double maxWidth = (w1 < w2) ? w1 : w2 * 0.8;
		double maxHeiht = (h1 < h2) ? h1 : h2 * 0.8;

		opencv_core.Mat src = new opencv_core.Mat(new opencv_core.Size(2, 4), opencv_core.CV_32F,
				new FloatPointer(p0.x(), p0.y(), p1.x(), p1.y(), p3.x(), p3.y(), p2.x(), p2.y()));

		opencv_core.Mat warpImg = new opencv_core.Mat(new opencv_core.Size((int) maxWidth, (int) maxHeiht), img.type());

		opencv_core.Mat dst = new opencv_core.Mat(new opencv_core.Size(2, 4), opencv_core.CV_32F,
				new FloatPointer(0, 0, warpImg.cols(), 0, warpImg.cols(), warpImg.rows(), 0, warpImg.rows()));

		opencv_core.Mat trans = opencv_imgproc.getPerspectiveTransform(src, dst);

		opencv_imgproc.warpPerspective(img, warpImg, trans, new opencv_core.Size((int) maxWidth, (int) maxHeiht));

//		aws Ŭ������� ���� ���� ��ȯ ���
//		String exten = filename.split("\\.")[1];
//		BufferedImage warpB = Buffered2(warpImg);
		
//		File f = new File(filename);
//		ImageIO.write(warpB, exten, f);
//		S3Util s3 = new S3Util();
//		filename = s3.fileUpload("whame01/warping", f);
		
		
		// ������ �̹����� ������ ���.
		String target = "D:/image/warping/" + filename;
		opencv_imgcodecs.imwrite(target, warpImg);
		
		return target;
	}

	public opencv_core.Mat Mat2(BufferedImage imgurl) {
		OpenCVFrameConverter.ToIplImage cv = new OpenCVFrameConverter.ToIplImage();
		Java2DFrameConverter jcv = new Java2DFrameConverter();
		return cv.convertToMat(jcv.convert(imgurl));
	}

	public BufferedImage Buffered2(opencv_core.Mat warpImg) throws Exception {

		int type = BufferedImage.TYPE_BYTE_GRAY;
		UByteIndexer si = warpImg.createIndexer();

		if (warpImg.channels() > 1) {
			type = BufferedImage.TYPE_3BYTE_BGR;
		}
		int buffereSize = warpImg.channels() * warpImg.cols() * warpImg.rows();
		byte[] data = new byte[buffereSize];
		int[] d = new int[buffereSize];
		si.get(0, 0, d);

		for (int i = 0; i < data.length; i++) {
			data[i] = (byte) d[i];
		}

		byte b;
		for (int i = 0; i < data.length; i = i + 3) {
			b = data[i];
			data[i] = data[i + 2];
			data[i + 2] = b;
		}

		BufferedImage img = new BufferedImage(warpImg.cols(), warpImg.rows(), type);
		img.getRaster().setDataElements(0, 0, warpImg.cols(), warpImg.rows(), data);
		return img;
	}
}