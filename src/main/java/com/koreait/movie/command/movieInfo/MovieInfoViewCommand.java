package com.koreait.movie.command.movieInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.MovieInfoDao;
import com.koreait.movie.dto.CommentDto;
import com.koreait.movie.dto.MovieDto;
import com.koreait.movie.dto.UserDto;
import com.koreait.movie.dto.WishListDto;

public class MovieInfoViewCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MovieInfoDao dao = sqlSession.getMapper(MovieInfoDao.class);
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		String movie = request.getParameter("movieNo");
		
		
		int userNo = 0;
		int movieNo= 0;
		
//		영화정보, 배우 정보
		// http://localhost:8080/movie/movieInfoPage.do?movieNo=1 의 movieNo 정보를 받아옵니다.
		if(movie != null) {
			
			movieNo = Integer.parseInt(request.getParameter("movieNo"));
			MovieDto movieDto = dao.getMovie(movieNo);
			model.addAttribute("movieDto", movieDto);
			
			List<String> actorList = dao.getMovieActor(movieNo);
			model.addAttribute("actorList", actorList);
			
			List<MovieDto> relationMovieList = dao.getRelationMovieList(movieNo);
			model.addAttribute("relationMovieList", relationMovieList);
			
		}
		
		
		
		HttpSession session = request.getSession();
		
		// 로그인된 유저의 정보를 받아옵니다.
		UserDto loginUser = (UserDto)session.getAttribute("loginUser");
		
		if(loginUser != null) {
			
			model.addAttribute("loginUser", loginUser);
			userNo = loginUser.getUser_no();
		}
		
		
		// 코멘트 리스트
		List<CommentDto> commentList = dao.commentList(movieNo);
		
		if(commentList != null) {
			model.addAttribute("commentList", commentList);
		}
		
		
		// 위시리스트 여부
		if(userNo > 0) {
			Map<String, Object> wishListMap = new HashMap<String, Object>();
			wishListMap.put("userNo", userNo);
			wishListMap.put("movieNo", movieNo);
			WishListDto wishListDto = dao.selectWishList(wishListMap);
			if(wishListDto != null) {
				model.addAttribute("isWishList", 1);
			}else {
				model.addAttribute("isWishList", 0);
				
			}
			
		}
		
		
	}

}
