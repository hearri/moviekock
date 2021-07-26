package com.koreait.movie.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.movie.command.recommand.RecommandSituMovieCommand;
import com.koreait.movie.command.recommand.RecommandCategoryCommand;
import com.koreait.movie.command.recommand.RecommandGenreCheckCommand;
import com.koreait.movie.command.recommand.RecommandRandomMovieCommand;

@Controller

public class RecommandPageController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private RecommandRandomMovieCommand randomMovieCommand;
	private RecommandSituMovieCommand situMovieCommand;
	private RecommandCategoryCommand categoryCommand;
	private RecommandGenreCheckCommand genreCheckCommand;
	
	@Autowired
	public void setBean(RecommandRandomMovieCommand randomMovieCommand, 
						RecommandSituMovieCommand situMovieCommand,
						RecommandCategoryCommand categoryCommand,
						RecommandGenreCheckCommand genreCheckCommand) {
		this.randomMovieCommand = randomMovieCommand;
		this.situMovieCommand = situMovieCommand;
		this.categoryCommand = categoryCommand;
		this.genreCheckCommand = genreCheckCommand;
	}
	

	@RequestMapping(value="recommandPage.do")
	public String recommandPage() {
		return "recommandPage/recommandPage";
	}
	
	@RequestMapping(value="recommandRandomPage.do")
	public String recommandRandonPage(Model model) {
		randomMovieCommand.execute(sqlSession, model);
		return "recommandPage/recommandRandomPage";
	}
	
	
	//@RequestMapping(value="recommandSituPage.do",
	//				method=RequestMethod.GET)
	//public String recommandSituPage(HttpServletRequest request, Model model) {
	//	model.addAttribute("request", request);
	//	situMovieCommand.execute(sqlSession, model);
	//	return "recommandPage/recommandMovieSituPage";
	//}
	
	@RequestMapping(value="categoryRecommandPage.do",method=RequestMethod.GET)
	public String categoryRecommandPage(HttpServletRequest request,Model model) {
		model.addAttribute("request", request);
		categoryCommand.execute(sqlSession, model);
		return "recommandPage/categoryRecommandPage";
	}
	
	
	@RequestMapping(value="RecomandGenrePage/{genreNo}",
			method=RequestMethod.GET,
			produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> categoryRecommandPageGenre(@PathVariable("genreNo") int genreNo,
			Model model){
		model.addAttribute("genreNo", genreNo);
		
		return genreCheckCommand.execute(sqlSession, model);
	}
}
