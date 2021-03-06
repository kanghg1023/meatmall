package com.hk.meatmall.iservices;

import java.util.List;

import com.hk.meatmall.dtos.RecordDto;
import com.hk.meatmall.dtos.UserDto;

public interface ILoginService {
	
	public UserDto login(String user_id, String user_pw);
	public int idChk(String user_id);
	public boolean idLockCheck(int user_num);
	public int lockClear(int user_num);
	public int stopClear(String user_id);
	public int loginFail(int user_num);
	public boolean loginRecord(String user_id, String ip, int record_check);
	public boolean signUp(UserDto dto);
	public int nickChk(String user_nick);
	public boolean pwChk(String user_id, String user_pw);
	public boolean userUpdate(UserDto dto);
	public List<String> inquiry(UserDto dto);
	public boolean inquiryChk(UserDto dto);
	public boolean pwChange(String user_id, String user_pw);
	public List<RecordDto> loginRecordList(int user_num);
	//회원 탈퇴
	public boolean withdraw(int user_num);
	//회원 리스트
	public List<UserDto> userlist(String pnum);
	// ㄴ페이지수
	public int userPcount();
	
	//관리자가보는 유저정보
	public UserDto adminUserInfo(int user_num);
	//유저 정지
	public boolean userStop(int user_num);
	
	//사업자 등급에 따른 할인률
	public int levelChk(int license_level);
	
}
