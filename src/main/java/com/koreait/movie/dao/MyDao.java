package com.koreait.movie.dao;import java.util.List;
import java.util.Map;

import com.koreait.movie.dto.CommentDto;
import com.koreait.movie.dto.MovieDto;
import com.koreait.movie.dto.UserDto;

import java.sql.Date;
import java.util.List;

import com.koreait.movie.dto.CommentDto;

public interface MyDao {

	public int user_no(int user_no);
	
	public Integer movie_no(int movie_no);
	
	public String comments_title(String comments_title);
	
	public Date comment_date(Date comment_date);

	public List<CommentDto> my_write_page();

	public CommentDto my_write(String user_no);
	
	public CommentDto view(int no);
	
	public int userUpdate(UserDto userDto);
	
	public UserDto sessionUser(int userNo);
	
	public int userWriteTotalCount(int userNo);
	
	public List<CommentDto> loginUserCommentList(Map<String, Object> sendSqlMap);
	
	public String getMovieTitle(int movieNo);
	
	public int updateComment(String commentTitle, String commentContent, String commentNo );
	
	public int deleteComment(int commentNo);
	

	public Integer pwCheck(String pw);
	

	public int userAddProfile(String uploadFilename, int userNo);
	
	public int userAddCover(String uploadFilename, int userNo);

	public int wishListCount(int userNo);
	
	public int commentListCount(int userNo);
	
	public List<MovieDto> wishList(int userNo);
}
