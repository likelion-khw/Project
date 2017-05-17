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
   //키 정보
	@Autowired
	CommonUtils cu;
	private String accessKey = "AKIAIAIMSUFMKWLG73CQ";
    private String secretKey = "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";
     
    private AmazonS3 conn;
     
    public S3Util() {
        AWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);
        ClientConfiguration clientConfig = new ClientConfiguration();
        clientConfig.setProtocol(Protocol.HTTP);
        this.conn = new AmazonS3Client(credentials, clientConfig);
        // s3 엔드포인트 지역 ( 도쿄 )
        conn.setEndpoint("s3-ap-northeast-1.amazonaws.com");
    }
     
    // Bucket List
    public List<Bucket> getBucketList() {
        return conn.listBuckets();
    }
     
    // Bucket 생성
    public Bucket createBucket(String bucketName) {
        return conn.createBucket(bucketName);
    }
     
    // 폴더 생성 (폴더는 파일명 뒤에 "/"를 붙여야한다.)
//    public void createFolder(String bucketName, String folderName) {
//        conn.putObject(new PutObjectRequest(bucketName, folderName + "/",  new ByteArrayInputStream(new byte[0]), new ObjectMetadata()));
//    }

    // 파일 업로드
    public String fileUpload(String bucketName, File file) throws Exception {
    	System.out.println("fileupload" + bucketName);
       String filename = cu.getRandomString()+"."+file.getName().split("\\.")[1];
       ObjectMetadata metaData = new ObjectMetadata();
       byte[] bytes = IOUtils.toByteArray(new FileInputStream(file));
       metaData.setContentLength(bytes.length);
       ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);
       PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, filename, byteArrayInputStream, metaData);
       conn.putObject(putObjectRequest);
       return filename;
    }
     
    // 파일 삭제
    public void fileDelete(String bucketName, String fileName) {
        conn.deleteObject(bucketName, fileName);
    }
     
    // 파일 URL
    public String getFileURL(String bucketName, String fileName) {
        return conn.generatePresignedUrl(new GeneratePresignedUrlRequest(bucketName, fileName)).toString();
    }

}