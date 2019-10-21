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
public class UserDto {
	
	//회원번호
	private int user_num;
	//아이디
	private String user_id;
	//비밀번호
	private String user_pw;
	//이름
	private String user_name;
	//닉네임
	private String user_nick;
	//전화번호
	private String user_ph;
	//주소
	private String user_addr;
	//이메일
	private String user_email;
	//회원상태
	private String user_enabled;
	//사업자등록번호
	private String user_businessnum;
	//사업자 등급
	private String license_level;
	//회원 분류
	private String user_role;
	//계정 제재기한
	private Date user_stop_date;
	
}
