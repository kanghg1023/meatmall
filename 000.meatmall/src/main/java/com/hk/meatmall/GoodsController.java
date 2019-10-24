package com.hk.meatmall;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hk.meatmall.dtos.Detail_imgDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.Goods_optionDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.IGoodsService;
import com.hk.meatmall.iservices.ILoginService;

@Controller
public class GoodsController {

private static final Logger logger = LoggerFactory.getLogger(GoodsController.class);
	
	@Autowired
	private ILoginService loginService;
	
	@Autowired
	private IGoodsService GoodsService;
	
	@RequestMapping(value = "/login.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String login(HttpServletRequest request, Model model, String user_id, String user_pw) {
		logger.info("로그인");
		
		HttpSession session = request.getSession();
		
		UserDto ldto = loginService.login(user_id,user_pw);
		
		session.setAttribute("ldto", ldto);
		
		return "main";
	}
	
	@RequestMapping(value = "/allGoods.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String allGoods(Model model) {
		logger.info("전체 상품");
		
		List<GoodsDto> list = GoodsService.allGoods();
		
		model.addAttribute("list", list);
		
		return "allGoods";
	}
	
	@RequestMapping(value = "/category.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String category(Model model) {
		logger.info("부위별 카테고리");
		List<Goods_kindDto> list = GoodsService.category();
		
		model.addAttribute("list", list);
		
		return "category";
	}
	
	@RequestMapping(value = "/insertCategoryForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertCategoryForm() {
		logger.info("카테고리 추가 폼");
		
		return "insertCategory";
	}
	
	@RequestMapping(value = "/insertCategory.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertCategory(Model model,String kind_name) {
		logger.info("카테고리 추가");
		System.out.println(kind_name);
		boolean isS = GoodsService.insertCategory(kind_name);
		
		if(isS) {
			return "redirect:category.do";
		}else {
			return "insertCategory";
		}
	}
	
	@RequestMapping(value = "/delCategory.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String delBoard(Model model ,String[] chk) {
		logger.info("카테고리 삭제");
		boolean isS = GoodsService.delCategory(chk);
		
		if(isS) {
			return "redirect:category.do";
		}else {
			return "redirect:category.do";
		}
	}
	
	@RequestMapping(value = "/categoryGoods.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String categoryGoods(Model model, int kind_num) {
		logger.info("카테고리별 상품");
		
		List<GoodsDto> list = GoodsService.categoryGoods(kind_num);
		
		model.addAttribute("list", list);
		
		return "categoryGoods";
	}
	
	@RequestMapping(value = "/insertGoodsForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertForm() {
		logger.info("상품 추가 폼");
		
		return "insertGoods";
	}
	
	@RequestMapping(value = "/insertGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertGoods(Model model, GoodsDto dto) {
		logger.info("상품 추가");
		boolean isS = GoodsService.insertGoods(dto);
		
		if(isS) {
			return "redirect:allGoods.do";
		}else {
			return "insertGoods";
		}
	}
	
	@RequestMapping(value = "/Detail_img.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertDetail_img(Model model, Detail_imgDto Dto) {
		logger.info("상품 추가 (상세이미지)");
		boolean isS = GoodsService.insertDetail_img(Dto);
			    
		if(isS) {
			return "redirect:allGoods.do";
		}else {
			return "insertGoods";
		}
	}
	
//	@RequestMapping(value = "/insertGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
//	public String insertGoods_option(Model model, Goods_optionDto Dto) {
//		logger.info("상품 추가 (옵션)");
//		boolean isS = GoodsService.insertGoods_option(Dto);
//			    
//		if(isS) {
//			return "redirect:allGoods.do";
//		}else {
//			return "insertGoods";
//		}
//	}
	
}
