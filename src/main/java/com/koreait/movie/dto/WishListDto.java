package com.koreait.movie.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WishListDto {
	
	private int wishList_no;
	private int user_no;
	private int movie_no;
}
