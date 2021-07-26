package com.koreait.movie.command.myPage;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.MyDao;

public class CommentUpdateCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> updateObj = (Map<String, Object>)model.asMap().get("updateObj");
		
		String commentTitle = (String)updateObj.get("titleValue");
		String commentContent = (String)updateObj.get("contentValue");
		String commentNo = (String)updateObj.get("commentNo");
		MyDao dao = sqlSession.getMapper(MyDao.class);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("updateResult", dao.updateComment(commentTitle, commentContent, commentNo));
		
		return resultMap;
	}

}
