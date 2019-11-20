package com.hk.meatmall.dtos;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class BoardDto {

	//게시글 번호
	private int board_num;
	//작성자 번호
	private int user_num;
	//글 제목
	private String board_title;
	//글 내용
	private String board_content;
	//작성일
	private Date board_regdate;
	//조회수
	private int board_readcount;
	//공지글 여부
	private int board_notice;
	//삭제여부
	private int board_delflag;

	//조인
	//닉네임
	private String user_nick;
	
	//좋아요 갯수
	private int likecount;
}
