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
public class QuestionDto {
	
	//문의글 번호
	private int question_num;
	//작성자 번호
	private int user_num;
	//질문 제목
	private String question_title;
	//질문 상세내용
	private String question_content;
	//조회수
	private int question_readcount;
	//작성일
	private Date question_regdate;
	//답변여부
	private String question_status;

}
