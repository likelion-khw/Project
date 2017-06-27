package spring.mvc.whame;


import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Properties;

public class Mail {
    public Mail(){}
    
    String username=null;
    String password=null;
    
    public void sendmail(String title,String name,String pw, String memo, String email) throws IOException{
        String path = "D:/GeonS/email.txt";
        StringBuilder sb = new StringBuilder();
        String strLine;
        
        BufferedReader br = new BufferedReader(new FileReader(path));
        while((strLine=br.readLine())!=null){
        	sb.append(strLine);
        }
        br.close();
        String[] ex = sb.toString().split("/");
        username = ex[0];
        password = ex[1];
        
        Properties props = new Properties(); 
        /*props.put("mail.smtp.user",username); 
        props.put("mail.smtp.password", password);*/
		long time = System.currentTimeMillis(); 

		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		String str = dayTime.format(new Date(time));
      
        InternetAddress from = new InternetAddress() ;

        props.put("mail.smtp.host", "smtp.gmail.com"); 
        props.put("mail.smtp.port", "25"); 
        props.put("mail.debug", "true"); 
        props.put("mail.smtp.auth", "true"); 
        props.put("mail.smtp.starttls.enable","true"); 
        props.put("mail.smtp.EnableSSL.enable","true");
        props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
        props.setProperty("mail.smtp.socketFactory.fallback", "false");   
        props.setProperty("mail.smtp.port", "465");   
        props.setProperty("mail.smtp.socketFactory.port", "465"); 
    
        Session session = Session.getInstance(props,new javax.mail.Authenticator() { 
        public PasswordAuthentication getPasswordAuthentication() { 
        return new PasswordAuthentication(username, password); 
        }});
        System.out.println("??");
        try{
            Message message = new MimeMessage(session); 
            message.setFrom(from);// ������ �̸���
            message.setRecipients(Message.RecipientType.TO,InternetAddress.parse("whktem@gmail.com")); //�޴��̸���
            message.setSubject(title+"                 Time : "+str);
            message.setContent(memo+"<br><br><br><br>from:"+email,"text/html; charset=utf-8");//���� 
            System.out.println("send!!!");
            Transport.send(message);
            System.out.println("SEND");
            
            
        } catch(Exception e){
            e.printStackTrace();
        }
    }    
}
