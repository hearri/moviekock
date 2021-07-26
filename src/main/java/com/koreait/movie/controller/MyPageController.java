package com.koreait.movie.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.movie.command.myPage.CommentDeleteCommand;
import com.koreait.movie.command.myPage.CommentUpdateCommand;
import com.koreait.movie.command.myPage.GetMovieTitleCommand;
import com.koreait.movie.command.myPage.MyPageCommand;

import com.koreait.movie.command.myPage.MyPagePwCommand;

import com.koreait.movie.command.myPage.UserAddCoverCommand;
import com.koreait.movie.command.myPage.UserAddProfileCommand;

import com.koreait.movie.command.myPage.UserUpdateCommand;
import com.koreait.movie.command.myPage.UserWriteListCommand;
import com.koreait.movie.command.myPage.WishListCommand;
import com.koreait.movie.dto.PageVo;
import com.koreait.movie.dto.UserDto;

@Controller

public class MyPageController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private MyPageCommand myPageCommand;
	private UserUpdateCommand userUpdateCommand;
	private UserWriteListCommand userWriteListCommand;
	private GetMovieTitleCommand getMovieTitleCommand;
	private CommentUpdateCommand commentUpdateCommand;
	private CommentDeleteCommand commentDeleteCommand;

	private MyPagePwCommand myPagePwCommand;

	private UserAddProfileCommand userAddProfileCommand;
	private UserAddCoverCommand userAddCoverCommand;
	private WishListCommand wishListCommand;

	
	@Autowired
	public void setBean(
				MyPageCommand myPageCommand,
				UserUpdateCommand userUpdateCommand,
				UserWriteListCommand userWriteListCommand,
				GetMovieTitleCommand getMovieTitleCommand,
				CommentUpdateCommand commentUpdateCommand,
				CommentDeleteCommand commentDeleteCommand,
				UserAddProfileCommand userAddProfileCommand,
				UserAddCoverCommand userAddCoverCommand,
				WishListCommand wishListCommand

			) {
		this.myPageCommand = myPageCommand;
		this.userUpdateCommand = userUpdateCommand;
		this.userWriteListCommand = userWriteListCommand;
		this.getMovieTitleCommand = getMovieTitleCommand;
		this.commentUpdateCommand = commentUpdateCommand;
		this.commentDeleteCommand = commentDeleteCommand;
		this.myPagePwCommand = myPagePwCommand;
		this.userAddProfileCommand = userAddProfileCommand;
		this.userAddCoverCommand = userAddCoverCommand;
		this.wishListCommand = wishListCommand;

	}

	@RequestMapping(value="myWritePage.do")
	public String myWritePage() {
		return "myPage/myWritePage";
	}
	
	@RequestMapping(value="myWriteViewPage.do")
	public String myWriteViewPage() {
		return "myPage/myWriteViewPage";
	}
	
	/**** 마이 페이지 접속 시 로그인 된 유저의 정보를 가져옴*****/
	@RequestMapping(value="myPage.do")
	public String myPage(HttpServletRequest request,
						Model model) {
		model.addAttribute("request", request);
		
		myPageCommand.execute(sqlSession, model);
		
		return "myPage/myPage";
	}
	
	/**** 마이 페이지 내에서 업데이트*****/
	@RequestMapping(value="userUpdate.do",
					method=RequestMethod.POST,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> userUpdate(@RequestBody UserDto userDto,
											HttpServletRequest request,
											Model model){
		model.addAttribute("userDto", userDto);
		model.addAttribute("request", request);
		
		return userUpdateCommand.execute(sqlSession, model);
	}
	

	/**** 내가 쓴 글 목록 불러오기*****/
	@RequestMapping(value="userWriteList.do",
					method=RequestMethod.POST,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> userWriteList(@RequestBody PageVo pageVo, HttpServletRequest request, Model model){
		model.addAttribute("page", pageVo.getPage());
		model.addAttribute("request", request);
		
		return userWriteListCommand.execute(sqlSession, model);
	}
	
	/**** 영화 넘버로 영화제목 가져오기 ******/
	@RequestMapping(value="getMovieTitle/{movieNo}",
			method=RequestMethod.GET,
			produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> getMovieTitle(@PathVariable("movieNo") int movieNo, Model model){
	model.addAttribute("movieNo", movieNo);
	
	return getMovieTitleCommand.execute(sqlSession, model);
	}
	
	/****** 글 수정 하기 *******/
	@RequestMapping(value="userUpdateComment.do",
					method=RequestMethod.PUT,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> userUpdateComment(@RequestBody Map<String, Object> updateObj, Model model){
		
		model.addAttribute("updateObj", updateObj);
		
		return commentUpdateCommand.execute(sqlSession, model);
	}
	
	/****** 글 삭제 하기 *******/
	@RequestMapping(value="userDeleteComment/{commentNo}",
			method=RequestMethod.DELETE,
			produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> userDeleteComment(@PathVariable("commentNo") int commentNo, Model model){
	
	model.addAttribute("commentNo", commentNo);
	
	return commentDeleteCommand.execute(sqlSession, model);
	}
	
	@RequestMapping(value="userControllProfile.do",
					method=RequestMethod.POST,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> userControllProfile(MultipartHttpServletRequest multipartRequest, Model model){
		model.addAttribute("multipartRequest", multipartRequest);
		return userAddProfileCommand.execute(sqlSession, model);
	}
	
	@RequestMapping(value="userControllCover.do",
			method=RequestMethod.POST,
			produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> userControllCover(MultipartHttpServletRequest multipartRequest, Model model){
		model.addAttribute("multipartRequest", multipartRequest);
		return userAddCoverCommand.execute(sqlSession, model);
	}

	@RequestMapping(value="wishList.do")
	public String wishList(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		wishListCommand.execute(sqlSession, model);
		return "myPage/wishListPage";
	}
}
