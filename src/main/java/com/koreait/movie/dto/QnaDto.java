package com.koreait.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class QnaDto {
	
	private int qna_no;
	private int qna_secret;
	private String qna_select;
	private int user_no;
	private String qna_title;
	private String qna_content;
	private String qna_pw;
	private Date qna_date;
	private int qna_yn;
	
	private String user_nickname;
	
}