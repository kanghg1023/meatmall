package com.hk.meatmall;

import java.security.NoSuchAlgorithmException;

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

import com.hk.meatmall.dtos.UserDto;
import com.hk.meatmall.iservices.ILoginService;
import com.hk.utils.Util;

@Controller
public class LoginController {

private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private ILoginService loginService;
	
	@RequestMapping(value = "/main.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String main() {
		//메인페이지 출력에 필요한 것들 추가요망
		
		return "main";
	}
	
	@RequestMapping(value = "/loginPage.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String loginPage() {
		logger.info("로그인페이지로");
		
		return "loginPage";
	}
	
	@RequestMapping(value = "/login.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String login(HttpServletRequest request, Model model, String user_id, String pw) throws NoSuchAlgorithmException {
		logger.info("로그인");
		
		HttpSession session = request.getSession();
		
		String page = (String)session.getAttribute("page");
		
		System.out.println(page);
		
		String errorMsg1 = "아이디가 존재하지 않거나 비밀번호가 틀립니다.";
		String errorMsg2 = "해당 계정은 5회이상 로그인 실패하여 계정 보호중입니다.";
		
		//아이디가 존재하는지 체크
		int user_num = loginService.idChk(user_id);
		
		//비밀번호 암호화
		String user_pw = Util.sha256(pw);
		
		if(user_num>0) {
			//아이디가 존재
			
			//true=로그인 진행 , false=로그인 실패(잠김/비밀번호틀림)
			boolean isLogin = loginService.idLockCheck(user_num);
			
			if(isLogin){
				UserDto ldto = loginService.login(user_id,user_pw);
				loginService.stopClear(user_id);
				if(ldto == null) {
					//비밀번호 틀림
					loginService.loginFail(user_num);
					model.addAttribute("loginError", errorMsg1);
				}else {
					loginService.lockClear(user_num);
					
					if(ldto.getUser_stop_date() == null) {
						//로그인 성공
						session.setAttribute("ldto", ldto);
						model.addAttribute("loginError");
					}else {
						//정지된 계정
						String stop_date = Util.dateFormatChange(ldto.getUser_stop_date());
						model.addAttribute("loginError", "해당계정은"+stop_date+"까지 이용이 제한됩니다.");
					}
				}
			}else {
				//계정잠김
				model.addAttribute("loginError", errorMsg2);
			}
		}else {
			//아이디가 존재하지 않음
			model.addAttribute("loginError", errorMsg1);
		}
		session.removeAttribute("readcount");
		return page;
	}
	
	@RequestMapping(value = "/logout.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String logout(HttpServletRequest request, Model model) {
		logger.info("로그아웃");
		
		HttpSession session = request.getSession();
		String page = (String)session.getAttribute("page");
		
		session.removeAttribute("ldto");
		
		return page;
	}
	
	@RequestMapping(value = "/registPage.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String registPage(Model model) {
		logger.info("회원가입 페이지로");
		
		model.addAttribute("registError");
		
		return "registPage";
	}
	
	@RequestMapping(value = "/licenseeRegist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String licenseeRegist(Model model) {
		logger.info("사업자 회원가입폼");

		model.addAttribute("licenseeRegist", "licenseeRegist");
		
		return "registForm";
	}
	
	@RequestMapping(value = "/normalRegist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String normalRegist(Model model) {
		logger.info("일반 회원가입폼");
		
		model.addAttribute("licenseeRegist");
		
		return "registForm";
	}
	
	@RequestMapping(value = "/regist.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String regist(HttpServletRequest request, Model model, UserDto dto) throws NoSuchAlgorithmException {
		logger.info("회원가입");
		
		HttpSession session = request.getSession();
		String page = (String)session.getAttribute("page");
		
		//비밀번호 암호화
		dto.setUser_pw(Util.sha256(dto.getUser_pw()));
		
		boolean isRegist = loginService.regist(dto);
		
		if(isRegist) {
			UserDto ldto = loginService.login(dto.getUser_id(), dto.getUser_pw());
			session.setAttribute("ldto", ldto);
			return page;
		}else {
			model.addAttribute("registError", "회원가입에 실패하였습니다.\n같은문제가 계속될 경우 관리자에게 문의 주십시오");
			return "redirect:registPage.do";
		}
	}
	
	@RequestMapping(value = "/myPage.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String myPage(Model model) {
		logger.info("마이페이지");
		
		
		return "myPage";
	}
	
	@RequestMapping(value = "/userInfo.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String userInfo(Model model, UserDto dto) {
		logger.info("정보보기");
		
		
		return "myPage";
	}
	
	@ResponseBody
	@RequestMapping(value = "/idChk.do", method = {RequestMethod.GET,RequestMethod.POST})
	public boolean idChk(Model model, String user_id) {
		logger.info("아이디 중복체크");
		
		int user_num = loginService.idChk(user_id);
		
		return user_num>0 ? true : false;
	}
	
	@ResponseBody
	@RequestMapping(value = "/nickChk.do", method = {RequestMethod.GET,RequestMethod.POST})
	public boolean nickChk(Model model, String user_nick) {
		logger.info("아이디 중복체크");
		
		int user_num = loginService.nickChk(user_nick);
		
		return user_num>0 ? true : false;
	}
	
}
