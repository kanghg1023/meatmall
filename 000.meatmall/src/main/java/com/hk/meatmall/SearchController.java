package com.hk.meatmall;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.GoodsDto;
import com.hk.meatmall.dtos.Goods_kindDto;
import com.hk.meatmall.iservices.ISearchService;
import com.hk.utils.Util;

@Controller
public class SearchController {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	@Autowired
	private ISearchService SearchService;
	
	@RequestMapping(value = "/search.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String search(Model model, String search_word) {
		logger.info("전체 검색");
		
		List<Goods_kindDto> caList = SearchService.CategorySearch(search_word);
		List<GoodsDto> goodsList = SearchService.goodsSearch(search_word);
		List<BoardDto> bList = SearchService.boardSearch(search_word);
		
		for (BoardDto dto:bList) {
			String con = dto.getBoard_content();
			if(con.length() > 10) {
				dto.setBoard_content(Util.sampleContent(con));
			}
		}
		
		//검색된적 있는지 체크
		boolean isBe = SearchService.beSearch(search_word);
		boolean isSearch = true;
		
		if(isBe) {
			//검색 횟수 증가
			isSearch = SearchService.addSearch(search_word);
		}else {
			//새로운 단어 추가
			isSearch = SearchService.addWord(search_word);
		}
		
		if(isSearch){
			model.addAttribute("search_word",search_word);
			model.addAttribute("caList",caList);
			model.addAttribute("goodsList",goodsList);
			model.addAttribute("bList",bList);
			return "searchResult";
		}else {
			model.addAttribute("msg", "검색 실패");
			model.addAttribute("url", "main.do");
			return "error";
		}
		
	}
	

	
}
