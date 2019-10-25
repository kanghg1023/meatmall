package com.hk.meatmall.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Override
	public int idChk(String user_id) {
		int user_num = 0;
		user_num = loginDao.idChk(user_id);
		return user_num;
	}

	@Override
	public boolean idLockCheck(int user_num) {
		return loginDao.idLockCheck(user_num);
	}

	@Override
	public int lockClear(int user_num) {
		return loginDao.lockClear(user_num);
	}

	@Override
	public int stopClear(String user_id) {
		return loginDao.stopClear(user_id);
	}

	@Transactional
	@Override
	public int loginFail(int user_num) {
		int lfcu = loginDao.loginFailCountUp(user_num);
		int ll = loginDao.loginLock(user_num);
		return lfcu+ll;
	}

	@Override
	public boolean regist(UserDto dto) {
		return loginDao.regist(dto);
	}

	@Override
	public int nickChk(String user_nick) {
		int user_num = 0;
		user_num = loginDao.nickChk(user_nick);
		return user_num;
	}

	
	
}
