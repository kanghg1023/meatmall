package com.hk.meatmall.iservices;

import java.util.List;

import com.hk.meatmall.dtos.AnswerDto;
import com.hk.meatmall.dtos.FAQDto;
import com.hk.meatmall.dtos.QuestionDto;

public interface IQnAService {

	//자주묻는질문 리스트
	public List<FAQDto> getFAQList();
	//자주묻는질문 글추가
	public boolean FAQinsertBoard(FAQDto dto);
	//자주묻는질문 상세보기
	public FAQDto FAQdetail(int seq);	
	//자주묻는질문 글수정
	public boolean FAQupdateBoard(FAQDto dto);
	//자주묻는질문 글삭제
	public boolean FAQdelBoard(int seq);
	
	//1:1 문의 글 리스트
	public List<QuestionDto> getQuestionList(String user_num,String pnum);
	//1:1 문의 글추가 
	public boolean Questioninsert(QuestionDto dto);
	//1:1 문의 글 상세보기
	public QuestionDto Questiondetail(int seq);	
	//1:1 문의 글수정
	public boolean Questionupdate(QuestionDto dto);
	//1:1 문의 글삭제
	public boolean Questiondelete(int seq);
	//1:1문의 글 조회수
	public boolean QuestionreadCount(int seq);
	
	//1:1답변 글 추가하기
	public boolean Answerinsert(AnswerDto dto);
	//1:1답변 글 상세보기
	public AnswerDto Answerdetail(int seq);
	//1:1답변 글 삭제
	public boolean Answerdelete(int seq);
	//답변완료시 답변상태 변경
	public boolean StatusChange(int seq);
	//1:1 문의 글 전체 리스트 (페이징 처리)
	public List<QuestionDto> AllQuestionList(String pnum);
	//1:1 문의 글 전체 리스트 페이지 개수 구하기
	public int QnAPcount();
	//자신의 문의 글 리스트 페이지 개수 구하기
	public int QnAPPcount(int user_num);
}
