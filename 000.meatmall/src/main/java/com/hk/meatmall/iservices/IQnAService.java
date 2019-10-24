package com.hk.meatmall.iservices;

import java.util.List;

import com.hk.meatmall.dtos.FAQDto;
import com.hk.meatmall.dtos.QuestionDto;

public interface IQnAService {

	//자주묻는질문 리스트
	public List<FAQDto> getFAQList();
	//자주묻는질문 글추가
	public boolean FAQinsertBoard(FAQDto dto);	
	//자주묻는질문 글수정
	public boolean FAQupdateBoard(FAQDto dto);
	//자주묻는질문 글삭제
	public boolean FAQdelBoard(int seq);
	
	//1:1 문의 글 리스트
	public List<QuestionDto> getQuestionList(int user_num);
	//1:1 문의 글추가 
	public boolean Questioninsert(QuestionDto dto);
	//1:1 문의 글 상세보기
	public QuestionDto Questiondetail(int seq);	
	//1:1 문의 글수정
	public boolean Questionupdate(QuestionDto dto);
	//1:1 문의 글삭제
	public boolean Questiondelete(int seq);
}
