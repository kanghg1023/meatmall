package com.hk.meatmall.iservices;

import com.hk.meatmall.dtos.UserDto;

public interface ILoginService {
	
	public UserDto login(String user_id, String user_pw);
	public int idChk(String user_id);
	public boolean idLockCheck(int user_num);
	public int lockClear(int user_num);
	public int stopClear(String user_id);
	public int loginFail(int user_num);
	
}
