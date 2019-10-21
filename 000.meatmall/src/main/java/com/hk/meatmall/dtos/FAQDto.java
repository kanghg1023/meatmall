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
public class FAQDto {
	
	//FAQ 번호
	private int faq_num;
	//질문
	private String faq_title;
	//질문 답변
	private String faq_content;

}
