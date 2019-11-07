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
public class CommentDto {

	//댓글 번호
	private int comment_num;
	//게시글 번호
	private int board_num;
	//작성자
	private int user_num;
	//댓글 내용
	private String comment_content;
	//작성일
	private Date comment_regdate;
	//댓글 그룹
	private int comment_refer;
	//대댓글 구분
	private String comment_re_check;
	//삭제여부
	private int comment_delflag;

	//조인
	//닉네임
	private String user_nick;
	
}
