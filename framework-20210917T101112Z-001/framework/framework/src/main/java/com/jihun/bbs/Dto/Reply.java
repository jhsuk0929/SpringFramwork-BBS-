package com.jihun.bbs.Dto;

import java.util.Date;

public class Reply {
	private int replyID;
	private int bbsID;
	private String replyContent;
	private String userID;
	private Date replyDate;
	private int replyAvailable;
	
	public Reply() {
		
	}
	
	public Reply(int replyID, int bbsID, String replyContent, String userID, Date replyDate, int replyAvailable) {
		super();
		this.replyID = replyID;
		this.bbsID = bbsID;
		this.replyContent = replyContent;
		this.userID = userID;
		this.replyDate = replyDate;
		this.replyAvailable = replyAvailable;
	}
	public int getReplyID() {
		return replyID;
	}
	public void setReplyID(int replyID) {
		this.replyID = replyID;
	}
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public Date getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}
	public int getReplyAvailable() {
		return replyAvailable;
	}
	public void setReplyAvailable(int replyAvailable) {
		this.replyAvailable = replyAvailable;
	}

	@Override
	public String toString() {
		return "Reply [replyID=" + replyID + ", bbsID=" + bbsID + ", replyContent=" + replyContent + ", userID="
				+ userID + ", replyDate=" + replyDate + ", replyAvailable=" + replyAvailable + "]";
	}
	
	
	
}
