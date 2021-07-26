package com.koreait.movie.command.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.MainDao;
import com.koreait.movie.dto.MovieDto;

public class SearchResultCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		MainDao dao = sqlSession.getMapper(MainDao.class);

		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		String search = request.getParameter("search");
		
		List<MovieDto> resultList = dao.resultList(search);
		model.addAttribute("resultList", resultList);
		model.addAttribute("search", search);
	}
}