package com.hk.meatmall.daos;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.FAQDto;
import com.hk.meatmall.dtos.QuestionDto;
import com.hk.meatmall.idaos.IQnADao;

@Repository
public class QnADao implements IQnADao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String nameSpace="com.QnA.";
	
	//자주묻는질문 리스트
	@Override
	public List<FAQDto> getFAQList() {
		return sqlSession.selectList(nameSpace+"qnaboardlist");
	}
	//자주묻는질문 글추가
	@Override
	public boolean FAQinsertBoard(FAQDto dto) {
		int count = sqlSession.insert(nameSpace+"faqinsertboard",dto);
		return count>0?true:false;
	}
	//자주묻는질문 글 수정
	@Override
	public boolean FAQupdateBoard(FAQDto dto) {
		int count = sqlSession.update(nameSpace+"faqupdateboard",dto);
		return count>0?true:false;
	}
	
	//자주묻는질문 글 삭제
	@Override
	public boolean FAQdelBoard(int seq) {
		int count=sqlSession.delete(nameSpace+"faqdelboard",seq);
		return count>0?true:false;
	}
	
	
	
	
	//1:1문의 글 리스트
	@Override
	public List<QuestionDto> getQuestionList(int user_num) {	
		return sqlSession.selectList(nameSpace+"questionlist",user_num);
		
	}
	//1:1문의 글 추가
	@Override
	public boolean Questioninsert(QuestionDto dto) {
		int count = sqlSession.insert(nameSpace+"questioninsert",dto);
		return count>0?true:false;
	}
	//1:1문의 글 상세보기
	@Override
	public QuestionDto Questiondetail(int seq) {
		return sqlSession.selectOne(nameSpace+"questiondetail",seq);
	}
	//1:1문의 글 수정하기
	@Override
	public boolean Questionupdate(QuestionDto dto) {
		int count = sqlSession.update(nameSpace+"questionupdateboard",dto);
		return count>0?true:false;
	}
	//1:1문의 글 삭제하기
	@Override
	public boolean Questiondelete(int seq) {
		int count=sqlSession.delete(nameSpace+"questiondelboard",seq);
		return count>0?true:false;
	}
	
	
	
	
	
}
