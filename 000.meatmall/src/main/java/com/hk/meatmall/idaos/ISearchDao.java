package com.hk.meatmall.idaos;

import java.util.List;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.GoodsDto;

public interface ISearchDao {

	public List<GoodsDto> goodsSearch(String search_word, String goods_doso);
	public List<GoodsDto> CategorySearch(String search_word);
	public List<BoardDto> boardSearch(String search_word);
	
}
