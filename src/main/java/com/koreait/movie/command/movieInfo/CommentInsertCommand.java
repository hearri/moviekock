package com.koreait.movie.command.movieInfo;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.MovieInfoDao;
import com.koreait.movie.dto.CommentDto;
import com.koreait.movie.dto.UserDto;

public class CommentInsertCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpSession session = request.getSession();
		
		String commentTitle = request.getParameter("commentTitle");
		String commentContents = request.getParameter("commentContents");
		int movieNo = Integer.parseInt(request.getParameter("commentMovieNo"));
		
		// 현재 로그인된 유저의 정보를 가져옵니다
		UserDto loginUser = (UserDto)session.getAttribute("loginUser");
		
		int userNo = loginUser.getUser_no();
		
		// dao
		MovieInfoDao dao = sqlSession.getMapper(MovieInfoDao.class);
		
		CommentDto commentDto = new CommentDto();
		
		commentDto.setComments_title(commentTitle);
		commentDto.setComment_content(commentContents);
		commentDto.setMovie_no(movieNo);
		commentDto.setUser_no(userNo);
		
		dao.commentInsert(commentDto);
		
	}

}
