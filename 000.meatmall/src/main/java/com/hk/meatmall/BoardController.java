package com.hk.meatmall;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.meatmall.dtos.BoardDto;
import com.hk.meatmall.dtos.Board_likeDto;
import com.hk.meatmall.dtos.CommentDto;
import com.hk.meatmall.dtos.MessageDto;
import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.IBoardService;
import com.hk.utils.Paging;
import com.hk.utils.Util;

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
		
		Map<String, Integer> pmap = new HashMap<>();
		boolean isList = true;
		int p = Integer.parseInt(pnum);
		
		while(isList) {
			if(ldto == null || !(ldto.getUser_role().equals("ADMIN"))) {
				boardList = boardService.boardListPage(String.valueOf(p));
				int pcount2 = boardService.getPcount2();
				pmap=Paging.pagingValue(pcount2, pnum, 5);
			}else {
				boardList = boardService.getAllList(String.valueOf(p));
				
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
		return "boardlist";
	}
	
	@RequestMapping(value = "/insertForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertForm(HttpSession session) {
		logger.info("글추가폼이동");
		
		UserDto ldto = (UserDto)session.getAttribute("ldto");
        
        if(ldto == null) {
           return "redirect:loginPage.do";
        }
		
		return "insertboard";
	}
	
	@RequestMapping(value = "/insertboard.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String insertBoard( HttpSession session
							 , Model model
							 , BoardDto dto) {
		logger.info("글추가하기");
		
		boolean isInsert = boardService.insertBoard(dto);
		
		if(dto.getBoard_notice() == 1) {
			List<BoardDto> noticeList = boardService.noticeList();
			session.setAttribute("noticeList", noticeList);
		}
		
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
		BoardDto boarddto =boardService.getBoard(board_num);
		List<CommentDto> clist = boardService.commentList(board_num);
		
		model.addAttribute("likecount", likecount);
		model.addAttribute("boarddto", boarddto);
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
	public String messageList( HttpSession session
							 , Model model
							 , String pnum) {
		logger.info("받은 쪽지함");
		
		if(pnum==null) {
			pnum=(String)session.getAttribute("pnum");
		}else {
			session.setAttribute("pnum", pnum);
		}
		
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		
		List<MessageDto> mlist = new ArrayList<>();
		boolean isList = true;
		int p = Integer.parseInt(pnum);
		
		while(isList) {
			mlist = boardService.messageList(ldto.getUser_num(),pnum);
			
			if(p==1 || mlist.size()>0) {
				isList = false;
			}else {
				pnum = String.valueOf(--p);
				session.setAttribute("pnum", pnum);
			}
		}
		
		for (MessageDto dto:mlist) {
			String con = dto.getMessage_content();
			if(con.length() > 10) {
				dto.setMessage_content(Util.sampleContent(con));
			}
		}
		
		int pcount = boardService.msgPcount(ldto.getUser_num());
		Map<String, Integer> qmap=Paging.pagingValue(pcount, pnum, 5);
		
		model.addAttribute("mlist", mlist);
		model.addAttribute("qmap", qmap);
		return "messageList";
	}
	
	@RequestMapping(value = "/sendMessageList.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String sendMessageList( HttpSession session
								 , Model model
								 , String pnum) {
		logger.info("보낸 쪽지함");
		
		if(pnum==null) {
			pnum=(String)session.getAttribute("pnum");
		}else {
			session.setAttribute("pnum", pnum);
		}
		
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		int message_from_num = ldto.getUser_num();
		
		List<MessageDto> sendmlist = new ArrayList<>();
		boolean isList = true;
		int p = Integer.parseInt(pnum);
		
		while(isList) {
			sendmlist = boardService.sendMessageList(message_from_num, pnum);
			
			if(p==1 || sendmlist.size()>0) {
				isList = false;
			}else {
				pnum = String.valueOf(--p);
				session.setAttribute("pnum", pnum);
			}
		}
		
		for (MessageDto dto:sendmlist) {
			String con = dto.getMessage_content();
			if(con.length() > 10) {
				dto.setMessage_content(Util.sampleContent(con));
			}
		}
		
		int pcount = boardService.sendMsgPcount(message_from_num);
		Map<String, Integer> pmap=Paging.pagingValue(pcount, pnum, 5);
		
		model.addAttribute("sendmlist", sendmlist);
		model.addAttribute("pmap", pmap);
		return "sendMessageList";
	}
	
	@RequestMapping(value = "/messageForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String messageForm( Model model
							 , int user_num
							 , String user_nick) {
		logger.info("쪽지 폼");
		
		model.addAttribute("user_num",user_num);
		model.addAttribute("user_nick",user_nick);
		return "messageForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/insertMessage.do", method = {RequestMethod.GET,RequestMethod.POST})
	public boolean insertMessage(Model model, MessageDto dto) {
		logger.info("쪽지 보내기");
		
		boolean isInsert = boardService.insertMessage(dto);
		
		return isInsert;
	}
	
	@RequestMapping(value = "/messageDetail.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String messageDetail(Model model, int message_num, int fromTo) {
		logger.info("쪽지 상세보기");
		
		MessageDto mdto = new MessageDto();
		
		if(fromTo > 0) {
			mdto = boardService.messageDetail(message_num);
			model.addAttribute("mdto",mdto);
			return "messageDetail";
		}else {
			mdto = boardService.messageDetail2(message_num);
			model.addAttribute("mdto",mdto);
			return "messageDetail2";
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteMessage.do", method = {RequestMethod.GET,RequestMethod.POST})
	public boolean deleteMessage(Model model, int message_num, int fromTo) {
		logger.info("쪽지 삭제하기");
		boolean isDelete;
		System.out.println(message_num);
		if(fromTo > 0) {
			isDelete = boardService.deleteMessage(message_num);
		}else {
			isDelete = boardService.deleteMessage2(message_num);
		}
		
		return isDelete;
	}
	
	//쿠키로 페이징 - 참고자료 (아직 안씀)
	@RequestMapping(value = "/pasing.do")
	public String pasing( HttpServletRequest request
							  , HttpServletResponse response
							  , HttpSession session
							  , int board_num) {
	        
		// 해당 게시판 번호를 받아 리뷰 상세페이지로 넘겨줌
		BoardDto boarddto =boardService.getBoard(board_num);
		Cookie[] cookies = request.getCookies();
		
		// 비교하기 위해 새로운 쿠키
		Cookie viewCookie = null;
		
		// 쿠키가 있을 경우 
		if (cookies != null && cookies.length > 0) {
			for(int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("cookie"+board_num)) {
					System.out.println("처음 쿠키가 생성한 뒤 들어옴.");
					viewCookie = cookies[i];
				}
			}
		}
	        
		if(boarddto != null) {
			// 만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리함.
			if(viewCookie == null) {   
				System.out.println("cookie 없음");
	                
				// 쿠키 생성(이름, 값)
				Cookie newCookie = new Cookie("cookie"+board_num, "|" + board_num + "|");
				
				response.addCookie(newCookie);
				
				// 쿠키를 추가 시키고 조회수 증가시킴
				boolean result = boardService.readCount(board_num);
				
				if(result) {
					System.out.println("조회수 증가");
				}else {
					System.out.println("조회수 증가 에러");
				}
			}else {
				// viewCookie가 null이 아닐경우 쿠키가 있으므로 조회수 증가 로직을 처리하지 않음.
				System.out.println("cookie 있음");
				
				// 쿠키 값 받아옴.
				String value = viewCookie.getValue();
				System.out.println("cookie 값 : " + value);
			}
			return "error";
		}else {
			// 에러 페이지 설정
			return "error";
		}
	}
	
	//한우레시피
	@RequestMapping(value = "/recipe.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String recipe() {
		logger.info("한우레시피");
		
		return "recipe";
	}

}
