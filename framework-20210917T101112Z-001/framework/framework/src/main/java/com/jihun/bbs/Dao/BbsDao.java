package com.jihun.bbs.Dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.jihun.bbs.Dto.Bbs;
import com.jihun.bbs.Dto.User;

@Repository
public class BbsDao {
	

	@Inject
	private SqlSession sqlSession;
	
	/*@inject -> part of a Java technology called CDI
	 *@Autowired ->spring's own annotation
	 * */
	
	
	private Map<String,Object>parms = new HashMap<String, Object>();

	int result = 0;

	/*
	 * private JdbcTemplate template;
	 * 
	 * @Autowired public void setDataSource(AbstractDataSource dataSource) {
	 * this.template = new JdbcTemplate(dataSource); }
	 */
	
	public int count(int pageNumber,String filterBy, String searchWord, String sortType) {
		int totalPage = 0;
		int totalBbs = 0;
		parms.put("pageNumber", pageNumber);
		parms.put("filterBy", filterBy);
		parms.put("searchWord", searchWord);
		parms.put("sortType", sortType);
		totalBbs = sqlSession.selectOne("Bbs.count", parms);
		if (totalBbs%5==0) totalPage = totalBbs/5;
		else totalPage = totalBbs/5 +1;
		return totalPage;
	}
	/*
	 * public int count(int pageNumber,String filterBy, String searchWord, String
	 * sortType) { int totalPage = 0; int totalBbs = 0; String sql =
	 * "select count(*) from bbs where bbsAvailable = 1 "; if(filterBy.isBlank()&
	 * searchWord.isBlank()) {
	 * 
	 * totalBbs = template.queryForInt(sql); } else { sql = sql+" and "+filterBy
	 * +" like '%"+searchWord+"%' "; totalBbs = template.queryForInt(sql);
	 * 
	 * } if (totalBbs%5==0) { totalPage=totalBbs/5; } else { totalPage= (totalBbs/5)
	 * +1; } return totalPage; }
	 */
	
	
	
	public ArrayList <Integer> getheader(int pageNumber){
		ArrayList <Integer> header = new ArrayList <Integer> ();
		ArrayList <Integer> realHeader = new ArrayList <Integer> ();

		for (int i=pageNumber*5; i>=(pageNumber*5)-4; i--) {
			header.add(i);
		}
		for (int e =4 ; e>=0; e--) {
			realHeader.add(header.get(e));
		}
		return realHeader;
	}
	
	public ArrayList<Integer> buttonPaging(int pageNumber) {
		ArrayList <Integer> buttonHeader = new ArrayList <Integer> ();
		int standard = 5;
		if(pageNumber>standard) {
			while (true) {
				standard = standard +5;
				if (pageNumber<=standard) {
					break;
				}
			}
		}
		for (int i = standard -4; i<=standard; i++) {
		buttonHeader.add(i);
		}
		return buttonHeader;
	}

	
	public List <Bbs> getList(int pageNumber,String filterBy, String searchWord, String sortType){
		List<Bbs> list = new ArrayList<Bbs>();
		int limit = (pageNumber-1) *5;
		parms.put("pageNumber", pageNumber);
		parms.put("filterBy", filterBy);
		parms.put("searchWord", searchWord);
		parms.put("sortType", sortType);
		parms.put("limit", limit);
		System.out.println(parms);
		System.out.println(filterBy);

		list = sqlSession.selectList("Bbs.getList", parms);
		return list;
	}
	

	/*
	 * public ArrayList <Bbs> getList(int pageNumber,String filterBy, String
	 * searchWord, String sortType){ ArrayList<Bbs> list = new ArrayList<Bbs>();
	 * String sql = "select * from bbs where bbsAvailable = 1 "; int limit =
	 * (pageNumber-1) *5; if(filterBy.isBlank() & searchWord.isBlank()) { sql = sql
	 * + "order by bbsDate "+sortType+" limit "+limit+",5";
	 * list.addAll(template.query(sql, bbsRowMapper())); } else { sql = sql+ "and "+
	 * filterBy
	 * +" like '%"+searchWord+"%' order by "+filterBy+" "+sortType+" limit "+limit+
	 * ",5"; list.addAll(template.query(sql, bbsRowMapper())); } return list; }
	 */
	
	
	
	

