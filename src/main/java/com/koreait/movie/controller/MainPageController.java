package com.koreait.movie.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.koreait.movie.command.main.MainCommand;
import com.koreait.movie.command.main.SearchResultCommand;

@Controller
public class MainPageController {

	@Autowired
	private SqlSession sqlSession;

	private MainCommand mainCommand;
	private SearchResultCommand searchResultCommand;

	@Autowired
	public void setBean(MainCommand mainCommand, SearchResultCommand searchResultCommand) {
		this.mainCommand = mainCommand;
		this.searchResultCommand = searchResultCommand;
	}

	@RequestMapping(value = "mainPage.do")
	public String mainPage(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
//		MainCommand mainCommand = new MainCommand();
		mainCommand.execute(sqlSession, model);

		return "mainPage/mainPage";
	}
	@RequestMapping(value = "searchResultPage.do", method=RequestMethod.GET)
	public String list(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		
//		SearchResultCommand searchResultCommand = new SearchResultCommand();
		searchResultCommand.execute(sqlSession, model);
		
		return "mainPage/searchResultPage";
	}
}
