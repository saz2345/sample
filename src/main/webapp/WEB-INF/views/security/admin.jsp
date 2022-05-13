<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>security/adminPage</h1>
<!-- principal : 현재 사용자
hasRole(권한) : 해당 권한이 있으면 true
hasAuthority(Authority) 
--
hasAnyRole(role1, role2) : () 안에 있는 구너한중에 하나라도 가지고 있으면 true
hasAnyAuthority(Auth1, Auth2)
--
permitAll : 모든 사용자에게 허용
denyAll : 모든 사용자 거부
isAnonymous() : 익명의 사용자인경우(로그인하지 않은 경우도 포함)
isAuthenticated() : 인증된 사용자면 true 
-->
<p>현재 사용자 정보 : <sec:authentication property="principal"/></p>
<p>MemberVO : <sec:authentication property="principal.member"/></p>
<p>사용자 이름 : <sec:authentication property="principal.member.userName"/></p>
<p>사용자 아이디 : <sec:authentication property="principal.username"/></p>
<p>사용자 권한리스트 : <sec:authentication property="principal.member.authList"/></p>

<!-- 인증된 사용자의 경우에만 안의 html 코드가 출력됨 -->
<sec:authorize access="isAuthenticated()">
<a href="/customLogout">Logout</a>
</sec:authorize>
<!-- 인증 안된 사용자의 경우에만 안의 html 코드가 출력된다. -->
<sec:authorize access="isAnonymous()">
<a href="/customLogin">Login</a>
</sec:authorize>
</body>
</html>