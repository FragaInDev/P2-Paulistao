<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>

<title>Quartas de final</title>
</head>
<body>
	<div>
          <jsp:include page="menu.jsp"/>
     </div>
    <div align="center">
          <form action="quartas" method="get"></form>
    </div>
    <br>
     <div>
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
		<c:if test="${not empty saida }">
			<H2><c:out value="${saida }" /></H2>
		</c:if>
	</div>
	<div class="tabela" align="center">
		<c:if test="${not empty quartas }">
		
		
			<table class="t-quartas" border="1"> 
				<thead>
					<tr>
						<th>Time A</th>
						<th>X</th>
						<th>Time B</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${quartas }" var="q">
						<tr align="center">
							<td><c:out value="${q.timeA }"></c:out></td>
							<td> X </td>
							<td><c:out value="${q.timeB }"></c:out></td>		
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>
</body>
</html>