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

	@Override
	public UserDto login(String user_id, String user_pw) {
		UserDto dto = new UserDto();
		Map<String, String> map = new HashMap<>();
		
		map.put("user_id", user_id);
		map.put("user_pw", user_pw);
		
		dto = sqlSession.selectOne(nameSpace+"login",map);
		
		return dto;
	}
}
