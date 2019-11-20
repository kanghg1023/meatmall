package com.hk.meatmall;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hk.meatmall.dtos.BannerDto;
import com.hk.meatmall.dtos.BasketDto;
import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.CouponDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.Goods_optionDto;
import com.hk.meatmall.dtos.OrderDto;
import com.hk.meatmall.dtos.ReviewDto;
import com.hk.meatmall.dtos.SearchDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.dtos.User_couponDto;
import com.hk.meatmall.iservices.IBoardService;
import com.hk.meatmall.iservices.IGoodsService;
import com.hk.meatmall.iservices.ISearchService;
import com.hk.utils.Paging;
import com.hk.utils.UploadFileUtils_D;
import com.hk.utils.UploadFileUtils_T;
import com.hk.utils.Util;

@Controller
public class GoodsController {

private static final Logger logger = LoggerFactory.getLogger(GoodsController.class);
	
	@Resource(name="uploadPath")
	private String uploadPath;

	@Autowired
	private IGoodsService GoodsService;
	
	@Autowired
	private IBoardService boardService;
	
	@Autowired
	private ISearchService SearchService;
	
	@RequestMapping(value = "/main.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String main( HttpSession session
					  , Model model) {
		logger.info("메인");
		
		
		if(session.getAttribute("category") == null) {
			List<Goods_kindDto> category = GoodsService.category();
			session.setAttribute("category", category);
		}
		
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		if(session.getAttribute("basketCount") == null && ldto != null) {
			int basketCount = GoodsService.basketCount(ldto.getUser_num());
			session.setAttribute("basketCount", basketCount);
		}
		
		//공지
		if(session.getAttribute("noticeList") == null) {
			List<BoardDto> noticeList = boardService.noticeList();
			session.setAttribute("noticeList", noticeList);
		}
		
		//배너
		if(session.getAttribute("mainBanner") == null) {
			List<BannerDto> mainBanner = GoodsService.mainBanner();
			
			while(mainBanner.size()<4) {
				BannerDto dto = new BannerDto();
				dto.setBanner_num(0);
				dto.setBanner_name("고기고기괴기");
				dto.setBanner_img_name("img\\logo9.png");
				mainBanner.add(dto);
			}
			session.setAttribute("mainBanner", mainBanner);
		}
		
		//인기검색어
		SearchService.searchClear();
		List<SearchDto> bestSearch = SearchService.bestSearch();
		bestSearch = Util.bestSearch(bestSearch);
		session.setAttribute("bestSearch", bestSearch);
		
		//인기글
		List<BoardDto> bestBoard = boardService.bestBoard();
		
		//상품
		List<GoodsDto> mainList = GoodsService.getMainList();
		
		model.addAttribute("bestBoard",bestBoard);
		model.addAttribute("mainList",mainList);
		return "main";
	}
	
	@RequestMapping(value = "/allGoods.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String allGoods( HttpSession session
						  , Model model
						  , String pnum	
						  , String kind_num) {
		logger.info("상품 목록");
		
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		if(pnum==null) {
			pnum=(String)session.getAttribute("pnum");
		}else {
			session.setAttribute("pnum", pnum);
		}
		
		List<GoodsDto> gList = new ArrayList<>();
		Map<String, Integer> map = new HashMap<>();
		
		boolean isList = true;
        int p = Integer.parseInt(pnum);
        int pcount = 0;
		
		while(isList) {
			if(ldto == null || !(ldto.getUser_role().equals("ADMIN"))) {
				if(kind_num != null){
					gList = GoodsService.getCateEnabled(kind_num,String.valueOf(p));
					pcount = GoodsService.getEnabledCatePcount(kind_num);
				}else {
					gList = GoodsService.getEnabled(String.valueOf(p));
					pcount = GoodsService.getEnabledPcount();
				}
				map=Paging.pagingValue(pcount, pnum, 5);
			}else {
				if(kind_num != null) {
					gList = GoodsService.categoryGoods(kind_num,String.valueOf(p));
					pcount = GoodsService.getAllCatePcount(kind_num);
				}else {
					gList = GoodsService.allGoods(String.valueOf(p));
					pcount = GoodsService.getAllPcount();
				}
				map=Paging.pagingValue(pcount, pnum, 5);
			}
			
			if((gList.size()>0) || (p==1 && gList.size()==0)) {
	              isList = false;
	        }else {
	        	pnum = String.valueOf(--p);
	        	session.setAttribute("pnum", pnum);
	        }
		}
		
		if(kind_num != null) {
			model.addAttribute("kind_num", kind_num);
		}
		
		model.addAttribute("map",map);
		model.addAttribute("gList", gList);
		return "allGoods";
	}
	
