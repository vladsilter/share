<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sincrono.gestionale.model.CommessaUtil"  %>
<%@ page import="com.sincrono.gestionale.model.CommessaService" %>
<%@ page import="org.springframework.beans.factory.annotation.Autowired" %>
<%@ page import="com.sincrono.gestionale.model.Note" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.lang.reflect.Array" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>Commesse</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link href="../css/main.css" rel="stylesheet" type="text/css">

<style>
.my-custom-scrollbar {
  position: relative;
  height: 350px;
  overflow: auto;
}
.table-wrapper-scroll-y {
  display: block;
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
	<br/>
	<br/>
	<!-- Sezione Commesse -->
	<div id="Commessa" style= "padding-top:50px; margin-bottom:50px;">
		<div class="my">
			<div class="container">
			<div class=infiltrato></div>
			<div class="col-sm-9">
  			<h2> Gestione Commesse</h2>
  			</div>
 			<div class="col-sm-3" style= "padding-top:20px;">
  					<p>INSERISCI NUOVA COMMESSA:</p>
       				<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#inserimentoCommessa">
        			<span class="glyphicon glyphicon-plus"></span> Commessa
       				</button>
				</div> 
			
				<div class="container" style= "padding-top:20px;">
				<h3>Lista Commesse</h3>
 				<input class="form-control" id="myInput" type="text" placeholder="Search..">
 		 		<br>
 		 		<div class="table-wrapper-scroll-y my-custom-scrollbar">
  					<table class="table table-bordered table-striped">
   			 		<thead>
     					<tr>
						<th style="display:none;">Id_commessa</th>
						<th>Cliente</th>
						<th >Titolo_progetto</th>
						<th>Data Inizio Progetto</th>
						<th>Data Fine Progetto</th>
						<th>Stato</th>
						<th></th>
     			 		</tr>
  					 </thead>
   			 		 <tbody id="myTable">			
   			 			<c:forEach items="${ListaCommesse}" var="x" varStatus="status">
						<tr>
       					<td style="display:none;">${x.id_commessa}</td>
					  	<td onclick="autoS1('${x.id_commessa}','${ListaIdClienti[status.index]}','${x.titolo_progetto}','${x.data_inizio}','${x.data_fine}')"data-toggle="modal" data-target="#myModalmodificaCommessa">${Listanomiclienti[status.index]}</td> 
						<td onclick="autoS1('${x.id_commessa}','${ListaIdClienti[status.index]}','${x.titolo_progetto}','${x.data_inizio}','${x.data_fine}')"data-toggle="modal" data-target="#myModalmodificaCommessa">${x.titolo_progetto}</td>
						<fmt:formatDate value="${x.data_inizio}" var="dataInizio" 
               			 type="date" pattern="dd-MM-yyyy" />
               			 <fmt:formatDate value="${x.data_fine}" var="dataFine" 
               			type="date" pattern="dd-MM-yyyy" />
               			 <td>${dataInizio}</td>
						 <td>${dataFine}</td>
						<td id="stato">

						<jsp:useBean  id="now" class="java.util.Date"/>

						<c:if test="${x.data_fine lt now}">

						<h5>Terminato </h5>

						</c:if>

						<c:if test="${x.data_fine ge now}">

						<h5>In corso</h5>

						</c:if>

						</td>
						<td>
						<fmt:formatDate value="${x.data_fine}" var="fine" 
               			 type="date" pattern="yyyy-MM-dd" />
						<a href="/comm/assegnazioneCommessa?id_commessa=${x.id_commessa}&&fin=${fine}" target="_blank" class="btn btn-default btn-xs">
         				<span class="glyphicon glyphicon-user"></span> Team di lavoro
       					</a>
       					<a href="#myModalmodificaCommessa" class="btn btn-default btn-xs"
       						onclick="autoS1('${x.id_commessa}','${ListaIdClienti[status.index]}','${x.titolo_progetto}','${x.data_inizio}','${x.data_fine}')"data-toggle="modal" data-target="#myModalmodificaCommessa">
         				<span class="glyphicon glyphicon-pencil"></span> Modifica
       					</a>       				
						</td>
						<td style="display:none;">${ListaIdClienti[status.index]}</td>
						</tr>
						</c:forEach>
					</tbody>
 					</table>
 				</div>
				</div>
			</div>
		</div>
	</div>
		
	<!--   Modal per modificare una commesa  -->
	<div id="myModalmodificaCommessa" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				
			<!--   Modal header  -->
			<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title">Gestione Commesse</h4>
			</div>
			
			<!--   Modal body-->
			<div class="modal-body">
				<h2>Modifica</h2>
				<form method="post"  action="/comm/modCommessa" name="formproge"> 
 		 			 <div class="form-group">
 		 			  	<input id="idCommessa" type="number"  class="form-control" name="idCommessa" style= "display:none" >
 		 			  	<input id="idCliente" type="number"  class="form-control" name="idCliente" style= "display:none" >
    					<label for="titolo">Titolo Progetto</label>
    					<input type="text" required class="form-control" id="titolo" name="titoloProgetto">
    					
    					<input type="date" name="dataInizio" id="dataIN" class="form-control" style="display:none">
    					<label for="DataFine" >Data Fine Progetto</label>
    					<input type="date" name="dataFine" id="dataFI" class="form-control" required>
  					</div>
					<div class="modal-footer"> 
  						<input type="submit" class="btn btn-primary btn-md" value="Modifica"/>
  						<button type="button" class="btn btn-default" data-dismiss="modal">Chiudi</button>
					</div>  
 				</form> 
			</div>
				
			</div>
		</div>
	</div>

				
		

	<!-- Modal per inserire nuova commessa -->
	<div id="inserimentoCommessa" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				
				<!--   Modal header -->
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Gestione Commesse</h4>
				</div>
			
				<!-- Modal body -->
				<div class="modal-body">
					<h2>Inserisci nuova commessa</h2>
					<form name="formproge" action="/comm/insCommessa">
    		  			<div class="form-group">
 					 		<label for="Cliente">Select Cliente:</label>
 							<select  name="nomeCliente">
    							<c:forEach items="${clienti}" var="x">
									<option value="${x}">${x}</option>
				 				</c:forEach>
  							</select>
   						</div>
    					<div class="form-group">
      						<label for="Titolo" >Titolo Progetto</label>
      						<input type="text" required class="form-control" id="titoloProgetto"  name="titoloProgetto">
    						<label for="Datainizio" >Data Inizio Progetto</label>
    						<input type="date" name="dataInizio" required class="form-control">
               				<label for="DataFine" >Data Fine Progetto</label>
    						<input type="date" name="dataFine" class="form-control">
    					</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-default">Submit</button>
    					</div>
  					</form>
				</div>
				
			</div>
		</div>
	</div>
	
</body>



<script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});

function aggiungiTitoloProgetto(titolo){
	console.log(titolo);
	document.getElementById("titoloProgetto2").innerHTML="Progetto: "+titolo;
}

function autoS1(id1,id2,id3,id4,id5){
	document.getElementById('idCommessa').value=id1;
	document.getElementById('idCliente').value=id2;
	document.getElementById('titolo').value=id3;
	document.getElementById('dataIN').value=id4.substring(0, 10);
	document.getElementById('dataFI').value=id5.substring(0, 10);
}

function validateFormProge()
{
    var a=document.forms["formproge"]["titoloProgetto"].value;
    if (a==null || a=="")
    {
        alert("Inserisci un titolo progetto");
        return false;
    }
}

var q = new Date();
var m = q.getMonth()+1;
var d = q.getDay();
var y = q.getFullYear();

var date = new Date(y,m,d);

mydate=new Date('2011-04-11');
console.log(date);
console.log(mydate)

if(date>mydate)
{
	document.getElementById('stato').innerHTML.replace("In corso");
	System.out.println("In corso");
}
else
{
	document.getElementById('stato').innerHTML.replace("Terminato");
	out.println("Terminato");
}


</script>
</html>