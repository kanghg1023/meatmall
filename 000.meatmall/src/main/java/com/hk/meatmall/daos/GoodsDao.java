package com.hk.meatmall.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.Detail_imgDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.Goods_optionDto;
import com.hk.meatmall.idaos.IGoodsDao;

@Repository
public class GoodsDao implements IGoodsDao { 

	private String nameSpace="com.goods.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public GoodsDao() {
		super();
	}
	
	//전체 상품 + 페이징
	@Override
	public List<GoodsDto> allGoods(String pnum) {
		return sqlSession.selectList(nameSpace+"allGoods",pnum);
	}
	
	//전체 상품 (삭제여부) + 페이징
	@Override
	public List<GoodsDto> getEnabled(String pnum) {
		return sqlSession.selectList(nameSpace+"getEnabled",pnum);
	}
	
	//전체 페이지 수
	@Override
	public int getAllPcount() {
		int pcount = sqlSession.selectOne(nameSpace+"allPcount");
		return pcount;
	}
	
	//전체 페이지 수 (삭제여부)
	@Override
	public int getEnabledPcount() {
		int pcount = sqlSession.selectOne(nameSpace+"enabledPcount");
		return pcount;
	}
		
	//부위별 카테고리
	@Override
	public List<Goods_kindDto> category() {
		return sqlSession.selectList(nameSpace+"category");
	}
	
	//카테고리 추가
	@Override
	public boolean insertCategory(String kind_name) {
		int count = sqlSession.insert(nameSpace+"insertCategory", kind_name);
		return count > 0 ? true:false;
	}
	
	//카테고리 삭제
	@Override
	public boolean delCategory(String[] chk) {
		Map<String, String[]> map = new HashMap<>();
		map.put("chk", chk);
		
		int count = sqlSession.delete(nameSpace+"delCategory", map);
		return count > 0 ? true:false;
	}
	
	//카테고리별 상품
	@Override
	public List<GoodsDto> categoryGoods(String kind_num, String pnum) {
		Map<String, String> map = new HashMap<>();
		map.put("kind_num", kind_num);
		map.put("pnum", pnum);
		return sqlSession.selectList(nameSpace+"categoryGoods", map);
	}
	
	//카테고리별 상품 (삭제여부)
	@Override
	public List<GoodsDto> getCateEnabled(String kind_num,String pnum) {
		Map<String, String> map = new HashMap<>();
		map.put("kind_num", kind_num);
		map.put("pnum", pnum);
		return sqlSession.selectList(nameSpace+"getCateEnabled", map);
	}
	
	//카테고리 페이지 수
	@Override
	public int getAllCatePcount(String kind_num) {
		int pcount = sqlSession.selectOne(nameSpace+"allCatePcount", kind_num);
		return pcount;
	}
		
	//카테고리 페이지 수 (삭제여부)
	@Override
	public int getEnabledCatePcount(String kind_num) {
		int pcount = sqlSession.selectOne(nameSpace+"enabledCatePcount", kind_num);
		return pcount;
	}

	//상품 추가
	@Override
	public boolean insertGoods(GoodsDto gDto) {
		int count = sqlSession.insert(nameSpace+"insertGoods",gDto);
		return count > 0 ? true:false;
	}

	//상품 추가 (상세이미지)
	@Override
	public boolean insertDetail_img(Detail_imgDto iDto) {
		int count = sqlSession.insert(nameSpace+"insertDetail_img",iDto);
		return count > 0 ? true:false;
	}

	//상품 추가 (옵션)
	@Override
	public boolean insertGoods_option(Goods_optionDto oDto) {
		int count = sqlSession.insert(nameSpace+"insertGoods_option",oDto);
		return count > 0 ? true:false;
	}
	
	//상품 추가 (부위 선택)
	@Override
	public List<Goods_optionDto> kind_num() {
		return sqlSession.selectList(nameSpace+"kind_num");
	}


	//상품 상세
	@Override
	public GoodsDto getGoods(int goods_num) {
		return sqlSession.selectOne(nameSpace+"getGoods", goods_num);
	}
	
	//상품 상세 (상세이미지)
	@Override
	public Detail_imgDto getDetail_img(int goods_num) {
		return sqlSession.selectOne(nameSpace+"getDetail_img", goods_num);
	}

	//상품 상세 (옵션)
	@Override
	public List<Goods_optionDto> getGoods_option(int goods_num) {
		return sqlSession.selectList(nameSpace+"getGoods_option", goods_num);
	}
	
	//전체 상품에서 삭제
	@Override
	public boolean delGoods(String[] chk, String pnum) {
		Map<String, Object> map = new HashMap<>();
		map.put("chk", chk);
		map.put("pnum", pnum);
		
		int count = sqlSession.update(nameSpace+"delGoods", map);
		return count > 0 ? true:false;
	}
	
	//카테고리 상품에서 삭제
	@Override
	public boolean delCateGoods(String[] chk, String kind_num, String pnum) {
		Map<String, Object> map = new HashMap<>();
		map.put("chk", chk);
		map.put("kind_num", kind_num);
		map.put("pnum", pnum);
		
		int count = sqlSession.update(nameSpace+"delCateGoods", map);
		return count > 0 ? true:false;
	}

	//상품 수정
	@Override
	public boolean upGoods(GoodsDto gDto) {
		int count = sqlSession.update(nameSpace+"upGoods", gDto);
		return count > 0 ? true:false;
	}

	//상품 수정 (상세 이미지)
	@Override
	public boolean upDetail_img(Detail_imgDto iDto) {
		int count = sqlSession.update(nameSpace+"upDetail_img", iDto);
		return count > 0 ? true:false;
	}
	
	//상품 수정 (옵션)
	@Override
	public boolean upGoods_option(Goods_optionDto oDto) {
		int count = sqlSession.update(nameSpace+"upGoods_option", oDto);
		return count > 0 ? true:false;
	}

	

	

	

	

	

	

	

	



	
}
