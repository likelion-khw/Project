package spring.mvc.whame.aws;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.amazonaws.ClientConfiguration;
import com.amazonaws.Protocol;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.util.IOUtils;

@Component
public class S3Util {
	// Ű ����
	@Autowired
	CommonUtils cu;
	
	Keyload key = new Keyload();
	
	private AmazonS3 conn;

	public S3Util(){
		AWSCredentials credentials = new BasicAWSCredentials(key.getAccessKey(), key.getSecretKey());
		ClientConfiguration clientConfig = new ClientConfiguration();
		clientConfig.setProtocol(Protocol.HTTP);
		this.conn = new AmazonS3Client(credentials, clientConfig);
		// s3 ��������Ʈ ���� ( ���� )
		conn.setEndpoint("s3-ap-northeast-1.amazonaws.com");
	}

	// Bucket List
	public List<Bucket> getBucketList() {
		return conn.listBuckets();
	}

	// Bucket ����
	public Bucket createBucket(String bucketName) {
		return conn.createBucket(bucketName);
	}

	// ���� ���� (������ ���ϸ� �ڿ� "/"�� �ٿ����Ѵ�.)
	// public void createFolder(String bucketName, String folderName) {
	// conn.putObject(new PutObjectRequest(bucketName, folderName + "/", new
	// ByteArrayInputStream(new byte[0]), new ObjectMetadata()));
	// }

	// ���� ���ε�
	public String fileUpload(String bucketName, File file) throws Exception {
		System.out.println("fileupload" + bucketName);
		String filename = cu.getRandomString() + "." + file.getName().split("\\.")[1];
		ObjectMetadata metaData = new ObjectMetadata();
		byte[] bytes = IOUtils.toByteArray(new FileInputStream(file));
		metaData.setContentLength(bytes.length);
		ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);
		PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, filename, byteArrayInputStream, metaData);
		conn.putObject(putObjectRequest);
		return filename;
	}

	// ���� ����
	public void fileDelete(String bucketName, String fileName) {
		conn.deleteObject(bucketName, fileName);
	}

	// ���� URL
	public String getFileURL(String bucketName, String fileName) {
		return conn.generatePresignedUrl(new GeneratePresignedUrlRequest(bucketName, fileName)).toString();
	}
	
}