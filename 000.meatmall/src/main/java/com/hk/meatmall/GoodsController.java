package com.hk.meatmall;

import java.util.List;
import java.util.Map;

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
import com.hk.utils.Paging;

@Controller
public class GoodsController {

private static final Logger logger = LoggerFactory.getLogger(GoodsController.class);
	
	@Autowired
	private IGoodsService GoodsService;
	
	@RequestMapping(value = "/allGoods.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String allGoods(HttpServletRequest request, Model model, String pnum) {
		logger.info("전체 상품");
		HttpSession session=request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		if(ldto == null || ldto.getUser_role().equals("USER") || ldto.getUser_role().equals("LICENSE")) {
			//enabled Y만 보이게
			List<GoodsDto> gList = GoodsService.getEnabled(pnum);
			model.addAttribute("gList", gList);
		
			int pcount = GoodsService.getEnabledPcount();
			Map<String, Integer> map=Paging.pagingValue(pcount, pnum, 5);
			model.addAttribute("map",map);
		}else {
			//enabled 다 보이게
			List<GoodsDto> gList = GoodsService.allGoods(pnum);
			model.addAttribute("gList", gList);
			
			int pcount = GoodsService.getAllPcount();
			Map<String, Integer> map=Paging.pagingValue(pcount, pnum, 5);
			model.addAttribute("map",map);
		}
		
		if(pnum==null) {
			pnum=(String)request.getSession().getAttribute("pnum");
		}else {
			request.getSession().setAttribute("pnum", pnum);
		}
		
		return "allGoods";
	}
	
	@RequestMapping(value = "/category.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String category(Model model) {
		logger.info("부위별 카테고리");
		List<Goods_kindDto> cList = GoodsService.category();
		
		model.addAttribute("cList", cList);
		
		return "category";
	}
	
	@RequestMapping(value = "/insertCategoryForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertCategoryForm() {
		logger.info("카테고리 추가 폼");
		
		return "insertCategory";
	}
	
