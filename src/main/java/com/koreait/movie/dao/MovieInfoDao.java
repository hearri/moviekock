package com.koreait.movie.dao;

import java.util.List;
import java.util.Map;

import com.koreait.movie.dto.CommentDto;
import com.koreait.movie.dto.MovieDto;
import com.koreait.movie.dto.MovieScoreDto;
import com.koreait.movie.dto.WishListDto;

public interface MovieInfoDao {
	
	public Integer movie_no(int movie_no);
	
	public CommentDto my_write(int user_no);
	
	public CommentDto view(int no);
	
	public MovieDto getMovie(int movieNo);
	
	public List<String> getMovieActor(int movieNo);
	
	public List<MovieDto> getRelationMovieList(int movieNo);
	
	public int setStarScore(int userNo, int movieNo, double starScore);
	
	public int updateStarScore(double starScore, int movieScoreNo);
	
	public MovieScoreDto seachUserStarScore(int userNo, int movieNo);
	
	public int commentInsert(CommentDto commentDto);
	
	public List<CommentDto> commentList(int movieNo);
	
	public List<CommentDto> movieCommentViewList(int movieNo);
	
	public int totalCommentRecord(int movieNo);
	
	public List<CommentDto> scrollCommentList(Map<String, Object> map);
	
	public int insertWishList(int userNo, int movieNo);
	
	public int deleteWishList(int userNo, int movieNo);
	
	public WishListDto selectWishList(Map<String, Object> map);
}