package com.koreait.movie.command.recommand;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.RecommandDao;
import com.koreait.movie.dto.MovieDto;
import com.koreait.movie.dto.UserDto;

public class RecommandSortCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		

		Map<String, Object> map = model.asMap();
		RecommandDao dao = sqlSession.getMapper(RecommandDao.class);
		
		int sort_no = (Integer)map.get("sortNo");
		

		MovieDto movieDto = new MovieDto();
		
		List<MovieDto> movieSortScore = dao.movieSortScore(movieDto);
		List<MovieDto> movieSortKorean = dao.movieSortKorean(movieDto);
		List<MovieDto> movieSortOpen = dao.movieSortOpen(movieDto);
			
		Map<String, Object> sortMap = new HashMap<String, Object>();
		
		if(sort_no==0) {
			sortMap.put("movieSortScore", movieSortScore);
		}else if(sort_no==1) {
			sortMap.put("movieSortKorean", movieSortKorean);
		}else if(sort_no==2){
			sortMap.put("movieSortOpen", movieSortOpen);
		}
	}

}
