package com.jihun.bbs.Dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.jihun.bbs.Dto.Reply;

@Repository
public class ReplyDao {

	@Inject
	private SqlSession sqlSession;
	private Map<String,Object>parms = new HashMap<String, Object>(); //used for multiparams
	int result = 0;

	/*
	 * private JdbcTemplate template;
	 * 
	 * @Autowired private void setDataSource(AbstractDataSource dataSource) {
	 * this.template = new JdbcTemplate(dataSource); }
	 */
	
	public List<Reply> getComments(int bbsID, int limit){
		List<Reply> comments = new ArrayList<Reply>();
		parms.put("bbsID", bbsID);
		parms.put("limit", limit);
		
		comments = sqlSession.selectList("Reply.getComments", parms);
		return comments;
		
	}
	
	
	/*
	 * public ArrayList<Reply> getComments(int bbsID, int limit) { ArrayList <Reply>
	 * comments = new ArrayList<Reply>();
	 * 
	 * String sql = "select * from reply where replyAvailable = 1 and bbsID = "
	 * +bbsID+" order by replyDate DESC limit "+limit+",4";
	 * comments.addAll(template.query(sql, replyRowMapper())); return comments; }
	 */
	
	
	//RowMapper used by JDBCTemplate for mapping rows of result sets
	/*
	 * private RowMapper<Reply> replyRowMapper() { return new RowMapper<Reply>() {
	 * 
	 * @Override public Reply mapRow(ResultSet rs, int rowNum) throws SQLException {
	 * //replyID, bbsID, replyContent, userID, replyDate, replyAvailable Reply reply
	 * = new Reply(); reply.setReplyID(rs.getInt("replyID"));
	 * reply.setBbsID(rs.getInt("bbsID"));
	 * reply.setReplyContent(rs.getString("replyContent"));
	 * reply.setUserID(rs.getString("userID"));
	 * reply.setReplyDate(rs.getDate("replyDate"));
	 * reply.setReplyAvailable(rs.getInt("replyAvailable"));
	 * System.out.println("here: " + reply); return reply; } }; }
	 */	
	
	public int count(int bbsID, int limit) {
		result = sqlSession.selectOne("Reply.count",bbsID);
		return result;
	}
	
		/*
		 * public int count(int bbsID, int limit) { int result = 0; String sql =
		 * "select count(*) from reply where replyAvailable = 1 and bbsID = " + bbsID;
		 * result = template.queryForInt(sql);
		 * 
		 * 
		 * return result; }
		 */
	
	public ArrayList<Integer> getReplyButtons(int replyPage) {
		ArrayList <Integer> buttonHeader = new ArrayList <Integer> ();
		int standard = 4;
		if(replyPage>standard) {
			while (true) {
				standard = standard +4;
				if (replyPage<=standard) {
					break;
				}
			}
		}
		for (int i = standard -3; i<=standard; i++) {
		buttonHeader.add(i);
		}
		return buttonHeader;
	}

	public int update(int replyID, int bbsID, String updateContent) {
	parms.put("replyID", replyID);
	parms.put("bbsID", bbsID);
	parms.put("updateContent", updateContent);
	result = sqlSession.update("Reply.upddate", parms);
	return result;
	}
	
	/*
	 * public int update(int replyID, int bbsID, String updateContent) { int result
	 * = 0; String sql =
	 * "update reply set replyContent= '"+updateContent+"' where replyID= "+replyID+
	 * " and bbsID= "+bbsID; result = template.update(sql);
	 * System.out.println(result); return result; }
	 */

	public int delete(int replyID, int bbsID) {
		parms.put("replyID", replyID);
		parms.put("bbsID", bbsID);
		result = sqlSession.update("Reply.delete", parms);
		return result;
	}
	
	
	/*
	 * public int delete(int replyID, int bbsID) { int result = 0; String sql =
	 * "update reply set replyAvailable = 2 where replyID= "+replyID+" and bbsID= "
	 * +bbsID; result = template.update(sql); return result; }
	 */

	public int getReplyID() {
		int replyID = 0;
		replyID = sqlSession.selectOne("Reply.getReplyID") ;
		return replyID + 1;
	}
	
	/*
	 * public int getReplyID() { int replyID = 0; String sql =
	 * "select replyID from reply order by replyID desc limit 1"; replyID =
	 * template.queryForInt(sql) + 1; return replyID; }
	 */

	public int replyWrite(int replyID, int bbsID, String replyContent, String userID, String replyDate,
			int replyAvailable) {
		parms.put("replyID", replyID);
		parms.put("bbsID", bbsID);
		parms.put("replyContent", replyContent);
		parms.put("userID", userID);
		parms.put("replyDate", replyDate);
		parms.put("replyAvailable", replyAvailable);
		result = sqlSession.insert("Reply.replyWrite", parms);
		return result;
	}
	
	/*
	 * public void viewCount(int bbsID) { sqlSession.update("Bbs.viewCount", bbsID);
	 * }
	 */
	

	
	/*
	 * public int replyWrite(int replyID, int bbsID, String replyContent, String
	 * userID, String replyDate, int replyAvailable) { int result = 0; String sql =
	 * "insert into reply(replyID,bbsID,replyContent," +
	 * "userID,replyDate,replyAvailable) values("+replyID+","+bbsID+",'"
	 * +replyContent+"','"+userID+"','"+replyDate+"',"+replyAvailable+")"; result =
	 * template.update(sql); return result; }
	 */


	
	
	
	
	
	
}
