<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>

<title>Grupos</title>
</head>
<body>
	<div>
        <jsp:include page="menu.jsp"/>
    </div>
    <div align= "center">
    	<H1>Grupos do Paulistão</H1>
		</br>
		<form action="grupos" method="post">
	 		<input type="submit" id="botao" name="botao" value="Gerar">
	 	</form>
	</div>
	<div class="tabelas" align="center">
		<c:if test="${not empty grupoA }">
			<table class="tabelaA">
				<thead>
					<tr>
						<th>Grupo A</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${grupoA }" var="ga">
						<tr>
							<td><c:out value="${ga.nome_time }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		
		<c:if test="${not empty grupoB }">
			<table class="tabelaB">
				<thead>
					<tr>
						<th>Grupo B</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${grupoB }" var="gb">
						<tr>
							<td><c:out value="${gb.nome_time }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		
		<c:if test="${not empty grupoC }">
			<table class="tabelaC">
				<thead>
					<tr>
						<th>Grupo C</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${grupoC }" var="gc">
						<tr>
							<td><c:out value="${gc.nome_time }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		
		<c:if test="${not empty grupoD }">
			<table class="tabelaD">
				<thead>
					<tr>
						<th>Grupo D</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${grupoD }" var="gd">
						<tr>
							<td><c:out value="${gd.nome_time }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
		
	</div>
</body>
</html>