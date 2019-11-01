package com.hk.meatmall.services;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.meatmall.dtos.AnswerDto;
import com.hk.meatmall.dtos.FAQDto;
import com.hk.meatmall.dtos.QuestionDto;
import com.hk.meatmall.idaos.IQnADao;
import com.hk.meatmall.iservices.IQnAService;

@Service
public class QnAService implements IQnAService {
	
	@Autowired
	private IQnADao qnaDao;
	//자주묻는질문 리스트
	@Override
	public List<FAQDto> getFAQList() {
		return qnaDao.getFAQList();
	}
	//자주묻는질문 글추가
	@Override
	public boolean FAQinsertBoard(FAQDto dto) {
		return qnaDao.FAQinsertBoard(dto);
	}
	//자주묻는질문 글수정
	@Override
	public boolean FAQupdateBoard(FAQDto dto) {
		return qnaDao.FAQupdateBoard(dto);
	}
	//자주묻는질문 상세보기
	@Override
	public FAQDto FAQdetail(int faq_num) {
		return qnaDao.FAQdetail(faq_num);
	}
	
	//자주묻는질문 글삭제
	@Override
	public boolean FAQdelBoard(int faq_num) {
		return qnaDao.FAQdelBoard(faq_num);
	}
	
	
	
	
	//1:1문의 글 리스트
	@Override
	public List<QuestionDto> getQuestionList(String user_num,String pnum) {
		return qnaDao.getQuestionList(user_num,pnum);
	}
	//1:1문의 글 추가
	@Override
	public boolean Questioninsert(QuestionDto dto) {
		return qnaDao.Questioninsert(dto);
	}
	//1:1문의 글 상세보기
	@Override
	public QuestionDto Questiondetail(int question_num) {
		return qnaDao.Questiondetail(question_num);
	}
	//1:1문의 글 수정
	@Override
	public boolean Questionupdate(QuestionDto dto) {
		return qnaDao.Questionupdate(dto);
	}
	//1:1문의 글 삭제
	@Override
	public boolean Questiondelete(int question_num) {
		return qnaDao.Questiondelete(question_num);
	}
	////1:1문의 글 조회수
	@Override
	public boolean QuestionreadCount(int question_num) {
		return qnaDao.QuestionreadCount(question_num);
	}
	
	
	
	//1:1답변 글 추가하기
	@Override
	public boolean Answerinsert(AnswerDto dto) {
		return qnaDao.Answerinsert(dto);
	}
	//1:1답변 글 상세보기
	@Override
	public AnswerDto Answerdetail(int question_num) {
		return qnaDao.Answerdetail(question_num);
	}	
	//1:1답변 글 삭제
	@Override
	public boolean Answerdelete(int question_num) {
		return qnaDao.Answerdelete(question_num);
	}
	//답변완료시 답변상태 변경
	@Override
	public boolean StatusChange(int question_num) {
		return qnaDao.StatusChange(question_num);
	}
	//1:1 문의 글 전체 리스트	
	@Override
	public List<QuestionDto> AllQuestionList(String pnum) {
		return qnaDao.AllQuestionList(pnum);
	}
	//1:1 문의 글 전체 페이지 개수 구하기
	@Override
	public int QnAPcount() {
		return qnaDao.QnAPcount();
	}
	//자신의 문의 글 리스트 페이지 개수 구하기
	@Override
	public int QnAPPcount(int user_num) {
		return qnaDao.QnAPPcount(user_num);
	}
	
	
}
