package com.jihun.bbs.ReplyModifyController;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jihun.bbs.Dao.ReplyDao;

@Controller
public class ReplyModifyController {
	
	
	ReplyDao dao;
	@Autowired
	private ReplyModifyController (ReplyDao dao) {
		this.dao = dao;
	}
	
	
	@RequestMapping(value="/detail/replyupdate",method = RequestMethod.POST)
	public String replyUpdate(@RequestParam(value="replyID", required=true) int replyID,
			@RequestParam(value="bbsID", required=true) int bbsID,
			@RequestParam(value="updateContent", required=true) String updateContent
			) {
		dao.update(replyID, bbsID,updateContent);
		return "redirect:/detail?bbsID="+bbsID+"&cc=replyupdate";
	}

	@RequestMapping(value="/detail/replydelete", method = RequestMethod.POST)
	public String replyDelete(@RequestParam(value="replyID", required=true) int replyID,
			@RequestParam(value="bbsID", required=true) int bbsID
			){
		dao.delete(replyID,bbsID);
		return "redirect:/detail?bbsID="+bbsID+"&cc=replydelete";
	}

		









}
