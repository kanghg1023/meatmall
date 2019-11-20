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
public class SearchDto {

	//검색어
	private String search_word;
	//검색 횟수
	private int search_count;
	//조작한 순위
	private String search_fake_ranking;
	//조작할 시간
	private Date search_fake_date;

}
