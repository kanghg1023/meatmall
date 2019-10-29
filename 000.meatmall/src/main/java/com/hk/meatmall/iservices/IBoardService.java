package com.hk.meatmall.iservices;

import java.util.List;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.Board_likeDto;
import com.hk.meatmall.dtos.CommentDto;

public interface IBoardService {
	
	//글전체목록보기
	public List<BoardDto> getAllList(String pnum);
	//글추가하기
	public boolean insertBoard(BoardDto dto);
	//글상세보기
	public BoardDto getBoard(int board_num);
	//글수정하기
	public boolean updateBoard(BoardDto dto);
	//글삭제하기
	public boolean delBoard(int board_num);
	//조회수
	public boolean readCount(int board_num);
	//공지글 목록 (3개만 뽑기)
	public List<BoardDto> noticeList();
	//글목록의 페이지수 구하기
	public int getPcount();
	//유저넘버 받아서 닉네임으로 변경
	public String numNick(int user_num);
	//좋아요 출력
	public boolean getLike(Board_likeDto dto);
	//좋아요 개수
	public int likeCount(int board_num);
	//좋아요 입력
	public boolean insertLike(Board_likeDto dto);
	//좋아요 삭제
	public boolean deleteLike(Board_likeDto dto);
	//댓글 목록 보기
	public List<CommentDto> commentList(int board_num);
	//모댓글 추가
	public boolean addcomment(CommentDto dto);
	//대댓글 추가
	public boolean recomment(CommentDto dto);
	// 댓글 삭제
	public boolean delcomment(int comment_num);
	// 댓글 수정
	public boolean updatecomment(CommentDto dto);
	
}
