package com.hk.meatmall.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.RecordDto;
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

	//계정정지해제
	@Override
	public int stopClear(String user_id) {
		return sqlSession.update(nameSpace+"stopClear",user_id);
	}

	//로그인 실패시 잠금관리 -----
	@Override
	public int loginFail(int user_num) {
		return sqlSession.update(nameSpace+"loginFail",user_num);
	}

	//로그인 성공실패여부 기록
	@Override
	public boolean loginRecord(String user_id, String ip, int record_check) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_id", user_id);
		map.put("ip", ip);
		map.put("record_check", String.valueOf(record_check));
		
		int count = 0;
		count = sqlSession.insert(nameSpace+"loginRecord",map);
		return count>0 ? true : false;
	}
	
	//회원가입
	@Override
	public boolean signUp(UserDto dto) {
		int count = 0;
		count = sqlSession.insert(nameSpace+"signUp",dto);
		return count>0 ? true : false;
	}
	
	//닉네임 중복검사
	@Override
	public int nickChk(String user_nick) {
		int user_num = 0;
		String idNum =sqlSession.selectOne(nameSpace+"nickChk",user_nick);
		
		if(idNum != null) {
			user_num = Integer.parseInt(idNum);
		}
		
		return user_num;
	}

	//정보수정을 위한 비밀번호체크
	@Override
	public boolean pwChk(String user_id, String user_pw) {
		Map<String,String> map = new HashMap<>(); 
		map.put("user_id", user_id);
		map.put("user_pw", user_pw);
		
		String id = sqlSession.selectOne(nameSpace+"pwChk", map);
		
		if(id == null) {
			return false;
		}else {
			return true;
		}
	}

	//정보수정
	@Override
	public boolean userUpdate(UserDto dto) {
		int count = 0;
		count = sqlSession.update(nameSpace+"userUpdate",dto);
		
		return count>0 ? true : false;
	}

	//아이디/비밀번호 찾기
	@Override
	public List<String> inquiry(UserDto dto) {
		List<String> list = sqlSession.selectList(nameSpace+"inquiry",dto);
		return list;
	}

	//비밀번호 변경
	@Override
	public boolean pwChange(String user_id, String user_pw) {
		int count = 0;
		Map<String, String> map = new HashMap<>();
		map.put("user_id", user_id);
		map.put("user_pw", user_pw);
		
		count = sqlSession.update(nameSpace+"pwChange",map);
		
		return count>0 ? true : false;
	}

	//로그인 기록 조회
	@Override
	public List<RecordDto> loginRecordList(int user_num) {
		List<RecordDto> list = sqlSession.selectList(nameSpace+"loginRecordList",user_num);
		return list;
	}

	//일주일지난 기록을 삭제
	@Override
	public int loginRecordDel() {
		int count = 0;
		count = sqlSession.update(nameSpace+"loginRecordDel");
		
		return count;
	}

	@Override
	public List<GoodsDto> getMainList(String goods_doso) {
		List<GoodsDto> list = sqlSession.selectList(nameSpace+"getMainList",goods_doso);
		return list;
	}
	
}
