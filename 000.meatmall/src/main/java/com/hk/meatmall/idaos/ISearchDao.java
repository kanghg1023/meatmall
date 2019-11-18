package com.hk.meatmall.idaos;

import java.util.List;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;

public interface ISearchDao {

	public List<Goods_kindDto> CategorySearch(String search_word);
	public List<GoodsDto> goodsSearch(String search_word);
	public List<BoardDto> boardSearch(String search_word);
	
}
