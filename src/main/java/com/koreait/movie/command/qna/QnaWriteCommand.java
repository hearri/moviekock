package com.koreait.movie.command.qna;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.QnaDao;
import com.koreait.movie.dto.QnaDto;
import com.koreait.movie.dto.UserDto;

public class QnaWriteCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		RedirectAttributes rttr = (RedirectAttributes)map.get("rttr");
		
		String qna_select = request.getParameter("qna_select");
		String qna_title = request.getParameter("qna_title");
		String qna_content = request.getParameter("qna_content");
		int qna_secret = 0;
		if (request.getParameter("qna_secret") != null && !request.getParameter("qna_secret").isEmpty()) {
			qna_secret = 1;
		}
		String qna_pw = request.getParameter("qna_pw");
		
		HttpSession session = request.getSession();
		UserDto loginUser = (UserDto)session.getAttribute("loginUser");
		int user_no = loginUser.getUser_no();
		
		QnaDto qnaDto = new QnaDto();
		qnaDto.setUser_no(user_no);
		qnaDto.setQna_select(qna_select);
		qnaDto.setQna_title(qna_title);
		qnaDto.setQna_content(qna_content);
		qnaDto.setQna_secret(qna_secret);
		qnaDto.setQna_pw(qna_pw);
		
	    QnaDao qnaDao = sqlSession.getMapper(QnaDao.class);
		int qnaWriteResult = qnaDao.qnaWrite(qnaDto);
		
		rttr.addFlashAttribute("qnaWriteResult", qnaWriteResult);
		
		// insert 후에 이동되었음을 JSP에게 알려주겠습니다.
		rttr.addFlashAttribute("afterqnaWrite", true);
		
	}

}
