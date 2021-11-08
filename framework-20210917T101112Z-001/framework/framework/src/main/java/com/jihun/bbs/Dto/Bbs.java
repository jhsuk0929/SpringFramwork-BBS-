package com.jihun.bbs.Dto;

import java.util.Date;


public class Bbs {
	private int bbsID;
	private String bbsTitle;
	private String userID;
	private Date bbsDate;
	private String bbsContent;
	private int bbsAvailable;
	private String file;
	private int view;
	private int likeed;
	private int dislikeed;
	public Bbs() {
		
	}
	

	
	public Bbs(int bbsID, String bbsTitle, String userID, Date bbsDate, String bbsContent, int bbsAvailable,
			String file, int view, int likeed, int dislikeed) {
		super();
		this.bbsID = bbsID;
		this.bbsTitle = bbsTitle;
		this.userID = userID;
		this.bbsDate = bbsDate;
		this.bbsContent = bbsContent;
		this.bbsAvailable = bbsAvailable;
		this.file = file;
		this.view = view;
		this.likeed = likeed;
		this.dislikeed = dislikeed;
	}



	public int getLikeed() {
		return likeed;
	}

	public void setLikeed(int likeed) {
		this.likeed = likeed;
	}

	public int getDislikeed() {
		return dislikeed;
	}

	public void setDislikeed(int dislikeed) {
		this.dislikeed = dislikeed;
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}

	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public Date getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(Date bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
	@Override
	public String toString() {
		return "Bbs [bbsID=" + bbsID + ", bbsTitle=" + bbsTitle + ", userID=" + userID + ", bbsDate=" + bbsDate
				+ ", bbsContent=" + bbsContent + ", bbsAvailable=" + bbsAvailable + "]";
	}
	
}