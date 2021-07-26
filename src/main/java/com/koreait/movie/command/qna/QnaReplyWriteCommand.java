package com.koreait.movie.command.qna;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.QnaDao;
import com.koreait.movie.dao.QnaReplyDao;
import com.koreait.movie.dto.QnaReplyDto;

public class QnaReplyWriteCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		RedirectAttributes rttr = (RedirectAttributes)map.get("rttr");
		
		// qna_reply 테이블에 삽입하기
		int qna_no = Integer.parseInt(request.getParameter("qna_no"));
		String qna_reply_content = request.getParameter("qna_reply_content");	
		
		QnaReplyDto qnaReplyDto = new QnaReplyDto();
		qnaReplyDto.setQna_no(qna_no);
		qnaReplyDto.setQna_reply_content(qna_reply_content);
		
	    QnaReplyDao qnaReplyDao = sqlSession.getMapper(QnaReplyDao.class);
	    int qnaReplyWriteResult = qnaReplyDao.qnaReplyWrite(qnaReplyDto);
		
		rttr.addFlashAttribute("qnaReplyWriteResult", qnaReplyWriteResult);
		rttr.addFlashAttribute("afterqnaReply", true);
		
		// qna_reply 정보 가져오기
		QnaReplyDto qnaReplyDto2 = qnaReplyDao.qnaReplyView(qna_no);
		rttr.addFlashAttribute("qnaReplyDto", qnaReplyDto2);
		
		// qna 테이블의 qna_yn 업데이트하기
		if (qnaReplyWriteResult > 0) {
			QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
			qnaDao.updateQnaYn(qna_no);
		}
		
		
	}

}