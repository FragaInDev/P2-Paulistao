<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>

<title>Resultados do Campeonato</title>
</head>
<body>
	<div>
          <jsp:include page="menu.jsp"/>
     </div>
    <div align="center">
    	  <h1>Tabela do Campeonato</h1>
          <form action="campeonato" method="get"></form>
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
		<c:if test="${not empty camp }">
		
		
			<table class="t-camp" border="1"> 
				<thead>
					<tr>
						<th>Time</th>
						<th>Jogos disputados</th>
						<th>Vitorias</th>
						<th>Empates</th>
						<th>Derrotas</th>
						<th>Gols Marcados</th>
						<th>Gols Sofridos</th>
						<th>Saldo de Gols</th>
						<th>Pontos</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${camp }" var="c">
						<tr align="center">
							<td><c:out value="${c.nome_time }"></c:out></td>
							<td><c:out value="${c.num_jogos_disputados }"></c:out></td>
							<td><c:out value="${c.vitorias }"></c:out></td>
							<td><c:out value="${c.empates }"></c:out></td>
							<td><c:out value="${c.derrotas }"></c:out></td>
							<td><c:out value="${c.gols_marcados }"></c:out></td>
							<td><c:out value="${c.gols_sofridos }"></c:out></td>
							<td><c:out value="${c.saldo_gols }"></c:out></td>
							<td><c:out value="${c.pontos }"></c:out></td>				
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>
</body>
</html>