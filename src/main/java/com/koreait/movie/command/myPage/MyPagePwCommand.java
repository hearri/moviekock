package com.koreait.movie.command.myPage;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.common.Sha256;
import com.koreait.movie.dao.MyDao;
import com.koreait.movie.dao.SignupSigninDao;
import com.koreait.movie.dto.UserDto;

public class MyPagePwCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model)  {
		
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpServletResponse response = (HttpServletResponse)map.get("response");
		
		MyDao dao1 = sqlSession.getMapper(MyDao.class);
		SignupSigninDao dao2 = sqlSession.getMapper(SignupSigninDao.class);
		
		String user_pw;
		user_pw = Sha256.sha256(request.getParameter("pw"));
		
		UserDto userDto = new UserDto();
		HttpSession session = request.getSession();
		
		userDto.setUser_pw(user_pw);
		
		UserDto loginUser = dao2.loginUser(userDto);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(loginUser == null) {
			model.addAttribute("loginResult", false);
		} else {
			model.addAttribute("loginResult", true);
			session.setAttribute("loginUser", loginUser);
		}
		
		
		
	}

}
