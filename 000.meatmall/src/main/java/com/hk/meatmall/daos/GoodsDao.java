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
	
	//전체 상품
	@Override
	public List<GoodsDto> allGoods() {
		return sqlSession.selectList(nameSpace+"allGoods");
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
	public List<GoodsDto> categoryGoods(int kind_num) {
		return sqlSession.selectList(nameSpace+"categoryGoods", kind_num);
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
	public Goods_optionDto getGoods_option(int goods_num) {
		return sqlSession.selectOne(nameSpace+"getGoods_option", goods_num);
	}
	
	//상품 삭제
	@Override
	public boolean delGoods(String[] chk) {
		Map<String, String[]> map = new HashMap<>();
		map.put("chk", chk);
		
		int count = sqlSession.delete(nameSpace+"delGoods", map);
		return count > 0 ? true:false;
	}

	

	

	



	
}
