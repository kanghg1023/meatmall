package com.hk.meatmall.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.AnswerDto;
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
	//자주묻는질문 상세보기
	@Override
	public FAQDto FAQdetail(int seq) {
		return sqlSession.selectOne(nameSpace+"faqdetail",seq);
	}
	
	//자주묻는질문 글 삭제
	@Override
	public boolean FAQdelBoard(int seq) {
		int count=sqlSession.delete(nameSpace+"faqdelboard",seq);
		return count>0?true:false;
	}
	
	
	
	
	//1:1문의 글 리스트
	@Override
	public List<QuestionDto> getQuestionList(String user_num,String pnum) {
		Map<String, String> map = new HashMap<>();
		map.put("user_num", String.valueOf(user_num));
		map.put("pnum",pnum);	
 		return sqlSession.selectList(nameSpace+"questionlist",map);		
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
		int count = sqlSession.update(nameSpace+"questionupdate",dto);
		return count>0?true:false;
	}
	//1:1문의 글 삭제하기
	@Override
	public boolean Questiondelete(int seq) {
		int count=sqlSession.delete(nameSpace+"questiondelete",seq);
		return count>0?true:false;
	}
	//1:1문의 글 조회 수
	@Override
	public boolean QuestionreadCount(int seq) {
		int count=sqlSession.update(nameSpace+"questionreadcount",seq);
		return count>0?true:false;
	}
	
	//1:1답변 글 추가하기
	@Override
	public boolean Answerinsert(AnswerDto dto) {
		int count = sqlSession.insert(nameSpace+"answerinsert",dto);
		return count>0?true:false;
	}
	//1:1답변 글 상세보기
	@Override
	public AnswerDto Answerdetail(int seq) {
		return sqlSession.selectOne(nameSpace+"answerdetail",seq);
	}
	//1:1답변글 삭제
	@Override
	public boolean Answerdelete(int seq) {
		int count=sqlSession.delete(nameSpace+"answerdelete",seq);
		return count>0?true:false;
	}
	//답변완료시 답변상태 변경
	@Override
	public boolean StatusChange(int seq) {
		int count = sqlSession.update(nameSpace+"statuschange",seq);
		return count>0?true:false;
	}
	//1:1 문의 글 전체 리스트(페이징 처리)
	@Override
	public List<QuestionDto> AllQuestionList(String pnum) {
		return sqlSession.selectList(nameSpace+"allquestionlist",pnum);		
	}
	@Override
	//1:1 전체 문의 글 리스트  페이지 개수 구하기
	public int QnAPcount() {
		int pcount=0;
		return pcount=sqlSession.selectOne(nameSpace+"qnapcount");
	}
	@Override
	//1:1 자신의 문의 글 리스트 페이지 개수 구하기
	public int QnAPPcount(int user_num) {
		int pcount=0;
		return pcount=sqlSession.selectOne(nameSpace+"qnappcount",user_num);
	}
	
	

}
