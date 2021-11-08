package com.jihun.bbs.AccountSettingController;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jihun.bbs.Dao.UserDao;
import com.jihun.bbs.Dto.User;

@Controller
public class AccountSettingController {
	
	private UserDao dao;
	@Autowired
	public AccountSettingController (UserDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping(value = "/account", method = RequestMethod.GET)
	public String settingPage(HttpServletRequest request) {
		String userID = (String) request.getSession().getAttribute("userid");
		System.out.println("Account Controller UserID" + userID);
		if(request.getSession().getAttribute("userid") != null) {
			String how = "잘못된 접근입니다";
			request.setAttribute("how", how);
		}
		return "accountSetting";
	}
	
	@RequestMapping(value = "/accountInfo", method = RequestMethod.GET)
	public String accountInfo(HttpServletRequest request) {
		String userID = (String) request.getSession().getAttribute("userid");
		if(userID.isBlank() || userID == null) {
			String how = "잘못된 접근입니다";
			request.setAttribute("how", how);
		}
		
		User info = dao.getAccount(userID);
		String userName = info.getUserName();
		String ID = info.getUserID();
		String userEmail = info.getUserEmail();
		request.setAttribute("userName", userName);
		request.setAttribute("ID", ID);
		request.setAttribute("userEmail", userEmail);
		return "accountInfo";
	}
	
	@RequestMapping(value = "/changePassword", method = RequestMethod.GET)
	public String changePassword(HttpServletRequest request) {
		String userID = (String) request.getSession().getAttribute("userid");
		if(userID.isBlank() || userID == null) {
			String how = "잘못된 접근입니다";
			request.setAttribute("how", how);
		}
		User info = dao.getAccount(userID);
		String now = info.getUserPassword();
		request.setAttribute("now", now);
		return "changePassword";
	}
	
	@RequestMapping(value = "/editPassword", method = RequestMethod.POST)
	public String changingPassword(HttpServletRequest request,
			@RequestParam(value = "changed", required = true) String changed
			) {
		String userID = (String) request.getSession().getAttribute("userid");
		if(userID.isBlank() || userID == null) {
			String how = "잘못된 접근입니다";
			request.setAttribute("how", how);
		}
		
		dao.changePassworrd(userID, changed);
		String result = "o";
		request.setAttribute("result", result);
		return "accountSetting";
	}
	
	@RequestMapping(value = "/deleteAccount", method = RequestMethod.GET)
	public String deleteAccount(HttpServletRequest request) {
		String userID = (String) request.getSession().getAttribute("userid");
		if(userID.isBlank() || userID == null) {
			String how = "잘못된 접근입니다";
			request.setAttribute("how", how);
		}
		User info = dao.getAccount(userID);
		request.setAttribute("userID", info.getUserID());
		request.setAttribute("userPassword", info.getUserPassword());
		request.setAttribute("userEmail", info.getUserEmail());
		return "deleteAccount";
	}
	
	@RequestMapping(value = "/deleteAccount", method = RequestMethod.POST)
	public String byebye(HttpServletRequest request,
			@RequestParam(value = "userID", required = true) String userID,
			@RequestParam(value = "userPassword", required = true) String userPassword,
			@RequestParam(value = "userEmail", required = true) String userEmail
			
			) {
		
		
		String suserID = (String) request.getSession().getAttribute("userid");
		if(suserID.isBlank() || suserID == null) {
			String how = "잘못된 접근입니다";
			request.setAttribute("how", how);
		}
												/**/
		dao.deleteAccount(userID, userPassword, userEmail);
		String delete = "o";
		request.setAttribute("delete", delete);
		request.getSession().removeAttribute("userid");
		request.getSession().invalidate();
		return "home";
	}
	
	

	
	

}
