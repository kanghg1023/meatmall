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
public class AnswerDto {
	
	//답변 번호
	private int answer_num;
	//문의글 번호
	private int question_num;
	//답변 내용
	private String answer_content;
	//작성일
	private Date answer_regdate;

}
