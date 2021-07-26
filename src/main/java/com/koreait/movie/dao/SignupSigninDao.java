package com.koreait.movie.dao;

import java.util.List;
import java.util.Map;

import com.koreait.movie.dto.MovieDto;
import com.koreait.movie.dto.UserDto;

public interface SignupSigninDao {
	
	public Integer signIdCheck(String id);
	
	public Integer signNickCheck(String nick);
	
	public Integer signEmailCheck(String email);
	
	public int signUserInsert(UserDto userDto);
	

	public UserDto loginUser(UserDto userDto);

	public List<MovieDto> signMovieDefaultList();
	
	public List<Integer> userSelectMovieList(Map<String, Object> map);

	public int userInsertGenre(Map<String, Object> map);
	
	public int totalMovieRecord();
	
	public List<MovieDto> scrollMovieList(Map<String, Object> controllMap);
	
	public UserDto findId(UserDto userDto);
	
	public UserDto findPw(UserDto userDto);
	
	public int updatePw(String temporaryPw, String id);
}
