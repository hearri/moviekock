package com.koreait.movie.command.signupSignin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.SignupSigninDao;
import com.koreait.movie.dto.MovieDto;

public class SignupSigninChoiceMovieDefaultListCommand implements CommonVoidCommand{
	
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		SignupSigninDao dao = sqlSession.getMapper(SignupSigninDao.class);
		
		List<MovieDto> movieDefaultList = dao.signMovieDefaultList();
		
		model.addAttribute("movieDefaultList", movieDefaultList);
		
		
	}
}
