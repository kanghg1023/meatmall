package com.hk.meatmall.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.Goods_optionDto;
import com.hk.meatmall.idaos.IGoodsDao;
import com.hk.meatmall.iservices.IGoodsService;

@Service
public class GoodsService implements IGoodsService {

	@Autowired
	private IGoodsDao GoodsDao;
	
	//전체 상품 + 페이징
	@Override
	public List<GoodsDto> allGoods(String pnum) {
		return GoodsDao.allGoods(pnum);
	}
	
	//전체 상품 (삭제여부) + 페이징
	@Override
	public List<GoodsDto> getEnabled(String pnum) {
		return GoodsDao.getEnabled(pnum);
	}
	
	//전체 페이지 수
	@Override
	public int getAllPcount() {
		return GoodsDao.getAllPcount();
	}
	
	//전체 페이지 수 (삭제여부)
	@Override
	public int getEnabledPcount() {
		return GoodsDao.getEnabledPcount();
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
	public List<GoodsDto> categoryGoods(String kind_num, String pnum) {
		return GoodsDao.categoryGoods(kind_num, pnum);
	}
	
	
	//카테고리별 상품 (삭제여부)
	@Override
	public List<GoodsDto> getCateEnabled(String kind_num, String pnum) {
		return GoodsDao.getCateEnabled(kind_num, pnum);
	}
	
	//카테고리 페이지 수
	@Override
	public int getAllCatePcount(String kind_num) {
		return GoodsDao.getAllCatePcount(kind_num);
	}

	//카테고리 페이지 수 (삭제여부)
	@Override
	public int getEnabledCatePcount(String kind_num) {
		return GoodsDao.getEnabledCatePcount(kind_num);
	}

	//상품 추가
	@Override
	public boolean insertGoods(GoodsDto gDto) {
		return GoodsDao.insertGoods(gDto);
	}

	//상품 추가 (옵션)
	@Override
	public boolean insertGoods_option(Goods_optionDto oDto) {
		return GoodsDao.insertGoods_option(oDto);
	}
	
	//상품 추가 (부위 선택)
	@Override
	public List<Goods_kindDto> kind_num() {
		return GoodsDao.kind_num();
	}

	//상품 상세
	@Override
	public GoodsDto getGoods(int goods_num) {
		return GoodsDao.getGoods(goods_num);
	}

	//상품 상세 (옵션)
	@Override
	public List<Goods_optionDto> getGoods_option(int goods_num) {
		return GoodsDao.getGoods_option(goods_num);
	}
	
	//전체 상품에서 삭제
	@Override
	public boolean delGoods(String[] chk, String pnum) {
		return GoodsDao.delGoods(chk, pnum);
	}
	
	//카테고리 상품에서 삭제
	@Override
	public boolean delCateGoods(String[] chk, String kind_num, String pnum) {
		return GoodsDao.delCateGoods(chk, kind_num, pnum);
	}

	//상품 수정
	@Override
	public boolean upGoods(GoodsDto gDto) {
		return GoodsDao.upGoods(gDto);
	}

	//상품 수정 (옵션)
	@Override
	public boolean upGoods_option(Goods_optionDto oDto) {
		return GoodsDao.upGoods_option(oDto);
	}

	

	

	

	

	

	

	



	
	
	

	

	

	

	

	

	
	
}
