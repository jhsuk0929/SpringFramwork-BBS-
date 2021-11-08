package com.jihun.bbs.BbsController;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jihun.bbs.HomeController;
import com.jihun.bbs.Dao.BbsDao;
import com.jihun.bbs.Dto.Bbs;

@Controller
public class BbsController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	private BbsDao dao;
	@Autowired
	public BbsController(BbsDao dao) {
		this.dao = dao;
	}
	/*autowired 3가지 방식
	1.field injection ex) @Autowired BbsDao dao;
	2.setter based injection ex)
	public void setBbsDao(BbsDao bbsDao) {
	this.dao = bbsDao;
	}
	1,2 ->런타임에서 의존성을 주입하기 때문에 의존성을 주입하지 않아도 객체생성가능
	3.constructor based injection ->객체가 생성되는 시점에 빈을 주입: nullpointerexception 방지
	*/
	private ArrayList <Bbs> list = new ArrayList<Bbs>();
	private ArrayList <Integer> header = new ArrayList<Integer>();
	private ArrayList <Integer> paging = new ArrayList<Integer>();
	private int totalPage = 0;


	@RequestMapping(value="/board", method = RequestMethod.GET)
	public String Board(@RequestParam (value="searchWord", required=false, defaultValue="") String searchWord,
			@RequestParam (value="pageNumber", required=false, defaultValue= "1") int pageNumber,
			@RequestParam (value="filterBy", required=false, defaultValue="") String filterBy,
			@RequestParam (value="sortType", required=false, defaultValue="DESC") String sortType,
			@RequestParam (value="cc", required = false) String cc,
			HttpServletRequest request) {
		
		list = (ArrayList<Bbs>) dao.getList(pageNumber, filterBy, searchWord, sortType);
		header=dao.getheader(pageNumber);
		paging=dao.buttonPaging(pageNumber);
		totalPage=dao.count(pageNumber, filterBy, searchWord, sortType);
		if(! list.isEmpty()) {
			request.setAttribute("list",list);
			request.setAttribute("header", header);
			request.setAttribute("paging", paging);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("pageNumber", pageNumber);
			request.setAttribute("searchWord", searchWord);
			request.setAttribute("filterBy", filterBy);
			request.setAttribute("sortType", sortType);
			/* @RequestParam-> best for reading a small number of parameters
			 * @ModelAttribute -> best for reading a form with a large number of fields, data binding
			 * */
			if (request.getSession().getAttribute("userid") !=null) {
				request.setAttribute("Session", request.getSession().getAttribute("userid").toString());
			}
		} else {
			String nosuch = "x";
			request.setAttribute("nosuch",nosuch);
		}
		logger.info("trace log={}", list);

		request.setAttribute("cc",cc);
		return "board";
	}

	@RequestMapping(value="/board", method = RequestMethod.POST)
	public String advanceBoard(@RequestParam (value="searchWord", required=false, defaultValue ="") String searchWord,
			@RequestParam (value="pageNumber", required=true) int pageNumber,
			@RequestParam (value="sorts") String sorts,
			@RequestParam (value="filterBy", required=false, defaultValue ="") String filterBy,
			@RequestParam (value="sortType", required=false) String sortType,
			@RequestParam (value="cc", required = false) String cc,
			HttpServletRequest request			
			) {

		if(sorts != null) {
			String[] words = sorts.split(",");
			filterBy = words[0];
			sortType =words[1];
		}
		
		list = (ArrayList<Bbs>) dao.getList(pageNumber, filterBy, searchWord, sortType);
		header=dao.getheader(pageNumber);
		paging=dao.buttonPaging(pageNumber);
		totalPage=dao.count(pageNumber, filterBy, searchWord, sortType);
		if(! list.isEmpty()) {
			request.setAttribute("list", list);
			request.setAttribute("header", header);
			request.setAttribute("paging", paging);
			request.setAttribute("totalPage", totalPage);
			request.setAttribute("pageNumber", pageNumber);
			request.setAttribute("searchWord", searchWord);
			request.setAttribute("filterBy", filterBy);
			request.setAttribute("sortType", sortType);
			
			logger.info("trace log={}", list);

			
		} else {
			String nosuch = "x";
			request.setAttribute("nosuch",nosuch);
		}
		request.setAttribute("cc",cc);

		return "/board";
	}




}
