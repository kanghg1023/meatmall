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
public class MessageDto {

	//쪽지 번호
	private int message_num;
	//보낸사람 아이디
	private int message_from_num;
	//받는 사람 번호
	private int user_num;
	//쪽지 내용
	private String message_content;
	//보낸 날짜
	private Date message_regdate;
	//받는쪽 삭제여부
	private int message_to_delflag;
	//보낸쪽 삭제여부
	private int message_from_delflag;


}
