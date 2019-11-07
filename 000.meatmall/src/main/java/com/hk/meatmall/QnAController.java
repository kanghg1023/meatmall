package com.hk.meatmall;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.hk.meatmall.dtos.FAQDto;
import com.hk.meatmall.dtos.QnADto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.IQnAService;
import com.hk.utils.Paging;
import com.hk.utils.Util;

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
			logger.info("자주묻는글 수정하기");
			
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
			
			if(pnum==null) {
				pnum=(String)session.getAttribute("pnum");
			}else {
				session.setAttribute("pnum", pnum);
			}
			
			List<QnADto> qlist = new ArrayList<>();
			
			boolean isList = true;
			int p = Integer.parseInt(pnum);
			
			while(isList) {
				if(ldto.getUser_role().equals("ADMIN")) {
					qlist = qnaService.AllQuestionList(String.valueOf(p));
				}else {
					String user_num = String.valueOf(ldto.getUser_num());
					qlist = qnaService.getQuestionList(user_num,String.valueOf(p));
				}
				
				if((qlist.size()>0) || (p==1 && qlist.size()==0)) {
					isList = false;
				}else {
					pnum = String.valueOf(--p);
					session.setAttribute("pnum", pnum);
				}
			}
			
			int pcount=qnaService.QnAPcount();
			Map<String, Integer> qmap=Paging.pagingValue(pcount, pnum, 5);
			
			model.addAttribute("qmap",qmap);
			model.addAttribute("qlist",qlist);

			return "QuestionList";
		}
		
		@RequestMapping(value="/questioninsertform.do",method= {RequestMethod.POST,RequestMethod.GET})
		public String Questioninsertform(Model model) {
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
		public String Questiondetail( HttpServletRequest request
									, Model model
									, int question_num) {
			logger.info("1:1문의글상세보기");
			
			HttpSession session = request.getSession();
			UserDto ldto = (UserDto)session.getAttribute("ldto");
			
			QnADto qdto=qnaService.Questiondetail(question_num);
			
			if(qdto.getQuestion_status()==0 && ldto.getUser_role().equals("ADMIN")) {
				qnaService.StatusChange(question_num);
			}
			
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
				
			boolean isQuestiondelete=qnaService.Questiondelete(question_num);
				
			if(isQuestiondelete) {
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
		public String Answerinsert(Model model, QnADto qdto) {
			logger.info("1:1답변 글 추가하기");
			
			boolean isInsert=qnaService.Answerinsert(qdto);
			
			if(isInsert) {
				return "redirect:questiondetail.do?question_num="+qdto.getQuestion_num();
			}else {
				model.addAttribute("msg","1:1답변 추가 실패");
				model.addAttribute("url","questiondetail.do?question_num="+qdto.getQuestion_num());
				return "error";
			}
		}
		
		@ResponseBody
		@RequestMapping(value = "/imageUpload.do",method= {RequestMethod.POST})
		public String communityImageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
			System.out.println("들어는옴");
			//한글깨짐을 방지하기위해 문자셋 설정
			response.setCharacterEncoding("utf-8");
		 
	        // 마찬가지로 파라미터로 전달되는 response 객체의 한글 설정
	        response.setContentType("text/html; charset=utf-8");
	 
	        // 업로드한 파일 이름
	        String fileName = upload.getOriginalFilename();
	       
	        String stored_fname = Util.createUUId()
			         +(fileName.substring(fileName.lastIndexOf(".")));
	        // 파일을 바이트 배열로 변환
	        byte[] bytes = upload.getBytes();
	 
	        // 이미지를 업로드할 디렉토리(배포 디렉토리로 설정)
//		        String uploadPath ="D:\\java_lec_2class\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\000.meatmall4ck\\images\\";
//		        String uploadPath ="D:\\eclips\\딱따구리\\000.meatmalltest\\src\\main\\webapp\\resources\\ckimages\\";
	        String uploadPath ="C:\\Users\\HKEDU\\git\\meatmall\\000.meatmall\\src\\main\\webapp\\resources\\ckimages\\";
//한결 집	    String uploadPath ="C:\\Users\\10H\\git\\meatmall\\000.meatmall\\src\\main\\webapp\\resources\\ckimages\\";
	        
	        OutputStream out = new FileOutputStream(new File(uploadPath + stored_fname));
	        
	        // 서버로 업로드
	        // write메소드의 매개값으로 파일의 총 바이트를 매개값으로 준다.
	        // 지정된 바이트를 출력 스트립에 쓴다 (출력하기 위해서)
	        out.write(bytes);
	        	        
	        // 서버=>클라이언트로 텍스트 전송(자바스크립트 실행)
	        PrintWriter printWriter = response.getWriter();
	        
	        String fileUrl = "/meatmall/ckimages/" + stored_fname;	     
	        System.out.println(fileUrl);
	        printWriter.println("{\"fileName\" : \""+stored_fname+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");     
	        printWriter.flush();
	        out.close();
	        printWriter.close(); 
	        return null;
	    }	
		 
			
		
}
