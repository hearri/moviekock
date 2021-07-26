package com.koreait.movie.command.myPage;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.MyDao;

public class MyWriteCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		MyDao my_dao = sqlSession.getMapper(MyDao.class);
		model.addAttribute("my_write", my_dao.my_write_page());
	}

}
