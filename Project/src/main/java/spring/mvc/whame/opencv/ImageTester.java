package spring.mvc.whame.opencv;

import java.awt.RenderingHints;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.media.jai.JAI;
import javax.media.jai.OpImage;
import javax.media.jai.RenderedOp;

import org.springframework.stereotype.Component;

import com.sun.media.jai.codec.SeekableStream;

@Component
public class ImageTester {

	private static final String JAI_STREAM_ACTION = "stream";

	private static final String JAI_SUBSAMPLE_AVERAGE_ACTION = "SubsampleAverage";

	private static final String JAI_ENCODING_FORMAT_JPEG = "JPEG";

	private static final String JAI_ENCODE_ACTION = "encode";

	static {
		System.setProperty("com.sun.media.jai.disableMediaLib", "true");

	}

	public void resizeImageAsJPEG(InputStream imageInputStream, OutputStream imageOutputStream, int pMaxWidth)
			throws IOException {

		SeekableStream seekableImageStream = SeekableStream.wrapInputStream(
				imageInputStream, true);

		RenderedOp originalImage = JAI.create(JAI_STREAM_ACTION,
				seekableImageStream);

		((OpImage) originalImage.getRendering()).setTileCache(null);

		int origImageWidth = originalImage.getWidth();

		double scale = 1.0;
		if (pMaxWidth > 0 && origImageWidth > pMaxWidth) {
			scale = (double) pMaxWidth / origImageWidth;
		}

		ParameterBlock paramBlock = new ParameterBlock();
		paramBlock.addSource(originalImage); // The Source Image
		paramBlock.add(scale); // xScale
		paramBlock.add(scale); // yScale
		paramBlock.add(0.0); // x translation
		paramBlock.add(0.0); // y translation

		// 여기가 핵심인듯.
		RenderingHints qualityHints = new RenderingHints(
				RenderingHints.KEY_RENDERING,
				RenderingHints.VALUE_RENDER_QUALITY);

		RenderedOp resizedImage = JAI.create(JAI_SUBSAMPLE_AVERAGE_ACTION, paramBlock, qualityHints);

		JAI.create(JAI_ENCODE_ACTION, resizedImage, imageOutputStream, JAI_ENCODING_FORMAT_JPEG, null);

	}

	public void resizeImageAsJPEG(File src, File dest, int maxWidth) {
		if (!src.exists()) {
			throw new IllegalArgumentException(src.getAbsolutePath() + " 파일이 존재하지 않습니다.");
		}

		FileOutputStream outputStream = null;
		try {
			outputStream = new FileOutputStream(dest);
			resizeImageAsJPEG(new FileInputStream(src), outputStream, maxWidth);
		} catch (IOException e) {
		} finally {
			if (outputStream != null) {
				try {
					outputStream.close();
				} catch (Exception ex) {
					// ignored
				}
			}
		}
	}

}
