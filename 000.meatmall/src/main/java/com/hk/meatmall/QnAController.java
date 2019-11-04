package com.hk.meatmall;

import java.util.ArrayList;
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

import com.hk.meatmall.dtos.FAQDto;
import com.hk.meatmall.dtos.QnADto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.IQnAService;
import com.hk.utils.Paging;

@Controller
public class QnAController {
private static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	
	@Autowired
	private IQnAService qnaService;
	
	@RequestMapping(value = "/faqlist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String FAQlist(HttpServletRequest request, Model model) {
		logger.info("자주묻는질문보기");
		
		HttpSession session = request.getSession();
		
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		if(ldto == null) {
			return "redirect:loginPage.do";
		}
		
		List<FAQDto> faqlist = qnaService.getFAQList();
		
		model.addAttribute("faqlist",faqlist);

		return "FAQList";
	}
	
	@RequestMapping(value="/faqinsertform.do",method= {RequestMethod.POST,RequestMethod.GET})
	public String faqinsertform() {
		logger.info("자주묻는글 추가하기 폼");
		
		return "FAQinsertboard";
	}
	
	@RequestMapping(value="/faqinsertboard.do",method= {RequestMethod.POST,RequestMethod.GET})
	public String FAQinsertBoard(Model model,FAQDto fdto) {
		logger.info("자주묻는글 추가하기");
		
		boolean isInsert = qnaService.FAQinsertBoard(fdto);
		
		if(isInsert) {
			return "redirect:faqlist.do";
		}else {
			model.addAttribute("msg","추가 실패: 같은문제가 반복될경우 관리자에게 문의하세요");
			model.addAttribute("url","faqinsertform.do");
			return "error"; 
		}
	}
	
		@RequestMapping(value="/faqupdateform.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String updateform(Model model,int faq_num) {
			logger.info("자주묻는글 수정하기 폼");
			
			FAQDto fdto = qnaService.FAQdetail(faq_num);
			
			model.addAttribute("fdto",fdto);
			return "FAQupdateboard";
		}
		
		@RequestMapping(value="/faqupdateboard.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String updateboard(Model model, FAQDto fdto) {
			logger.info("글 수정하기");
			
			boolean isUpdate = qnaService.FAQupdateBoard(fdto);
			
			if(isUpdate) {
				return "redirect:faqlist.do";
			}else {
				model.addAttribute("msg","수정 실패");
				model.addAttribute("url","faqlist.do");
				return "error";
			}
		}
		
		@RequestMapping(value="/faqdelboard.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String FAQdelBoard(Model model, int faq_num) {
			logger.info("자주묻는글 삭제하기");
			
			boolean isS=qnaService.FAQdelBoard(faq_num);
			
			if(isS) {
				return "redirect:faqlist.do?";
			}else {
				model.addAttribute("msg","수정 실패");
				model.addAttribute("url","faqlist.do");
				return "redirect:faqlist.do";
			}
		}
			
		@RequestMapping(value = "/questionlist.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String questionlist( HttpServletRequest request
								  , Model model
								  , String pnum) {
			logger.info("1:1문의 리스트");
			HttpSession session=request.getSession();
			
			UserDto ldto = (UserDto)session.getAttribute("ldto");
			
			request.getSession().removeAttribute("readcount");
			if(pnum==null) {
				pnum=(String)request.getSession().getAttribute("pnum");
			}else {
				request.getSession().setAttribute("pnum", pnum);
			}
			
			List<QnADto> qlist = new ArrayList<>();
			
			if(ldto.getUser_role().equals("ADMIN")) {
				qlist = qnaService.AllQuestionList(pnum);
			}else {
				String user_num = String.valueOf(ldto.getUser_num());
				qlist = qnaService.getQuestionList(user_num,pnum);
			}
			
			int pcount=qnaService.QnAPPcount(ldto.getUser_num());
			Map<String, Integer> qmap=Paging.pagingValue(pcount, pnum, 5);
			
			model.addAttribute("qmap",qmap);
			model.addAttribute("qlist",qlist);

			return "QuestionList";
		}
		
