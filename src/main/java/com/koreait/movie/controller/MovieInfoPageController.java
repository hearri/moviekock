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

import com.koreait.movie.command.movieInfo.CommentInsertCommand;
import com.koreait.movie.command.movieInfo.CommentScrollEventCommand;
import com.koreait.movie.command.movieInfo.DeleteWishListCommand;
import com.koreait.movie.command.movieInfo.InitStarScoreCommand;
import com.koreait.movie.command.movieInfo.InsertWishListCommand;
import com.koreait.movie.command.movieInfo.MovieCommentViewListCommand;
import com.koreait.movie.command.movieInfo.MovieInfoViewCommand;
import com.koreait.movie.command.movieInfo.StarSetCommand;

@Controller
public class MovieInfoPageController {
	
	@Autowired
	private SqlSession sqlSession;
	
	private MovieInfoViewCommand movieInfoViewCommand;
	private StarSetCommand starSetCommand;
	private InitStarScoreCommand initStarScoreCommand;
	private CommentInsertCommand commentInsertCommand;
	private MovieCommentViewListCommand movieCommentViewListCommand;
	private CommentScrollEventCommand commentScrollEventCommand;
	private InsertWishListCommand insertWishListCommand;
	private DeleteWishListCommand deleteWishListCommand;
	
	@Autowired
	public void setBean(MovieInfoViewCommand movieInfoViewCommand,
						StarSetCommand starSetCommand,
						InitStarScoreCommand initStarScoreCommand,
						CommentInsertCommand commentInsertCommand,
						MovieCommentViewListCommand movieCommentViewListCommand,
						CommentScrollEventCommand commentScrollEventCommand,
						InsertWishListCommand insertWishListCommand,
						DeleteWishListCommand deleteWishListCommand) {
		this.movieInfoViewCommand = movieInfoViewCommand;
		this.starSetCommand = starSetCommand;
		this.initStarScoreCommand = initStarScoreCommand;
		this.commentInsertCommand = commentInsertCommand;
		this.movieCommentViewListCommand = movieCommentViewListCommand;
		this.commentScrollEventCommand = commentScrollEventCommand;
		this.insertWishListCommand = insertWishListCommand;
		this.deleteWishListCommand = deleteWishListCommand;
		
	}
	
	
	@RequestMapping(value="movieInfoPage.do")
	public String movieInfoPage(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
		movieInfoViewCommand.execute(sqlSession, model);
		return "movieInfoPage/movieInfoPage";
	}
	
	
	
	@RequestMapping(value="movieCommentPage.do")
	public String movieCommentPage(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
		movieCommentViewListCommand.execute(sqlSession, model);
		
		return "movieInfoPage/movieCommentPage";
	}
	
	@RequestMapping(value="setStar/{movieNo}/{rating:.+}",
					method=RequestMethod.POST,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> setStar(@PathVariable("movieNo") int movieNo,
										@PathVariable("rating") double rating,
										HttpServletRequest request,
										Model model) {
		System.out.println(rating);
		model.addAttribute("movieNo", movieNo);
		model.addAttribute("rating", rating);
		model.addAttribute("request", request);
		
		return starSetCommand.execute(sqlSession, model);
	}
	
	
	@RequestMapping(value="initStarScore/{loginUser}/{movieNo}",
					method=RequestMethod.GET,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> initStarScore(@PathVariable("loginUser") int userNo,
											@PathVariable("movieNo") int movieNo,
											HttpServletRequest request,
											Model model){
		model.addAttribute("userNo", userNo);
		model.addAttribute("movieNo", movieNo);
		
		return initStarScoreCommand.execute(sqlSession, model);
	}
	
	@RequestMapping(value="commentSubmit.do",
					method=RequestMethod.POST)
	public String commentSubmit(HttpServletRequest request, Model model) {
		
		model.addAttribute("request", request);
		int movieNo = Integer.parseInt(request.getParameter("commentMovieNo"));
		commentInsertCommand.execute(sqlSession, model);
		
		return "redirect:movieInfoPage.do?movieNo=" + movieNo;
		
	}
	
	@RequestMapping(value="scrollCommentList/{scrollCount}/{movieNo}",
					method=RequestMethod.GET,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> scrollCommentList(@PathVariable("scrollCount") int scrollCount,
												@PathVariable("movieNo") int movieNo, Model model){
		model.addAttribute("scrollCount", scrollCount);
		model.addAttribute("movieNo", movieNo);
		
		return commentScrollEventCommand.execute(sqlSession, model);
	}
	
	@RequestMapping(value="insertWishList/{movieNo}",
					method=RequestMethod.POST,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> insertWishList(@PathVariable("movieNo") int movieNo,
												HttpServletRequest request, Model model){
		model.addAttribute("movieNo", movieNo);
		model.addAttribute("request", request);
		
		return insertWishListCommand.execute(sqlSession, model);
	}
	
	@RequestMapping(value="deleteWishList/{movieNo}",
			method=RequestMethod.POST,
			produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> deleteWishList(@PathVariable("movieNo") int movieNo,
			HttpServletRequest request, Model model){
		model.addAttribute("movieNo", movieNo);
		model.addAttribute("request", request);
		
		return deleteWishListCommand.execute(sqlSession, model);
	}
	
}