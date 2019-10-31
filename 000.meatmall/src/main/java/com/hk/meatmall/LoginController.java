package com.hk.meatmall;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.hk.meatmall.dtos.RecordDto;
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
		
		String errorMsg1 = "아이디가 존재하지 않거나 비밀번호가 틀립니다.";
		String errorMsg2 = "해당 계정은 5회이상 로그인 실패하여 계정 보호중입니다.";
		
		//아이디가 존재하는지 체크
		int user_num = loginService.idChk(user_id);
		
		//비밀번호 암호화
		String user_pw = Util.sha256(pw);
		
		//로그인 성공실패여부
		String record_check = "N";
		
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
						record_check = "Y";
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
			
			HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
	        String ip = req.getHeader("X-FORWARDED-FOR");
	        
	        if (ip == null) {
	            ip = req.getRemoteAddr();
	        }
	        
	        if(ip.equals("0:0:0:0:0:0:0:1")) {
	        	try {
					InetAddress hostip = InetAddress.getLocalHost();
					ip = hostip.getHostAddress();
				} catch (UnknownHostException e) {
					e.printStackTrace();
				}
	        }
	        
	        loginService.loginRecord(user_id, ip, record_check);
		}else {
			//아이디가 존재하지 않음
			model.addAttribute("loginError", errorMsg1);
		}
		
		if(record_check.equals("Y")) {
			return page;
		}else {
			return "loginPage";
		}
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
	public String regist(Model model, UserDto dto) throws NoSuchAlgorithmException {
		logger.info("회원가입");
		
		String pw = dto.getUser_pw();
		dto.setUser_pw(Util.sha256(dto.getUser_pw()));
		
		boolean isRegist = loginService.regist(dto);
		
		if(isRegist) {
			boolean issignUpLog = loginService.signUpLog(dto.getUser_id());
			
			if(issignUpLog) {
				model.addAttribute("user_id",dto.getUser_id());
				model.addAttribute("pw",pw);
				return "redirect:login.do";
			}
		}
		
		model.addAttribute("registError", "회원가입에 실패하였습니다.\n같은문제가 계속될 경우 관리자에게 문의 주십시오");
		return "redirect:registPage.do";
	}
	
	@RequestMapping(value = "/myPage.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String myPage(Model model) {
		logger.info("마이페이지");
		
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
		logger.info("닉네임 중복체크");
		
		int user_num = loginService.nickChk(user_nick);
		
		return user_num>0 ? true : false;
	}
	
	@ResponseBody
	@RequestMapping(value = "/pwChk.do", method = {RequestMethod.GET,RequestMethod.POST})
	public boolean pwChk(Model model, String user_id, String pw) throws NoSuchAlgorithmException {
		logger.info("비밀번호 확인");
		
		String user_pw = Util.sha256(pw);
		
		boolean isPW = loginService.pwChk(user_id,user_pw);
		
		return isPW;
	}
	
	@RequestMapping(value = "/userInfo.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String userInfo(Model model) {
		logger.info("내 정보보기");
		
		return "userInfo";
	}
	
	@RequestMapping(value = "/userUpdate.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String userUpdate(HttpServletRequest request, Model model, UserDto dto) throws NoSuchAlgorithmException {
		logger.info("정보 수정하기");
		
		HttpSession session = request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		String pw = dto.getUser_pw();
		
		if(pw.equals("")) {
			dto.setUser_pw(null);
		}else {
			dto.setUser_pw(Util.sha256(pw));
		}
		
		boolean isUpdate = loginService.userUpdate(dto);
		
		if(isUpdate) {
			ldto.setUser_ph(dto.getUser_ph());
			ldto.setUser_addr(dto.getUser_addr());
			ldto.setUser_addr_detail(dto.getUser_addr_detail());
			ldto.setUser_email(dto.getUser_email());
			
			session.setAttribute("ldto", ldto);
			model.addAttribute("updateSuccess","변경되었습니다.");
			return "myPage";
		}else {
			model.addAttribute("updateError","수정실패!\n같은문제가 반복될경우 관리자에게 문의주세요.");
			return "userInfo";
		}
	}
	
	@RequestMapping(value = "/idInquiryForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String idInquiryForm() {
		logger.info("아이디 찾기로");
		
		return "idInquiryForm";
	}
	
	@RequestMapping(value = "/pwInquiryForm.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String pwInquiryForm() {
		logger.info("비밀번호 찾기로");
		
		return "pwInquiryForm";
	}
	
	@RequestMapping(value = "/idInquiry.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String idInquiry(Model model, UserDto dto) {
		logger.info("아이디 찾기");
		
		List<String> idList = loginService.inquiry(dto);
		model.addAttribute("idList",idList);
		
		return "idInquiryForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/inquiryChk.do", method = {RequestMethod.GET,RequestMethod.POST})
	public boolean inquiryChk(Model model, UserDto dto) {
		logger.info("이름/아이디/이메일 확인");
		
		boolean isChk = loginService.inquiryChk(dto);
		
		return isChk;
	}
	
	@RequestMapping(value = "/pwInquiry.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String pwInquiry(Model model, UserDto dto) throws Exception {
		logger.info("비밀번호 찾기");
		
		String user_id = dto.getUser_id();
		String pw = Util.garaPW();
		String user_pw = Util.sha256(pw);
		
		String subject = "임시 비밀번호 발급 안내";
		
		String msg="";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color:blue;'><strong>"+user_id;
		msg += "님</strong>의 임시비밀번호 입니다. 로그인후 비밀번호를 변경해주세요.</h3>";
		msg += "<p>임시 비밀번호 : <strong>" + pw + "<strong></p></div>";
		
		Util.sendMail(dto.getUser_email(), subject, msg);
		
		boolean pwSuccess = loginService.pwChange(user_id,user_pw);
		
		model.addAttribute("pwSuccess",pwSuccess);
		
		return "pwInquiryForm";
	}
	
	@RequestMapping(value = "/loginRecord.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String loginRecord(HttpServletRequest request, Model model) {
		logger.info("로그인 기록보기");
		
		HttpSession session = request.getSession();
		UserDto ldto = (UserDto)session.getAttribute("ldto");
		List<RecordDto> recordList = loginService.loginRecordList(ldto.getUser_num());
		
		System.out.println(recordList.get(0).getRecord_date());
		model.addAttribute("recordList", recordList);
		return "loginRecord";
	}
	
	@RequestMapping(value = "/getAddr.do", method = {RequestMethod.GET,RequestMethod.POST})
	public String getAddr(Model model, UserDto dto) {
		logger.info("주소api");
		
		return "getAddr";
	}
	
	
	
	
}
