package com.hk.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
	
}
