package com.hk.meatmall.iservices;

import java.util.List;

import com.hk.meatmall.dtos.Detail_imgDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.Goods_optionDto;

public interface IGoodsService {

	//전체 상품
	public List<GoodsDto> allGoods(String pnum);
	
	//페이지 수 (전체)
	public int getAllPcount();
		
	//페이지 수 (조건)
	public int getEnabledPcount();
	
	//삭제여부 (전체)
	public List<GoodsDto> getEnabled(String pnum);
	
	//부위별 카테고리
	public List<Goods_kindDto> category();
	
	//카테고리 추가
		public boolean insertCategory(String kind_name);
		
	//카테고리 삭제
	public boolean delCategory(String[] chk);
	
	//카테고리 별 상품 
	public List<GoodsDto> categoryGoods(String kind_num, String pnum);
	
	//삭제여부 (카테고리)
	public List<GoodsDto> getCateEnabled(String kind_num, String pnum);
	
	//상품 추가
	public boolean insertGoods(GoodsDto gDto);
		
	//상품 추가 (상세이미지)
	public boolean insertDetail_img(Detail_imgDto iDto);
		
	//상품 추가 (옵션)
	public boolean insertGoods_option(Goods_optionDto oDto);
	
	//상품 추가 (부위 선택)
	public List<Goods_optionDto> kind_num();
	
	//상품 상세
	public GoodsDto getGoods(int goods_num);
	
	//상품 상세 (상세이미지)
	public Detail_imgDto getDetail_img(int goods_num);
		
	//상품 상세 (옵션)
	public List<Goods_optionDto> getGoods_option(int goods_num);
	
	//전체상품에서 삭제
	public boolean delGoods(String[] chk);
	
	
}
