package com.koreait.movie.command.recommand;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.RecommandDao;
import com.koreait.movie.dto.MovieDto;
import com.koreait.movie.dto.UserDto;

public class RecommandCategoryCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		RecommandDao dao = sqlSession.getMapper(RecommandDao.class);
		

		List<MovieDto> movieAllList = dao.movieListGenreAll();
		
		model.addAttribute("movieAllList",movieAllList);
			

	}

}
