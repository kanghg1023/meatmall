package com.hk.meatmall.daos;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.SearchDto;
import com.hk.meatmall.idaos.ISearchDao;

@Repository
public class SearchDao implements ISearchDao {

	private String nameSpace="com.search.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Goods_kindDto> CategorySearch(String search_word) {
		return sqlSession.selectList(nameSpace+"CategorySearch",search_word);
	}
	
	@Override
	public List<GoodsDto> goodsSearch(String search_word) {
		
		return sqlSession.selectList(nameSpace+"goodsSearch", search_word);
	}

	@Override
	public List<BoardDto> boardSearch(String search_word) {
		return sqlSession.selectList(nameSpace+"boardSearch",search_word);
	}

	@Override
	public boolean beSearch(String search_word) {
		int count = sqlSession.selectOne(nameSpace+"beSearch",search_word);
		return count>0 ? true : false;
	}

	@Override
	public boolean addSearch(String search_word) {
		int count = sqlSession.update(nameSpace+"addSearch",search_word);
		return count>0 ? true : false;
	}

	@Override
	public boolean addWord(String search_word) {
		int count = sqlSession.insert(nameSpace+"addWord",search_word);
		return count>0 ? true : false;
	}

	@Override
	public int searchClear() {
		return sqlSession.update(nameSpace+"searchClear");
	}
	
	@Override
	public List<SearchDto> bestSearch() {
		return sqlSession.selectList(nameSpace+"bestSearch");
	}

	
}
