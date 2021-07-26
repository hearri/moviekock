package com.koreait.movie.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserDto {
	
	private int user_no;
	private String user_id;
	private String user_pw;
	private String user_nickname;
	private String user_name;
	private String user_email;
	private String user_phone;
	private Date user_date;
	private String user_image_name;
	private String user_profile_name;
	
	private String genre;
	
}