	@RequestMapping(value = "/insertCategory.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertCategory(Model model, String kind_name) {
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
	public String delBoard(Model model, String[] chk) {
		logger.info("카테고리 삭제");
		boolean isS = GoodsService.delCategory(chk);
		
		if(isS) {
			return "redirect:category.do";
		}else {
			return "redirect:category.do";
		}
	}
	
	@RequestMapping(value = "/categoryGoods.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String categoryGoods(HttpServletRequest request, Model model, String kind_num, String pnum) {
		logger.info("카테고리별 상품");
		HttpSession session=request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		if(ldto == null || ldto.getUser_role().equals("USER") || ldto.getUser_role().equals("LICENSE")) {
			//enabled Y만 보이게
			List<GoodsDto> cList = GoodsService.getCateEnabled(kind_num, pnum);
			model.addAttribute("cList", cList);
			model.addAttribute("kind_num",kind_num);
		
			int pcount = GoodsService.getEnabledPcount();
			Map<String, Integer> map=Paging.pagingValue(pcount, pnum, 5);
			model.addAttribute("map",map);
		}else {
			//enabled 다 보이게
			List<GoodsDto> cList = GoodsService.categoryGoods(kind_num, pnum);
			model.addAttribute("cList", cList);
			model.addAttribute("kind_num",kind_num);
			
			int pcount = GoodsService.getAllPcount();
			Map<String, Integer> map=Paging.pagingValue(pcount, pnum, 5);
			model.addAttribute("map",map);
		}
		
		if(pnum==null) {
			pnum=(String)request.getSession().getAttribute("pnum");
		}else {
			request.getSession().setAttribute("pnum", pnum);
		}
		
		return "categoryGoods";
	}
	
	@RequestMapping(value = "/insertGoodsForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertForm(Model model) {
		logger.info("전체상품에서 추가 폼");
		
		List<Goods_optionDto> oList = GoodsService.kind_num();
		model.addAttribute("oList",oList);
		
		return "insertGoods";
	}
	
	@RequestMapping(value = "/insertGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertAllGoods(Model model, GoodsDto gDto, Detail_imgDto iDto
			, String[] option_name, int[] option_count, int[] option_weight) {
		logger.info("전체상품에서 추가");
		
		Goods_optionDto oDto = new Goods_optionDto();
		
		boolean isS = GoodsService.insertGoods(gDto);
				isS = GoodsService.insertDetail_img(iDto);
				
		for(int i=0;i<option_name.length;i++) {
			oDto.setOption_name(option_name[i]);
			oDto.setOption_count(option_count[i]);
			oDto.setOption_weight(option_weight[i]);
			isS = GoodsService.insertGoods_option(oDto);
		}
				
		
		if(isS) {
			return "redirect:allGoods.do?pnum=1";
		}else {
			return "insertGoods";
		}
	}
	
	@RequestMapping(value = "/insertCateGoodsForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertCateForm(Model model, String kind_num ) {
		logger.info("카테고리상품에서 추가 폼");
		model.addAttribute("kind_num",kind_num);
		return "insertCateGoods";
	}
	
	@RequestMapping(value = "/insertCateGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertCateGoods(Model model, GoodsDto gDto, Detail_imgDto iDto
				, String[] option_name, int[] option_count, int[] option_weight, String kind_num) {
		logger.info("카테고리상품에서 추가");
		
		Goods_optionDto oDto = new Goods_optionDto();
		
		boolean isS = GoodsService.insertGoods(gDto);
				isS = GoodsService.insertDetail_img(iDto);
				
		for(int i=0;i<option_name.length;i++) {
			oDto.setOption_name(option_name[i]);
			oDto.setOption_count(option_count[i]);
			oDto.setOption_weight(option_weight[i]);
			isS = GoodsService.insertGoods_option(oDto);
		}
				
		if(isS) {
			return "redirect:categoryGoods.do?pnum=1&kind_num="+kind_num;
		}else {
			return "insertGoods";
		}
	}
	
	@RequestMapping(value = "/goodsDetail.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String goodsDetail(Model model, int goods_num) {
		logger.info("전체상품에서 상세");
		GoodsDto gDto = GoodsService.getGoods(goods_num);
		Detail_imgDto iDto = GoodsService.getDetail_img(goods_num);
		List<Goods_optionDto> oDto = GoodsService.getGoods_option(goods_num);
		
		model.addAttribute("gDto", gDto);
		model.addAttribute("iDto", iDto);
		model.addAttribute("oDto", oDto);
		
		return "goodsDetail";
	}
	
	@RequestMapping(value = "/goodsCateDetail.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String goodsCateDetail(Model model, int goods_num) {
		logger.info("카테고리상품에서 상세");
		GoodsDto gDto = GoodsService.getGoods(goods_num);
		Detail_imgDto iDto = GoodsService.getDetail_img(goods_num);
		List<Goods_optionDto> oDto = GoodsService.getGoods_option(goods_num);
		System.out.println(oDto);
		
		model.addAttribute("gDto", gDto);
		model.addAttribute("iDto", iDto);
		model.addAttribute("oDto", oDto);
		
		return "goodsCateDetail";
	}
	
	@RequestMapping(value = "/delallGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String delAllGoods(Model model, String[] chk) {
		logger.info("전체 상품에서 삭제");
		boolean isS = GoodsService.delGoods(chk);
		
		if(isS) {
			return "redirect:allGoods.do";
		}else {
			return "redirect:allGoods.do";
		}
	}
	
	@RequestMapping(value = "/delcateGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String delCateGoods(Model model, String[] chk,String kind_num) {
		logger.info("카테고리 상품에서 삭제");
		boolean isS = GoodsService.delGoods(chk);
		
		if(isS) {
			return "redirect:categoryGoods.do?kind_num="+kind_num;
		}else {
			return "redirect:categoryGoods.do";
		}
	}
	
	
	
}
