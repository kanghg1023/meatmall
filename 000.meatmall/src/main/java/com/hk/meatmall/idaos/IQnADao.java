package com.hk.meatmall.idaos;

import java.util.List;

import com.hk.meatmall.dtos.FAQDto;
import com.hk.meatmall.dtos.QnADto;

public interface IQnADao {

	//자주묻는질문 리스트
	public List<FAQDto> getFAQList();
	//자주묻는질문 글추가
	public boolean FAQinsertBoard(FAQDto dto);
	//자주묻는질문 상세보기
	public FAQDto FAQdetail(int faq_num);
	//자주묻는질문 글수정
	public boolean FAQupdateBoard(FAQDto dto);
	//자주묻는질문 글삭제
	public boolean FAQdelBoard(int faq_num);
	
	
	//1:1 문의 글 리스트
	public List<QnADto> getQuestionList(String user_num,String pnum);
	//1:1 문의 글추가 
	public boolean Questioninsert(QnADto dto);
	//1:1 문의 글 상세보기
	public QnADto Questiondetail(int question_num);	
	//1:1문의 글 수정하기
	public boolean Questionupdate(QnADto dto);
	//1:1문의 글 삭제하기
	public boolean Questiondelete(int question_num);
	
	//답변달기
	public boolean Answerinsert(QnADto dto);
	//답변완료시 답변상태 변경
	public boolean StatusChange(int question_num);
	//1:1 문의 글 전체 리스트(페이징 처리)
	public List<QnADto> AllQuestionList(String pnum);
	//1:1 문의 글 전체 리스트 페이지 개수 구하기
	public int QnAPcount();
	//1:1 자신의 문의 글 리스트 페이지 개수 구하기
	public int QnAUserPcount(int user_num);
	
}
