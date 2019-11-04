package com.hk.meatmall;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.dtos.Goods_optionDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.IGoodsService;
import com.hk.utils.Paging;
import com.hk.utils.UploadFileUtils;

@Controller
public class GoodsController {

private static final Logger logger = LoggerFactory.getLogger(GoodsController.class);
	
	@Resource(name="uploadPath")
	private String uploadPath;

	@Autowired
	private IGoodsService GoodsService;
	
	@RequestMapping(value = "/allGoods.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String allGoods(HttpServletRequest request, Model model, String pnum) {
		logger.info("전체 상품");
		
		HttpSession session=request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		if(pnum==null) {
			pnum=(String)request.getSession().getAttribute("pnum");
		}else {
			request.getSession().setAttribute("pnum", pnum);
		}
		
		List<GoodsDto> gList = new ArrayList<>();
		Map<String, Integer> map = new HashMap<>();
		
		if(ldto == null || !(ldto.getUser_role().equals("ADMIN"))) {
			gList = GoodsService.getEnabled(pnum);
		
			int pcount = GoodsService.getEnabledPcount();
			map=Paging.pagingValue(pcount, pnum, 5);
		}else {
			gList = GoodsService.allGoods(pnum);
			
			int pcount = GoodsService.getAllPcount();
			map=Paging.pagingValue(pcount, pnum, 5);
		}
		
		model.addAttribute("gList", gList);
		model.addAttribute("map",map);
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
		
		boolean isInsert = GoodsService.insertCategory(kind_name);
		
		if(isInsert) {
			return "redirect:category.do";
		}else {
			model.addAttribute("msg", "추가 실패");
			model.addAttribute("url", "insertCategoryForm.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/delCategory.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String delCategory(Model model, String[] chk) {
		logger.info("카테고리 삭제");
		
		boolean isDelete = GoodsService.delCategory(chk);
		
		if(isDelete) {
			return "redirect:category.do";
		}else {
			model.addAttribute("msg", "추가 실패");
			model.addAttribute("url", "category.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/categoryGoods.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String categoryGoods( HttpServletRequest request
							   , Model model
							   , String kind_num
							   , String pnum) {
		logger.info("카테고리별 상품");
		
		HttpSession session=request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		if(pnum==null) {
			pnum=(String)request.getSession().getAttribute("pnum");
		}else {
			request.getSession().setAttribute("pnum", pnum);
		}
		
		List<GoodsDto> cList = new ArrayList<>();
		Map<String, Integer> map = new HashMap<>();
		int pcount = 0;
		
		if(ldto == null || !(ldto.getUser_role().equals("ADMIN"))) {
			cList = GoodsService.getCateEnabled(kind_num, pnum);
			pcount = GoodsService.getEnabledCatePcount(kind_num);
		}else {
			cList = GoodsService.categoryGoods(kind_num, pnum);
			pcount = GoodsService.getAllCatePcount(kind_num);
		}
		
		map=Paging.pagingValue(pcount, pnum, 5);
		
		model.addAttribute("cList", cList);
		model.addAttribute("kind_num",kind_num);
		model.addAttribute("map",map);
		return "categoryGoods";
	}
	
	@RequestMapping(value = "/insertGoodsForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertForm(Model model) {
		logger.info("추가 폼으로");
		
		List<Goods_optionDto> oList = GoodsService.kind_num();
		
		model.addAttribute("oList",oList);
		return "insertGoods";
	}
	
	@RequestMapping(value = "/insertGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertAllGoods( Model model
								, GoodsDto gDto
								, String[] option_name
								, int[] option_count
								, int[] option_weight
								, MultipartFile file) throws IOException, Exception {
		logger.info("전체상품에서 추가");
		
		Goods_optionDto oDto = new Goods_optionDto();
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if(file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		}else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		gDto.setGoods_img_title("imgUpload" + ymdPath + File.separator + fileName);
		boolean isInsertGoods = GoodsService.insertGoods(gDto);
		
		boolean isInsertOption = false;
		
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
	
	@RequestMapping(value = "/insertCateGoodsForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertCateForm(Model model, String kind_num) {
		logger.info("카테고리상품에서 추가 폼");
		
		model.addAttribute("kind_num",kind_num);
		return "insertCateGoods";
	}
	
	@RequestMapping(value = "/insertCateGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String insertCateGoods( Model model
								 , GoodsDto gDto
								 , String[] option_name
								 , int[] option_count
								 , int[] option_weight
								 , String kind_num
								 , MultipartFile file) throws IOException, Exception {
		logger.info("카테고리상품에서 추가");
		
		Goods_optionDto oDto = new Goods_optionDto();
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if(file != null) {
		 fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		} else {
		 fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		gDto.setGoods_img_title("imgUpload" + ymdPath + File.separator + fileName);
		
		boolean isS = GoodsService.insertGoods(gDto);
				
		for(int i=0;i<option_name.length;i++) {
			oDto.setOption_name(option_name[i]);
			oDto.setOption_count(option_count[i]);
			oDto.setOption_weight(option_weight[i]);
			isS = GoodsService.insertGoods_option(oDto);
		}
				
		if(isS) {
			return "redirect:categoryGoods.do?pnum=1&kind_num="+kind_num;
		}else {
			model.addAttribute("msg", "추가 실패");
			model.addAttribute("url", "insertGoodsForm.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/goodsDetail.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String goodsDetail(Model model, int goods_num) {
		logger.info("전체상품에서 상세");
		
		GoodsDto gDto = GoodsService.getGoods(goods_num);
		List<Goods_optionDto> oDto = GoodsService.getGoods_option(goods_num);
		
		model.addAttribute("gDto", gDto);
		model.addAttribute("oDto", oDto);
		return "goodsDetail";
	}
	
	@RequestMapping(value = "/goodsCateDetail.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String goodsCateDetail(Model model, int goods_num) {
		logger.info("카테고리상품에서 상세");
		
		GoodsDto gDto = GoodsService.getGoods(goods_num);
		List<Goods_optionDto> oDto = GoodsService.getGoods_option(goods_num);
		
		model.addAttribute("gDto", gDto);
		model.addAttribute("oDto", oDto);
		return "goodsCateDetail";
	}
	
	@RequestMapping(value = "/delAllGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String delAllGoods( HttpServletRequest request
							 , Model model
							 , String[] chk
							 , String pnum) {
		logger.info("전체 상품에서 삭제");
		
		if(pnum==null) {
			pnum=(String)request.getSession().getAttribute("pnum");
		}else {
			request.getSession().setAttribute("pnum", pnum);
		}
		
		boolean isDelete = GoodsService.delGoods(chk, pnum);
		
		if(isDelete) {
			model.addAttribute("pnum",pnum);
			return "redirect:allGoods.do";
		}else {
			model.addAttribute("msg", "추가 실패");
			model.addAttribute("url", "allGoods.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/delCateGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String delCateGoods(HttpServletRequest request, Model model, String[] chk, String kind_num, String pnum) {
		logger.info("카테고리 상품에서 삭제");
		
		if(pnum==null) {
			pnum=(String)request.getSession().getAttribute("pnum");
		}else {
			request.getSession().setAttribute("pnum", pnum);
		}
		
		boolean isDelete = GoodsService.delCateGoods(chk, kind_num, pnum);
		
		if(isDelete) {
			model.addAttribute("kind_num",kind_num);
			model.addAttribute("pnum",pnum);
			return "redirect:categoryGoods.do";
		}else {
			model.addAttribute("msg", "추가 실패");
			model.addAttribute("url", "categoryGoods.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/upGoodsForm.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String upAllGoodsForm(Model model, int goods_num) {
		logger.info("전체상품에서 수정 폼");
		
		List<Goods_optionDto> oList = GoodsService.kind_num();
		GoodsDto gDto = GoodsService.getGoods(goods_num);
		List<Goods_optionDto> oDto = GoodsService.getGoods_option(goods_num);
		
		model.addAttribute("oList",oList);
		model.addAttribute("gDto", gDto);
		model.addAttribute("oDto", oDto);
		return "updateGoods";
	}
	
	@RequestMapping(value = "/upGoods.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String upAllGoods( Model model
							, HttpServletRequest request
							, GoodsDto gDto
							, int[] option_num
							, String[] option_name
							, int[] option_count
							, int[] option_weight
							, MultipartFile file
							) throws IOException, Exception {
		logger.info("전체상품에서 수정");
	
		Goods_optionDto oDto = new Goods_optionDto();
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		if(file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath); 
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		gDto.setGoods_img_title("imgUpload" + ymdPath + File.separator + fileName);
		
		boolean isUpGoods = GoodsService.upGoods(gDto);
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
			return "redirect:goodsDetail.do?goods_num="+gDto.getGoods_num();
		}else {
			model.addAttribute("msg", "추가 실패");
			model.addAttribute("url", "upGoodsForm.do");
			return "error";
		}		
	}
	
	
}
