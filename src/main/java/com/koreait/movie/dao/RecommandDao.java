package com.koreait.movie.dao;

import java.util.List;

import com.koreait.movie.dto.MovieDto;

public interface RecommandDao {
	
	public String movieTitle(int no);
	
	public int movieCount();
	
	public String movieSitu(int no);
	
	public List<MovieDto> movieList(int no);
	
	public List<MovieDto> movieListGenre(int no);
	
	public List<MovieDto> movieListGenreAll();
	
	public List<MovieDto> movieSortScore(MovieDto movieDto);
	
	public List<MovieDto> movieSortKorean(MovieDto movieDto);
	
	public List<MovieDto> movieSortOpen(MovieDto movieDto);
}
