package com.hk.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.apache.commons.mail.HtmlEmail;

import com.hk.meatmall.dtos.MessageDto;

public class Util {
	
	public static String dateFormatChange(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
		
		return sdf.format(date);
	}
	
	//SHA-256 암호화
	public static String sha256(String pw) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
	    md.update(pw.getBytes());
	    byte[] bytes = md.digest();
	    
	    StringBuilder sb = new StringBuilder();
	    
	    for (byte b: bytes) {
	    	sb.append(String.format("%02x", b));
	    }
	    
	    return sb.toString();
	}
	
	public static String garaPW() {
		StringBuffer garaPW = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 8; i++) {
		    int rIndex = rnd.nextInt(3);
		    switch (rIndex) {
		    case 0:
		        // a-z
		    	garaPW.append((char) ((int) (rnd.nextInt(26)) + 97));
		        break;
		    case 1:
		        // A-Z
		    	garaPW.append((char) ((int) (rnd.nextInt(26)) + 65));
		        break;
		    case 2:
		        // 0-9
		    	garaPW.append((rnd.nextInt(10)));
		        break;
		    }
		}
		
		return garaPW.toString();
	}
	
	public static void sendMail(String email, String subject, String msg) throws Exception{
		//메일 서버 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com";
		String hostSMTPid = "testkang1995";
		String hostSMTPpwd = "q1!w2@e3#";
		
		//보내는 사람
		String fromEmail="testkang1995@naver.com";
		String fromName="운영자";
		
		try {
			HtmlEmail mail  = new HtmlEmail();
			mail.setDebug(true);
			mail.setCharset(charSet);
			mail.setSSLOnConnect(true);  
			
			mail.setHostName(hostSMTP);
			mail.setSmtpPort(465);
			
			mail.setAuthentication(hostSMTPid, hostSMTPpwd);
			mail.setStartTLSEnabled(true);
			mail.addTo(email);
			mail.setFrom(fromEmail, fromName, charSet);
			mail.setSubject(subject);
			mail.setHtmlMsg(msg);
			mail.send();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//랜덤한 값 32자리 만드는 메서드
	public static String createUUId() {
		return UUID.randomUUID().toString().replaceAll("-", "");
    }
	
	
	public static List<MessageDto> sampleContent(List<MessageDto> list) {
		
		for (MessageDto mdto:list) {
			if(mdto.getMessage_content().length() > 10) {
				mdto.setMessage_content(mdto.getMessage_content().substring(0, 10)+"...");
			}
		}
		
		return list;
	}
}
