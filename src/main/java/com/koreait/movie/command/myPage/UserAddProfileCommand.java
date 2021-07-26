package com.koreait.movie.command.myPage;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.movie.common.CommonMapCommand;
import com.koreait.movie.dao.MyDao;
import com.koreait.movie.dao.SignupSigninDao;
import com.koreait.movie.dto.UserDto;

public class UserAddProfileCommand implements CommonMapCommand {

	@Override
	public Map<String, Object> execute(SqlSession sqlSession, Model model) {

		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)map.get("multipartRequest");
		
		MyDao dao = sqlSession.getMapper(MyDao.class);
		SignupSigninDao loginDao = sqlSession.getMapper(SignupSigninDao.class);
		
		HttpSession session = multipartRequest.getSession();
		
		UserDto loginUser = (UserDto)session.getAttribute("loginUser");
		int userNo = loginUser.getUser_no();
		
		MultipartFile file = multipartRequest.getFile("userProfile");
		Map<String, Object> resultMap = null;
		
		String originalFilename = null;
		if(file != null && !file.isEmpty()) {
			originalFilename = file.getOriginalFilename();
			
			

			
			String extension = originalFilename.substring( originalFilename.lastIndexOf(".") + 1 );
			// 파일명 (abcde 구하기)
			String filename = originalFilename.substring( 0, originalFilename.lastIndexOf(".") );
			
			// 업로드 할 파일명 만들기 (abcde_업로드시간.jpg)
			String uploadFilename1 =System.currentTimeMillis() +
					                "." +
					                extension;
			
			String uploadFilename = null;
		try {
				uploadFilename = URLEncoder.encode(uploadFilename1, "UTF-8");
			String realPath = multipartRequest.getServletContext().getRealPath("assets/images/userProfile");
			
			File dir = new File(realPath);
			if ( !dir.exists() ) {
				dir.mkdirs();
			}
			
			File uploadFile = new File(realPath, uploadFilename);
			
			try {
				file.transferTo(uploadFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			resultMap = new HashMap<String, Object>();
			if(dao.userAddProfile(uploadFilename, userNo) > 0) {
				resultMap.put("result", true);
				resultMap.put("filename", uploadFilename);
				session.setAttribute("loginUser",loginDao.loginUser(loginUser));
			}else {
				resultMap.put("result", false);
			}
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
			
			
		}else {
			System.out.println("첨부 에러");
		}
		
		
		return resultMap;
	}

}
