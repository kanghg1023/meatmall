package com.hk.meatmall.daos;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.idaos.IBoardDao;

@Repository
public class BoardDao implements IBoardDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
}
