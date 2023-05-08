<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>

<title>Jogos</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp"/>
	</div>

	
	<div class = "t-jogos">
		<h1>Confira os Jogos do Paulistão</h1>
	</div>
	
	<div align="center">
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
		<c:if test="${not empty saida }">
			<H2><c:out value="${saida }" /></H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty jogos }">
			<table class="t-jogos" border="1">
				<thead>
					<tr>
						<th>Time A</th>
						<th>Gols A</th>
						<th>Gols B</th>
						<th>Time B</th>
						<th>Data</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${jogos }" var="j">
						<tr>
							<td><c:out value="${j.nome_timeA }"></c:out></td>
							
							<td><c:out value="${j.gols_timeA }"></c:out></td>
							
							<td><c:out value="${j.gols_timeB }"></c:out></td>
							
							<td><c:out value="${j.nome_timeB }"></c:out></td>
							
							<td><c:out value="${t.data_jogo }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>			
	</div>
	
</body>
</html>