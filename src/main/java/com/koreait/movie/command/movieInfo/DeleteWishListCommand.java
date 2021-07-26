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

public class DeleteWishListCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		HttpSession session = request.getSession();
		
		UserDto loginUser = (UserDto)session.getAttribute("loginUser");
		
		int userNo = loginUser.getUser_no();
		int movieNo = (Integer)map.get("movieNo");
		
		MovieInfoDao dao = sqlSession.getMapper(MovieInfoDao.class);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(dao.deleteWishList(userNo, movieNo) > 0) {
			resultMap.put("deleteResult", true);
		}else {
			resultMap.put("deleteResult", false);
		}
		
		
		return resultMap;
	}

}
