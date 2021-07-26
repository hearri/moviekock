package com.koreait.movie.command.recommand;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.RecommandDao;
import com.koreait.movie.dto.MovieDto;

public class RecommandSituMovieCommand implements CommonVoidCommand{

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		RecommandDao dao = sqlSession.getMapper(RecommandDao.class);

		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		String userChoice = request.getParameter("tag1");
		int situNo = 0;
		
		switch (userChoice) {
		case "썸":
			situNo = 1;
			break;
		case "dawn":
			situNo = 2;
			break;
		case "drink":
			situNo = 3;
			break;
		case "some":
			situNo = 4;
			break;
		case "success":
			situNo = 5;
			break;
		case "rooftop":
			situNo = 6;
			break;
		case "officeway":
			situNo = 7;
			break;
		case "business":
			situNo = 8;
			break;
		case "new":
			situNo = 9;
			break;
		case "sea":
			situNo = 10;
			break;
		case "corona":
			situNo = 11;
			break;
		case "home":
			situNo = 12;
			break;
		
		}
		
		List<MovieDto> movieList = dao.movieList(situNo);
		model.addAttribute("movieList", movieList);
		
	}

}
