package com.koreait.movie.command.signupSignin;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.SignupSigninDao;

public class SignupSigninEmailCheckCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		
		String email = (String)map.get("userEmail");
		
		SignupSigninDao dao = sqlSession.getMapper(SignupSigninDao.class);
		
		Integer result = dao.signEmailCheck(email);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(result == null) {
			resultMap.put("emailCheckResult", "yes");
		}else {
			resultMap.put("emailCheckResult", "no");
			
		}
		
		return resultMap;
	}

}
