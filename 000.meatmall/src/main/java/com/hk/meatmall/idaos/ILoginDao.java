package com.hk.meatmall.idaos;

import com.hk.meatmall.dtos.UserDto;

public interface ILoginDao {
	
	public UserDto login(String user_id, String user_pw);
	
}
