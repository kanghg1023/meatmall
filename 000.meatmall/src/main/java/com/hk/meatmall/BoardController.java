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
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.Board_likeDto;
import com.hk.meatmall.dtos.CommentDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.IBoardService;



@Controller
public class BoardController {

private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	
	@Autowired
	private IBoardService boardService;
		
	
	@RequestMapping(value = "/boardlist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String boardlist(HttpServletRequest request, Locale locale, Model model, String pnum) {
		logger.info("글목록보기 :{}", locale);
		request.getSession().removeAttribute("readcount");		
		 if(pnum==null) {
	          pnum=(String)request.getSession().getAttribute("pnum");
	       }else {
	          request.getSession().setAttribute("pnum", pnum);
	       }
		List<BoardDto> list=boardService.getAllList(pnum);
		model.addAttribute("list", list );
		int pcount=boardService.getPcount();
		Map<String, Integer> pmap=com.hk.utils.Paging.pagingValue(pcount, pnum, 5);
		//HttpSession session = request.getSession();
		//session.setAttribute("pmap", map);
		model.addAttribute("pmap", pmap);
		List<BoardDto> list1=boardService.noticeList();
		model.addAttribute("list1", list1 );	
		return "boardlist";
	}
	
	@RequestMapping(value = "/insertForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertForm(Locale locale, Model model) {
		logger.info("글추가폼이동:{}", locale);
		return "insertboard";
	}
	
	@RequestMapping(value = "/insertboard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertBoard(HttpServletRequest request, Locale locale, Model model,BoardDto dto) {
		logger.info("글추가하기:{}", locale);
						
		if(dto.getBoard_notice() == null) {
			dto.setBoard_notice("N");
		}
		
		System.out.println(dto);
		boolean isS=boardService.insertBoard(dto);
		if(isS) {
			return "redirect:boardlist.do?pnum=1";
		}else {
			model.addAttribute("msg", "글추가실패");
			return "error";			
		}
	}
	
	@RequestMapping(value = "/boarddetail.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String boarddetail(HttpServletRequest request, Locale locale, Model model, int board_num,String pnum) {
		logger.info("글상세보기 :{}", locale);				
		HttpSession session = request.getSession();		
		String board_count = (String)session.getAttribute("readcount");
				
		UserDto ldto = (UserDto)session.getAttribute("ldto");	
		
		if(board_count==null) {
			boardService.readCount(board_num);
			session.setAttribute("readcount", board_num+"");
		}
		if(ldto != null) {
			boolean like = boardService.getLike(new Board_likeDto(board_num,ldto.getUser_num()));			
			model.addAttribute("like",like);
		}
		int likecount = boardService.likeCount(board_num);
		model.addAttribute("likecount",likecount);
					
		BoardDto dto1 =boardService.getBoard(board_num);
		model.addAttribute("dto", dto1);
		
		List<CommentDto> clist = boardService.commentList(board_num);
		model.addAttribute("clist", clist);					
		return "boarddetail";
	}
	
	
	@RequestMapping(value = "/updateform.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateForm(Locale locale, Model model,int board_num ) {
		logger.info("글수정폼이동:{}", locale);
		BoardDto dto = boardService.getBoard(board_num);
		model.addAttribute("dto", dto);
		return "updateboard";
	}
	
	@RequestMapping(value = "/updateboard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateBoard(Locale locale, Model model,BoardDto dto) {
		logger.info("글수정하기:{}", locale);
		boolean isS=boardService.updateBoard(dto);
		model.addAttribute("dto", dto);
		if(isS) {
			return "redirect:boarddetail.do?board_num="+dto.getBoard_num();
		}else {
			model.addAttribute("msg", "글수정실패");
			return "error";
		}
	}
	
	@RequestMapping(value = "/delboard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String delboard(Locale locale, Model model,int board_num ) {
		logger.info("글삭제:{}", locale);
		boolean isS=boardService.delBoard(board_num);
		if(isS) {
			return "redirect:boardlist.do";
		}else {
			model.addAttribute("msg", "글삭제실패");
			return "error";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/likechange.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String likechange(HttpServletRequest request, Model model,Board_likeDto dto) {
		logger.info("좋아요 추가 및 삭제");
		System.out.println("여기 왔음");
		
		boolean like = boardService.getLike(dto);
		if(like) {
			//좋아요 삭제
			boolean isS=boardService.deleteLike(dto);
			if(isS) {
				System.out.println("여기도 왔음");
				like= false;
			}else {
				//에러 처리
			}
		}else {
			//좋아요 추가
			boolean isS=boardService.insertLike(dto);
			if(isS) {
				like= true;
			}else {
				//에러 처리	
			}
		}
		int likecount = boardService.likeCount(dto.getBoard_num());
		return like+","+likecount;
	}
	
	
	@RequestMapping(value = "/addcomment.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String addcomment(HttpServletRequest request, Locale locale, Model model, CommentDto dto) {
		logger.info("모댓글달기:{}", locale);
		
		HttpSession session = request.getSession();
		
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		dto.setUser_num(ldto.getUser_num());
		
		boolean isS=boardService.addcomment(dto);
		if(isS) {
			return "redirect:boarddetail.do?board_num="+dto.getBoard_num();
		}else {
			model.addAttribute("msg", "모댓글달기");
			return "error";
		}
	}

	
	@RequestMapping(value = "/delcomment.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String delcomment(HttpServletRequest request,Locale locale, Model model,String comment_num,CommentDto dto ) {
		logger.info("댓글삭제:{}", locale);
		HttpSession session = request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		dto.setUser_num(ldto.getUser_num());
		
		boolean isS=boardService.delcomment(Integer.parseInt(comment_num));
		if(isS) {
			return "redirect:boarddetail.do?board_num="+dto.getBoard_num();
		}else {
			model.addAttribute("msg", "글삭제실패");
			return "error";
		}
	}
	
	@RequestMapping(value = "/recomment.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String recomment(HttpServletRequest request, Locale locale, Model model, CommentDto dto) {
		logger.info("대댓글달기:{}", locale);
		
		HttpSession session = request.getSession();
		
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		dto.setUser_num(ldto.getUser_num());
		
		boolean isS=boardService.recomment(dto);
		if(isS) {
			return "redirect:boarddetail.do?board_num="+dto.getBoard_num();
		}else {
			model.addAttribute("msg", "대댓글달기");
			return "error";
		}
	}
	

	@RequestMapping(value = "/updatecomment.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String updatecomment(Locale locale, Model model,CommentDto dto) {
		logger.info("댓글수정하기:{}", locale);
		boolean isS=boardService.updatecomment(dto);
		model.addAttribute("dto", dto);
		if(isS) {
			return "redirect:boarddetail.do?board_num="+dto.getBoard_num();
		}else {
			model.addAttribute("msg", "댓글수정실패");
			return "error";
		}
	}
	
	
	
	
}
