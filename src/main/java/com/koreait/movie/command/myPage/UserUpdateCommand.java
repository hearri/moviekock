package com.koreait.movie.command.myPage;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.common.Sha256;
import com.koreait.movie.dao.MyDao;
import com.koreait.movie.dto.UserDto;

public class UserUpdateCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
	
		
		MyDao myDao = sqlSession.getMapper(MyDao.class);
		
		
		
		UserDto userDto = (UserDto)map.get("userDto");
		
		String user_pw = Sha256.sha256(userDto.getUser_pw());
		
		userDto.setUser_pw(user_pw);

		int resultUpdate = myDao.userUpdate(userDto);
	
		
		
//		회원 변경이 성공 할 시 로그인 세션 정보를 업데이트해줌
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(resultUpdate > 0) {
			
			HttpSession session = request.getSession();
			
			UserDto loginUser = myDao.sessionUser(userDto.getUser_no());
			session.setAttribute("loginUser", loginUser);
			resultMap.put("updateResult", true);
		}else {
			resultMap.put("updateResult", false);
			
		}
		
		return resultMap;
	}

}
