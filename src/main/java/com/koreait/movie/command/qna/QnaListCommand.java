package com.koreait.movie.command.qna;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.common.Paging;
import com.koreait.movie.dao.QnaDao;
import com.koreait.movie.dto.QnaDto;

public class QnaListCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		int page = 1;  
		if (request.getParameter("page") != null) {  
			page = Integer.parseInt(request.getParameter("page"));  
		}  
		
		int totalRecord = qnaDao.totalRecord();  
		
		int recordPerPage = 10;  
		
		int beginRecord = (page - 1) * recordPerPage + 1;  
		int endRecord = beginRecord + recordPerPage - 1; 
		endRecord = endRecord < totalRecord ? endRecord : totalRecord;  
		
		List<QnaDto> list = qnaDao.qnaList(beginRecord, endRecord);
		
		String paging = Paging.getPaging("qnaListView.do", totalRecord, recordPerPage, page);
		
		model.addAttribute("list", list);
		
		model.addAttribute("paging", paging);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("page", page);
		model.addAttribute("recordPerPage", recordPerPage);

		
		
	}

}
