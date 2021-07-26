package com.koreait.movie.command.signupSignin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.SignupSigninDao;
import com.koreait.movie.dto.MovieDto;

public class ScrollMovieList implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		
		
		Map<String, Object> map = model.asMap();
		
		SignupSigninDao dao = sqlSession.getMapper(SignupSigninDao.class);
		
		int count = (Integer)map.get("scrollCount");
		
		int totalRecord = dao.totalMovieRecord();
		
		int recordPerPage = 6;
		int beginRecord = (count - 1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		endRecord = endRecord < totalRecord ? endRecord : totalRecord;
		
		Map<String, Object> controllMap = new HashMap<String, Object>();
		
		if(totalRecord >= endRecord) {
			
			controllMap.put("beginRecord", beginRecord);
			controllMap.put("endRecord", endRecord);
			
			List<MovieDto> scrollMovieList = dao.scrollMovieList(controllMap);
			
			controllMap.put("scrollMovieList", scrollMovieList);
			controllMap.put("isExist", true);
		}else {
			controllMap.put("isExist", false);

		}
		
		return controllMap;
	}

}
