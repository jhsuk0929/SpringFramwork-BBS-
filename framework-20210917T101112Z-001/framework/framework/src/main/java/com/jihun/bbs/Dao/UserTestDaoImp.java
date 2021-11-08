package com.jihun.bbs.Dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.jihun.bbs.Dto.User;

@Repository
public class UserTestDaoImp implements UserTestDao {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<User> list() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("User.list");
	}

	@Override
	public User Login(String userID, String userPassword) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int checkDup(String userID, String userPassword, String userName, String userEmail) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int addUser(String userID, String userPassword, String userName, String userGender, String userEmail) {
		// TODO Auto-generated method stub
		return 0;
	}

}
