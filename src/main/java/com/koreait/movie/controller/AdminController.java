package com.koreait.movie.controller;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.movie.command.admin.AdminQnaDeleteCommand;
import com.koreait.movie.command.admin.AdminQnaListCommand;
import com.koreait.movie.command.admin.MovieListCommand;
import com.koreait.movie.command.admin.UserDeleteCommand;
import com.koreait.movie.command.admin.UserListCommand;
import com.koreait.movie.dto.PageVo;

@Controller
public class AdminController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private UserListCommand userListCommand;
	private UserDeleteCommand userDeleteCommand;
	private MovieListCommand movieListCommand;
	private AdminQnaListCommand adminQnaListCommand;
	private AdminQnaDeleteCommand adminQnaDeleteCommand;
	
	@Autowired
	public void setBean(UserListCommand userListCommand,
						UserDeleteCommand userDeleteCommand,
						MovieListCommand movieListCommand,
						AdminQnaListCommand adminQnaListCommand,
						AdminQnaDeleteCommand adminQnaDeleteCommand) {
		
		this.userListCommand = userListCommand;
		this.userDeleteCommand = userDeleteCommand;
		this.movieListCommand = movieListCommand;
		this.adminQnaListCommand = adminQnaListCommand;
		this.adminQnaDeleteCommand = adminQnaDeleteCommand;
	}
	
	@RequestMapping(value="adminPage.admin")
	public String adminPage(){
		
		return "admin/adminPage";
	}
	
	@RequestMapping(value="movies.admin")
	public String moviesPage(){
		
		return "admin/moviesPage";
	}
	
	@RequestMapping(value="qna.admin")
	public String qnaPage(){
		
		return "admin/qnaPage";
	}
	
	@RequestMapping(value="userList.admin",
					method=RequestMethod.POST,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> userList(@RequestBody PageVo pageVo, Model model){
		
		model.addAttribute("page", pageVo.getPage());
		
		return userListCommand.execute(sqlSession, model);
	}
	
	@RequestMapping(value="userDelete/{userNo}",
			method=RequestMethod.DELETE,
			produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> userDelete(@PathVariable("userNo") int userNo, Model model){
		
		model.addAttribute("userNo", userNo);
		
		return userDeleteCommand.execute(sqlSession, model);
	}
		

	@RequestMapping(value="movieList.admin",
					method=RequestMethod.POST,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> movieList(@RequestBody PageVo pageVo, Model model){
	
	model.addAttribute("page", pageVo.getPage());
	
	return movieListCommand.execute(sqlSession, model);
	}
	
	@RequestMapping(value="qnaList.admin",
					method=RequestMethod.POST,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> qnaList(@RequestBody PageVo pageVo, Model model){
	
	model.addAttribute("page", pageVo.getPage());
	
	return adminQnaListCommand.execute(sqlSession, model);
	}
		
	@RequestMapping(value="adminQnaDelete/{qnaNo}",
			method=RequestMethod.DELETE,
			produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> adminQnaDelete(@PathVariable("qnaNo") int qnaNo, Model model){
		
		model.addAttribute("qnaNo", qnaNo);
		
		return adminQnaDeleteCommand.execute(sqlSession, model);
	}
	
	
	
}
