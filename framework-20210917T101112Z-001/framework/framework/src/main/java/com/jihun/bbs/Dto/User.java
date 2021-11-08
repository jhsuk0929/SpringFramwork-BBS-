package com.jihun.bbs.Dto;


public class  User {

		private String userID;
		private String userPassword;
		private String userName;
		private String userGender;
		private String userEmail;
		private String likeed;
		private String dislikeed;
		
		public User() {
			
		}
		
		
		public User(String userID, String userPassword, String userName, String userGender, String userEmail,
				String likeed, String dislikeed) {
			super();
			this.userID = userID;
			this.userPassword = userPassword;
			this.userName = userName;
			this.userGender = userGender;
			this.userEmail = userEmail;
			this.likeed = likeed;
			this.dislikeed = dislikeed;
		}

		public String getLikeed() {
			return likeed;
		}

		public void setLikeed(String likeed) {
			this.likeed = likeed;
		}

		public String getDislikeed() {
			return dislikeed;
		}

		public void setDislikeed(String dislikeed) {
			this.dislikeed = dislikeed;
		}

		public String getUserID() {
			return userID;
		}
		public void setUserID(String userID) {
			this.userID = userID;
		}
		public String getUserPassword() {
			return userPassword;
		}
		public void setUserPassword(String userPassword) {
			this.userPassword = userPassword;
		}
		public String getUserName() {
			return userName;
		}
		public void setUserName(String userName) {
			this.userName = userName;
		}
		public String getUserGender() {
			return userGender;
		}
		public void setUserGender(String userGender) {
			this.userGender = userGender;
		}
		public String getUserEmail() {
			return userEmail;
		}
		public void setUserEmail(String userEmail) {
			this.userEmail = userEmail;
		}

		@Override
		public String toString() {
			return "User [userID=" + userID + ", userPassword=" + userPassword + ", userName=" + userName + ", userGender="
					+ userGender + ", userEmail=" + userEmail + "]";
		}
		
		

	}