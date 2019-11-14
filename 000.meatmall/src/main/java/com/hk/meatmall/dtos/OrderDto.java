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

	//주문 번호
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
	//주문 개수
	private int order_count;

	//조인
	//판매자 닉네임
	private String user_nick;
	//유저 주소
	private String user_addr;
	//상품명
	private String goods_title;
	//선택한 옵션명
	private String option_name;
	//상품 이미지
	private String goods_img_title;
	
}
