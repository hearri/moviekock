package com.koreait.movie.command.myPage;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.MyDao;

public class GetMovieTitleCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		
		
		int movieNo = (Integer)map.get("movieNo");
		
		MyDao dao = sqlSession.getMapper(MyDao.class);
		
		String movieTitle = dao.getMovieTitle(movieNo);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("movieTitle", movieTitle);
		
		
		return resultMap;
	}

}
