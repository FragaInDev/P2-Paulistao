<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/styles.css" />'>

<title>Resultados por Grupo</title>
</head>
<body>
	<div>
          <jsp:include page="menu.jsp"/>
     </div>
    <div align="center">
    	  <h1>Confira a Pontuação dos Grupos</h1>
          <form action="grupojogos" method="post">
               <table>
                 <tr>
                 <td><input type="submit" id="botao" name="botao" value="Exibir"><td>
                 </tr>
               </table>
          </form>
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
		<c:if test="${not empty grupoA }">
		
		
			<table class="tableA" border="1"> 
				<thead>
					<h2> Grupo A </h2>
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
					<c:forEach items="${grupoA }" var="ga">
						<tr align="center">
							<td><c:out value="${ga.nome_time }"></c:out></td>
							<td><c:out value="${ga.num_jogos_disputados }"></c:out></td>
							<td><c:out value="${ga.vitorias }"></c:out></td>
							<td><c:out value="${ga.empates }"></c:out></td>
							<td><c:out value="${ga.derrotas }"></c:out></td>
							<td><c:out value="${ga.gols_marcados }"></c:out></td>
							<td><c:out value="${ga.gols_sofridos }"></c:out></td>
							<td><c:out value="${ga.saldo_gols }"></c:out></td>
							<td><c:out value="${ga.pontos }"></c:out></td>				
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>
	<div class="tabela" align="center">
		<c:if test="${not empty grupoB }">
		
		
			<table class="tableB" border="1"> 
				<thead>
					<h2> Grupo B </h2>
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
					<c:forEach items="${grupoB }" var="gb">
						<tr align="center">
							<td><c:out value="${gb.nome_time }"></c:out></td>
							<td><c:out value="${gb.num_jogos_disputados }"></c:out></td>
							<td><c:out value="${gb.vitorias }"></c:out></td>
							<td><c:out value="${gb.empates }"></c:out></td>
							<td><c:out value="${gb.derrotas }"></c:out></td>
							<td><c:out value="${gb.gols_marcados }"></c:out></td>
							<td><c:out value="${gb.gols_sofridos }"></c:out></td>
							<td><c:out value="${gb.saldo_gols }"></c:out></td>
							<td><c:out value="${gb.pontos }"></c:out></td>				
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>
	<div class="tabela" align="center">
		<c:if test="${not empty grupoC }">
		
		
			<table class="tableC" border="1"> 
				<thead>
					<h2> Grupo C </h2>
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
					<c:forEach items="${grupoC }" var="gc">
						<tr align="center">
							<td><c:out value="${gc.nome_time }"></c:out></td>
							<td><c:out value="${gc.num_jogos_disputados }"></c:out></td>
							<td><c:out value="${gc.vitorias }"></c:out></td>
							<td><c:out value="${gc.empates }"></c:out></td>
							<td><c:out value="${gc.derrotas }"></c:out></td>
							<td><c:out value="${gc.gols_marcados }"></c:out></td>
							<td><c:out value="${gc.gols_sofridos }"></c:out></td>
							<td><c:out value="${gc.saldo_gols }"></c:out></td>
							<td><c:out value="${gc.pontos }"></c:out></td>				
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>
	<div class="tabela" align="center">
		<c:if test="${not empty grupoD }">
		
		
			<table class="tableD" border="1"> 
				<thead>
					<h2> Grupo D </h2>
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
					<c:forEach items="${grupoD }" var="gd">
						<tr align="center">
							<td><c:out value="${gd.nome_time }"></c:out></td>
							<td><c:out value="${gd.num_jogos_disputados }"></c:out></td>
							<td><c:out value="${gd.vitorias }"></c:out></td>
							<td><c:out value="${gd.empates }"></c:out></td>
							<td><c:out value="${gd.derrotas }"></c:out></td>
							<td><c:out value="${gd.gols_marcados }"></c:out></td>
							<td><c:out value="${gd.gols_sofridos }"></c:out></td>
							<td><c:out value="${gd.saldo_gols }"></c:out></td>
							<td><c:out value="${gd.pontos }"></c:out></td>				
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>
</body>
</html>