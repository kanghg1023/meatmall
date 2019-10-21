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
public class BannerDto {
	
	//배너번호
	private int banner_num;
	//배너이름
	private String banner_name;
	//이미지이름
	private String banner_img_name;
	//배너를 등록한 시간
	private Date banner_regist_date;
	//배너가 내려갈 시간
	private Date banner_end_date;

}
