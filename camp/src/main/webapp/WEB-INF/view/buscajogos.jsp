<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>

<title>Pesquisa de Jogos</title>
</head>
<body>
	     <div>
          <jsp:include page="menu.jsp"/>
     </div>
     <div align="center">
     	  <h1>Pesquise os jogos pela data</h1>
          <form action="buscajogos" method="post">
               <table class="z">
                 <tr>
                 
                 <td><input type="date" id="data" name="data"><td>
                 <td><input type="submit" id="botao" name="botao" value="Pesquisar"><td>
                 
                 </tr>
               </table>
          </form>
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
	   <c:choose>
		<c:when test="${not empty jogos }">
			<table class="table" border="1">
				<thead>
					<tr>
						<th>Time A</th>		
						<th>Time B</th>
						<th>Data</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${jogos }" var="j">
						<tr>
							<td><c:out value="${j.nome_timeA }"></c:out></td>
							
							<td><c:out value="${j.nome_timeB }"></c:out></td>
							
							<td><c:out value="${j.data_jogo }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:when>
      
		<c:otherwise>
			<div class="z">
                  <p>Ainda não existe jogos nessa data!</p>
			</div>
		</c:otherwise>		
	 </c:choose>		
	</div>
</body>
</html>