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
		
		String msg1 = "아이디가 존재하지 않거나 비밀번호가 틀립니다.";
		String msg2 = "해당 계정은 5회이상 로그인 실패하여 계정 보호중입니다.";
		
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
					request.setAttribute("msg", msg1);
				}else {
					loginService.lockClear(user_num);
					
					if(ldto.getUser_stop_date() == null) {
						//로그인 성공
						session.setAttribute("ldto", ldto);
					}else {
						//정지된 계정
						String stop_date = Util.dateFormatChange(ldto.getUser_stop_date());
						request.setAttribute("msg", "해당계정은"+stop_date+"까지 이용이 제한됩니다.");
					}
				}
			}else {
				//계정잠김
				request.setAttribute("msg", msg2);
			}
		}else {
			//아이디가 존재하지 않음
			request.setAttribute("msg", msg1);
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
	
	

	
}
