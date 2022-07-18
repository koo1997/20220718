<%@ page contentType = "text/html; charset=utf-8" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String memberID = request.getParameter("memberID");
	String name = request.getParameter("name");
	
	int updateCount = 0;
	
	// Class.forName("com.mysql.jdbc.Driver");
	Class.forName("oracle.jdbc.OracleDriver");
	
	Connection conn = null;
	// Statement stmt = null;
	PreparedStatement stmt = null;
	
	try {
		// String jdbcDriver = "jdbc:mysql://localhost:3306/chap14?" +
		//					"useUnicode=true&characterEncoding=utf8";
		// String dbUser = "jspexam";
		// String dbPass = "jsppw";
		
		String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:XE";
		String dbUser = "java";
		String dbPass = "java";
		
		/* String query = "update MEMBER set NAME = '"+name+"' "+
					   "where MEMBERID = '"+memberID+"'"; */
		
/* 	   String query = "update MEMBER_TBL set NAME = '"+name+"' "+
				      "where MEMBERID = '"+memberID+"'"; */
				      
	    String query = "update MEMBER_TBL set NAME = ? "+
			      	   "where MEMBERID = ?";		      
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		// stmt = conn.createStatement();
		
		stmt = conn.prepareStatement(query); // PreparedStatement
		
		// 인자 처리 : PrepareedStatment
		stmt.setString(1, name);
		stmt.setString(2, memberID);
		
		// updateCount = stmt.executeUpdate(query);
		
		updateCount = stmt.executeUpdate(); // PreparedStatement
		
	} finally {
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
<html>
<head><title>이름 변경</title></head>
<body>
<%  if (updateCount > 0) { %>
<%= memberID %>의 이름을 <%= name %>(으)로 변경
<%  } else { %>
<%= memberID %> 아이디가 존재하지 않음
<%  } %>

</body>
</html>
