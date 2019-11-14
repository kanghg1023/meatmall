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
public class BasketDto {

	//장바구니 사용자
	private int user_num;
	//상품 번호
	private int goods_num;
	//옵션 번호
	private int option_num;
	//담긴 수량
	private int basket_count;
	
	//조인
	//상품명
	private String goods_title;
	//대표이미지
	private String goods_img_title;
	//100g당 가격
	private int goods_cost;
	//선택한 옵션명
	private String option_name;
	//옵션 - 무게
	private int option_weight;
	//판매자 번호
	private int seller_num;
	
	//최종가격
	private int basket_cost;
	
}
