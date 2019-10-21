package com.hk.meatmall.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.idaos.ILoginDao;
import com.hk.meatmall.iservices.ILoginService;

@Service
public class LoginService implements ILoginService {

	@Autowired
	private ILoginDao loginDao;

	@Override
	public UserDto login(String user_id, String user_pw) {
		return loginDao.login(user_id,user_pw);
	}
	
}
