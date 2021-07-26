package com.koreait.movie.command.myPage;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.MyDao;
import com.koreait.movie.dto.MovieDto;
import com.koreait.movie.dto.UserDto;

public class WishListCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpSession session = request.getSession();
		
		UserDto loginUser = (UserDto)session.getAttribute("loginUser");
		
		int userNo = loginUser.getUser_no();
		String userNickname = loginUser.getUser_nickname();
		
		MyDao dao = sqlSession.getMapper(MyDao.class);
		
		List<MovieDto> movieDtoList = dao.wishList(userNo);
		
		model.addAttribute("movieDtoList", movieDtoList);
		model.addAttribute("userNickname", userNickname);
		
	}

}
