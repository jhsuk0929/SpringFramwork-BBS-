package com.jihun.bbs.Dao;

import java.util.List;

import com.jihun.bbs.Dto.User;

public interface UserTestDao {

	public List<User> list();
	
	public User Login (String userID, String userPassword);
	
	public int checkDup(String userID, String userPassword, String userName, String userEmail);
	
	public int addUser(String userID, String userPassword, String userName, String userGender, String userEmail);
	
}
