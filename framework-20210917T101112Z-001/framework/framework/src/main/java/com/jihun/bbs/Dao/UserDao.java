package com.jihun.bbs.Dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.jihun.bbs.Dto.Bbs;
import com.jihun.bbs.Dto.User;
import com.mchange.v2.c3p0.DriverManagerDataSource;

@Repository
public class UserDao {
	
	
		@Inject
		private SqlSession sqlSession;
		private Map<String,Object>parms = new HashMap<String, Object>(); //parameter를 하나이상 써야할 떄 map에 담음
		int result = 0;

	
		/*
		 * private String driver="com.mysql.cj.jdbc.Driver"; private String
		 * url="jdbc:mysql://localhost:3306/BBS"; private String userid="root"; private
		 * String userpw="1234";
		 * 
		 * private DriverManagerDataSource dataSource; private JdbcTemplate template;
		 */
		
		/*
		private Connection conn = null;
		private PreparedStatement pstmt = null;
		private ResultSet rs = null;
		*/
		/*
		 * public UserDao() { dataSource = new DriverManagerDataSource();
		 * dataSource.setDriverClass(driver); dataSource.setJdbcUrl(url);
		 * dataSource.setUser(userid); dataSource.setPassword(userpw);
		 * 
		 * template = new JdbcTemplate(); template.setDataSource(dataSource);
		 * 
		 * }
		 */
		public User Login(String userID, String userPassword) {
			parms.put("userID", userID);
			parms.put("userPassword", userPassword);
			return sqlSession.selectOne("User.Login",parms);
		}
		
		
		/*
		 * public int Login2(String userID, String userPassword) {
		 * 
		 * int result = 0; String sql =
		 * "select count(*) from user where userID = '"+userID+"' and userPassword= '"
		 * +userPassword+"'"; result = template.queryForInt(sql);
		 * System.out.println(result);
		 */
			/*
			try {
				Class.forName(driver);
				conn = DriverManager.getConnection(url,userid,userpw);
				String sql = "select count(*) from user where userID = "+userID+" and userPassword= "+userPassword;
				pstmt = conn.prepareStatement(sql);
				result = pstmt.executeUpdate();
			} catch(ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
				}catch (SQLException e ) {
					e.printStackTrace();
				}
			}*/
			/*
			 * return result; }
			 */
		
		public int addUser(String userID, String userPassword, String userName, String userGender, String userEmail) {
			parms.put("userID", userID);
			parms.put("userPassword", userPassword);
			parms.put("userName", userName);
			parms.put("userGender", userGender);
			parms.put("userEmail", userEmail);
			result = sqlSession.insert("User.addUser", parms);
			
			return result;
		}
		/*
		 * public int addUser2(String userID, String userPassword, String userName,
		 * String userGender, String userEmail) { int result= 0;
		 * 
		 * String sql =
		 * "insert into user (userID, userPassword, userName, UserGender, userEmail) values('?','?','?','?','?')"
		 * ; result=
		 * template.update(sql,userID,userPassword,userName,userGender,userEmail);
		 * 
		 * return result;
		 * 
		 * }
		 */
		public int checkDup(String userID, String userPassword, String userName,String userGender, String userEmail) {
			parms.put("userID", userID);
			parms.put("userPassword", userPassword);
			parms.put("userName", userName);
			parms.put("userGender", userGender);
			parms.put("userEmail", userEmail);
			
			result = sqlSession.selectOne("User.checkDup", parms);
			
			return result;
		}

		/*
		 * public int checkDup(String userID2, String userPassword, String userName,
		 * String userGender, String userEmail) { int result = 0; String sql=
		 * "select count(*) from user where userID = '"+userID2+"' or userName= '"
		 * +userName+"' or userEmail= '"+userEmail+"' or userPassword= '"+userPassword+
		 * "'"; result = template.queryForInt(sql); return result; }
		 */
		
		/*
		 * public void viewCount(int bbsID) { sqlSession.update("User.viewCount",
		 * bbsID); }
		 */
		
		
		public User getAccount(String userID) {
			User info = new User();
			info = sqlSession.selectOne("User.getAccount", userID);
			
			return info;
		}
		
		
		public void changePassworrd(String userID, String Password) {
			parms.put("userID", userID);
			parms.put("Password", Password);
			
			sqlSession.update("User.changePassword", parms);
		}
		
		
		public void deleteAccount(String userID, String userPassword, String userEmail) {
			parms.put("userID", userID);
			parms.put("userPassword", userPassword);
			parms.put("userEmail", userEmail);
			
			sqlSession.delete("User.deleteAccount", parms);
		}
		
		
		/*==========================================*/
		public String getUserStatus(String userStatus, String userID, int bbsID) {
			String check = "ok";
			parms.put("userStatus", userStatus);
			parms.put("userID", userID);
			String result = sqlSession.selectOne("User.getUserStatus", parms);
			System.out.println("result:  " + result);
			if(result == null) {
				check = "norecord";
			} else if (result.contains(",")){ 
				String [] list = result.split(",");
				for(String a : list) {
					System.out.println("results:  " + a);
					if(Integer.parseInt(a) == bbsID) {
						check="already";
						}
					}
				} else if (Integer.parseInt(result) == bbsID) {
					check="already";
				}
			return check;
		}
		
		public String existStatus(String userStatus, String userID, int bbsID) {
			parms.put("userStatus", userStatus);
			parms.put("userID", userID);
			String result = sqlSession.selectOne("User.getUserStatus", parms);
			System.out.println("result:  " + result);
			return result;
		}


		public void addRecord(String userID, String bbsID2, String userStatus) {
			parms.put("bbsID2", bbsID2);
			parms.put("userStatus", userStatus);
			parms.put("userID", userID);
			sqlSession.update("User.addRecord", parms);
		}
		
		
}
