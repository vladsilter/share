<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.sincrono.gestionale.model.CommessaUtil"  %>
<%@ page import="com.sincrono.gestionale.model.CommessaService" %>
<%@ page import="org.springframework.beans.factory.annotation.Autowired" %>
<%@ page import="com.sincrono.gestionale.model.Note" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.lang.reflect.Array" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<title>${titolo}</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="../../css/main.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <script src="../../js/util.js"></script>
<style>
#Profilo {padding-top:50px;height:600px; color: #fff; background-color: #1E88E5;}
#myModalProfile{color:black;}
#Note{padding-top:50px;}
#RIL{padding-top:50px;}
.my{height:550px;}
.my-custom-scrollbar {
  position: relative;
  height: 350px;
  overflow: auto;
}
.table-wrapper-scroll-y {
  display: block;
}

.ruolo {
 color: dark;
  font-size: 18px;
}

#card{margin-top:60px; text-align:center;}
#info{margin-top:60px; padding-left:50px;}
.disabled{
 cursor: not-allowed;
}
</style>
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
  			<button class="logoutBtn" style="background-color: red;" onclick="" >Logout</button>
  		</form>
	</nav> 


	<div id="Assegnazione" style= "padding-top:50px; margin-bottom:50px;">
	<div class="my">
		<div class="container">
			<div class=infiltrato style= "padding-top:20px;" ></div>
			<div class="col-sm-9">
				<h2> Progetto: ${titolo} </h2>
				<p>
				<jsp:useBean  id="now" class="java.util.Date"/>
				<c:if test="${fin lt now}">
 				<h3>Stato: Terminato</h3>
				</c:if>
				<c:if test="${fin ge now}">
				<h3>Stato: In corso</h3>
				</c:if>
				</p>
			</div>
 			<div class="col-sm-3" style= "padding-top:20px;">
 				<p> AGGIUNGI AL TEAM:</p>
				<c:if test="${fin lt now}">
 				<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal1" disabled>
        		<span class="glyphicon glyphicon-plus" ></span> Dipendente
				</button>
				</c:if>
				<c:if test="${fin ge now}">
				<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal1">
        		<span class="glyphicon glyphicon-plus" ></span> Dipendente
				</button>
				</c:if>
			</div>
			<div class="container" style= "padding-top:20px;">
			<h5 class="invisible">spazio</h5>
			<h3>Lista Dipendenti</h3> 
 			<input class="form-control" id="myInput" type="text" placeholder="Search..">
 			<br>
 			<div class="table-wrapper-scroll-y my-custom-scrollbar">
 				<table class="table table-bordered table-striped">
 	   			<thead>
   	  	 			<tr>
   	  	 			<th style= "display:none;">Id ASSEGNAZIONE</th>
   	  	 			<th style= "display:none;">ID</th>
   		  			<th>Dipendente</th>
   		  			<th>Ruolo</th>
      		  		<th>Costo</th>
      				<th>Prezzo</th>
      				<th></th>
       				</tr>
  	   			</thead>
		   		<tbody id="myTable">
      				<c:forEach items="${iddipe}" var="x" varStatus="status">
					<tr>
					<td style= "display:none;">${asse[status.index]}</td>
					<td style= "display:none;">${x.id_dipendente}</td>
					<td>${x.cognome} ${x.nome}</td>
					<td>${ruolo[status.index]}</td>
					<td >${costo[status.index]}</td>
					<td>${prezzo[status.index]}</td>
					<td>
					<c:if test="${fin lt now}">
					<a class="btn btn-default btn-xs disabled" onclick="autoAS('${asse[status.index]}','${x.id_dipendente}')" data-toggle="modal" data-target="#myModalmodificaCosto">
						<span class="glyphicon glyphicon-pencil">Costi</span>
					</a>
					<a class="btn btn-default btn-xs disabled" href="/comm/deleteCommessa?idAssegnazioneCommessa=${asse[status.index]}&&idCommessa=${idCommessa}">
						<span class="glyphicon glyphicon-remove">Elimina</span>
					</a>
					</c:if>
					<c:if test="${fin ge now}">
					<a class="btn btn-default btn-xs" onclick="autoAS('${asse[status.index]}','${x.id_dipendente}')" data-toggle="modal" data-target="#myModalmodificaCosto">
					<span class="glyphicon glyphicon-pencil">Costi</span>
					</a>
					<fmt:formatDate value="${fin}" var="fine" 
               			 type="date" pattern="yyyy-MM-dd" />
					<a class="btn btn-default btn-xs" href="/comm/deleteCommessa?idAssegnazioneCommessa=${asse[status.index]}&&idCommessa=${idCommessa}&&fin=${fine}">
					<span class="glyphicon glyphicon-remove">Elimina</span>
					</a>
					</c:if>
					</td>
					</tr>
					</c:forEach>
    			</tbody>
 				</table>
  			</div>
		</div>
	</div>
	</div>
	</div>

	<!-- Modal per vedere lista dei dipendenti non assegnati ad una commessa-->
	<div id="myModal1" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<!--  Modal header-->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Assegnazione</h4>
				</div>
				
				<!--   Modal body-->
				<div class="modal-body">
					<h1>Dipendenti disponibili</h1>
 					<div class="table-wrapper-scroll-y my-custom-scrollbar">
 						<table class="table table-bordered table-striped">
 		   					<thead>
   		  	 					<tr>
   		  	 					<th>Ruolo</th>
      		  					<th colspan="2">Dipendente</th>	
      	   						</tr>
  		   					</thead>
   		   					<tbody id="myTable">
      							<c:forEach items="${nonasse}" var="y" varStatus="status">
								<tr>
									<td>${ruolo1[status.index]}</td>
									<td style= "border-right:none;">${y.cognome} ${y.nome}</td>
									<td style= "border-left:none;">
									<button type="button" onclick="autoS('${y.id_dipendente}')" class="btn btn-default btn-xs" data-toggle="modal" data-target="#myModalAssegna" >Assegna</button>
        							</td>
								</tr>
								</c:forEach>
    						</tbody>
 						</table>
 						<div class="modal-footer">
  						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
						</div>  
  					</div>
  				</div>
  	
  				
  			</div>
  		</div>
  	</div>
  	
  	
  	<!-- Modal per aggiungere un dipendente ad una nuova commessa-->
	<div id="myModalAssegna" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
		
			<!--  Modal header-->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Assegnazione</h4>
			</div>
			
			<!--   Modal body-->
				<div class="modal-body">
					<h2>Costo e Prezzo</h2>
					<fmt:formatDate value="${fin}" var="fine" 
               			 type="date" pattern="yyyy-MM-dd"  />
					<form method="post" action="/comm/assignCommessa?idCommessa=${idcom}&fin=${fine}"> 
 		 				<div class="form-group">
 		 				  	<input id="idDip" type="number"  class="form-control" name="idDipendente" style= "display:none" >
    						<label >costo:</label>
    						<input type="number" class="form-control" name="costo" required>
   							<label>prezzo:</label>
   							<input type="number" class="form-control" name="prezzo" required>
  						</div>
						<div class="modal-footer">
  							<input type="submit" class="btn btn-primary btn-md" value="Assegna">
  							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
						</div>  
 					</form> 
				</div>
				
			</div>
		</div>
	</div>

		
	<!-- Modal per modifica costo e prezzo -->
	<div id="myModalmodificaCosto" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<!--   Modal header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Gestione Assegnazione</h4>
				</div>
			
				<!-- Modal body -->
				<div class="modal-body">
					<h2>Modifica</h2>
					<fmt:formatDate value="${fin}" var="fine" 
               			 type="date" pattern="yyyy-MM-dd" />
					<form method="post" action="/comm/modAssCommessa?idC=${idcom}&fin=${fine}"> 
 			 			 <div class="form-group">
 			 				 <input id="idAssegna" type="number"  class="form-control" name="idAssegnazione" style= "display:none" >
 		 					 <input id="idDipe" type="number"  class="form-control" name="idDipendente" style= "display:none" >
   		 					 <label >Costo</label>
    						 	<input type="number" class="form-control" name="costo" required>
    						 <label >Prezzo</label>
    						 	<input type="number" class="form-control" name="prezzo" id='idPrezzo' required >
    						 	
  						</div>
						<div class="modal-footer">
  							<input type="submit" class="btn btn-primary btn-md" value="Salva">
						</div>  
 					</form> 
				</div>
			
			</div>
		</div>
	</div>

<script>
function autoS(id){
	document.getElementById('idDip').value=id;
}

function autoAS(id1,id2){
	document.getElementById('idAssegna').value=id1;
	document.getElementById('idDipe').value=id2;
}



</script>
</body>
</html>