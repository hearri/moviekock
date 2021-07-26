package com.koreait.movie.dao;

import java.util.List;
import java.util.Map;

import com.koreait.movie.dto.MovieDto;

public interface MainDao {

	public List<MovieDto> mainList1(Map<String, Object> map2);

	public List<MovieDto> mainList2();

	public List<MovieDto> mainList3();
	public List<MovieDto> mainList4();
	public List<MovieDto> mainList5();

	public List<MovieDto> resultList(String search);

	public List<MovieDto> userGenreList(int userNo);

}