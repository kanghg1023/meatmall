package com.hk.meatmall.dtos;

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
public class CouponDto {
	
	//쿠폰 번호
	private int coupon_num;
	//쿠폰이름
	private String coupon_name;
	//쿠폰이미지
	private String coupon_img;
	//할인 금액
	private int coupon_money;
	//쿠폰기간 (며칠)
	private int coupon_period;

}
