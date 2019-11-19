package com.hk.meatmall.daos;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.idaos.ISearchDao;

@Repository
public class SearchDao implements ISearchDao {

	private String nameSpace="com.search.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<GoodsDto> goodsSearch(String search_word) {
		
		return sqlSession.selectList(nameSpace+"goodsSearch", search_word);
	}

	@Override
	public List<Goods_kindDto> CategorySearch(String search_word) {
		return sqlSession.selectList(nameSpace+"CategorySearch",search_word);
	}

	@Override
	public List<BoardDto> boardSearch(String search_word) {
		return sqlSession.selectList(nameSpace+"boardSearch",search_word);
	}
}
