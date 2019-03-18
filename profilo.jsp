<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sincrono.gestionale.model.CommessaUtil"  %>
<%@ page import="com.sincrono.gestionale.model.CommessaService" %>
<%@ page import="org.springframework.beans.factory.annotation.Autowired" %>
<%@ page import="com.sincrono.gestionale.model.Note" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.lang.reflect.Array" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link href="../css/main.css" rel="stylesheet" type="text/css">

</head>

</head>
<body data-spy="scroll" data-target=".navbar" data-offset="60">
<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="/">Sincronize</a>
    </div>
    <ul class="nav navbar-nav">
    	<c:forEach items="${sessionScope.viewsMap}" var="x">
    		<li><a href="${x.key}"><c:out value="${x.value}"></c:out></a></li>
    	</c:forEach>
    </ul>
  </div>
  <form class="formExit" action="/exit" method="post">
  	<button class="logoutBtn" style="background-color: red" onclick="">Logout</button>
  </form>
</nav> 

<!-- Sezione Profilo -->
<div id="Profilo" class="container-fluid">
	<div class="container" >
		<div class="row" >
		<h1>Profilo </h1>
		<div class="col-sm-2" ></div>
		<div id="card" class="col-sm-3" >
 			<img src=http://arshiyagraphic.com/wp-content/uploads/2018/01/facebook-profile-blank-face-1-1024x646.jpeg style="width:100%">
 			<br>
 			<br>
 			<hr>
 			<p class="ruolo">${ruolo}</p>
 			<hr>
		</div>
		<div id="info" class="col-sm-4">
		<hr>
		<h2>Dati Anagrafici</h2>
		<table>
		<tbody>
			<tr>
				<td><h5>Nome:</h5></td>
				<td class=invisible>spazio</td>
				<td>${dipendente.nome}</td>
			</tr>
			<tr>
				<td><h5>Cognome:</h5></td>
				<td class=invisible>spazio</td>
				<td>${dipendente.cognome}</td>
			</tr>
			<tr>
				<td><h5>Indirizzo:</h5></td>
				<td class=invisible>spazio</td>
				<td>${dipendente.indirizzo}</td>
			</tr>
			<tr>
				<td><h5>Email:</h5></td>
				<td class=invisible>spazio</td>
				<td>${dipendente.email}</td>
			</tr>
			
<!-- 			CV -->
			<tr>
				
				<td colspan="2">
					<c:if test="${hasUploadedCV}">
						<div class="dropdown" style="overflow: visible;">
										  <button class="btn btn-info btn-sm" style="background-color: white; color:navy">Opzioni CV</button>
											  <div class="dropdown-content">
											  <a href="/file/viewCV" class="btn btn-info btn-lg">
											   		Visualizza</a>
											  <a 	 href="/file/removeCV" class="btn btn-info btn-lg">
											  		Rimuovi CV</a>
											  </div>
										</div>
					</c:if>
				<c:if test="${not hasUploadedCV}">
					<p>CV non caricato</p>
					</c:if>
				</td>
				<td><button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModalUploadCV">Upload CV</button></td>
			</tr>
			<tr>
				<td colspan="3">
				         <h4>${message}</h4>	
				</td> 
			</tr>
		</tbody>
		</table>
		<br>
		<button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModalProfile">Modifica Profilo</button>
		</div>
		<div class="col-sm-2"></div>
	 	</div>
	</div>
	
		<!--  This is Modal Box To UPLOAD CV -->
	<div id="myModalUploadCV" class="modal fade">
	<div class="modal-dialog">
	<div class="modal-content">
		<!--   This is the Div for HEADER-->
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"> &times; </button>
			<h4 class="modal-title">Upload CV</h4>
		</div>
		<!--   This is the Div for BODY-->
		<div class="modal-body" style= "text-align:center">
			<div id="editProfile">
				<form method="POST" enctype="multipart/form-data" action="/file/upload"> 
 					<div class="form-group">
	 					<label>File to upload:</label>
	 					<input type="file" name="file" />
 					</div>
 					
 					<br>
 		
					<div class="modal-footer">
  						<input type="submit" class="btn btn-primary btn-md" value="Upload file"/> 
  						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
					</div> 
 				</form> 
			</div>
		</div>
	</div>
	</div>
	</div>
	
	<!--  This is Modal Box To hold Complete Content in Div-->
	<div id="myModalProfile" class="modal fade">
	<div class="modal-dialog">
	<div class="modal-content">
		<!--   This is the Div for HEADER-->
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"> &times; </button>
			<h4 class="modal-title">Modifica Profilo</h4>
		</div>
		<!--   This is the Div for BODY-->
		<div class="modal-body" style= "text-align:center">
			<div id="editProfile">
				<form method="post" action="/modificaProfilo"> 
 					<div class="form-group">
 					<label>Nome:</label>
 					<input type="text" name="nome" value="${dipendente.nome}">
 					</div>
 					<div class="form-group">
 					<label>Cognome:</label>
 					<input type="text" name="cognome" value="${dipendente.cognome}">
  					</div>
  					<div class="form-group">
  					<label>Codice Fiscale:</label>
  					<input type="text" name="codicefiscale" value="${dipendente.cod_fiscale}">
  					</div>
  					<div class="form-group">
  					<label>Password:</label>
  					<input type="password" name="password" value="${dipendente.password}">
  					</div>
  					<div class="form-group">
 					<label>Indirizzo:</label>
 					<input type="text" name="indirizzo" value="${dipendente.indirizzo}">
 					</div>
 					<div class="form-group">
 					<label >Email:</label>
 					<input type="text" name="email" value="${dipendente.email}">
 					</div>
  					<br>
					<div class="modal-footer">
  						<input type="submit" class="btn btn-primary btn-md" value="Modifica"/> 
  						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
					</div> 
 				</form> 
			</div>
		</div>
	</div>
	</div>
	</div>
</div>
</body>
</html>
