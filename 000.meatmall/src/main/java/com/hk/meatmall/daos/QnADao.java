package com.hk.meatmall.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.FAQDto;
import com.hk.meatmall.dtos.QnADto;
import com.hk.meatmall.idaos.IQnADao;

@Repository
public class QnADao implements IQnADao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String nameSpace="com.QnA.";
	
	//자주묻는질문 리스트
	@Override
	public List<FAQDto> getFAQList() {
		return sqlSession.selectList(nameSpace+"getFAQList");
	}
	//자주묻는질문 글추가
	@Override
	public boolean FAQinsertBoard(FAQDto dto) {
		int count = sqlSession.insert(nameSpace+"FAQinsertBoard",dto);
		return count>0?true:false;
	}
	//자주묻는질문 글 수정
	@Override
	public boolean FAQupdateBoard(FAQDto dto) {
		int count = sqlSession.update(nameSpace+"FAQupdateBoard",dto);
		return count>0?true:false;
	}
	//자주묻는질문 상세보기
	@Override
	public FAQDto FAQdetail(int faq_num) {
		return sqlSession.selectOne(nameSpace+"FAQdetail",faq_num);
	}
	
	//자주묻는질문 글 삭제
	@Override
	public boolean FAQdelBoard(int faq_num) {
		int count=sqlSession.delete(nameSpace+"FAQdelBoard",faq_num);
		return count>0?true:false;
	}
	
	
	//1:1문의 글 리스트
	@Override
	public List<QnADto> getQuestionList(String user_num,String pnum) {
		Map<String, String> map = new HashMap<>();
		map.put("user_num", String.valueOf(user_num));
		map.put("pnum",pnum);	
 		return sqlSession.selectList(nameSpace+"getQuestionList",map);		
	}
	//1:1문의 글 추가
	@Override
	public boolean Questioninsert(QnADto dto) {
		int count = sqlSession.insert(nameSpace+"Questioninsert",dto);
		return count>0?true:false;
	}
	//1:1문의 글 상세보기
	@Override
	public QnADto Questiondetail(int question_num) {
		return sqlSession.selectOne(nameSpace+"Questiondetail",question_num);
	}
	//1:1문의 글 수정하기
	@Override
	public boolean Questionupdate(QnADto dto) {
		int count = sqlSession.update(nameSpace+"Questionupdate",dto);
		return count>0?true:false;
	}
	//1:1문의 글 삭제하기
	@Override
	public boolean Questiondelete(int question_num) {
		int count=sqlSession.delete(nameSpace+"Questiondelete",question_num);
		return count>0?true:false;
	}
	
	//답변달기
	@Override
	public boolean Answerinsert(QnADto dto) {
		int count = sqlSession.update(nameSpace+"Answerinsert",dto);
		return count>0 ? true : false;
	}
	
	//답변완료시 답변상태 변경
	@Override
	public boolean StatusChange(int question_num) {
		int count = sqlSession.update(nameSpace+"StatusChange",question_num);
		return count>0 ? true : false;
	}
	
	//1:1 문의 글 전체 리스트(페이징 처리)
	@Override
	public List<QnADto> AllQuestionList(String pnum) {
		Map<String, String> map = new HashMap<>();
		map.put("pnum", pnum);
		
		return sqlSession.selectList(nameSpace+"getQuestionList",map);		
	}
	
	@Override
	//1:1 전체 문의 글 리스트  페이지 개수 구하기
	public int QnAPcount() {
		return sqlSession.selectOne(nameSpace+"QnAPcount");
	}
	@Override
	//1:1 자신의 문의 글 리스트 페이지 개수 구하기
	public int QnAUserPcount(int user_num) {
		return sqlSession.selectOne(nameSpace+"QnAUserPcount",user_num);
	}
	
	
	

}
