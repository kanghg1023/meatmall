package com.hk.meatmall.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.meatmall.dtos.Detail_imgDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.Goods_optionDto;
import com.hk.meatmall.idaos.IGoodsDao;
import com.hk.meatmall.iservices.IGoodsService;

@Service
public class GoodsService implements IGoodsService {

	@Autowired
	private IGoodsDao GoodsDao;
	
	//전체 상품
	@Override
	public List<GoodsDto> allGoods() {
		return GoodsDao.allGoods();
	}
	
	//부위별 카테고리
	@Override
	public List<Goods_kindDto> category() {
		return GoodsDao.category();
	}
	
	//카테고리 추가
	@Override
	public boolean insertCategory(String kind_name) {
		return GoodsDao.insertCategory(kind_name);
	}
	
	//카테고리 삭제
	@Override
	public boolean delCategory(String[] chk) {
		return GoodsDao.delCategory(chk);
	}
	
	//카테고리별 상품
	@Override
	public List<GoodsDto> categoryGoods(int kind_num) {
		return GoodsDao.categoryGoods(kind_num);
	}

	//상품 추가
	@Override
	public boolean insertGoods(GoodsDto dto) {
		return GoodsDao.insertGoods(dto);
	}

	//상품 추가 (상세 이미지)
	@Override
	public boolean insertDetail_img(Detail_imgDto dto) {
		return GoodsDao.insertDetail_img(dto);
	}

	//상품 추가 (옵션)
	@Override
	public boolean insertGoods_option(Goods_optionDto dto) {
		return GoodsDao.insertGoods_option(dto);
	}

	

	

	
	
}
