package com.koreait.movie.command.signupSignin;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.SignupSigninDao;

public class SignupSigninIdCheckCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		
		String id = (String)map.get("userId");
		
		SignupSigninDao dao = sqlSession.getMapper(SignupSigninDao.class);
		
		Integer result = dao.signIdCheck(id);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(result == null) {
			resultMap.put("idCheckResult", "yes");
		}else {
			resultMap.put("idCheckResult", "no");
			
		}
		
		return resultMap;
	}

}
