<%@ page contentType = "text/html; charset=utf-8" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String memberID = request.getParameter("memberID");
	String password= request.getParameter("password");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	// Class.forName("com.mysql.jdbc.Driver");
	Class.forName("oracle.jdbc.OracleDriver");
	
	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
/* 		String jdbcDriver = "jdbc:mysql://localhost:3306/chap14?" +
							"useUnicode=true&characterEncoding=utf8";
		String dbUser = "jspexam";
		String dbPass = "jsppw"; */
		
		String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbUser = "java";
		String dbPass = "java";
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		/* pstmt = conn.prepareStatement(
			"insert into MEMBER values (?, ?, ?, ?)"); */
			
		pstmt = conn.prepareStatement(
				"insert into MEMBER_TBL values (?, ?, ?, ?)");	
		pstmt.setString(1, memberID);
		pstmt.setString(2, password);
		pstmt.setString(3, name);
		pstmt.setString(4, email);
		
		// 메시징
		if (pstmt.executeUpdate() == 1) {
			out.println("데이터가 저장에 성공하였습니다.<br>");
		} else {
			// out.println("데이터가 저장에 실패하였습니다.<br>");
			throw new SQLException("데이터가 저장에 실패하였습니다.");
		}
		
	// 예외처리	
	} catch (SQLException e) {
		out.println("예외처리 : "+ e + "<br>");
		e.printStackTrace();
	} finally {
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
<html>
<head><title>삽입</title></head>
<body>

<!-- MEMBER 테이블에 새로운 레코드를 삽입했습니다 -->

</body>
</html>