package com.hk.meatmall.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.Board_likeDto;
import com.hk.meatmall.dtos.CommentDto;
import com.hk.meatmall.dtos.MessageDto;
import com.hk.meatmall.idaos.IBoardDao;

@Repository
public class BoardDao implements IBoardDao {

	private String nameSpace="com.board.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<BoardDto> getAllList(String pnum) {		
		return sqlSession.selectList(nameSpace+"boardlist",pnum);
	}

	@Override
	public List<BoardDto> boardListPage(String pnum) {		
		return sqlSession.selectList(nameSpace+"boardlistpage",pnum);
	}	
	
	@Override
	public boolean insertBoard(BoardDto dto) {
		int count=sqlSession.insert(nameSpace+"insertboard", dto);
		return count > 0 ? true:false;
	}

	@Override
	public BoardDto getBoard(int board_num) {
		return sqlSession.selectOne(nameSpace+"getboard", board_num);
	}

	@Override
	public boolean updateBoard(BoardDto dto) {
		int count = sqlSession.update(nameSpace+"updateboard", dto);
		return count > 0 ? true:false;
	}

	@Override
	public boolean delBoard(int board_num) {
		int count = sqlSession.update(nameSpace+"delboard", board_num);
		return count > 0 ? true:false;
	}
	
	@Override
	public boolean readCount(int board_num) {
		int count = sqlSession.update(nameSpace+"readcount", board_num);
		return count > 0 ? true:false;
	}

	@Override
	public List<BoardDto> noticeList() {		
		return sqlSession.selectList(nameSpace+"noticelist");
	}

	@Override
	public int getPcount() {		
		int pcount = sqlSession.selectOne(nameSpace+"pcount");
		return pcount;
	}
	
	@Override
	public int getPcount2() {		
		int pcount2 = sqlSession.selectOne(nameSpace+"pcount2");
		return pcount2;
	}

	@Override
	public boolean getLike(Board_likeDto dto) {
		Board_likeDto likedto = new Board_likeDto();
		likedto = sqlSession.selectOne(nameSpace+"getLike",dto);
		return likedto !=null ? true:false ;
	}

	@Override
	public int likeCount(int board_num) {
		int count = sqlSession.selectOne(nameSpace+"likeCount",board_num);
		return count;
	}

	@Override
	public boolean insertLike(Board_likeDto dto) {
		int count = sqlSession.insert(nameSpace+"insertLike", dto);
		return count > 0 ? true:false;
	}

	@Override
	public boolean deleteLike(Board_likeDto dto) {
		int count = sqlSession.insert(nameSpace+"deleteLike", dto);
		return count > 0 ? true:false;
	}

	
	@Override
	public List<CommentDto> commentList(int board_num) {		
		return sqlSession.selectList(nameSpace+"commentList",board_num);
	}

	@Override
	public boolean addcomment(CommentDto dto) {
		int count=sqlSession.insert(nameSpace+"addcomment",dto);
		return count > 0 ? true:false;
	}

	@Override
	public boolean recomment(CommentDto dto) {
		int count=sqlSession.insert(nameSpace+"recomment",dto);
		return count > 0 ? true:false;
	}

	@Override
	public boolean delcomment(int comment_num) {
		int count=sqlSession.update(nameSpace+"delcomment",comment_num);
		return count > 0 ? true:false;
	}

	@Override
	public boolean updatecomment(CommentDto dto) {
		int count=sqlSession.update(nameSpace+"updatecomment",dto);
		return count > 0 ? true:false;
	}

	@Override
	public int msgPcount(int user_num) {
		return sqlSession.selectOne(nameSpace+"msgPcount",user_num);
	}
	
	@Override
	public int sendMsgPcount(int message_from_num) {
		return sqlSession.selectOne(nameSpace+"sendMsgPcount",message_from_num);
	}
	
	@Override
	public List<MessageDto> messageList(int user_num, String pnum) {
		Map<String, Object> map = new HashMap<>();
		map.put("user_num", user_num);
		map.put("pnum", pnum);
		
		return sqlSession.selectList(nameSpace+"messageList",map);
	}

	@Override
	public List<MessageDto> sendMessageList(int message_from_num, String pnum) {
		Map<String, Object> map = new HashMap<>();
		map.put("message_from_num", message_from_num);
		map.put("pnum", pnum);
		
		return sqlSession.selectList(nameSpace+"sendMessageList",map);
	}

	@Override
	public boolean insertMessage(MessageDto dto) {
		int count = sqlSession.insert(nameSpace+"insertMessage",dto);
		return count>0 ? true : false;
	}

	@Override
	public MessageDto messageDetail(int message_num) {
		return sqlSession.selectOne(nameSpace+"messageDetail",message_num);
	}

	@Override
	public MessageDto messageDetail2(int message_num) {
		return sqlSession.selectOne(nameSpace+"messageDetail2",message_num);
	}
	
	@Override
	public boolean deleteMessage(int message_num) {
		int count = 0;
		count = sqlSession.insert(nameSpace+"deleteMessage",message_num);
		return count>0 ? true : false;
	}

	@Override
	public boolean deleteMessage2(int message_num) {
		int count = 0;
		count = sqlSession.insert(nameSpace+"deleteMessage2",message_num);
		return count>0 ? true : false;
	}

	

	


	
}
