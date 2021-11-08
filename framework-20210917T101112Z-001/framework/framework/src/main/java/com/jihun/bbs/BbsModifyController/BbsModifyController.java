package com.jihun.bbs.BbsModifyController;

import java.io.File;
import java.io.IOException;
import java.net.http.HttpRequest;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jihun.bbs.Dao.BbsDao;
import com.jihun.bbs.Dao.UserDao;

@Controller
public class BbsModifyController {

	private BbsDao dao;
	private UserDao dao2;
	@Autowired
	public BbsModifyController(BbsDao dao, UserDao dao2) {
		this.dao = dao;
		this.dao2 = dao2; 
	}
	
	@RequestMapping(value="/detail/boardupdate", method = RequestMethod.POST)
	public String boardUpdate(@RequestParam(value="bbsTitle", required = true) String bbsTitle,
			@RequestParam(value="bbsContent", required = true) String bbsContent,
			@RequestParam(value="bbsID", required = true) int bbsID,
			 @RequestParam("file") MultipartFile file1,
			@RequestParam("filetwo") MultipartFile file2, HttpServletRequest request,
			@RequestParam(value ="checkbox", required = false) String used,
			@RequestParam(value ="checkbox2", required = false) String delfiles
			) throws IllegalStateException, IOException{
		
		if (used != null ) {
			System.out.println("O---------------- : ");
			String fileName = "";
			dao.upddate(bbsTitle, bbsContent,bbsID, fileName);
		}else if (delfiles != null){
			System.out.println("delfiles : -----------------");
			
			String fileName = "xx";
			dao.upddate(bbsTitle, bbsContent,bbsID, fileName);
				
		}else{
			System.out.println("new : ---------------");
			System.out.println("file 1:" + file1 +"File2: "+ file2);
			String name1="";
			String name2="";
			String realPath = request.getServletContext().getRealPath("/resources");
			String fileName = "";
			if( file1 != null && !file1.isEmpty()) {
			name1 = file1.getOriginalFilename();
			file1.transferTo(new File(realPath,file1.getOriginalFilename()));
			fileName = name1;
			}
			if (file2 != null && !file2.isEmpty()) {
			name2=file2.getOriginalFilename();
			file2.transferTo(new File(realPath,file2.getOriginalFilename()));
			if(! name1.isBlank()) {
			fileName = name1+","+name2;
			}else {
				fileName = name2;
			}
			}
			System.out.println("used: " + used);

			System.out.println("fileName: " + fileName);

			dao.upddate(bbsTitle,bbsContent, bbsID, fileName);
			
			
		}
		System.out.println("used: " + used);
		System.out.println("delfiles: " + delfiles );

		return "redirect:/detail?bbsID="+bbsID+"&cc=update";

	}

	@RequestMapping(value="/detail/boarddelete", method = RequestMethod.POST)
	public String boardDelet(
			@RequestParam(value="bbsID", required = true) int bbsID) {
		dao.delete(bbsID);
		return "redirect:/board?cc=delete";
	}
/*==================================================*/
	@RequestMapping(value="/detail/status", method = RequestMethod.GET)
	public String status(
			HttpServletRequest request,
			@RequestParam (value="status", required = true) String status,
			@RequestParam (value="bbsID", required = true) int bbsID,
			@RequestParam (value="userID", required = true) String userID
			) {
			/*cheeck if status is like or dislike
			 * check if a user alreay liked or disliked
			 * if yes -> redirect
			 * if no -> like+ or dislike-
			 * 
			 * 
			 * */
		String userStatus = status+"ed";
		String avail = dao2.getUserStatus(userStatus,userID,bbsID);
		System.out.println("avail:  "+ avail);
		if (avail == "ok" || avail == "norecord") {
			dao.status(bbsID, userStatus);
			String bbsID2 = String.valueOf(bbsID);
			String result = dao2.existStatus(userStatus, userID, bbsID);
			if (avail == "ok") {
				bbsID2 = result+","+bbsID2;
				System.out.println("bbsID2:  "+ bbsID2);
				dao2.addRecord(userID, bbsID2, userStatus);
			}else {
				dao2.addRecord(userID, bbsID2, userStatus);
			}
			
		}
		System.out.println("avail: " + avail);
		return "redirect:/detail?bbsID="+bbsID;
	}


}
