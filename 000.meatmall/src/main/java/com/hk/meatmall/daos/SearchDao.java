package com.hk.meatmall.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.idaos.ISearchDao;

@Repository
public class SearchDao implements ISearchDao {

	private String nameSpace="com.search.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<GoodsDto> goodsSearch(String search_word, String goods_doso) {
		Map<String, String> map = new HashMap<>();
		map.put("search_word", search_word);
		map.put("goods_doso", goods_doso);
		
		return sqlSession.selectList(nameSpace+"goodsSearch", map);
	}

	@Override
	public List<GoodsDto> CategorySearch(String search_word) {
		return sqlSession.selectList(nameSpace+"CategorySearch",search_word);
	}

	@Override
	public List<BoardDto> boardSearch(String search_word) {
		return sqlSession.selectList(nameSpace+"boardSearch",search_word);
	}
}
