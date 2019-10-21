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
public class GoodsDto {

	//상품번호
	private int goods_num;
	//상품이름
	private String goods_title;
	//판매자
	private int user_num;
	//도소매 구분
	private String goods_doso;
	//대표이미지 이름
	private String goods_img_title;
	//상품등록한 시간
	private Date goods_date;
	//삭제여부
	private String goods_enabled;
	//상품 종류
	private int kind_num;
	//이력번호
	private String goods_history;
	//100g당 가격
	private int goods_cost;

}
