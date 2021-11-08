package com.jihun.bbs.JoinController;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jihun.bbs.Dao.UserDao;
import com.jihun.bbs.Dto.User;

@Controller
public class JoinController {
	private UserDao dao;

	@Autowired
	public JoinController(UserDao dao) {
		this.dao = dao;
	}

	@RequestMapping(value="/join", method = RequestMethod.GET)
	public String Join() {
		
		return "join";
	}
	
	
	
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String userJoin(@RequestParam(value="userid", required=true) String userID,
			@RequestParam(value="userpassword", required=true) String userPassword,
			@RequestParam(value="name", required=true) String userName,
			@RequestParam(value="gender", required=true) String userGender,
			@RequestParam(value="email", required=true) String userEmail,
			HttpServletRequest request/* , @ModelAttribute("user") User user, BindingResult result */
			) { //@modelattribute => 파라미터 타입의 오브젝트 자동생성, 생성된 오브젝트 자동으로 바인딩(HTTP ex) /bbs?bbsId=x),자동으로 model객체에 추가 및 뷰로 전달
		String page = null;
		int resulting = dao.checkDup(userID, userPassword, userName, userGender, userEmail);
		if(resulting == 0) {
			dao.addUser(userID, userPassword, userName, userGender, userEmail);
			page = "login";
		} else {
			String joinfail = "no";
			request.setAttribute("joinfail", joinfail);
			page="join";
		}
		 		return page;
	}
	
}
