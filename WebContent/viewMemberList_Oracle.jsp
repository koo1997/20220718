<%@ page contentType = "text/html; charset=utf-8" %>

<%--@ page import = "java.sql.*" --%>
<%--@ page import = "java.sql.DriverManager, java.sql.Connection" --%>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<html>
<head><title>회원 목록</title></head>
<body>

MEMBER 테이블의 내용
<table width="100%" border="1">
<tr>
	<td>이름</td><td>아이디</td><td>이메일</td>
</tr>
<%
	// 1. JDBC 드라이버 로딩
	// Class.forName("com.mysql.jdbc.Driver");
	Class.forName("oracle.jdbc.OracleDriver");
	// Class.forName("oracle.jdbc.driver.OracleDriver");
	
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		// String jdbcDriver = "jdbc:mysql://localhost:3306/chap14?" +
		//					"useUnicode=true&characterEncoding=utf8";
		// String dbUser = "jspexam";
		// String dbPass = "jsppw";
							 
		// Data Source Explorer => Properties => 
		// jdbc:oracle:thin:@localhost:1521:xe
		String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbUser = "java";
		String dbPass = "java";
		
		// String query = "select * from MEMBER order by MEMBERID";
		String query = "select * from MEMBER_TBL order by MEMBERID";
		
		// 2. 데이터베이스 커넥션 생성
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		// 3. Statement 생성
		// stmt = conn.createStatement();
		
		// 3-1. PreparedStatement
		pstmt = conn.prepareStatement(query);
		
		// 4. 쿼리 실행
		// rs = stmt.executeQuery(query);
		
		// 4-1. 쿼리 실행
		rs = pstmt.executeQuery();
		
		// 5. 쿼리 실행 결과 출력
		while(rs.next()) {
%>
<tr>
	<td><%= rs.getString("NAME") %></td>
	<td><%= rs.getString("MEMBERID") %></td>
	<td><%= rs.getString("EMAIL") %></td>
</tr>
<%
		}
	} catch(SQLException ex) {
		out.println(ex.getMessage());
		ex.printStackTrace();
	} finally {
		// 6. 사용한 Statement 종료
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		// if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		
		// 6-1. 사용한 PreparedStatement 종료 
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		
		// 7. 커넥션 종료
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
</table>

</body>
</html>
