package com.koreait.movie.common;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface CommonVoidCommand {
	
	public void execute(SqlSession sqlSession, Model model);
	
}
