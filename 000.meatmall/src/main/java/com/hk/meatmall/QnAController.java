package com.hk.meatmall;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hk.meatmall.dtos.FAQDto;
import com.hk.meatmall.dtos.QuestionDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.ILoginService;
import com.hk.meatmall.iservices.IQnAService;

@Controller
public class QnAController {
private static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	
	@Autowired
	private ILoginService loginService;
	
	@Autowired
	private IQnAService qnaService;
	
	@RequestMapping(value = "/", method = {RequestMethod.GET,RequestMethod.POST})
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/login.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String login(HttpServletRequest request, Model model, String user_id, String user_pw) {
		logger.info("로그인");
		
		HttpSession session = request.getSession();
		
		UserDto ldto = loginService.login(user_id,user_pw);
		
		session.setAttribute("ldto", ldto);
		
		return "main";
	}
	
	@RequestMapping(value = "/faqlist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String FAQlist(Locale locale, Model model) {
		logger.info("자주묻는질문보기:{}", locale);
		List<FAQDto> list=qnaService.getFAQList();
		
		
		model.addAttribute("list",list);

		return "FAQList"; //.jsp
	}
	
	@RequestMapping(value="/faqinsertform.do",method= {RequestMethod.POST,RequestMethod.GET})
	public String faqinsertform(Locale locale,Model model) {
		logger.info("자주묻는글 추가하기 폼:{}",locale);
		return "FAQinsertboard"; //viewResolver가 "WEB_INF/views/"+"boardlist"+".jsp"를 찾아준다.
	}
	
	@RequestMapping(value="/faqinsertboard.do",method= {RequestMethod.POST,RequestMethod.GET})
	public String FAQinsertBoard(Locale locale,Model model,FAQDto dto) {
		logger.info("자주묻는글 추가하기:{}",locale);
		boolean isS=qnaService.FAQinsertBoard(dto);
		if(isS) {
			return "redirect:faqlist.do"; //그냥 실행됨
		}
		else {
			model.addAttribute("msg","자주묻는글추가실패");
			return "error"; 
		}
	}
	
		@RequestMapping(value="/faqupdateform.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String updateform(Model model,FAQDto dto) {
			logger.info("자주묻는글 수정하기 폼");

			model.addAttribute("dto",dto);
//			FAQDto dto=qnaService.FAQupdateBoard(seq);
			
//			System.out.println(dto.getId());
			return "FAQupdateboard"; 
		}
		
		@RequestMapping(value="/faqupdateboard.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String updateboard(Locale locale,Model model,FAQDto dto) {
			logger.info("글 수정하기:{}",locale);
			
			boolean isS=qnaService.FAQupdateBoard(dto);
			
			if(isS) {
				return "redirect:boarddetail.do";
			}
			else {
				model.addAttribute("msg","글수정실패");
				return "error";
			}
		}
		
		@RequestMapping(value="/faqdelboard.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String FAQdelBoard(Model model,int seq) {
			logger.info("자주묻는글 삭제하기");
			
			boolean isS=qnaService.FAQdelBoard(seq);
			if(isS) {
				return "redirect:faqlist.do?"; //viewResolver가 "WEB_INF/views/"+"boardlist"+".jsp"를 찾아준다.
			}
			else {
				return "redirect:faqlist.do?";
			}
		}
		
		
		@RequestMapping(value = "/questionlist.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String QuestionList(Locale locale, Model model,int user_num) {
			logger.info("1:1문의 리스트:{}", locale);
			
			List<QuestionDto> list=qnaService.getQuestionList(user_num);
				
			model.addAttribute("list",list);
			
			return "QuestionList"; //.jsp
		}
		
		@RequestMapping(value="/questioninsertform.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questioninsertform(Locale locale,Model model) {
			logger.info("1:1문의 글쓰기 폼:{}",locale);
			return "Questioninsert"; //viewResolver가 "WEB_INF/views/"+"boardlist"+".jsp"를 찾아준다.
		}
		
		@RequestMapping(value="/questioninsert.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questioninsert(Locale locale,Model model,QuestionDto dto) {
			logger.info("1:1문의 글 추가하기:{}",locale);
			boolean isS=qnaService.Questioninsert(dto);
			if(isS) {
				return "redirect:questionlist.do?user_num="+dto.getUser_num(); //그냥 실행됨
			}
			else {
				model.addAttribute("msg","1:1문의글추가실패");
				return "error"; 
			}
		}
	
		@RequestMapping(value="/questiondetail.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questiondetail(Model model,int seq) {
			logger.info("1:1문의글상세보기");
			QuestionDto dto=qnaService.Questiondetail(seq);
			model.addAttribute("dto",dto);
			return "Questiondetail"; //viewResolver가 "WEB_INF/views/"+"boardlist"+".jsp"를 찾아준다.
		}
		
		@RequestMapping(value="/questionupdateform.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String QnAupdateform(Model model,QuestionDto dto) {
			logger.info("1:1문의글 수정하기 폼");
			model.addAttribute("dto",dto);
			return "Questionupdate"; 
		}
		
		@RequestMapping(value="/questionupdate.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questionupdate(Locale locale,Model model,QuestionDto dto) {
			logger.info("1:1문의글 수정하기:{}",locale);
			
			boolean isS=qnaService.Questionupdate(dto);
			
			if(isS) {
				return "redirect:questionlist.do?user_num="+dto.getUser_num();
			}
			else {
				model.addAttribute("msg","글수정실패");
				return "error";
			}
		}
}
