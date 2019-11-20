package com.hk.meatmall.idaos;

import java.util.List;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.SearchDto;

public interface ISearchDao {
	
	//카테고리 검색
	public List<Goods_kindDto> CategorySearch(String search_word);
	//상품 검색
	public List<GoodsDto> goodsSearch(String search_word);
	//게시판 검색
	public List<BoardDto> boardSearch(String search_word);
	
	//검색된적 있는 단어인지 체크
	public boolean beSearch(String search_word);
	//검색 횟수 증가
	public boolean addSearch(String search_word);
	//새단어 추가
	public boolean addWord(String search_word);
	
	//인기검색어 조회전 조작 초기화
	public int searchClear();
	//인기검색어 출력
	public List<SearchDto> bestSearch();
	
	//인기검색어 조작
	public boolean updateBestSearch(SearchDto dto);
	//인기검색어 등록
	public boolean insertBestSearch(SearchDto dto);
	
}