	//관리자 메뉴
	@RequestMapping(value = "/category.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String category(Model model) {
		logger.info("부위별 카테고리");
		
		return "category";
	}
	
	@RequestMapping(value = "/insertCategoryForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertCategoryForm() {
		logger.info("카테고리 추가 폼");
		
		return "insertCategory";
	}
	
	@RequestMapping(value = "/insertCategory.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertCategory( HttpSession session
								, Model model
								, String kind_name) {
		logger.info("카테고리 추가");
		
		boolean isInsert = GoodsService.insertCategory(kind_name);
		
		if(isInsert) {
			List<Goods_kindDto> category = GoodsService.category();
			session.setAttribute("category", category);
			
			return "redirect:category.do";
		}else {
			model.addAttribute("msg", "추가 실패");
			model.addAttribute("url", "insertCategoryForm.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/delCategory.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String delCategory( HttpSession session
							 , Model model
							 , String[] chk) {
		logger.info("카테고리 삭제");
		
		boolean isDelete = GoodsService.delCategory(chk);
		
		if(isDelete) {
			List<Goods_kindDto> category = GoodsService.category();
			session.setAttribute("category", category);
			return "redirect:category.do";
		}else {
			model.addAttribute("msg", "삭제 실패");
			model.addAttribute("url", "category.do");
			return "error";
		}
	}
	
	
	
	@RequestMapping(value = "/insertGoodsForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertForm(Model model) {
		logger.info("상품추가 폼으로");
		
		List<Goods_kindDto> kList = GoodsService.kind_num();
		
		model.addAttribute("kList",kList);
		return "insertGoods";
	}
	
	@RequestMapping(value = "/insertGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertAllGoods( Model model
								, GoodsDto gdto
								, String[] option_name
								, int[] option_count
								, int[] option_weight
								, MultipartFile title_file
								, MultipartHttpServletRequest mtfRequest
								) throws IOException, Exception {
		logger.info("상품 추가");
		
		//대표이미지
		String imgUploadPath_T = uploadPath + File.separator + "imgUpload";
		String ymdPath_T = UploadFileUtils_T.calcPath(imgUploadPath_T);
		String fileName_T = null;
		
		if(title_file != null) {
			fileName_T = UploadFileUtils_T.fileUpload_T(imgUploadPath_T, title_file.getOriginalFilename(), title_file.getBytes(), ymdPath_T);
		}else {
			fileName_T = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		gdto.setGoods_img_title("imgUpload" + ymdPath_T + File.separator + fileName_T);
		
		//상세이미지
		List<MultipartFile> detail_file = mtfRequest.getFiles("detail_file");
		
		String imgUploadPath_D = uploadPath + File.separator + "imgUpload";
		String ymdPath_D = UploadFileUtils_D.calcPath(imgUploadPath_D);
		List<String> fileName_D = new ArrayList<>();
		String fileName_D_html = "";

		if(detail_file != null) {
			for(int i=0;i<detail_file.size();i++) {
				fileName_D.add(UploadFileUtils_T.fileUpload_T(imgUploadPath_T, detail_file.get(i).getOriginalFilename(), detail_file.get(i).getBytes(), ymdPath_T));
				
				if(i>0) {
					fileName_D_html += "<br />";
				}
				fileName_D_html += "<img src='imgUpload" + ymdPath_D + File.separator + fileName_D.get(i) + "' style='width: 800px; height: 580px;'>";
			}
		}else {
			fileName_D.add(uploadPath + File.separator + "images" + File.separator + "none.png");
		}

		gdto.setGoods_img_detail(fileName_D_html);
		boolean isInsertGoods = GoodsService.insertGoods(gdto);
		
		boolean isInsertOption = false;
		
		Goods_optionDto oDto = new Goods_optionDto();
		System.out.println(oDto.getGoods_num());
		
		for(int i=0;i<option_name.length;i++) {
			oDto.setOption_name(option_name[i]);
			oDto.setOption_count(option_count[i]);
			oDto.setOption_weight(option_weight[i]);
			isInsertOption = GoodsService.insertGoods_option(oDto);
			
			if(!(isInsertOption)) {
				break;
			}
		}
				
		if(isInsertGoods && isInsertOption) {
			return "redirect:allGoods.do?pnum=1";
		}else {
			model.addAttribute("msg", "추가 실패");
			model.addAttribute("url", "insertGoodsForm.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/goodsDetail.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String goodsDetail(Model model, int goods_num) {
		logger.info("상세");
		
		GoodsDto gdto = GoodsService.getGoods(goods_num);
		List<Goods_optionDto> oList = GoodsService.getGoods_option(goods_num);
		List<ReviewDto> rList = GoodsService.reviewList(goods_num);
		
		model.addAttribute("gdto", gdto);
		model.addAttribute("oList", oList);
		model.addAttribute("rList", rList);
		return "goodsDetail";
	}
	
	//내 상품에서 삭제로 변경
	@RequestMapping(value = "/delAllGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String delAllGoods( HttpSession session
							 , Model model
							 , String[] chk
							 , String pnum) {
		logger.info("전체 상품에서 삭제");
		
		if(pnum==null) {
			pnum=(String)session.getAttribute("pnum");
		}else {
			session.setAttribute("pnum", pnum);
		}
		
		boolean isDelete = GoodsService.delGoods(chk, pnum);
		
		if(isDelete) {
			model.addAttribute("pnum",pnum);
			return "redirect:allGoods.do";
		}else {
			model.addAttribute("msg", "삭제 실패");
			model.addAttribute("url", "allGoods.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/upGoodsForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String upAllGoodsForm(Model model, int goods_num) {
		logger.info("상품 수정 폼");
		
		List<Goods_kindDto> kList = GoodsService.kind_num();
		GoodsDto gdto = GoodsService.getGoods(goods_num);
		List<Goods_optionDto> oDto = GoodsService.getGoods_option(goods_num);
		
		model.addAttribute("kList",kList);
		model.addAttribute("gdto", gdto);
		model.addAttribute("oDto", oDto);
		return "updateGoods";
	}
	
	@RequestMapping(value = "/upGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String upAllGoods( Model model
							, GoodsDto gdto
							, int goods_num
							, int[] option_num
							, String[] option_name
							, int[] option_count
							, int[] option_weight
							, MultipartFile title_file
							, String goods_img_title
							, String goods_img_detail
							, List<MultipartFile> detail_file) throws IOException, Exception {
		logger.info("상품 수정");
		
		Goods_optionDto oDto = new Goods_optionDto();
		
		//대표이미지
		// 새로운 파일이 등록되었는지 확인
		if(title_file.getOriginalFilename() != null && title_file.getOriginalFilename() != "") {
			// 기존 파일을 삭제
			new File(uploadPath + goods_img_title).delete();
		  
			// 새로 첨부한 파일을 등록
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils_T.calcPath(imgUploadPath);
			String fileName = UploadFileUtils_T.fileUpload_T(imgUploadPath, title_file.getOriginalFilename(), title_file.getBytes(), ymdPath);
		  
			gdto.setGoods_img_title("imgUpload" + ymdPath + File.separator + fileName);
		  
		}else {  // 새로운 파일이 등록되지 않았다면
			// 기존 이미지를 그대로 사용
			gdto.setGoods_img_title(null);
		}
		
		//상세이미지
		// 새로운 파일이 등록되었는지 확인
		if(detail_file.get(0).getOriginalFilename( ) != "") {
			
			// 기존 파일을 삭제
			new File(uploadPath + goods_img_detail).delete();

			// 새로 첨부한 파일을 등록
			String imgUploadPath_D = uploadPath + File.separator + "imgUpload";
			String ymdPath_D = UploadFileUtils_D.calcPath(imgUploadPath_D);
			List<String> fileName_D = new ArrayList<>();
			String fileName_D_html = "";
			
			if(detail_file != null) {
				for(int i=0;i<detail_file.size();i++) {
					fileName_D.add(UploadFileUtils_D.fileUpload_D(imgUploadPath_D, detail_file.get(i).getOriginalFilename(), detail_file.get(i).getBytes(), ymdPath_D));
					
					if(i>0) {
						fileName_D_html += "<br />";
					}
					fileName_D_html += "<img src='imgUpload" + ymdPath_D + File.separator + fileName_D.get(i) + "' style='width: 800px; height: 580px;'>";
				}
			}
			System.out.println(fileName_D_html);
			
			gdto.setGoods_img_detail(fileName_D_html);
		  
		}else {  // 새로운 파일이 등록되지 않았다면
			// 기존 이미지를 그대로 사용
			gdto.setGoods_img_detail(null);
		}
		
		boolean isUpGoods = GoodsService.upGoods(gdto);
		boolean isUpOption = false;
		boolean isInsertOption = false;
		int i = 0;
		
		for(i=0;i<option_num.length;i++) {
			oDto.setOption_num(option_num[i]);
			oDto.setOption_name(option_name[i]);
			oDto.setOption_count(option_count[i]);
			oDto.setOption_weight(option_weight[i]);
			isUpOption = GoodsService.upGoods_option(oDto);
			
			if(!(isUpOption)) {
				break;
			}
		}
		
		if(i < option_name.length) {
			oDto.setGoods_num(goods_num);
			
			for(int j=i;j<option_name.length;j++) {
				oDto.setOption_name(option_name[i]);
				oDto.setOption_count(option_count[i]);
				oDto.setOption_weight(option_weight[i]);
				isInsertOption = GoodsService.insertGoods_option(oDto);
				
				if(!(isInsertOption)) {
					break;
				}
			}
		}else {
			isInsertOption = true;
		}
		
		if(isUpGoods && isUpOption && isInsertOption) {
			return "redirect:goodsDetail.do?goods_num="+gdto.getGoods_num();
		}else {
			model.addAttribute("msg", "수정 실패");
			model.addAttribute("url", "upGoodsForm.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/basketList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String basketList(Model model, int user_num) {
		logger.info("장바구니 목록");
		
		if(user_num == 0) {
			return "redirect:loginPage.do";
		}
		
		List<BasketDto> basketList = new ArrayList<>();
		
		basketList = GoodsService.basketList(user_num);

		model.addAttribute("basketList", basketList);
		return "basketList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/insertBasket.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertBasket( HttpSession session
							  , Model model
							  , int user_num
							  , int goods_num
							  , @RequestParam(value="option_num[]")List<Integer> option_num
							  , @RequestParam(value="basket_count[]")List<Integer> basket_count) {
		logger.info("장바구니 상품 추가");
		
		boolean isInsert = false;
		BasketDto bDto = new BasketDto();
		bDto.setUser_num(user_num);
		bDto.setGoods_num(goods_num);
		
		for(int i=0;i<option_num.size();i++) {
			boolean isBe = GoodsService.beBasket(user_num,option_num.get(i));
			if(isBe) {
				isInsert = true;
			}else {
				bDto.setOption_num(option_num.get(i));
				bDto.setBasket_count(basket_count.get(i));
				isInsert = GoodsService.insertBasket(bDto);
			}
			
			if(!(isInsert)) {
				break;
			}
		}
		
		int basketCount = GoodsService.basketCount(user_num);
		session.setAttribute("basketCount", basketCount);
		
		return isInsert+","+basketCount;
	}
	
	@RequestMapping(value = "/delBasket.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String delBasket(HttpSession session, Model model, int[] chk) {
		logger.info("장바구니 상품 삭제");
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		boolean isDelete = GoodsService.delBasket(chk);
		
		if(isDelete) {
			int basketCount = GoodsService.basketCount(ldto.getUser_num());
			session.setAttribute("basketCount", basketCount);
			return "redirect:basketList.do?user_num="+ldto.getUser_num();
		}else {
			model.addAttribute("msg", "삭제 실패");
			model.addAttribute("url", "basketList.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/insertOrderForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertOrderForm( Model model
								 , int user_num
								 , int[] option_num
								 , int[] basket_count) {
		logger.info("주문 폼");

		List<BasketDto> basketList = new ArrayList<>();
		BasketDto dto = new BasketDto();
		
		if(option_num != null) {
			for(int i=0;i<option_num.length;i++) {
				dto = GoodsService.goodsData(option_num[i]);
				dto.setUser_num(user_num);
				dto.setBasket_count(basket_count[i]);
				basketList.add(dto);
			}
		}else {
			basketList = GoodsService.basketList(user_num);
		}
		
		model.addAttribute("basketList", basketList);
		return "insertOrder";
	}
	
	@RequestMapping(value = "/insertOrder.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertOrder( HttpSession session
							 , Model model
							 , int user_num
							 , String addr
							 , String addrDetail
							 , int[] seller_num
							 , int[] goods_num
							 , int[] option_num
							 , int[] order_money
							 , int[] option_count
							 , int user_coupon_num) {
		logger.info("주문");
		
		OrderDto dto = new OrderDto();
		
		boolean isInsert = false;
		boolean isCount = false;
		
		dto.setUser_num(user_num);
		dto.setOrder_addr(addr+" "+addrDetail);
		
		for(int i=0;i<goods_num.length;i++) {
			dto.setOrder_seller(seller_num[i]);
			dto.setGoods_num(goods_num[i]);
			dto.setOption_num(option_num[i]);
			dto.setOrder_money(order_money[i]);
			dto.setOrder_count(option_count[i]);
			isInsert = GoodsService.insertOrder(dto);
			isCount = GoodsService.optionSell(option_num[i],option_count[i]);
			
			if(!(isInsert) || !(isCount)) {
				break;
			}
		}
		boolean isBe = false;
		
		//장바구니삭제
		for(int i=0;i<option_num.length;i++) {
			isBe = GoodsService.beBasket(user_num,option_num[i]);
			
			if(isBe) {
				break;
			}
		}
		
		boolean isDel = true;
		
		if(isBe) {
			isDel = GoodsService.delBasket(option_num);
		}
		
		//쿠폰사용
		boolean isUse = false;
		
		if(user_coupon_num > 0){
			isUse = GoodsService.useCoupon(user_coupon_num);
		}else {
			isUse = true;
		}
		
		
		if(isInsert && isCount && isDel && isUse) {
			int basketCount = GoodsService.basketCount(user_num);
			session.setAttribute("basketCount", basketCount);
			return "redirect:orderList.do?user_num="+user_num;
		}else {
			model.addAttribute("msg", "주문 실패");
			model.addAttribute("url", "main.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/adminPage.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String adminPage(Model model) {
		logger.info("관리자 페이지");

		return "adminPage";
	}
	
	@RequestMapping(value = "/adminCouponList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String adminCouponList(HttpSession session, Model model, String pnum) {
		logger.info("관리자 쿠폰 목록");
		
		if(pnum==null) {
			pnum=(String)session.getAttribute("pnum");
		}else {
			session.setAttribute("pnum", pnum);
		}
		
		int pcount = GoodsService.CouponPcount();
		Map<String, Integer> map=Paging.pagingValue(pcount, pnum, 5);
		List<CouponDto> coulist = GoodsService.adminCouponList(pnum);

		model.addAttribute("map",map);
		model.addAttribute("coulist", coulist);
		return "adminCouponList";
	}
	
	@RequestMapping(value = "/insertCouponForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertCouponForm(Model model) {
		logger.info("쿠폰생성폼으로");

		return "insertCouponForm";
	}
	
	@RequestMapping(value = "/insertCoupon.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertCoupon( Model model
							  , CouponDto dto
							  , MultipartFile title_file) throws IOException, Exception {
		logger.info("쿠폰생성");

		String imgUploadPath_T = uploadPath + File.separator + "imgUpload";
		String ymdPath_T = UploadFileUtils_T.calcPath(imgUploadPath_T);
		String fileName_T = null;

		if(title_file != null) {
			fileName_T = UploadFileUtils_T.fileUpload_T(imgUploadPath_T, title_file.getOriginalFilename(), title_file.getBytes(), ymdPath_T);
		}else {
			fileName_T = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		dto.setCoupon_img("imgUpload" + ymdPath_T + File.separator + fileName_T);
		
		boolean isInsert = GoodsService.insertCoupon(dto);
		
		if(isInsert) {
			return "redirect:adminCouponList.do";
		}else {
			model.addAttribute("msg", "추가 실패");
			model.addAttribute("url", "insertCouponForm.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/couponList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String couponList(Model model, int user_num) {
		logger.info("쿠폰목록보기(팝업)");

		List<User_couponDto> clist = GoodsService.couponList(user_num);
		model.addAttribute("clist", clist);
		return "couponList";
	}
	
	@RequestMapping(value = "/orderList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String orderList( HttpSession session
						   , Model model
						   , int user_num) {
		logger.info("구매내역");
		
		List<OrderDto> olist = GoodsService.orderList(user_num);
		String addReview = (String)session.getAttribute("addReview");
		
		if(addReview != null) {
			model.addAttribute("addReview", addReview);
			session.removeAttribute("addReview");
		}
		
		model.addAttribute("olist", olist);
		return "orderList";
	}
	
	@RequestMapping(value = "/selOrderList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String selOrderList( Model model
						   	  , int user_num) {
		logger.info("판매관리");
		
			List<OrderDto> dlist = GoodsService.orderDelivery(user_num);
			List<OrderDto> slist = GoodsService.orderSeller(user_num);
			model.addAttribute("dlist", dlist);
			model.addAttribute("slist", slist);
		
		return "selOrderList";
	}
	
	@RequestMapping(value = "/stateUpdate.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String stateUpdate( HttpSession session
							 , Model model
						     , int order_num
						     , int chk) {
		logger.info("배송상태변경");
		
		boolean isUpdate = GoodsService.stateUpdate(order_num);
		
		if(isUpdate) {
			UserDto ldto = (UserDto)session.getAttribute("ldto");
			if(chk > 0) {
				return "redirect:orderList.do?user_num="+ldto.getUser_num();
			}else {
				return "redirect:selOrderList.do?user_num="+ldto.getUser_num();
			}
			
		}else {
			model.addAttribute("msg", "상태변경 실패");
			model.addAttribute("url", "orderList.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/reviewForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String reviewForm(Model model, int order_num) {
		logger.info("후기 폼으로");
		
		OrderDto odto = GoodsService.getOrder(order_num);
		
		model.addAttribute("odto",odto);
		return "insertReview";
	}
	
	@RequestMapping(value = "/addReview.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String addReview( Model model
						   , ReviewDto dto
						   , int order_num
						   , HttpSession session) {
		logger.info("후기 등록");
		
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		boolean isInsert = GoodsService.addReview(dto);
		boolean isUpdate = GoodsService.stateUpdate(order_num);
		
		//랜덤으로 쿠폰 증정
		List<Integer> coulist = GoodsService.AllCouponList();
        int ran = (int)(Math.random() * coulist.size());
        int coupon_num = coulist.get(ran);
        
		CouponDto cdto = GoodsService.couponDetail(coupon_num);
		boolean isCoupon = GoodsService.insertUserCoupon(ldto.getUser_num(),cdto);
		
		//평점에 따라 사업자 등급 변경
		int review_score = GoodsService.scoreAVG(dto.getUser_num());
		boolean isLevel = true;
		
		if(review_score >= 4) {
			isLevel = GoodsService.levelChange(dto.getUser_num(),3);
		}else if(review_score >= 3) {
			isLevel = GoodsService.levelChange(dto.getUser_num(),2);
		}else {
			isLevel = GoodsService.levelChange(dto.getUser_num(),1);
		}
		
		if(isInsert && isUpdate && isCoupon && isLevel) {
			String addReview = "랜덤 쿠폰이 지급되었습니다.";
			session.setAttribute("addReview", addReview);
			return "redirect:orderList.do?user_num="+ldto.getUser_num();
		}else {
			model.addAttribute("msg", "상태변경 실패");
			model.addAttribute("url", "orderList.do");
			return "error";
		}

	}
	
	@RequestMapping(value = "/bannerList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String bannerList(HttpSession session, Model model, String pnum) {
		logger.info("배너 목록");
		
		if(pnum==null) {
			pnum=(String)session.getAttribute("pnum");
		}else {
			session.setAttribute("pnum", pnum);
		}
		
		int pcount = GoodsService.bannerPcount();
		Map<String, Integer> map=Paging.pagingValue(pcount, pnum, 5);
		List<BannerDto> bannerlist = GoodsService.bannerList(pnum);

		model.addAttribute("map",map);
		model.addAttribute("bannerlist", bannerlist);
		return "bannerList";
	}
	
	@RequestMapping(value = "/insertBannerForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertBannerForm(Model model) {
		logger.info("배너생성폼으로");

		return "insertBannerForm";
	}
	
	@RequestMapping(value = "/insertBanner.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertBanner( HttpSession session
							  , Model model
							  , BannerDto dto
							  , MultipartFile title_file) throws IOException, Exception {
		logger.info("배너생성");

		String imgUploadPath_T = uploadPath + File.separator + "imgUpload";
		String ymdPath_T = UploadFileUtils_T.calcPath(imgUploadPath_T);
		String fileName_T = null;

		if(title_file != null) {
			fileName_T = UploadFileUtils_T.fileUpload_T(imgUploadPath_T, title_file.getOriginalFilename(), title_file.getBytes(), ymdPath_T);
		}else {
			fileName_T = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		dto.setBanner_img_name("imgUpload" + ymdPath_T + File.separator + fileName_T);
		
		boolean isInsert = GoodsService.insertBanner(dto);
		
		if(isInsert) {
			List<BannerDto> mainBanner = GoodsService.mainBanner();
			
			while(mainBanner.size()<4) {
				BannerDto bdto = new BannerDto();
				bdto.setBanner_num(0);
				bdto.setBanner_name("고기고기괴기");
				bdto.setBanner_img_name("img\\logo9.png");
				mainBanner.add(bdto);
			}
			session.setAttribute("mainBanner", mainBanner);
			
			return "redirect:bannerList.do";
		}else {
			model.addAttribute("msg", "추가 실패");
			model.addAttribute("url", "insertCouponForm.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/myCouponList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String myCouponList( HttpSession session
							  , Model model
							  , String pnum
							  , int user_num) {
		logger.info("관리자 쿠폰 목록");
		
		if(pnum==null) {
			pnum=(String)session.getAttribute("pnum");
		}else {
			session.setAttribute("pnum", pnum);
		}
		
		int pcount = GoodsService.myCouponPcount(user_num);
		Map<String, Integer> map=Paging.pagingValue(pcount, pnum, 5);
		List<User_couponDto> clist = GoodsService.myCouponList(pnum,user_num);
		
		model.addAttribute("map",map);
		model.addAttribute("clist", clist);
		return "myCouponList";
	}
	
}
		

