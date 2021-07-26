package com.koreait.movie.command.qna;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.QnaDao;
import com.koreait.movie.dao.QnaReplyDao;

public class QnaDeleteCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		RedirectAttributes rttr = (RedirectAttributes)map.get("rttr");
		
		
		int qna_no = Integer.parseInt(request.getParameter("qna_no"));  // 원글 번호

		String str_qna_reply_no = request.getParameter("qna_reply_no");
		int qna_reply_no;
		int qnaReplyDeleteResult = 0;
		if ( str_qna_reply_no != null && !str_qna_reply_no.isEmpty() ) {
			qna_reply_no = Integer.parseInt(str_qna_reply_no);  // 댓글 번호
			QnaReplyDao qnaReplyDao = sqlSession.getMapper(QnaReplyDao.class);
			if(qnaReplyDao.qnaReplyCount(qna_no) > 0) {  // 원글에 달린 댓글의 갯수
				qnaReplyDeleteResult = qnaReplyDao.qnaReplyDelete(qna_reply_no);  // 댓글 지우기
			}
		}
		
		QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
		int qnaDeleteResult = qnaDao.qnaDelete(qna_no);  // 원글 지우기
		
		/*
		if (QnaReplyDao = 0) {
			QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
			int qnaDeleteResult = qnaDao.qnaDelete(qna_no);
		}
		*/
		
		
		rttr.addFlashAttribute("qnaReplyDeleteResult", qnaReplyDeleteResult);
		rttr.addFlashAttribute("qnaDeleteResult", qnaDeleteResult);
		
		// insert 후에 이동되었음을 JSP에게 알려주겠습니다.
		rttr.addFlashAttribute("afterqnaDelete", true);
		
	}
}
