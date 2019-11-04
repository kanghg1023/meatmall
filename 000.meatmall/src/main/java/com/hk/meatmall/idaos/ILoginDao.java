package com.hk.meatmall.idaos;

import java.util.List;

import com.hk.meatmall.dtos.RecordDto;
import com.hk.meatmall.dtos.UserDto;

public interface ILoginDao {
	
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
	public boolean pwChange(String user_id, String user_pw);
	public List<RecordDto> loginRecordList(int user_num);
	public int loginRecordDel();
	
}
