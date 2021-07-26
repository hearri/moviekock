package com.koreait.movie.command.myPage;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.MyDao;
import com.koreait.movie.dto.UserDto;

public class MyPageCommand implements CommonVoidCommand {
	
	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		HttpSession session = request.getSession();
		
		

		UserDto loginUser = (UserDto)session.getAttribute("loginUser");
		model.addAttribute("loginUser", loginUser);
		MyDao dao = sqlSession.getMapper(MyDao.class);
		
		int userNo = loginUser.getUser_no();
		
		int wishListCount = 0;
		int commentListCount = 0;
		
		if(userNo > 0) {
			wishListCount = dao.wishListCount(userNo);
			commentListCount = dao.commentListCount(userNo);
			model.addAttribute("wishListCount", wishListCount);
			model.addAttribute("commentListCount", commentListCount);
		}
		
		
	}
}
