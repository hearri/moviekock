package com.koreait.movie.command.signupSignin;

import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.dao.SignupSigninDao;
import com.koreait.movie.dto.UserDto;

public class SignupSigninFindIdCommand implements CommonVoidCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		try {
			
			Map<String, Object> map = model.asMap();
			
			HttpServletRequest request = (HttpServletRequest)map.get("request");  // request에 들어 있는 findIdName, findIdEmail를 꺼내야 합니다.
			JavaMailSender mailSender = (JavaMailSender)map.get("mailSender");
			
			// 컨트롤러에서는 model.addAttribute("name", name)을 한 적이 없습니다.
			// 컨트롤러에서는 model.addAttribute("email", email)을 한 적이 없습니다.
			// String user_name = (String)map.get("name");  // 들어 있지 않음
			// String user_email = (String)map.get("email");  // 들어 있지 않음
	
			
			String user_name = request.getParameter("user_name");
			String user_email = request.getParameter("user_email");
			
			
			UserDto userDto = new UserDto();
			userDto.setUser_name(user_name);
			userDto.setUser_email(user_email);
			
			SignupSigninDao dao = sqlSession.getMapper(SignupSigninDao.class);
			
			// UserDto findIdEmail = dao.findIdEmail(userDto);  // 이름과 아이디가 일치하는 회원이 findIdEmail이라면 findIdEmail이 있는지 없는지 체크하는 부분이 필요하겠죠.
			
			UserDto findIdEmail = null;
			findIdEmail = dao.findId(userDto);
			
			if (findIdEmail != null) {
				
				// MimeMessage 클래스가 이메일의 내용을 작성합니다.
				MimeMessage message = mailSender.createMimeMessage();
				message.setHeader("Content-Type", "text/plain; charset=utf-8");
				message.setFrom(new InternetAddress("moviekock@gmail.com", "무비콕"));  // 보내는 사람
				InternetAddress to = new InternetAddress(request.getParameter("user_email"));  // 받는 사람
				InternetAddress[] toList = {to};  // 받는 사람을 배열에 저장해 두면 여러 곳에 한 번에 보낼 수도 있습니다.
				message.setRecipients(Message.RecipientType.TO, toList);
				message.setSubject("무비콕 요청하신 아이디 찾기 입니다.");  // 제목
				message.setText("아이디 : " + findIdEmail.getUser_id());  // 본문  - 아이디는 findIdEmail.getId() 같은 걸로 빼면 되겠습니다.
				
				mailSender.send(message);  // 메일을 보냅니다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
