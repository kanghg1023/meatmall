package com.hk.meatmall;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.hk.meatmall.dtos.MessageDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.IBoardService;
import com.hk.utils.Paging;

@Controller
public class BoardController {

private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private IBoardService boardService;
	
	@RequestMapping(value = "/boardlist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String boardlist( HttpSession session
						   , Model model
						   , String pnum) {
		logger.info("글목록보기");
		
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		session.removeAttribute("readcount");
		
		if(pnum == null) {
			pnum = (String)session.getAttribute("pnum");
		}else {
			session.setAttribute("pnum", pnum);
		}
		
		List<BoardDto> boardList = new ArrayList<>();
		List<BoardDto> noticeList = new ArrayList<>();
		
		Map<String, Integer> pmap = new HashMap<>();
		boolean isList = true;
		int p = Integer.parseInt(pnum);
		
		while(isList) {
			if(ldto == null || !(ldto.getUser_role().equals("ADMIN"))) {
				boardList = boardService.boardListPage(String.valueOf(p));
				noticeList = boardService.noticeList();
				int pcount2 = boardService.getPcount2();
				pmap=Paging.pagingValue(pcount2, pnum, 5);
			}else {
				boardList = boardService.getAllList(String.valueOf(p));
				noticeList = boardService.noticeList();
				int pcount = boardService.getPcount();
				pmap=Paging.pagingValue(pcount, pnum, 5);
			}
		
			if((boardList.size()>0) || (p==1 && boardList.size()==0)) {
				isList = false;
			}else {
				pnum = String.valueOf(--p);
				session.setAttribute("pnum", pnum);
			}
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
	public String insertBoard( HttpSession session
							 , Model model
							 , BoardDto dto) {
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
	public String boarddetail( HttpSession session
							 , Model model
							 , int board_num
							 , String pnum) {
		logger.info("글상세보기");	
		
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
	public String updateForm(Model model, int board_num) {
		logger.info("글수정폼이동");
		
		BoardDto dto = boardService.getBoard(board_num);
		
		model.addAttribute("dto", dto);
		return "updateboard";
	}
	
	@RequestMapping(value = "/updateboard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateBoard(Model model, BoardDto dto) {
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
	public String delboard(Model model, int board_num ) {
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
	public String likechange(Model model, Board_likeDto dto) {
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
	public String addcomment( HttpSession session
							, Model model
							, CommentDto dto) {
		logger.info("댓글달기");
		
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
	public String delcomment( HttpSession session
							, Model model
							, String comment_num
							, CommentDto dto ) {
		logger.info("댓글삭제");
		
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
	public String recomment( HttpSession session
						   , Model model
						   , CommentDto dto) {
		logger.info("대댓글달기");
		
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
	public String updatecomment(Model model, CommentDto dto) {
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
	
	@RequestMapping(value = "/messageList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String messageList(Model model, int user_num) {
		logger.info("받은 쪽지함");
		
		List<MessageDto> mlist = boardService.messageList(user_num);
		
		model.addAttribute("mlist", mlist);
		
		return "messageList";
	}
	
	@RequestMapping(value = "/sendMessageList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String sendMessageList(Model model, int message_from_num) {
		logger.info("보낸 쪽지함");
		
		List<MessageDto> sendmlist = boardService.sendMessageList(message_from_num);
		
		model.addAttribute("sendmlist", sendmlist);
		
		return "sendMessageList";
	}
	
	@RequestMapping(value = "/messageForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String messageForm(Model model) {
		logger.info("쪽지 폼");
		
		return "messageForm";
	}
	
	@RequestMapping(value = "/insertMessage.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertMessage(Model model, MessageDto dto) {
		logger.info("쪽지 보내기");
		
		boolean isInsert = boardService.insertMessage(dto);
		
		if(isInsert) {
			return "redirect:sendMessageList.do";
		}else {
			model.addAttribute("msg", "쪽지 보내기 실패");
			model.addAttribute("url", "sendMessageList.do");
			return "error";
		}
	}
}
