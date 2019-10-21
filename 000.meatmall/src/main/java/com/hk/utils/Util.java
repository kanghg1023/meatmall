package com.hk.utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

public class Util {
	
	//usebean을 쓰기 위한 구조를 만든다: dto처럼 맴버필드가 있고, get/set메서드가 있는 구조
	private String toDates;
	
	//화면에서 getProperty태그가 호출해줄 메서드
	public String getToDates() {
		return toDates;
	}
	
	//문자열을 날짜 형식으로 표현하는 메서드
	//화면에서 setProperty태그가 호출해줄 메서드
	//201908311234 => 2019년 08월 31일 12시 34분
	public void setToDates(String mdate) {
		//date형식: yyyy-MM-dd hh:mm:ss
		//문자열을 date타입으로 변환
		String m = mdate.substring(0, 4)+"-"	//year
					+mdate.substring(4, 6)+"-"	//month
					+mdate.substring(6, 8)+" "	//date
					+mdate.substring(8, 10)+":"	//hour
					+mdate.substring(10)+":00";	//min
		
		Timestamp tm = Timestamp.valueOf(m);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년MM월dd일 HH시mm분");
		
		this.toDates = sdf.format(tm);
	}

	//숫자 자리수 보정
	public static String isTwo(String s) {
		return s.length()<2? "0"+s : s;
	}
	
	//달력의 날짜에 대한 요일을 확인해서 폰트 색을 적용하는 메서드
	public static String fontColor(int week, int i){
		String color = "";
		if(week == 0){
			color = "blue";
		}else if(week == 1){
			color = "red";
		}else{
			color = "black";
		}
		return color;
	}
	
	
	
}
