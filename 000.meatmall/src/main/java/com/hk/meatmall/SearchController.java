package com.hk.meatmall;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hk.meatmall.iservices.ISearchService;

@Controller
public class SearchController {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	@Autowired
	private ISearchService SearchService;
	
	@RequestMapping(value = "/search.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String search(Model model, String year, String month) {
		logger.info("일정목록조회");
		
		
		return "calendar";
	}
	

	
}
