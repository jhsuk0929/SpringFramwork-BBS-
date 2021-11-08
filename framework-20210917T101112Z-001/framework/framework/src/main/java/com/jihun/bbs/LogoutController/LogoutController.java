package com.jihun.bbs.LogoutController;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
@Controller
public class LogoutController {
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		request.getSession().removeAttribute("userid");
		request.getSession().invalidate();
		return "home";
		
	}
}
