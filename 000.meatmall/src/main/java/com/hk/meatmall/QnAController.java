package com.hk.meatmall;

import java.util.List;
import java.util.Locale;
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

import com.hk.meatmall.dtos.AnswerDto;
import com.hk.meatmall.dtos.FAQDto;
import com.hk.meatmall.dtos.QuestionDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.IQnAService;

@Controller
public class QnAController {
private static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	
	@Autowired
	private IQnAService qnaService;
	
	@RequestMapping(value = "/faqlist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String FAQlist(Locale locale, Model model,QuestionDto fdto) {
		logger.info("자주묻는질문보기:{}", locale);
		List<FAQDto> flist=qnaService.getFAQList();
		
		model.addAttribute("fdto",fdto);
		model.addAttribute("flist",flist);

		return "FAQList"; //.jsp
	}
	
	@RequestMapping(value="/faqinsertform.do",method= {RequestMethod.POST,RequestMethod.GET})
	public String faqinsertform(Locale locale,Model model) {
		logger.info("자주묻는글 추가하기 폼:{}",locale);
		return "FAQinsertboard"; //viewResolver가 "WEB_INF/views/"+"boardlist"+".jsp"를 찾아준다.
	}
	
	@RequestMapping(value="/faqinsertboard.do",method= {RequestMethod.POST,RequestMethod.GET})
	public String FAQinsertBoard(Locale locale,Model model,FAQDto fdto) {
		logger.info("자주묻는글 추가하기:{}",locale);
		boolean isS=qnaService.FAQinsertBoard(fdto);
		if(isS) {
			return "redirect:faqlist.do"; //그냥 실행됨
		}
		else {
			model.addAttribute("msg","자주묻는글추가실패");
			return "error"; 
		}
	}
	
		@RequestMapping(value="/faqupdateform.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String updateform(Locale locale,Model model,int faq_num) {
			logger.info("자주묻는글 수정하기 폼");
			FAQDto fdto = qnaService.FAQdetail(faq_num);		
			model.addAttribute("fdto",fdto);
			return "FAQupdateboard"; 
		}
		
