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
public class Detail_imgDto {
	
	//상세이미지 번호
	private int detail_img_num;
	//상품번호
	private int goods_num;
	//상세이미지 이름
	private String detail_img_name;

}
