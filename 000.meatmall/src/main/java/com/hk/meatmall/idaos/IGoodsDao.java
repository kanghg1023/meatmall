package com.hk.meatmall.idaos;

import java.util.List;

import com.hk.meatmall.dtos.BasketDto;
import com.hk.meatmall.dtos.CouponDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.Goods_optionDto;
import com.hk.meatmall.dtos.OrderDto;
import com.hk.meatmall.dtos.ReviewDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.dtos.User_couponDto;

public interface IGoodsDao {

	//전체 상품+페이징
	public List<GoodsDto> allGoods(String pnum);
	
	//전체 상품 (삭제여부) + 페이징
	public List<GoodsDto> getEnabled(String pnum);
	
	//전체 페이지 수
	public int getAllPcount();
	
	//전체 페이지 수 (삭제여부)
	public int getEnabledPcount();
	
	//부위별 카테고리
	public List<Goods_kindDto> category();
	
	//카테고리 추가
	public boolean insertCategory(String kind_name);
	
	//카테고리 삭제
	public boolean delCategory(String[] chk);
	
	//카테고리별 상품
	public List<GoodsDto> categoryGoods(String kind_num, String pnum);
	
	//카테고리별 상품 (삭제여부)
	public List<GoodsDto> getCateEnabled(String kind_num, String pnum);
	
	//카테고리 페이지 수
	public int getAllCatePcount(String kind_num);
		
	//카테고리 페이지 수 (삭제여부)
	public int getEnabledCatePcount(String kind_num);
	
	//상품 추가
	public boolean insertGoods(GoodsDto gDto);
	
	//상품 추가 (옵션)
	public boolean insertGoods_option(Goods_optionDto oDto);

	//상품 추가 (부위 선택)
	public List<Goods_kindDto> kind_num();

	//상품 상세
	public GoodsDto getGoods(int goods_num);

	//상품 상세 (옵션)
	public List<Goods_optionDto> getGoods_option(int goods_num);
	
	//전체 상품에서 삭제
	public boolean delGoods(String[] chk, String pnum);
	
	//카테고리 상품에서 삭제
	public boolean delCateGoods(String[] chk, String kind_num, String pnum);
	
	//상품 수정
	public boolean upGoods(GoodsDto gDto);
	
	//상품 수정 (옵션)
	public boolean upGoods_option(Goods_optionDto oDto);
	
	//상품 수정에서 옵션 추가
	public boolean upInsertGoods_option(Goods_optionDto oDto);
	
	//장바구니 목록
	public List<BasketDto> basketList(int user_num);
	
	//장바구니 상품 추가
	public boolean insertBasket(BasketDto bDto);
	
	//장바구니 상품 삭제
	public boolean delBasket(int[] chk);
	
	//후기 목록
	public List<ReviewDto> reviewList(int goods_num);
	
	//유저 정보
	public UserDto userInfo(int user_num);
	
	//주문
	public boolean insertOrder(OrderDto dDto);
	
	//재고감소
	public boolean optionSell(int option_num, int option_count);
	
	//주문 정보
	public List<OrderDto> orderList(int user_num);
	
	//쿠폰목록(관리자)
	public List<CouponDto> adminCouponList(String pnum);
	
	//쿠폰등록(관리자)
	public boolean insertCoupon(CouponDto dto);
	
	//쿠폰페이징
	public int CouponPcount();
	
	//쿠폰목록(사용자)
	public List<User_couponDto> userCouponList(String pnum, int user_num);
	
	//쿠폰상세정보
	public CouponDto couponDetail(int coupon_num);
	
	//쿠폰 등록(사용자)
	public boolean insertUserCoupon(int user_num, CouponDto dto);
	
	//쿠폰목록(팝업)
	public List<User_couponDto> couponList(int user_num);
	
	//상품옵션정보(바로구매용)
	public BasketDto goodsData(int option_num);
	
	//쿠폰사용
	public boolean useCoupon(int user_coupon_num);
	
	//배송상태 변경
	public boolean stateUpdate(int order_num);
	
	//배송대기중인 상품 목록
	public List<OrderDto> orderDelivery(int user_num);

	//배송된 상품
	public List<OrderDto> orderSeller(int user_num);
	
}
