package com.hk.meatmall.daos;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.idaos.ILoginDao;

@Repository
public class LoginDao implements ILoginDao {
	
	private String nameSpace="com.login.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	//로그인
	@Override
	public UserDto login(String user_id, String user_pw) {
		UserDto dto = new UserDto();
		Map<String, String> map = new HashMap<>();
		
		map.put("user_id", user_id);
		map.put("user_pw", user_pw);
		
		//계정잠금 초기화
		//계정 정지 초기화
		
		dto = sqlSession.selectOne(nameSpace+"login",map);
		
		return dto;
	}

	//user_id를 user_num으로 / 아이디 중복체크
	@Override
	public int idChk(String user_id) {
		int user_num = 0;
		String idNum =sqlSession.selectOne(nameSpace+"idChk",user_id);
		
		if(idNum == null) {
			return user_num;
		}else {
			user_num = Integer.parseInt(idNum);
			return user_num;
		}
	}

	//계정 잠금여부 확인
	@Override
	public boolean idLockCheck(int user_num) {
		int lockcheck = sqlSession.selectOne(nameSpace+"idLockCheck",user_num);
							//잠김	안잠김
		return lockcheck>0 ? false : true;
	}

	//계정잠금해제
	@Override
	public int lockClear(int user_num) {
		return sqlSession.update(nameSpace+"lockClear",user_num);
	}

	@Override
	public int stopClear(String user_id) {
		return sqlSession.update(nameSpace+"stopClear",user_id);
	}

	@Override
	public int loginFailCountUp(int user_num) {
		return sqlSession.update(nameSpace+"loginFailCountUp",user_num);
	}

	@Override
	public int loginLock(int user_num) {
		return sqlSession.update(nameSpace+"loginLock",user_num);
	}

	@Override
	public boolean regist(UserDto dto) {
		int count = 0;
		count = sqlSession.insert(nameSpace+"regist",dto);
		return count>0 ? true : false;
	}

	//닉네임 중복검사
	@Override
	public int nickChk(String user_nick) {
		int user_num = 0;
		String idNum =sqlSession.selectOne(nameSpace+"nickChk",user_nick);
		
		if(idNum == null) {
			return user_num;
		}else {
			user_num = Integer.parseInt(idNum);
			return user_num;
		}
	}
}
