package com.koreait.movie.dao;

import com.koreait.movie.dto.QnaReplyDto;

public interface QnaReplyDao {
	
	public int qnaReplyWrite(QnaReplyDto qnaRepltDto);
	public int qnaReplyCount(int qna_no);
	public QnaReplyDto qnaReplyView(int qna_no);
	public int qnaReplyDelete(int qna_reply_no);
	
}
