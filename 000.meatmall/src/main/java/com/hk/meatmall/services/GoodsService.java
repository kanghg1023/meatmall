package com.hk.meatmall.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.hk.meatmall.iservices.IGoodsService;

@Service
public class GoodsService implements IGoodsService {

	@Autowired
	private IGoodsDao GoodsDao;
	
	//메인 상품리스트
	@Override
	public List<GoodsDto> getMainList() {
		return GoodsDao.getMainList();
	}
	
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
	
	//상품 수정에서 옵션 추가
	@Override
	public boolean upInsertGoods_option(Goods_optionDto oDto) {
		return GoodsDao.upInsertGoods_option(oDto);
	}

	//장바구니 목록
	@Override
	public List<BasketDto> basketList(int user_num) {
		return GoodsDao.basketList(user_num);
	}

	//장바구니 상품 추가
	@Override
	public boolean insertBasket(BasketDto bDto) {
		return GoodsDao.insertBasket(bDto);
	}

	//장바구니 상품 삭제
	@Override
	public boolean delBasket(int[] chk) {
		return GoodsDao.delBasket(chk);
	}

	//후기 목록
	@Override
	public List<ReviewDto> reviewList(int goods_num) {
		return GoodsDao.reviewList(goods_num);
	}
	
	//유저 정보
	@Override
	public UserDto userInfo(int user_num) {
		return GoodsDao.userInfo(user_num);
	}

	//주문
	@Override
	public boolean insertOrder(OrderDto dDto) {
		return GoodsDao.insertOrder(dDto);
	}

	//재고감소
	@Override
	public boolean optionSell(int option_num, int option_count) {
		return GoodsDao.optionSell(option_num, option_count);
	}
	
	//주문 정보
	@Override
	public List<OrderDto> orderList(int user_num) {
		return GoodsDao.orderList(user_num);
	}

	//쿠폰목록(관리자)
	@Override
	public List<CouponDto> adminCouponList(String pnum) {
		return GoodsDao.adminCouponList(pnum);
	}

	//쿠폰등록(관리자)
	@Override
	public boolean insertCoupon(CouponDto dto) {
		return GoodsDao.insertCoupon(dto);
	}

	//쿠폰페이징
	@Override
	public int CouponPcount() {
		return GoodsDao.CouponPcount();
	}

	//쿠폰 목록(사용자)
	@Override
	public List<User_couponDto> userCouponList(String pnum, int user_num) {
		return GoodsDao.userCouponList(pnum,user_num);
	}
	
	//쿠폰 상세정보
	@Override
	public CouponDto couponDetail(int coupon_num) {
		return GoodsDao.couponDetail(coupon_num);
	}
	
	//쿠폰 등록(사용자)
	@Override
	public boolean insertUserCoupon(int user_num, CouponDto dto) {
		return GoodsDao.insertUserCoupon(user_num, dto);
	}

	//쿠폰목록(팝업)
	@Override
	public List<User_couponDto> couponList(int user_num) {
		return GoodsDao.couponList(user_num);
	}

	//상품옵션정보(바로구매용)
	@Override
	public BasketDto goodsData(int option_num) {
		return GoodsDao.goodsData(option_num);
	}

	//쿠폰 사용
	@Override
	public boolean useCoupon(int user_coupon_num) {
		return GoodsDao.useCoupon(user_coupon_num);
	}

	//배송상태 변경
	@Override
	public boolean stateUpdate(int order_num) {
		return GoodsDao.stateUpdate(order_num);
	}

	@Override
	public List<OrderDto> orderDelivery(int user_num) {
		return GoodsDao.orderDelivery(user_num);
	}

	@Override
	public List<OrderDto> orderSeller(int user_num) {
		return GoodsDao.orderSeller(user_num);
	}

	@Override
	public OrderDto getOrder(int order_num) {
		return GoodsDao.getOrder(order_num);
	}

	//리뷰 등록
	@Override
	public boolean addReview(ReviewDto dto) {
		return GoodsDao.addReview(dto);
	}

	@Override
	public int basketCount(int user_num) {
		return GoodsDao.basketCount(user_num);
	}
	
}
