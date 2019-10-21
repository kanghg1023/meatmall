package com.hk.meatmall.dtos;

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
public class Board_likeDto {
	
	//게시글 번호
	private int board_num;
	//회원 번호
	private int user_num;

}
