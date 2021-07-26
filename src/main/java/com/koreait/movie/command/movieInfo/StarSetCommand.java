package com.koreait.movie.command.movieInfo;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.MovieInfoDao;
import com.koreait.movie.dto.MovieScoreDto;
import com.koreait.movie.dto.UserDto;

public class StarSetCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		MovieInfoDao dao = sqlSession.getMapper(MovieInfoDao.class);
		
		int movieNo = (Integer)map.get("movieNo");	
		double rating = (double)map.get("rating");	
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		HttpSession session = request.getSession();
		
		UserDto loginUser = (UserDto)session.getAttribute("loginUser");
		
		// 세션 로그인 체크
		if(loginUser != null) {
			int userNo = loginUser.getUser_no();
			
			MovieScoreDto movieScoreDto = dao.seachUserStarScore(userNo, movieNo);
			// 회원이 이미 별점평가를했는지 체크
			if(movieScoreDto == null) { // 별점체크가 처음이라면
				dao.setStarScore(userNo, movieNo, rating);
				resultMap.put("setUserScore", true);
			}else {
				System.out.println(rating);
				dao.updateStarScore(rating, movieScoreDto.getMovie_score_no() );
				resultMap.put("setUserScore", true);
			}
			
		}
		
		
		return resultMap;
	}

}