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
public class Goods_optionDto {
	
	//옵션 번호
	private int option_num;
	//상품 번호
	private int goods_num;
	//옵션 이름
	private String option_name;
	//재고
	private int option_count;
	//무게(g)
	private int option_weight;

}
