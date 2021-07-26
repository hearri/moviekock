package com.koreait.movie.command.qna;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.QnaReplyDao;
import com.koreait.movie.dao.QnaDao;

public class QnaViewCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		int qna_no = Integer.parseInt(request.getParameter("qna_no"));
		
		QnaReplyDao qnaReplyDao = sqlSession.getMapper(QnaReplyDao.class);
		model.addAttribute("qnaReplyCount", qnaReplyDao.qnaReplyCount(qna_no));
		model.addAttribute("qnaReplyDto", qnaReplyDao.qnaReplyView(qna_no));

		
		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
		model.addAttribute("qnaDto", qnaDao.qnaView(qna_no));
		model.addAttribute("page", request.getParameter("page"));
		
		
	}

}