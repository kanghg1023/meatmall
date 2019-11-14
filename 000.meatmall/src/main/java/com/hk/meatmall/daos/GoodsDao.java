package com.hk.meatmall.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.meatmall.dtos.BasketDto;
import com.hk.meatmall.dtos.CouponDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.Goods_optionDto;
import com.hk.meatmall.dtos.OrderDto;
import com.hk.meatmall.dtos.ReviewDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.dtos.User_couponDto;
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
		int count = 0;
		count = sqlSession.insert(nameSpace+"insertCategory", kind_name);
		return count > 0 ? true:false;
	}
	
	//카테고리 삭제
	@Override
	public boolean delCategory(String[] chk) {
		Map<String, String[]> map = new HashMap<>();
		map.put("chk", chk);
		
		int count = 0;
		count = sqlSession.delete(nameSpace+"delCategory", map);
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
		int count = 0;
		count = sqlSession.insert(nameSpace+"insertGoods",gDto);
		return count > 0 ? true:false;
	}

	//상품 추가 (옵션)
	@Override
	public boolean insertGoods_option(Goods_optionDto oDto) {
		int count = 0;
		count = sqlSession.insert(nameSpace+"insertGoods_option",oDto);
		return count > 0 ? true:false;
	}
	
	//상품 추가 (부위 선택)
	@Override
	public List<Goods_kindDto> kind_num() {
		return sqlSession.selectList(nameSpace+"kind_num");
	}


	//상품 상세
	@Override
	public GoodsDto getGoods(int goods_num) {
		return sqlSession.selectOne(nameSpace+"getGoods", goods_num);
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
		
		int count = 0;
		count = sqlSession.update(nameSpace+"delGoods", map);
		return count > 0 ? true:false;
	}
	
	//카테고리 상품에서 삭제
	@Override
	public boolean delCateGoods(String[] chk, String kind_num, String pnum) {
		Map<String, Object> map = new HashMap<>();
		map.put("chk", chk);
		map.put("kind_num", kind_num);
		map.put("pnum", pnum);
		
		int count = 0;
		count = sqlSession.update(nameSpace+"delCateGoods", map);
		return count > 0 ? true:false;
	}

	//상품 수정
	@Override
	public boolean upGoods(GoodsDto gDto) {
		int count = 0;
		count = sqlSession.update(nameSpace+"upGoods", gDto);
		return count > 0 ? true:false;
	}

	//상품 수정 (옵션)
	@Override
	public boolean upGoods_option(Goods_optionDto oDto) {
		int count = 0;
		count = sqlSession.update(nameSpace+"upGoods_option", oDto);
		return count > 0 ? true:false;
	}
	
	//상품 수정에서 옵션 추가
	@Override
	public boolean upInsertGoods_option(Goods_optionDto oDto) {
		int count = 0;
		count = sqlSession.insert(nameSpace+"upInsertGoods_option",oDto);
		return count > 0 ? true:false;
	}

	//장바구니 목록
	@Override
	public List<BasketDto> basketList(int user_num) {
		return sqlSession.selectList(nameSpace+"basketList", user_num);
	}
	
	//장바구니 상품 추가
	@Override
	public boolean insertBasket(BasketDto bDto) {
		int count = 0;
		count = sqlSession.insert(nameSpace+"insertBasket", bDto);
		return count > 0 ? true:false;
	}

	//장바구니 상품 삭제
	@Override
	public boolean delBasket(String[] chk) {
		Map<String, String[]> map = new HashMap<>();
		map.put("chk", chk);
		
		int count = 0;
		count = sqlSession.delete(nameSpace+"delBasket", map);
		return count > 0 ? true:false;
	}

	//후기 목록
	@Override
	public List<ReviewDto> reviewList(int goods_num) {
		return sqlSession.selectList(nameSpace+"reviewList", goods_num);
	}
	
	//유저 정보
	@Override
	public UserDto userInfo(int user_num) {
		return sqlSession.selectOne(nameSpace+"userInfo", user_num);
	}

	//주문
	@Override
	public boolean insertOrder(OrderDto dDto) {
		int count = 0;
		count = sqlSession.insert(nameSpace+"insertOrder", dDto);
		return count > 0 ? true:false;
	}

	//재고감소
	@Override
	public boolean optionSell(int option_num, int option_count) {
		Map<String, Integer> map = new HashMap<>();
		map.put("option_num", option_num);
		map.put("option_count", option_count);
		
		int count = 0;
		count = sqlSession.update(nameSpace+"optionSell", map);
		return count > 0 ? true:false;
	}
	
	//주문 정보
	@Override
	public List<OrderDto> orderInfo(int user_num) {
		return sqlSession.selectList(nameSpace+"orderInfo", user_num);
	}

	//쿠폰목록(관리자)
	@Override
	public List<CouponDto> adminCouponList(String pnum) {
		return sqlSession.selectList(nameSpace+"adminCouponList", pnum);
	}

	//쿠폰등록(관리자)
	@Override
	public boolean insertCoupon(CouponDto dto) {
		int count = 0;
		count = sqlSession.insert(nameSpace+"insertCoupon", dto);
		return count > 0 ? true : false;
	}

	//쿠폰페이징
	@Override
	public int CouponPcount() {
		return sqlSession.selectOne(nameSpace+"CouponPcount");
	}

	//쿠폰목록(사용자)
	@Override
	public List<User_couponDto> userCouponList(String pnum, int user_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pnum", pnum);
		map.put("user_num", user_num);
		
		return sqlSession.selectList(nameSpace+"userCouponList", map);
	}
	
	//쿠폰상세정보
	@Override
	public CouponDto couponDetail(int coupon_num) {
		return sqlSession.selectOne(nameSpace+"couponDetail",coupon_num);
	}
	
	//쿠폰 등록(사용자)
	@Override
	public boolean insertUserCoupon(int user_num, CouponDto dto) {
		Map<String, Integer> map = new HashMap<>();
		map.put("user_num", user_num);
		map.put("coupon_num", dto.getCoupon_num());
		map.put("coupon_period",dto.getCoupon_period());
		
		int count = 0;
		count = sqlSession.insert(nameSpace+"insertUserCoupon", map);
		return count > 0 ? true : false;
	}

	@Override
	public List<User_couponDto> couponList(int user_num) {
		return sqlSession.selectList(nameSpace+"couponList", user_num);
	}

	

	

	

	

}
