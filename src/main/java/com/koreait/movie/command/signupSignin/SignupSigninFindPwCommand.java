package com.koreait.movie.command.signupSignin;

import java.util.Map;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.Model;

import com.koreait.movie.common.CommonVoidCommand;
import com.koreait.movie.common.Sha256;
import com.koreait.movie.dao.SignupSigninDao;
import com.koreait.movie.dto.UserDto;

public class SignupSigninFindPwCommand implements CommonVoidCommand {

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
			int randomPw = ( (int)(Math.random() * 900000) + 100000);
			
			String temporaryPw = Sha256.sha256( String.valueOf( randomPw ) );
	
			
			String user_name = request.getParameter("user_name");
			String user_email = request.getParameter("user_email");
			String user_id = request.getParameter("user_id");
			
			
			UserDto userDto = new UserDto();
			userDto.setUser_name(user_name);
			userDto.setUser_email(user_email);
			userDto.setUser_id(user_id);
			
			SignupSigninDao dao = sqlSession.getMapper(SignupSigninDao.class);
			
			// UserDto findIdEmail = dao.findIdEmail(userDto);  // 이름과 아이디가 일치하는 회원이 findIdEmail이라면 findIdEmail이 있는지 없는지 체크하는 부분이 필요하겠죠.
			
			UserDto findPwEmail = null;
			findPwEmail = dao.findPw(userDto);
			
			dao.updatePw(temporaryPw, user_id);
			
