package com.hk.meatmall.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.Board_likeDto;
import com.hk.meatmall.dtos.CommentDto;
import com.hk.meatmall.dtos.MessageDto;
import com.hk.meatmall.idaos.IBoardDao;
import com.hk.meatmall.iservices.IBoardService;

@Service
public class BoardService implements IBoardService {

	@Autowired
	private IBoardDao boardDao;
	
	@Override
	public List<BoardDto> getAllList(String pnum) {	
		return boardDao.getAllList(pnum);
	}

	@Override
	public List<BoardDto> boardListPage(String pnum) {
		
		return boardDao.boardListPage(pnum);
	}
	
	@Override
	public boolean insertBoard(BoardDto dto) {		
		return boardDao.insertBoard(dto);
	}

	@Override
	public BoardDto getBoard(int board_num) {
		return boardDao.getBoard(board_num);
	}

	@Override
	public boolean updateBoard(BoardDto dto) {
		return boardDao.updateBoard(dto);
	}

	@Override
	public boolean delBoard(int board_num) {
		return boardDao.delBoard(board_num);
	}

	@Override
	public boolean readCount(int board_num) {
		return boardDao.readCount(board_num);
	}

	@Override
	public List<BoardDto> noticeList() {		
		return boardDao.noticeList();
	}

	@Override
	public int getPcount() {		
		return boardDao.getPcount();
	}
	
	@Override
	public int getPcount2() {		
		return boardDao.getPcount2();
	}

	@Override
	public boolean getLike(Board_likeDto dto) {		
		return boardDao.getLike(dto);
	}

	@Override
	public int likeCount(int board_num) {		
		return boardDao.likeCount(board_num);
	}

	@Override
	public boolean insertLike(Board_likeDto dto) {
		return boardDao.insertLike(dto);
	}

	@Override
	public boolean deleteLike(Board_likeDto dto) {		
		return boardDao.deleteLike(dto);
	}

	@Override
	public List<CommentDto> commentList(int board_num) {		
		return boardDao.commentList(board_num);
	}

	@Override
	public boolean addcomment(CommentDto dto) {		
		return boardDao.addcomment(dto);
	}

	@Override
	public boolean recomment(CommentDto dto) {		
		return boardDao.recomment(dto);
	}

	@Override
	public boolean delcomment(int comment_num) {		
		return boardDao.delcomment(comment_num);
	}

	@Override
	public boolean updatecomment(CommentDto dto) {		
		return boardDao.updatecomment(dto);
	}

	@Override
	public int msgPcount(int user_num) {
		return boardDao.msgPcount(user_num);
	}
	
	public int sendMsgPcount(int message_from_num) {
		return boardDao.sendMsgPcount(message_from_num);
	}
	
	@Override
	public List<MessageDto> messageList(int user_num, String pnum) {
		return boardDao.messageList(user_num,pnum);
	}

	@Override
	public List<MessageDto> sendMessageList(int message_from_num, String pnum) {
		return boardDao.sendMessageList(message_from_num,pnum);
	}

	@Override
	public boolean insertMessage(MessageDto dto) {
		return boardDao.insertMessage(dto);
	}

	@Override
	public MessageDto messageDetail(int message_num) {
		return boardDao.messageDetail(message_num);
	}

	@Override
	public MessageDto messageDetail2(int message_num) {
		return boardDao.messageDetail2(message_num);
	}
	
	@Override
	public boolean deleteMessage(int message_num) {
		return boardDao.deleteMessage(message_num);
	}

	@Override
	public boolean deleteMessage2(int message_num) {
		return boardDao.deleteMessage2(message_num);
	}

	@Override
	public int myboardPcount(int user_num) {
		return boardDao.myboardPcount(user_num);
	}

	@Override
	public List<BoardDto> myboardList(int user_num, String pnum) {
		return boardDao.myboardList(user_num, pnum);
	}

	@Override
	public List<BoardDto> bestBoard() {
		return boardDao.bestBoard();
	}

	
	


}
