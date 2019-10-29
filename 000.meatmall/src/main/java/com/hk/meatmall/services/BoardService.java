package com.hk.meatmall.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.Board_likeDto;
import com.hk.meatmall.dtos.CommentDto;
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
	public String numNick(int user_num) {
		return boardDao.numNick(user_num);
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


}
