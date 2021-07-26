package com.koreait.movie.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.movie.command.signupSignin.ScrollMovieList;
import com.koreait.movie.command.signupSignin.SignupSigninChoiceMovieDefaultListCommand;
import com.koreait.movie.command.signupSignin.SignupSigninEmailCheckCommand;
import com.koreait.movie.command.signupSignin.SignupSigninFindIdCommand;
import com.koreait.movie.command.signupSignin.SignupSigninFindPwCommand;
import com.koreait.movie.command.signupSignin.SignupSigninIdCheckCommand;
import com.koreait.movie.command.signupSignin.SignupSigninInsertUserCommand;
import com.koreait.movie.command.signupSignin.SignupSigninLoginCommand;
import com.koreait.movie.command.signupSignin.SignupSigninLogoutCommand;
import com.koreait.movie.command.signupSignin.SignupSigninNickCheckCommand;
import com.koreait.movie.command.signupSignin.SignupSigninUpdatePwCommand;
import com.koreait.movie.command.signupSignin.SignupSigninUserSelectMovieListCommand;

@Controller

public class SignupSigninPageController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private SignupSigninIdCheckCommand idcheckCommand;
	private SignupSigninNickCheckCommand nickCheckCommand;
	private SignupSigninEmailCheckCommand emailCheckCommand;
	private SignupSigninInsertUserCommand insertUserCommand;
	private SignupSigninLoginCommand loginCommand;
	private SignupSigninLogoutCommand logoutCommand;
	private SignupSigninChoiceMovieDefaultListCommand choiceMovieDefaultListCommand;
	private SignupSigninUserSelectMovieListCommand userSelectMovieListCommand;
	private SignupSigninFindIdCommand findIdCommand;
	private ScrollMovieList scrollMovieList;
	private SignupSigninFindPwCommand findPwCommand;
	private SignupSigninUpdatePwCommand updatePwCommand;
	
	@Autowired
	public void setBean(SignupSigninIdCheckCommand idcheckCommand,
						SignupSigninNickCheckCommand nickCheckCommand,
						SignupSigninEmailCheckCommand emailCheckCommand,
						SignupSigninInsertUserCommand insertUserCommand,
						SignupSigninLoginCommand loginCommand,
						SignupSigninLogoutCommand logoutCommand,
						SignupSigninChoiceMovieDefaultListCommand choiceMovieDefaultListCommand,
						SignupSigninUserSelectMovieListCommand userSelectMovieListCommand,
						SignupSigninFindIdCommand findIdCommand,
						ScrollMovieList scrollMovieList,
						SignupSigninFindPwCommand findPwCommand,
						SignupSigninUpdatePwCommand updatePwCommand) {
		this.idcheckCommand = idcheckCommand;
		this.nickCheckCommand = nickCheckCommand;
		this.emailCheckCommand = emailCheckCommand;
		this.insertUserCommand = insertUserCommand;
		this.loginCommand = loginCommand;
		this.logoutCommand = logoutCommand;
		this.choiceMovieDefaultListCommand = choiceMovieDefaultListCommand;
		this.userSelectMovieListCommand = userSelectMovieListCommand;
		this.findIdCommand = findIdCommand;
		this.scrollMovieList = scrollMovieList;
		this.findPwCommand = findPwCommand;
		this.updatePwCommand = updatePwCommand;
	}
	
	
	@RequestMapping(value="signupPage.do")
	public String signupPage() {
		return "signupSigninPage/signupPage";
	}
	
	@RequestMapping(value="loginPage.do")
	public String loginPage()	{
		return "signupSigninPage/loginPage";
	}
	
	@RequestMapping(value="signupChoicePage.do",
					method=RequestMethod.POST)
	public String signup_choice_page(HttpServletRequest request, Model model) {
		
		model.addAttribute("userNo", request.getParameter("no"));
		choiceMovieDefaultListCommand.execute(sqlSession, model);
		
		return "signupSigninPage/signupChoicePage";
	}
	
	@RequestMapping(value="findIdpwPage.do")
	public String findIdpwPage() {
		return "signupSigninPage/findIdpwPage";
	}
	
	@RequestMapping(value="privacy_agreementPage.do")
	public String privacy_agreementPage() {
		return "signupSigninPage/privacy_agreementPage";
	}
	
	/*** 아이디 체크 ***/
	@RequestMapping(value="userIdCheck/{userId}",
					method=RequestMethod.POST,
					produces="application/json; charset=utf-8")
	@ResponseBody

	public Map<String, Object> signUpIdCheck(@PathVariable("userId") String userId,
												Model model){
		model.addAttribute("userId", userId);
		
		return idcheckCommand.execute(sqlSession, model);
	}
	
	/*** 닉네임 체크 ***/
	@RequestMapping(value="userNickCheck/{userNick}",
			method=RequestMethod.POST,
			produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> signUpNickCheck(@PathVariable("userNick") String userNick,
			Model model){
		model.addAttribute("userNick", userNick);
		
		return nickCheckCommand.execute(sqlSession, model);
	}
	
	/*** 이메일 체크 ***/
	@RequestMapping(value="userEmailCheck/{userEmail}",
			method=RequestMethod.POST,
			produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> signUpEmailCheck(@PathVariable("userEmail") String userEmail,
			Model model){
		model.addAttribute("userEmail", userEmail);
		
		return emailCheckCommand.execute(sqlSession, model);
	}
	
	/*** 회원가입 ***/
	@RequestMapping(value="userSignUp.do",
					method=RequestMethod.POST)
	public String signUp(HttpServletRequest request,
						RedirectAttributes rttr,
						Model model) {
		model.addAttribute("request", request);
		model.addAttribute("rttr", rttr);
		
		insertUserCommand.execute(sqlSession, model);
		
		return "redirect:login.do";

	}
	
	/*** 로그인 ***/
	@RequestMapping(value="login.do",
					  method={RequestMethod.GET, RequestMethod.POST})
	public String login(HttpServletRequest request,
						  HttpServletResponse response,
						  Model model) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		loginCommand.execute(sqlSession, model);
		return "signupSigninPage/loginResultPage";
	}
	
	/*** 로그아웃 ***/
	@RequestMapping(value="logout.do")
	public String logout(HttpServletRequest request,
						   Model model) {
		model.addAttribute("request", request);
		logoutCommand.execute(sqlSession, model);
		return "signupSigninPage/logoutResultPage";
	}
	
	
	/*** 회원 영화 취향 고른 정보 저장 ***/
	@RequestMapping(value="userSelectMovieList.do",
					method=RequestMethod.POST)
	public String userSelectMovieList(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		userSelectMovieListCommand.execute(sqlSession, model);
		return "redirect:mainPage.do";
		
	}
	
	/*** 스크롤 하단 영화 리스트 불러오기 ***/
	@RequestMapping(value="scrollMovieList/{scrollCount}",
					method = RequestMethod.GET,
					produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> scrollMovieList(@PathVariable("scrollCount") int scrollCount,Model model){
		
		model.addAttribute("scrollCount", scrollCount);
		
		return scrollMovieList.execute(sqlSession, model);
	}
	
	/***** 이메일 *****/
	
	@Autowired
	private JavaMailSender mailSender;
	
	/***** 아이디 찾기 *****/
	@RequestMapping(value="findId.do", method=RequestMethod.POST)
	public String findId(HttpServletRequest request,
			                Model model) {
		model.addAttribute("request", request);
		model.addAttribute("mailSender", mailSender);
		findIdCommand.execute(sqlSession, model);
		
		return "signupSigninPage/findIdResultPage";
		
	}
	
	/***** 비밀번호 찾기 *****/
	@RequestMapping(value="findPw.do", method=RequestMethod.POST)
	public String findPwEmail(HttpServletRequest request,
			Model model) {
		model.addAttribute("request", request);
		model.addAttribute("mailSender", mailSender);
		findPwCommand.execute(sqlSession, model);
		updatePwCommand.execute(sqlSession, model);
		return "signupSigninPage/findPwResultPage";
		
	}
	
//	/*** 비밀번호 변경 ***/
//	@RequestMapping(value="userSignUp.do",
//					method=RequestMethod.POST)
//	public String updatePw(HttpServletRequest request,
//						RedirectAttributes rttr,
//						Model model) {
//		model.addAttribute("request", request);
//		model.addAttribute("rttr", rttr);
//		
//		updatePwCommand.execute(sqlSession, model);
//		
//		return "signupSigninPage/index";
//
//	}
//	
//	/***** 나중에 지울것! *****/
//	@RequestMapping(value="updatePwPage.do")
//	public String updatePwPage()	{
//		return "signupSigninPage/updatePwPage";
//	}
	
}