package com.koreait.movie.command.signupSignin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.SignupSigninDao;

public class SignupSigninUserSelectMovieListCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		String movie = request.getParameter("userSelectMovieList");
		int userNo = Integer.parseInt(request.getParameter("userNo"));

		String[] movieList = movie.split(",");
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("movieList", movieList);
		
		SignupSigninDao dao = sqlSession.getMapper(SignupSigninDao.class);
		
		List<Integer> genre = dao.userSelectMovieList(resultMap);
		resultMap.put("genre", genre);
		resultMap.put("user_no", userNo);
		int insertResult = dao.userInsertGenre(resultMap);
		
	}

}
