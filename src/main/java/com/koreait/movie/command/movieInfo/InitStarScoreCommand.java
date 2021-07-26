package com.koreait.movie.command.movieInfo;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.MovieInfoDao;
import com.koreait.movie.dto.MovieScoreDto;

public class InitStarScoreCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MovieInfoDao dao = sqlSession.getMapper(MovieInfoDao.class);
		
		int userNo = (Integer)map.get("userNo");
		int movieNo = (Integer)map.get("movieNo");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		MovieScoreDto movieScoreDto = dao.seachUserStarScore(userNo, movieNo);
		
		if(movieScoreDto != null) {
			resultMap.put("result", true);
			resultMap.put("movieScore", movieScoreDto.getStar_score());
		}else {
			resultMap.put("result", false);
		}
		
		
		return resultMap;
	}

}