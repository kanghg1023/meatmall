package com.hk.meatmall.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.idaos.ISearchDao;
import com.hk.meatmall.iservices.ISearchService;

@Service
public class SearchService implements ISearchService {

	@Autowired
	private ISearchDao searchDao;
	
	@Override
	public List<GoodsDto> goodsSearch(String search_word, String goods_doso) {
		return searchDao.goodsSearch(search_word,goods_doso);
	}

	@Override
	public List<GoodsDto> CategorySearch(String search_word) {
		return searchDao.CategorySearch(search_word);
	}

	@Override
	public List<BoardDto> boardSearch(String search_word) {
		return searchDao.boardSearch(search_word);
	}

}
