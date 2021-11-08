package com.jihun.bbs.DetailController;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import com.jihun.bbs.Dao.BbsDao;
import com.jihun.bbs.Dao.ReplyDao;
import com.jihun.bbs.Dto.Bbs;
import com.jihun.bbs.Dto.Reply;



@Controller
public class DetailController {
	
	
	private BbsDao dao;
	private ReplyDao dao2;

	@Autowired
	public DetailController(BbsDao dao, ReplyDao dao2) {
		this.dao = dao;
		this.dao2 = dao2;
	}
	
	
	
	@RequestMapping(value="/detail", method = RequestMethod.GET)
	public String detailPage(@RequestParam(value="bbsID", required = true) int bbsID,
			@RequestParam(value="replyPage", required = false, defaultValue = "1") int replyPage,			
			HttpServletRequest request
			) {
		//Sesssion
		request.setAttribute("Session", request.getSession().getAttribute("userid"));
		//Bbs
		Bbs bbs = dao.findBbs(bbsID);
		request.setAttribute("bbsTitle", bbs.getBbsTitle());
		request.setAttribute("userID", bbs.getUserID());
		request.setAttribute("bbsContent", bbs.getBbsContent());
		request.setAttribute("bbsID", bbs.getBbsID());
		request.setAttribute("likes", bbs.getLikeed());
		request.setAttribute("dislikes", bbs.getDislikeed());
		if( bbs.getFile() != null && ! bbs.getFile().isBlank()) request.setAttribute("files", bbs.getFile());
		System.out.println("get file: " + bbs.getFile());
		/*
		 * if( bbs.getFile() != null) { String files = bbs.getFile(); String[] file =
		 * files.split(","); if (!file[1].isBlank()) { request.setAttribute("file2",
		 * file[1]); System.out.println("File 2 : "+ file[1]); }
		 * request.setAttribute("file1", file[0]); System.out.println("File 1 : "+
		 * file[0]); }
		 */
		
		//Reply
		int limit = (replyPage -1) * 4;
		ArrayList<Reply> comments = (ArrayList<Reply>) dao2.getComments(bbsID,limit);
		int total = dao2.count(bbsID, limit);
		request.setAttribute("replyList", comments);
		request.setAttribute("total",total );
		request.setAttribute("replyPage", replyPage);
		int totalPage = 0;
		if (total%4 == 0) {
			totalPage = total/4;
		} else {
			totalPage = total/4 + 1;
		}
		
		dao.viewCount(bbsID);

		request.setAttribute("totalPage", totalPage);
		ArrayList<Integer> buttons = dao2.getReplyButtons(replyPage);
		request.setAttribute("buttons", buttons);
		return "detail";
	}
	
	@RequestMapping(value="/detail", method = RequestMethod.POST)
	public String replyPaging(@RequestParam(value="bbsID", required=true) int bbsID,
			@RequestParam(value="replyPage", required=true) int replyPage,
			HttpServletRequest request
			) {
				//Sesssion
				request.setAttribute("Session", request.getSession().getAttribute("userid"));
				//Bbs
				Bbs bbs = dao.findBbs(bbsID);
				request.setAttribute("bbsTitle", bbs.getBbsTitle());
				request.setAttribute("userID", bbs.getUserID());
				request.setAttribute("bbsContent", bbs.getBbsContent());
				request.setAttribute("bbsID", bbs.getBbsID());
				request.setAttribute("likes", bbs.getLikeed());
				request.setAttribute("dislikes", bbs.getDislikeed());
				if( bbs.getFile() != null &&  ! bbs.getFile().isBlank()) request.setAttribute("files", bbs.getFile());
				System.out.println("get file : " + bbs.getFile());
				
				//Reply
				int limit = (replyPage -1) * 4;
				ArrayList<Reply> comments = (ArrayList<Reply>) dao2.getComments(bbsID,limit);
				int total = dao2.count(bbsID, limit);
				request.setAttribute("replyList", comments);
				request.setAttribute("total",total );

				
		return"detail";
	}
	
	
}
