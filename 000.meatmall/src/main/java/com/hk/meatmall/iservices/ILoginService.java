package com.hk.meatmall.iservices;

import com.hk.meatmall.dtos.UserDto;

public interface ILoginService {
	
	public UserDto login(String user_id, String user_pw);
	
}
