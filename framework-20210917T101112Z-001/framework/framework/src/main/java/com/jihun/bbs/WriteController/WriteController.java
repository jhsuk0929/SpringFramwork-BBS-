package com.jihun.bbs.WriteController;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.jihun.bbs.Dao.BbsDao;

@Controller
public class WriteController {
	
	private BbsDao dao;
	@Autowired
	public WriteController(BbsDao dao) {
		this.dao = dao;
	}


	@RequestMapping(value="/write",method = RequestMethod.GET)
	public String writePage(HttpServletRequest request) {

		return "write";
	}
	
	
	@RequestMapping(value="/write/new", method = RequestMethod.POST )
	public String write(@RequestParam(value="userID", required=true) String userID,
			@RequestParam(value="bbsTitle", required=true) String bbsTitle,
			@RequestParam(value="bbsContent", required=true) String bbsContent,
			HttpServletRequest request, @RequestParam("mediaFile1") MultipartFile file1,
			@RequestParam("mediaFile2") MultipartFile file2
			) throws IOException, ServletException{
		
		
		String name1="";
		String name2="";
		
		int bbsID = dao.getBbsID();
		
		Date sampleDate =  new Date();
		String pattern = "yyyy-MM-dd HH:mm:ss";
		SimpleDateFormat formatter = new SimpleDateFormat(pattern);
		String bbsDate = formatter.format(sampleDate);
		
		
		ArrayList<MultipartFile> parts = new ArrayList <MultipartFile>(); 

		int bbsAvailable=1;
		//System.out.println("parts : "+request.getParts());
		//System.out.println("parts 1: "+parts.toString());
		//System.out.println("parts 2: "+parts.size());

		String realPath = request.getServletContext().getRealPath("/resources");
		String fileName = "";
		if( file1 != null && !file1.isEmpty()) {
		parts.add(file1);
		name1 = file1.getOriginalFilename();
		file1.transferTo(new File(realPath,file1.getOriginalFilename()));
		fileName = name1;
		}
		if (file2 != null && !file2.isEmpty()) {
		parts.add(file2);
		name2=file2.getOriginalFilename();
		file2.transferTo(new File(realPath,file2.getOriginalFilename()));
		
		if(! name1.isBlank()) {
		fileName = name1+","+name2;
		}else {
			fileName = name2;
		}
		}

		
		

		System.out.println("real path :" + realPath);
		System.out.println("fileName: " + fileName);
		
		int result = dao.write(bbsID, bbsTitle, userID, bbsDate, bbsContent, bbsAvailable,fileName);
		String cc = null;
		if (result == 1 ) {
			cc="yes";
			System.out.println(cc);
		}
		return "redirect:/board?cc=yes";
	}
}
