package com.jihun.bbs.LoginController;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jihun.bbs.Dao.UserDao;
import com.jihun.bbs.Dao.UserTestDao;
import com.jihun.bbs.Dto.User;


@Controller
public class LoginController {
	
	/*
	 * @Inject UserTestDao testdao;
	 */
	private UserDao dao;

	@Autowired
	public LoginController(UserDao dao) {
		this.dao = dao;
	}


	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String Login(HttpServletRequest request){
		String fail = "notnull";
		request.setAttribute("fail", fail);
		
		return "login";	
	}
	
	
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String Verify(HttpServletRequest request, @RequestParam (value="userID", required=true) String userID,
			@RequestParam(value="userPassword", required=true) String userPassword
			){
		
		
	if(dao.Login(userID, userPassword) != null) {
		
		HttpSession session = request.getSession(); 
		session.setAttribute("userid", userID); 
			
		System.out.println("ID: " + userID);
		System.out.println("Password: " + userPassword);
	} else {
		String fail = "x";
		request.setAttribute("fail", fail);
		return "login";
	}
	
	return "home";	

	}
	
	
	
}
