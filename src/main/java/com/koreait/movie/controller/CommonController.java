 package com.koreait.movie.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.koreait.movie.command.main.MainCommand;

@Controller
public class CommonController {

	@Autowired
	private SqlSession sqlSession;

//	public String index() {
//		return "mainPage/mainPage";
//	}
	
	@RequestMapping(value= {"", "index.do"})
	public String index(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
		MainCommand mainCommand = new MainCommand();
		mainCommand.execute(sqlSession, model);

		return "mainPage/mainPage";
	}
//	@RequestMapping(value= {"", "index.do"})
//	public String index() {
//		return "index";
//	}
	
}
