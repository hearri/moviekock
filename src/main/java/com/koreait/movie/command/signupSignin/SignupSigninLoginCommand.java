package com.koreait.movie.command.signupSignin;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.common.Sha256;
import com.koreait.movie.dao.SignupSigninDao;
import com.koreait.movie.dto.UserDto;

public class SignupSigninLoginCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpServletResponse response = (HttpServletResponse)map.get("response");
		
		// 회원가입 redirect 시 RedirectAttributes에 저장한 값 
		Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		UserDto signUpDto = null;
		String user_id;
		String user_pw;
		boolean signUp = false;
        if(null != inputFlashMap) {
            signUpDto = (UserDto)inputFlashMap.get("userDto");
        }
        if(signUpDto != null) {
        	user_id = signUpDto.getUser_id();
        	user_pw = signUpDto.getUser_pw();
        	signUp = true;
        }else {
        	user_id = request.getParameter("id");
        	user_pw = Sha256.sha256(request.getParameter("pw"));
        }
        
        // 아이디 저장 을 눌러두었을때 아이디를 전달하기 위함
		String rememberId = request.getParameter("rememberId");
		
		Cookie cookie = null;
		
		if (rememberId != null) {
			cookie = new Cookie("id", user_id);
			cookie.setMaxAge(60*60*24*7);
			response.addCookie(cookie);
		}
		
		UserDto userDto = new UserDto();
		
		userDto.setUser_id(user_id);
		userDto.setUser_pw(user_pw);

		
		SignupSigninDao dao = sqlSession.getMapper(SignupSigninDao.class);
		
		UserDto loginUser = dao.loginUser(userDto);
		
		HttpSession session = request.getSession();
		
		if(loginUser == null) {
			model.addAttribute("loginResult", false);
		} else {
			model.addAttribute("loginResult", true);
			session.setAttribute("loginUser", loginUser);
		}
		
		if(signUp) {
			model.addAttribute("signUp", true);
			
		}else {
			model.addAttribute("signUp", false);
			
		}
		
	}

}
