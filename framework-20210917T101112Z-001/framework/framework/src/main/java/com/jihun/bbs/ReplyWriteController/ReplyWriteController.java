package com.jihun.bbs.ReplyWriteController;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jihun.bbs.Dao.ReplyDao;


@Controller
public class ReplyWriteController {
	
	private ReplyDao dao;
	@Autowired
	public ReplyWriteController(ReplyDao dao) {
		this.dao = dao;
	}
	@RequestMapping(value="/detail/replywrite", method = RequestMethod.POST)
	public String replyWrite(@RequestParam(value="bbsID", required=true)int bbsID,
			@RequestParam(value="replyContent", required=true)String replyContent,
			HttpServletRequest request
			) {
		String userID = (String) request.getSession().getAttribute("userid");
		int replyID = dao.getReplyID();
		int replyAvailable=1;
		Date sampleDate =  new Date();
		String pattern = "yyyy-MM-dd HH:mm:ss";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern);
		String replyDate = formatter.format(sampleDate);
		dao.replyWrite(replyID,bbsID,replyContent,userID,replyDate,replyAvailable);
		return "redirect:/detail?bbsID="+bbsID+"&cc=replywrite";
	}


}