		@RequestMapping(value="/questioninsertform.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questioninsertform() {
			logger.info("1:1문의 글쓰기 폼");
			
			return "Questioninsert";
		}
		
		@RequestMapping(value="/questioninsert.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questioninsert(Model model,QnADto qdto) {
			logger.info("1:1문의 글 추가하기");
			
			boolean isInsert=qnaService.Questioninsert(qdto);
			
			if(isInsert) {
				return "redirect:questionlist.do?user_num="+qdto.getUser_num();
			}else {
				model.addAttribute("msg","문의글 등록실패");
				model.addAttribute("url","questionlist.do");
				return "error";
			}
		}
	
		@RequestMapping(value="/questiondetail.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questiondetail(HttpServletRequest request,Model model,int question_num) {
			logger.info("1:1문의글상세보기");
			
			HttpSession session=request.getSession();
			
			String readcount = (String)session.getAttribute("readcount");
			UserDto ldto = (UserDto)session.getAttribute("ldto");
			
			if(readcount==null && ldto.getUser_role().equals("ADMIN")) {
				qnaService.QuestionreadCount(question_num);
				session.setAttribute("readcount", "readcount");
			}
			
			QnADto qdto=qnaService.Questiondetail(question_num);
			
			model.addAttribute("qdto",qdto);
			return "Questiondetail";
		}
		
		@RequestMapping(value="/questionupdateform.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String QnAupdateform(Model model,int question_num) {
			logger.info("1:1문의글 수정하기 폼");
			
			QnADto qdto = qnaService.Questiondetail(question_num);
			
			model.addAttribute("qdto",qdto);
			return "Questionupdate"; 
		}
		
		@RequestMapping(value="/questionupdate.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questionupdate(Model model,QnADto qdto) {
			logger.info("1:1문의글 수정하기");
			
			boolean isUpdate=qnaService.Questionupdate(qdto);
			
			if(isUpdate) {
				return "redirect:questiondetail.do?question_num="+qdto.getQuestion_num();
			}
			else {
				model.addAttribute("msg","수정 실패");
				model.addAttribute("url","questiondetail.do?question_num="+qdto.getQuestion_num());
				return "error";
			}
		}
		
		@RequestMapping(value="/questiondelete.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questiondelete(HttpServletRequest request,Model model,int question_num) {
			logger.info("1:1문의글 삭제하기");
			
			HttpSession session=request.getSession();
			
			UserDto ldto=(UserDto)session.getAttribute("ldto");
			
			QnADto dto = qnaService.Questiondetail(question_num);
			
			boolean isAnswerdelete = false;
			
			if(dto.getQuestion_status().equals("Y")) {
				isAnswerdelete = qnaService.Answerdelete(question_num);
			}else {
				isAnswerdelete = true;
			}
			boolean isQuestiondelete=qnaService.Questiondelete(question_num);
			
			
			if(isQuestiondelete && isAnswerdelete) {
				if(ldto.getUser_role().equals("ADMIN")) {
					return "redirect:questionlist.do";
				}else {
					return "redirect:questionlist.do?user_num="+ldto.getUser_num();
				}
			}else {
				model.addAttribute("msg","삭제 실패");
				model.addAttribute("url","questiondetail.do?question_num="+question_num);
				return "error";
			}
		}
		
		@RequestMapping(value="/answerinsert.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Answerinsert(Model model, QnADto adto) {
			logger.info("1:1답변 글 추가하기");
			
//			boolean isInsert=qnaService.Answerinsert(adto);
			boolean isInsert=true;
			boolean isStatusChange=qnaService.StatusChange(adto.getQuestion_num());
			
			if(isInsert && isStatusChange) {
				return "redirect:questiondetail.do?question_num="+adto.getQuestion_num();
			}else {
				model.addAttribute("msg","1:1답변 추가 실패");
				model.addAttribute("url","questiondetail.do?question_num="+adto.getQuestion_num());
				return "error";
			}
		}	
		
}
