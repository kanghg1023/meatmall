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
public class ReviewDto {
	
	//후기번호
	private int review_num;
	//주문 번호
	private int order_num;
	//상품번호
	private int goods_num;
	//판매자 번호
	private int user_num;
	//작성자 아이디
	private String user_id;
	//후기내용
	private String review_content;
	//별점
	private int review_score;
	//후기 작성시간
	private Date review_date;

	//조인
	//상품명
	private String goods_title;
	//옵션명
	private String option_name;
	
}
