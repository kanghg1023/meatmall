package com.hk.meatmall.idaos;

import com.hk.meatmall.dtos.UserDto;

public interface ILoginDao {
	
	public UserDto login(String user_id, String user_pw);
	public int idChk(String user_id);
	public boolean idLockCheck(int user_num);
	public int lockClear(int user_num);
	public int stopClear(String user_id);
	public int loginFailCountUp(int user_num);
	public int loginLock(int user_num);
	
}
