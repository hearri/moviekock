package com.koreait.movie.command.movieInfo;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.MovieInfoDao;
import com.koreait.movie.dto.CommentDto;

public class MovieCommentViewListCommand implements CommonVoidCommand{
	
	@Override
	public void execute(SqlSession sqlSession, Model model) {

		
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		int movieNo = Integer.parseInt(request.getParameter("movieNo"));
		
		MovieInfoDao dao = sqlSession.getMapper(MovieInfoDao.class);
		
		List<CommentDto> commentDtoList = dao.commentList(movieNo);
		
		model.addAttribute("commentDtoList", commentDtoList);
		model.addAttribute("movieNo", movieNo);
	}
}