		@RequestMapping(value="/faqupdateboard.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String updateboard(Locale locale,Model model,FAQDto fdto) {
			logger.info("글 수정하기:{}",locale);
			
			boolean isS=qnaService.FAQupdateBoard(fdto);
			
			if(isS) {
				return "redirect:faqlist.do";
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
		
		@RequestMapping(value = "/allqnalist.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String AllQnAList(HttpServletRequest request,Locale locale, Model model,String pnum) {
			logger.info("1:1문의 전체 리스트:{}", locale);	
			request.getSession().removeAttribute("readcount");
			//글목록을 요청할때 따로 pnum 파라미터를 전달하지 않아도 목록을 볼 수 있게 전에 담긴 pnum을 사용
			if(pnum==null) {
				pnum=(String)request.getSession().getAttribute("pnum");
			}else {
				request.getSession().setAttribute("pnum", pnum);
			}
			List<QuestionDto> qlist=qnaService.AllQuestionList(pnum);
			int pcount=qnaService.QnAPcount();
			Map<String, Integer> qmap=com.hk.utils.Paging.pagingValue(pcount, pnum, 5); //페이지 갯수 5개씩 보여줌
			
			model.addAttribute("qmap",qmap);
			model.addAttribute("qlist",qlist);
			
			return "QuestionList"; //.jsp
		}
			
		@RequestMapping(value = "/questionlist.do", method = {RequestMethod.GET,RequestMethod.POST})
		public String QuestionList(HttpServletRequest request,Locale locale, Model model,String pnum) {
			logger.info("1:1문의 리스트:{}", locale);
			HttpSession session=request.getSession();
			
			UserDto ldto = (UserDto)session.getAttribute("ldto");
			String user_num = String.valueOf(ldto.getUser_num());
			request.getSession().removeAttribute("readcount");
			if(pnum==null) {
				pnum=(String)request.getSession().getAttribute("pnum");
			}else {
				request.getSession().setAttribute("pnum", pnum);
			}
			int pcount=qnaService.QnAPPcount(ldto.getUser_num());
			Map<String, Integer> qmap=com.hk.utils.Paging.pagingValue(pcount, pnum, 5); //페이지 갯수 5개씩 보여줌
			List<QuestionDto> qlist=qnaService.getQuestionList(user_num,pnum);
			
			model.addAttribute("qmap",qmap);
			model.addAttribute("qlist",qlist);

			return "QuestionList"; //.jsp
		}
		
		@RequestMapping(value="/questioninsertform.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questioninsertform(Locale locale,Model model) {
			logger.info("1:1문의 글쓰기 폼:{}",locale);
			return "Questioninsert"; //viewResolver가 "WEB_INF/views/"+"boardlist"+".jsp"를 찾아준다.
		}
		
		@RequestMapping(value="/questioninsert.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questioninsert(Locale locale,Model model,QuestionDto qdto) {
			logger.info("1:1문의 글 추가하기:{}",locale);
			boolean isS=qnaService.Questioninsert(qdto);
			if(isS) {
				return "redirect:questionlist.do?user_num="+qdto.getUser_num(); //그냥 실행됨
			}
			else {
				model.addAttribute("msg","1:1문의글추가실패");
				return "error"; 
			}
		}
	
		@RequestMapping(value="/questiondetail.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questiondetail(HttpServletRequest request,Model model,int seq) {
			logger.info("1:1문의글상세보기");
			HttpSession session=request.getSession();
			
			String rSeq=(String)session.getAttribute("readcount");
			UserDto dto1=(UserDto)session.getAttribute("ldto");
			if(rSeq==null&&dto1.getUser_role().equals("ADMIN")) {
			qnaService.QuestionreadCount(seq);
			session.setAttribute("readcount", seq+"");
			}
			QuestionDto qdto=qnaService.Questiondetail(seq);
			AnswerDto adto=qnaService.Answerdetail(seq);
			model.addAttribute("qdto",qdto);
			model.addAttribute("adto",adto);
			return "Questiondetail"; //viewResolver가 "WEB_INF/views/"+"boardlist"+".jsp"를 찾아준다.
		}
		
		@RequestMapping(value="/questionupdateform.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String QnAupdateform(Model model,QuestionDto qdto,int seq) {
			logger.info("1:1문의글 수정하기 폼");
			qdto = qnaService.Questiondetail(seq);
			model.addAttribute("qdto",qdto);
			return "Questionupdate"; 
		}
		
		@RequestMapping(value="/questionupdate.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questionupdate(Locale locale,Model model,QuestionDto qdto) {
			logger.info("1:1문의글 수정하기:{}",locale);
			boolean isS=qnaService.Questionupdate(qdto);
			
			if(isS) {
				return "redirect:questiondetail.do?seq="+qdto.getQuestion_num();
			}
			else {
				model.addAttribute("msg","글수정실패");
				return "error";
			}
		}
		
		@RequestMapping(value="/questiondelete.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questiondelete(HttpServletRequest request,Model model,int seq,int user_num) {
			logger.info("1:1문의글 삭제하기");
			HttpSession session=request.getSession();
			UserDto ldto=(UserDto)session.getAttribute("ldto");
			boolean isS=qnaService.Questiondelete(seq);
			qnaService.Answerdelete(seq);
			if(isS) {
				if(ldto.getUser_role().equals("USER") || ldto.getUser_role().equals("LICENSE")) {
					return "redirect:questionlist.do?user_num="+user_num; //viewResolver가 "WEB_INF/views/"+"boardlist"+".jsp"를 찾아준다.
				}else {
					return "redirect:allqnalist.do";
				}
			}
			else {
				return "error";
			}
		}
		
		@RequestMapping(value="/answerinsert.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Answerinsert(Locale locale,Model model,AnswerDto qdto) {
			logger.info("1:1답변 글 추가하기:{}",locale);
			boolean isS=qnaService.Answerinsert(qdto);
					isS=qnaService.StatusChange(qdto.getQuestion_num());
			if(isS) {
				return "redirect:questiondetail.do?seq="+qdto.getQuestion_num();
			}
			else {
				model.addAttribute("msg","1:1문의글추가실패");
				return "error"; 
			}
		}	
		
}
