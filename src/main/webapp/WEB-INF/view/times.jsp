<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>

<title>Times</title>
</head>
<body>
	<div>
        <jsp:include page="menu.jsp"/>
    </div>
    <div>
		<form action="times" method="get">
		 	<table class="z"></table>
		 </form>
	</div>
    <section>
    	<H1>Lista de Times</H1>
		<br/>
	
		<div align="center">
	        <c:if test="${not empty times }">
	            <table border="1">
	                <thead>
	                    <tr>
	                        <th>ID</th>
	                        <th>Nome</th>
	                        <th>Cidade</th>
	                        <th>Estádio</th>
	                        <th>Material Esportivo</th>
	                    </tr>
	                </thead>
	                <tbody>
	                 	<c:forEach items="${times }" var="times">
	                        <tr>
	                            <td><c:out value="${times.cod_time }"/></td>
	                            <td><c:out value="${times.nome }"/></td>
	                            <td><c:out value="${times.cidade }"/></td>
	                            <td><c:out value="${times.estadio }"/></td>
	                            <td><c:out value="${times.material_esportivo }"/></td>
	                        </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
	        </c:if>
		</div>
	</section>
</body>
</html>