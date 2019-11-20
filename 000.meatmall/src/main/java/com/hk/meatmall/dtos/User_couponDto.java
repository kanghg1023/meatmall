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
public class User_couponDto {

	//쿠폰 고유번호
	private int user_coupon_num;
	//쿠폰 번호
	private int coupon_num;
	//소유자
	private int user_num;
	//유효기간
	private Date user_coupon_date;
	//사용여부
	private int user_coupon_use;
	
	//조인
	//쿠폰이름
	private String coupon_name;
	private String coupon_img;
	private int coupon_money;
}
