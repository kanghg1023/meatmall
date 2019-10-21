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
public class LoginDto {
	
	//회원 번호
	private int user_num;
	//로그인 실패한 횟수
	private int login_fail_count;
	//계정잠금여부
	private String login_lock;
	//마지막으로 로그인 시도한 시간
	private Date login_last_try_date;

}
