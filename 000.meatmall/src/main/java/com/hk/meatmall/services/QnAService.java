package com.hk.meatmall.services;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	//자주묻는질문 글삭제
	@Override
	public boolean FAQdelBoard(int seq) {
		return qnaDao.FAQdelBoard(seq);
	}
	
	
	
	
	//1:1문의 글 리스트
	@Override
	public List<QuestionDto> getQuestionList(int user_num) {
		return qnaDao.getQuestionList(user_num);
	}
	//1:1문의 글 추가
	@Override
	public boolean Questioninsert(QuestionDto dto) {
		return qnaDao.Questioninsert(dto);
	}
	//1:1문의 글 상세보기
	@Override
	public QuestionDto Questiondetail(int seq) {
		return qnaDao.Questiondetail(seq);
	}
	//1:1문의 글 수정
	@Override
	public boolean Questionupdate(QuestionDto dto) {
		return qnaDao.Questionupdate(dto);
	}
	//1:1문의 글 삭제
	@Override
	public boolean Questiondelete(int seq) {
		return qnaDao.Questiondelete(seq);
	}
	
}
