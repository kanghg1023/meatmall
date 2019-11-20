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
public class LicenseDto {
	
	//사업자 등급
	private int license_level;
	//할인율
	private int license_discount;
	
}
