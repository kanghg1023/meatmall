package com.hk.meatmall;

import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.Board_likeDto;
import com.hk.meatmall.dtos.CommentDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.IBoardService;
import com.hk.utils.Paging;

@Controller
public class BoardController {

private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private IBoardService boardService;
	
	@RequestMapping(value = "/boardlist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String boardlist( HttpServletRequest request
						   , Model model
						   , String pnum) {
		logger.info("글목록보기");
		
		HttpSession session = request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		session.removeAttribute("readcount");
		
		if(pnum == null) {
			pnum = (String)session.getAttribute("pnum");
		}else {
			session.setAttribute("pnum", pnum);
		}
						
//		Map<String, Integer> pmap = Paging.pagingValue(pcount, pnum, 5);
//		List<BoardDto> boardList = boardService.getAllList(pnum);
//		List<BoardDto> noticeList=boardService.noticeList();
				
		List<BoardDto> boardList = new ArrayList<>();
		List<BoardDto> noticeList = new ArrayList<>();
		Map<String, Integer> pmap = new HashMap<>();
		
		if(ldto == null || !(ldto.getUser_role().equals("ADMIN"))) {
			boardList = boardService.boardListPage(pnum);
			noticeList = boardService.noticeList();
			int pcount2 = boardService.getPcount2();
			pmap=Paging.pagingValue(pcount2, pnum, 5);
		}else {
			boardList = boardService.getAllList(pnum);
			noticeList = boardService.noticeList();
			int pcount = boardService.getPcount();
			pmap=Paging.pagingValue(pcount, pnum, 5);
		}
		
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pmap", pmap);
		model.addAttribute("noticeList", noticeList);	
		return "boardlist";
	}
	
	@RequestMapping(value = "/insertForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertForm() {
		logger.info("글추가폼이동");
		
		return "insertboard";
	}
	
	@RequestMapping(value = "/insertboard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertBoard(HttpServletRequest request, Model model,BoardDto dto) {
		logger.info("글추가하기");
						
		if(dto.getBoard_notice() == null) {
			dto.setBoard_notice("0");
		}
		
		boolean isInsert = boardService.insertBoard(dto);
		
		if(isInsert) {
			return "redirect:boardlist.do";
		}else {
			model.addAttribute("msg", "글작성 실패");
			model.addAttribute("url", "insertForm.do");
			return "error";
		}
	}
	
	@RequestMapping(value = "/boarddetail.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String boarddetail( HttpServletRequest request
							 , Model model
							 , int board_num
							 , String pnum) {
		logger.info("글상세보기");	
		
		HttpSession session = request.getSession();
		String readcount = (String)session.getAttribute("readcount");
				
		UserDto ldto = (UserDto)session.getAttribute("ldto");	
		
		if(readcount == null) {
			boardService.readCount(board_num);
			session.setAttribute("readcount", "readcount");
		}
		
		if(ldto != null) {
			boolean like = boardService.getLike(new Board_likeDto(board_num,ldto.getUser_num()));			
			model.addAttribute("like", like);
		}
		
		int likecount = boardService.likeCount(board_num);
		model.addAttribute("likecount", likecount);
					
		BoardDto boarddto =boardService.getBoard(board_num);
		model.addAttribute("boarddto", boarddto);
		
		List<CommentDto> clist = boardService.commentList(board_num);
		model.addAttribute("clist", clist);					
		return "boarddetail";
	}
	
	
	@RequestMapping(value = "/updateform.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateForm(Model model,int board_num) {
		logger.info("글수정폼이동");
		
		BoardDto dto = boardService.getBoard(board_num);
		
		model.addAttribute("dto", dto);
		return "updateboard";
	}
	
	@RequestMapping(value = "/updateboard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateBoard(Model model,BoardDto dto) {
		logger.info("글수정하기");
		
		boolean isUpdate=boardService.updateBoard(dto);
		
		if(isUpdate) {
			model.addAttribute("dto", dto);
			return "redirect:boarddetail.do?board_num="+dto.getBoard_num();
		}else {
			model.addAttribute("msg", "수정 실패");
			model.addAttribute("url", "boarddetail.do?board_num="+dto.getBoard_num());
			return "error";
		}
	}
	
	@RequestMapping(value = "/delboard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String delboard(Model model,int board_num ) {
		logger.info("글삭제");
		
		boolean isDelete=boardService.delBoard(board_num);
		
		if(isDelete) {
			return "redirect:boardlist.do";
		}else {
			model.addAttribute("msg", "삭제 실패");
			model.addAttribute("url", "boardlist.do");
			return "error";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/likechange.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String likechange(HttpServletRequest request, Model model,Board_likeDto dto) {
		logger.info("좋아요 추가 및 삭제");
		
		boolean like = boardService.getLike(dto);
		
		if(like) {
			//좋아요 삭제
			boolean isS=boardService.deleteLike(dto);
			if(isS) {
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
	public String addcomment(HttpServletRequest request, Model model, CommentDto dto) {
		logger.info("댓글달기");
		
		HttpSession session = request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		dto.setUser_num(ldto.getUser_num());
		
		boolean isAddcomment=boardService.addcomment(dto);
		
		if(isAddcomment) {
			return "redirect:boarddetail.do?board_num="+dto.getBoard_num();
		}else {
			model.addAttribute("msg", "댓글 실패");
			model.addAttribute("url", "boarddetail.do?board_num="+dto.getBoard_num());
			return "error";
		}
	}

	
	@RequestMapping(value = "/delcomment.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String delcomment(HttpServletRequest request, Model model,String comment_num,CommentDto dto ) {
		logger.info("댓글삭제");
		
		HttpSession session = request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		dto.setUser_num(ldto.getUser_num());
		
		boolean isDelete=boardService.delcomment(Integer.parseInt(comment_num));
		
		if(isDelete) {
			return "redirect:boarddetail.do?board_num="+dto.getBoard_num();
		}else {
			model.addAttribute("msg", "삭제 실패");
			model.addAttribute("url", "boarddetail.do?board_num="+dto.getBoard_num());
			return "error";
		}
	}
	
	@RequestMapping(value = "/recomment.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String recomment(HttpServletRequest request, Model model, CommentDto dto) {
		logger.info("대댓글달기");
		
		HttpSession session = request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		dto.setUser_num(ldto.getUser_num());
		
		boolean isRecomment=boardService.recomment(dto);
		
		if(isRecomment) {
			return "redirect:boarddetail.do?board_num="+dto.getBoard_num();
		}else {
			model.addAttribute("msg", "대댓글 실패");
			model.addAttribute("url", "boarddetail.do?board_num="+dto.getBoard_num());
			return "error";
		}
	}
	

	@RequestMapping(value = "/updatecomment.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String updatecomment(Model model,CommentDto dto) {
		logger.info("댓글수정하기");
		
		boolean isUpdate=boardService.updatecomment(dto);
		
		if(isUpdate) {
			model.addAttribute("dto", dto);
			return "redirect:boarddetail.do?board_num="+dto.getBoard_num();
		}else {
			model.addAttribute("msg", "수정 실패");
			model.addAttribute("url", "boarddetail.do?board_num="+dto.getBoard_num());
			return "error";
		}
	}
	
	
	
	
}