	/*
	 * private RowMapper<Bbs> bbsRowMapper(){ return new RowMapper<Bbs>() {
	 * 
	 * @Override public Bbs mapRow(ResultSet rs, int rowNum) throws SQLException {
	 * 
	 * Bbs bbs = new Bbs(); bbs.setBbsID(rs.getInt("bbsID"));
	 * bbs.setBbsTitle(rs.getString("bbsTitle"));
	 * bbs.setUserID(rs.getString("userID")); bbs.setBbsDate(rs.getDate("bbsDate"));
	 * bbs.setBbsContent(rs.getString("bbsContent"));
	 * bbs.setBbsAvailable(rs.getInt("bbsAvailable")); return bbs; } }; }
	 */
	
	
	public int getBbsID() {
		int nextID = sqlSession.selectOne("Bbs.getBbsID");
		return nextID +1;
	}
	/*
	 * public int getBbsID() { String
	 * sql="Select bbsID from bbs order by bbsDate DESC limit 1"; int nextID =
	 * (template.queryForInt(sql)) +1; return nextID; }
	 */

	
	public int write(int bbsID, String bbsTitle, String userID, String bbsDate,
			  String bbsContent, int bbsAvailable, String fileName) {
		
		parms.put("bbsID", bbsID);
		parms.put("bbsTitle", bbsTitle);
		parms.put("userID", userID);
		parms.put("bbsDate", bbsDate);
		parms.put("bbsContent", bbsContent);
		parms.put("bbsAvailable", bbsAvailable);
		parms.put("fileName", fileName);
		result= sqlSession.update("Bbs.write", parms);
		
		return result;
	}
	/*
	 * public int write(int bbsID, String bbsTitle, String userID, String bbsDate,
	 * String bbsContent, int bbsAvailable) { String
	 * sql="insert into bbs(bbsID,bbsTitle,userID,bbsDate,bbsContent,bbsAvailable) values("
	 * +bbsID+",'"+bbsTitle+"','" +
	 * userID+"','"+bbsDate+"','"+bbsContent+"',"+bbsAvailable+")"; int result =
	 * template.update(sql); return result; }
	 */

	
	public Bbs findBbs(int bbsID) {
		
		Bbs bbs = sqlSession.selectOne("Bbs.findBbs", bbsID);
	    return bbs;
	}
	
	/*
	 * public Bbs findBbs(int bbsID) { String sql=
	 * "select * from bbs where bbsAvailable = 1 and bbsID = " +bbsID; Bbs bbs =
	 * template.queryForObject(sql, bbsRowMapper()); return bbs;
	 * 
	 * }
	 */

	
	public int upddate (String bbsTitle, String bbsContent, int bbsID, String fileName) {
		
		parms.put("bbsTitle", bbsTitle);
		parms.put("bbsContent", bbsContent);
		parms.put("bbsID", bbsID);
		parms.put("file", fileName);
		result = sqlSession.update("Bbs.upddate",parms);
		
		return result;
	}
	
	
	/*
	 * public int update(String bbsTitle, String bbsContent, int bbsID) { int result
	 * = 0; String sql =
	 * "update bbs set bbsTitle = '"+bbsTitle+"', "+"bbsContent = '"+
	 * bbsContent+"' where bbsID = "+bbsID; result = template.update(sql); return
	 * result; }
	 */
	
	public int delete(int bbsID) {
	
	result = sqlSession.delete("Bbs.delete", bbsID);
	
	
	return result;
	}
		
	
	/*
	public int delete(int bbsID) {
		int result = 0;
		String sql = "update bbs set bbsAvailable = 2 where bbsID ="+bbsID;
		result = template.update(sql);
		return result;
	}*/
	
	
	
	public void viewCount(int bbsID) {
		sqlSession.update("Bbs.viewCount", bbsID);
	}
	
	
	/*
	 * public User getAccount(String userID) { User info = new User(); info =
	 * sqlSession.selectOne("Bbs.getAccount", userID);
	 * 
	 * return info; }
	 * 
	 * 
	 * public void changePassworrd(String userID, String Password) {
	 * parms.put("userID", userID); parms.put("Password", Password);
	 * 
	 * sqlSession.update("Bbs.changePassword", parms); }
	 * 
	 * 
	 * public void deleteAccount(String userID, String userPassword, String
	 * userEmail) { parms.put("userID", userID); parms.put("userPassword",
	 * userPassword); parms.put("userEmail", userEmail);
	 * 
	 * sqlSession.delete("Bbs.deleteAccount", parms); }
	 * 
	 */
	
	
	
	public void status(int bbsID, String userStatus) {
		parms.put("bbsID", bbsID);
		parms.put("userStatus", userStatus);
		
		sqlSession.update("Bbs.status", parms);
	}
	
	public String getLikes(int bbsID) {
	return	sqlSession.selectOne("Bbs.getLikes", bbsID);
	}
	public String getDislikes(int bbsID) {
	return	sqlSession.selectOne("Bbs.getDislikes", bbsID);
	}

	
}












/*
 * private String driver="com.mysql.cj.jdbc.Driver"; private String
 * url="jdbc:mysql://localhost:3306/BBS"; private String userid="root"; private
 * String userpw="1234";
 */
/*
 * dataSource = new DriverManagerDataSource();
 * dataSource.setDriverClass(driver); dataSource.setJdbcUrl(url);
 * dataSource.setUser(userid); dataSource.setPassword(userpw);
 */
