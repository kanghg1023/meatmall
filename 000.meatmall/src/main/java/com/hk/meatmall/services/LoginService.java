package com.hk.meatmall.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.RecordDto;
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
		int lfcu = loginDao.loginFail(user_num);
		return lfcu;
	}

	@Override
	public boolean loginRecord(String user_id, String ip, int record_check) {
		return loginDao.loginRecord(user_id, ip, record_check);
	}
	
	@Override
	public boolean signUp(UserDto dto) {
		return loginDao.signUp(dto);
	}
	
	@Override
	public int nickChk(String user_nick) {
		int user_num = 0;
		user_num = loginDao.nickChk(user_nick);
		return user_num;
	}

	@Override
	public boolean pwChk(String user_id, String user_pw) {
		return loginDao.pwChk(user_id,user_pw);
	}

	@Override
	public boolean userUpdate(UserDto dto) {
		return loginDao.userUpdate(dto);
	}

	@Override
	public List<String> inquiry(UserDto dto) {
		return loginDao.inquiry(dto);
	}

	@Override
	public boolean inquiryChk(UserDto dto) {
		List<String> list = loginDao.inquiry(dto);
		if(list.size()>0) {
			return true;
		}
		return false;
	}

	@Override
	public boolean pwChange(String user_id, String user_pw) {
		return loginDao.pwChange(user_id,user_pw);
	}

	
	@Override
	public List<RecordDto> loginRecordList(int user_num) {
		loginDao.loginRecordDel();
		return loginDao.loginRecordList(user_num);
	}
	
}
