package com.koreait.movie.command.movieInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.MovieInfoDao;
import com.koreait.movie.dto.CommentDto;

public class CommentScrollEventCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		
		MovieInfoDao dao = sqlSession.getMapper(MovieInfoDao.class);
		
		int count = (Integer)map.get("scrollCount");
		int movieNo = (Integer)map.get("movieNo");
		
		int totalRecord = dao.totalCommentRecord(movieNo);
		
		int recordPerPage = 3;
		int beginRecord = (count - 1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		endRecord = endRecord < totalRecord ? endRecord : totalRecord;
		
		Map<String, Object> controllMap = new HashMap<String, Object>();
		
		if(totalRecord >= endRecord) {
			
			controllMap.put("beginRecord", beginRecord);
			controllMap.put("endRecord", endRecord);
			controllMap.put("movieNo", movieNo);
			
			List<CommentDto> scrollCommentList = dao.scrollCommentList(controllMap);
			
			controllMap.put("scrollCommentList", scrollCommentList);
			controllMap.put("isExist", true);
		}else {
			controllMap.put("isExist", false);

		}
		
		return controllMap;
	}

}
