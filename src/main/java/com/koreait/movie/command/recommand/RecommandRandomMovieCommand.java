package com.koreait.movie.command.recommand;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.RecommandDao;


public class RecommandRandomMovieCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		RecommandDao dao = sqlSession.getMapper(RecommandDao.class);
		
		
		Integer movieCount = dao.movieCount();
		
		
		int no = (int)(Math.random() * movieCount) +1;
		
	
		String movieTitle = dao.movieTitle(no);
		
		
		model.addAttribute("movieTitle",movieTitle);
		model.addAttribute("movieCount",movieCount);
		model.addAttribute("no",no);
		
		
		
	}

}
