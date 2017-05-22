package spring.mvc.whame.opencv;

import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Component;



@Component
public class ImageResize {
	private static int IMG_WIDTH = 720;
	private static int IMG_HEIGHT = 960;
	static File returnfile = new File("resize.jpg");
	
	public static File resizeImage(File convFile) throws Exception{
		BufferedImage originalImage = ImageIO.read(convFile);
		int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
		BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
		g.dispose();
		ImageIO.write(resizedImage, "jpg", returnfile);
		
		return returnfile;
	}

	public static File resizeImageWithHint(File convFile) throws Exception{
		BufferedImage originalImage = ImageIO.read(convFile);
		System.out.println(originalImage.getWidth());
		System.out.println(originalImage.getHeight());
		int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
		BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
		g.dispose();
		g.setComposite(AlphaComposite.Src);

		g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
		g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		
		ImageIO.write(resizedImage, "jpg", returnfile);

		return returnfile;
	}
}