			if (findPwEmail != null) {
				
				// MimeMessage 클래스가 이메일의 내용을 작성합니다.
				MimeMessage message = mailSender.createMimeMessage();
				message.setHeader("Content-Type", "text/plain; charset=utf-8");
				
				// MimeMessageHelper 클래스를 이용하는 방법도 있습니다.
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8"); 
				helper.setFrom(new InternetAddress("moviekock@gmail.com", "무비콕"));  // 보내는 사람
				helper.setTo(request.getParameter("user_email"));  // 받는 사람
				helper.setSubject("무비콕 요청하신 비밀번호 찾기 입니다.");  // 제목
				
				helper.setText("<html><head>\r\n" + 
						"    <meta charset=\"UTF-8\">\r\n" + 
						"    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n" + 
						"    <title>비밀번호 재설정</title>\r\n" + 
						"</head>\r\n" + 
						"\r\n" + 
						"<body>\r\n" + 
						"<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" \r\n" + 
						"style=\"\r\n" + 
						"margin: 0 auto;\r\n" + 
						"padding-top: 20px;\r\n" + 
						"width: 100%;\r\n" + 
						"color: #434245;\r\n" + 
						"font-family: '맑은 고딕', 'Malgun Gothic', sans-serif\">\r\n" + 
						"  <tbody>\r\n" + 
						"    <tr>\r\n" + 
						"      <td valign=\"top\" style=\"\r\n" + 
						"      display: block;\r\n" + 
						"      margin: 0 auto;\r\n" + 
						"      width: 100%;\r\n" + 
						"      max-width: 600px;\">\r\n" + 
						"        <div style=\"\r\n" + 
						"        display: block;\r\n" + 
						"        padding: 30px 0 40px;\r\n" + 
						"        box-sizing: border-box;\r\n" + 
						"        background-color: #F6F6F6;\">\r\n" + 
						"          <table style=\"\r\n" + 
						"          width: 100%;\r\n" + 
						"          color: #363a3c;\"\r\n" + 
						"          border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n" + 
						"            <tbody>\r\n" + 
						"              <tr>\r\n" + 
						"                <td style=\"box-sizing:border-box\">\r\n" + 
						"                  <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n" + 
						"                    <tbody>\r\n" + 
						"                      <tr>\r\n" + 
						"                        <td>\r\n" + 
						"                           <h2 style=\"\r\n" + 
						"                          font-size: 25px;\r\n" + 
						"                          font-weight: bold;\r\n" + 
						"                          padding-right:40px;\r\n" + 
						"                          padding-left:40px;\r\n" + 
						"                          line-height: 1.3;\"> (로고)MovieKcock<br></h2>\r\n" + 
						"                            <!-- 로고 넣으려면 img 태그 추가용-->\r\n" + 
						"                          <h1 style=\"\r\n" + 
						"                          font-size:30px;\r\n" + 
						"                          font-weight: bold;\r\n" + 
						"                          padding-right:40px;\r\n" + 
						"                          padding-left:40px;\r\n" + 
						"                          line-height: 1.3;\">\r\n" + 
						"                        비밀번호를 변경해주세요</h1>\r\n" + 
						"                                                    \r\n" + 
						"                          <p style=\"\r\n" + 
						"                          padding-left: 40px;\r\n" + 
						"                          padding-right: 40px;\r\n" + 
						"                          font-size: 18px;\r\n" + 
						"                          line-height: 1.5;\r\n" + 
						"                          margin-bottom: 30px;\">\r\n" + 
						"                            안녕하세요, "+ request.getParameter(user_name) +"님.<br>\r\n" + 
						"                            " + request.getParameter(user_email) +" 비밀번호 재설정을 위해 아래 버튼을 클릭해주세요.<br>\r\n" + 
						"                            <br>\r\n" + 
						"                            가입한 적이 없거나 비밀번호 찾기를 요청하지 않으신 경우,<br>\r\n" + 
						"                            이 메일을 삭제 또는 무시해 주세요.<br>\r\n" + 
						"                            기타 궁금하신 문의사항은,<br>\r\n" + 
						"                            <a href=\"\">moviekock@gmail.com</a>으로 문의해 주시기 바랍니다.<br>\r\n" + 
						"                          </p>\r\n" + 
						"                          <p style=\"\r\n" + 
						"                          padding-left: 200px;\r\n" + 
						"                          font-size: 18px;\r\n" + 
						"                          line-height: 1.5;\r\n" + 
						"                          margin-bottom: 30px;\">\r\n" + 
						"                            <a style=\"color: #f8fafb;\r\n" + 
						"                            border-color: #fff;\r\n" + 
						"                            background-color: #64a2bb;\r\n" + 
						"                            padding: 16px 32px;\r\n" + 
						"                            border-radius: 4px;\r\n" + 
						"                            text-decoration: none;\">\r\n" + 
						"                              임시비밀번호 : " + randomPw + "\r\n" + 
						"                            </a>\r\n" + 
						"                          </p>\r\n" + 
						"                          <p style=\"\r\n" + 
						"                          padding-left: 40px;\r\n" + 
						"                          padding-right: 40px;\r\n" + 
						"                          margin-bottom: 60px;\r\n" + 
						"                          font-size: 18px;\r\n" + 
						"                          line-height: 1.5;\">\r\n" + 
						"                            감사합니다.<br>\r\n" + 
						"                            Time to wait, moment to expect.<br>\r\n" + 
						"                            MovieKock 드림\r\n" + 
						"                          </p>\r\n" + 
						"                            \r\n" + 
						"                             <!-- 없어도 되는 부분, 쓰려면 링크 주소 넣어주세여-->\r\n" + 
						"                          <div style=\"margin-left: 40px;\r\n" + 
						"                          margin-right: 40px; border-top: 1px solid #ced3d6;\"></div>\r\n" + 
						"                          <div style=\"padding-top: 20px; padding-left: 40px;\r\n" + 
						"                          padding-right: 40px;\r\n" + 
						"                          font-size: 14px; color: #878d91; text-align: center; line-height: 1.5;\">\r\n" + 
						"                            <a href=\"http://meetgo.kr/\" style=\"padding:0 4px; color: #878d91;\">Website</a>  © moviekock, koreaitacademy 2021\r\n" + 
						"                          </div>\r\n" + 
						"                        </td>\r\n" + 
						"                      </tr>\r\n" + 
						"                    </tbody>\r\n" + 
						"                  </table>\r\n" + 
						"                </td>\r\n" + 
						"              </tr>\r\n" + 
						"            </tbody>\r\n" + 
						"          </table>\r\n" + 
						"        </div>\r\n" + 
						"      </td>\r\n" + 
						"    </tr>\r\n" + 
						"  </tbody>\r\n" + 
						"</table>\r\n" + 
						"    </body></html>", true);
				mailSender.send(message);  // 메일을 보냅니다.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
