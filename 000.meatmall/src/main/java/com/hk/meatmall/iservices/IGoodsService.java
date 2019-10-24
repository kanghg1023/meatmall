package com.hk.meatmall.iservices;

import java.util.List;

import com.hk.meatmall.dtos.Detail_imgDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.Goods_optionDto;

public interface IGoodsService {

	//전체 상품
	public List<GoodsDto> allGoods();
	
	//부위별 카테고리
	public List<Goods_kindDto> category();
	
	//카테고리 추가
		public boolean insertCategory(String kind_name);
		
	//카테고리 삭제
	public boolean delCategory(String[] chk);
	
	//카테고리 별 상품 
	public List<GoodsDto> categoryGoods(int kind_num);
	
	//상품 추가
	public boolean insertGoods(GoodsDto dto);
		
	//상품 추가 (상세이미지)
	public boolean insertDetail_img(Detail_imgDto dto);
		
	//상품 추가 (옵션)
	public boolean insertGoods_option(Goods_optionDto dto);
}
