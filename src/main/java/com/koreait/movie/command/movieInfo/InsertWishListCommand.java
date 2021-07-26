package com.koreait.movie.command.movieInfo;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.MovieInfoDao;
import com.koreait.movie.dto.UserDto;

public class InsertWishListCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		HttpSession session = request.getSession();
		
		// 현재 로그인되어있는 유저의 정보를 가져옵니다.
		UserDto loginUser = (UserDto)session.getAttribute("loginUser");
		
		int userNo = loginUser.getUser_no();
		int movieNo = (Integer)map.get("movieNo");
		
		MovieInfoDao dao = sqlSession.getMapper(MovieInfoDao.class);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 삭제 여부에 따라 boolean 타입으로 반환합니다.
		if(dao.insertWishList(userNo, movieNo) > 0) {
			resultMap.put("insertResult", true);
		}else {
			resultMap.put("insertResult", false);
		}
		
		
		return resultMap;
	}

}
