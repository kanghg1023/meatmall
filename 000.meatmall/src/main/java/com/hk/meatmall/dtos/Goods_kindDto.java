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
public class Goods_kindDto {
	
	//상품 그룹 번호
	private int kind_num;
	//그룹 이름 (안심,등심)
	private String kind_name;

}
