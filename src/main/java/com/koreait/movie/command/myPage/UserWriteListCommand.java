package com.koreait.movie.command.myPage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.MyDao;
import com.koreait.movie.dto.CommentDto;
import com.koreait.movie.dto.UserDto;


public class UserWriteListCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpSession session = request.getSession();
		
		UserDto loginUser = (UserDto)session.getAttribute("loginUser");
		
		MyDao myDao = sqlSession.getMapper(MyDao.class);
		
		int page = (int)map.get("page");
		int userNo = loginUser.getUser_no();
		
		int totalRecord = myDao.userWriteTotalCount(userNo);
		int recordPerPage = 6;
		int beginRecord = (page - 1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		endRecord = (endRecord < totalRecord) ? endRecord : totalRecord;
		int totalPage = totalRecord / recordPerPage;  // 전체 페이지의 개수
		if (totalRecord % recordPerPage != 0) {
			totalPage++;
		}
		totalPage = (totalPage >= page) ? totalPage : page;
		int pagePerBlock = 5;
		int beginPage = ((page - 1) / pagePerBlock) * pagePerBlock + 1;
		int endPage = beginPage + pagePerBlock - 1;
		endPage = endPage < totalPage ? endPage : totalPage;
		
		Map<String, Integer> paging = new HashMap<>();
		paging.put("totalRecord", totalRecord);
		paging.put("page", page);
		paging.put("totalPage", totalPage);
		paging.put("pagePerBlock", pagePerBlock);
		paging.put("beginPage", beginPage);
		paging.put("endPage", endPage);
		paging.put("recordPerPage", recordPerPage);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("paging", paging);
		session.setAttribute("paging", paging);
		
		Map<String, Object> sendSqlMap = new HashMap<String, Object>();
		
		sendSqlMap.put("beginRecord", beginRecord);
		sendSqlMap.put("endRecord", endRecord);
		sendSqlMap.put("userNo", userNo);
		
		
		List<CommentDto> list = myDao.loginUserCommentList(sendSqlMap);
		result.put("list", list);
		result.put("userNo", userNo);
		result.put("userNickname", loginUser.getUser_nickname());
		
		if (list.size() > 0) {
			result.put("exist", true);
		} else {
			result.put("exist", false);
		}
		
		return result;
		
	}

}
