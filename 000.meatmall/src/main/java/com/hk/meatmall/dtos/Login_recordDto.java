package com.hk.meatmall.dtos;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Login_recordDto {
	
	//회원번호
	private int user_num;
	//로그인 시도한 IP
	private String record_ip;
	//성공실패 여부
	private String record_check;
	//로그인 시도한 시간
	private Date record_date;
	
}
