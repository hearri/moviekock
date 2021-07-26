package com.koreait.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class QnaReplyDto {
	
	private int qna_reply_no; 
	private int qna_no;
	private String qna_reply_content;
	private Date qna_reply_date;

}
