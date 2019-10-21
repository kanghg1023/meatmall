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
public class OrderDto {

	//주분 번호
	private int order_num;
	//주문자 번호
	private int user_num;
	//판매자 번호
	private int order_seller;
	//상품 번호
	private int goods_num;
	//옵션 번호
	private int option_num;
	//배송지
	private String order_addr;
	//결제금액
	private int order_money;
	//결제일
	private Date order_date;
	//배송완료일
	private Date order_delivery_date;
	//배송 상태
	private String order_state;

}
