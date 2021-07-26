package com.koreait.movie.dao;

import java.util.List;
import java.util.Map;

import com.koreait.movie.dto.MovieDto;
import com.koreait.movie.dto.QnaDto;
import com.koreait.movie.dto.UserDto;

public interface AdminDao {

	public int userTotalCount();
	
	public List<UserDto> userDtoList(Map<String, Object> map);
	
	public int userDelete(int userNo);
	
	public List<MovieDto> movieDtoList(Map<String, Object> map);
	
	public int movieTotalCount();
	
	
	// 문의글 리스트
	public List<QnaDto> qnaDtoList(Map<String, Object> map);
	
	// 문의글 개수
	public int qnaTotalCount();
	
	// 문의글 답글 지우기
	public int adminQnaReplyDelete(int qnaReplyNo);
	
	// 문의글 지우기
	public int adminQnaDelete(int qnaNo);
	
}
