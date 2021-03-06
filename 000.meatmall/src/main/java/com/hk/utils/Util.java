package com.hk.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import org.apache.commons.mail.HtmlEmail;

import com.hk.meatmall.dtos.BasketDto;
import com.hk.meatmall.dtos.SearchDto;

public class Util {
	
	public static String dateFormatChange(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분ss초");
		
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

	public static String sampleContent(String msg) {
		return msg.substring(0, 10)+"...";
	}
	
	public static List<BasketDto> cost(List<BasketDto> list){
		
		for (BasketDto dto:list) {
			int cost = (dto.getOption_weight()/100)*dto.getGoods_cost();
			dto.setBasket_cost(cost);
		}
		
		return list;
	}
	
	//인기검색어 순위조정
	public static List<SearchDto> bestSearch(List<SearchDto> bestSearch){
		int j = 1;
		int k = 0;
		List<SearchDto> list = new ArrayList<>();
		
		for(int i=0;i<bestSearch.size();i++) {
			
			String test = bestSearch.get(i).getSearch_fake_ranking();
			
			if(test != null) {
				if( test.equals(String.valueOf(j)) ) {
					list.add(bestSearch.get(i));
				}else {
					for(k=j;k<Integer.parseInt(test);k++) {
						list.add(bestSearch.get(k));
					}

					list.add(bestSearch.get(i));
					i = i+k-(i+1);
				}
			}else {
				list.add(bestSearch.get(i));
			}
			j++;
		}
		
		return list;
	}
}
