<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page import="com.sincrono.gestionale.model.Dipendente" %>
<!DOCTYPE html>
<html>
<head>

<style>
#Profilo {padding-top:50px;height:600px; color: #fff; background-color: #1E88E5;}
#Clienti{padding-top:50px;}
#Commesse{padding-top:50px}
.my{height:550px;}

#myModalProfile{color: black}

.my-custom-scrollbar {
  position: relative;
  height: 350px;
  overflow: auto;
}
.table-wrapper-scroll-y {
  display: block;
}
#card {
  /*box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);*/
 /* height:250px;*/
  text-align:center;
}
.ruolo {
 color: dark;
  font-size: 18px;
}

#info{
/*height:250px;*/

}
</style>

<style>
input[type=text], input[type=date] { color:black;}
form, select { color: black;}
</style>

<meta charset="ISO-8859-1">
<title>Dipendenti</title>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../../css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="../../js/util.js"></script>

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
<br/>
<br/>

<!-- Sezione  DIPENDENTI-->
<div class="my">
			<div class="container">
			<div class=infiltrato></div>
			<div class="col-sm-9">
  			<h2> Gestione Dipendenti</h2>
  			</div>
  			  
 			<div class="col-sm-3" style= "padding-top:20px;">
  					<p>INSERISCI NUOVO DIPENDENTE:</p>
       				<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModalNuovo">
        			<span class="glyphicon glyphicon-plus"></span> Dipendente
       				</button>
				</div> 
			
				<div class="container" style= "padding-top:20px;">
				<h3>Lista Dipendenti</h3>
 				<input class="form-control" id="myInput" type="text" placeholder="Search..">
 		 		<br>
 			<div class="table-wrapper-scroll-y my-custom-scrollbar">
		 		<table class="table table-bordered table-striped">
				    <thead>
				      <tr>
				      	
				        <th>Nome</th>
					    <th>Cognome</th>
					    <th>Codice fiscale</th>
					    <th>Residenza</th>
					    <th>email</th>
					    <th>Ruolo</th>
					    <th>Inizio Contratto</th>
					    <th>Fine Contratto</th>
					    <th></th>
				      </tr>
				    </thead>
				    <tbody id="myTable">
				      
					    <c:forEach items="${listaDipendenti}" var="x">
							  <tr>
							  	
							  	<td>${x.nome}</td>
							    <td>${x.cognome}</td>
							    <td>${x.cod_fiscale}</td>
							    <td>${x.indirizzo}</td>
							    <td>${x.email}</td>
							    <td>${x.id_ruolo}</td>
							    <fmt:formatDate value="${x.dataInizio}" var="dataInizio" 
               			 		type="date" pattern="dd-MM-yyyy" />
               			 		<fmt:formatDate value="${x.dataFine}" var="dataFine" 
               					 type="date" pattern="dd-MM-yyyy" />
							    <td>${dataInizio}</td>
							    <td>${dataFine}</td>
							    <td>
							    	<div class="dropdown" >
									  <button class="btn btn-default btn-xs"><span class="glyphicon glyphicon-cog">Opzioni</span></button>
										  <div class="dropdown-content">
										  <a href="#containerFormDipendenti"
										  	class="btn btn-default btn-xs" data-toggle="modal" data-target="#myModalDipendenti"
										   	onclick="autoFill('${x.id_dipendente}','${x.nome}', '${x.cognome}','${x.cod_fiscale}','${x.indirizzo}','${x.id_ruolo}','${x.dataInizio}','${x.dataFine}')">
										   		Modifica</a>
										  <a href="/amm/deleteDip?id=${x.id_dipendente}" class="btn btn-default btn-xs">Elimina</a>
										  </div>
									</div>
								</td>
						  </tr>
					  </c:forEach>
				    </tbody>
				  </table>
  			</div>
		</div>
	</div>
	
	
	
	
	<!--  This is Modal Box To hold Complete Content in Div-->
	<div id="myModalDipendenti" class="modal fade">
	<div class="modal-dialog">
	<div class="modal-content">
		<!--   This is the Div for HEADER-->
			<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h2>Modifica Dipendente</h2>
			</div>
			<!--   This is the Div for BODY-->
				<div class="modal-body">
				<div id="modDip">
					
					<form method="post" action="/amm/editDip"> 
 						<div class="form-group">
 					 		<input type="number" id="id_dip" name="id" style="display:none">
		  		
					  		<label for="nome">Nome</label>
						    <input type="text" id="nome" name="nome" placeholder="Nome">
						   
						   	<label for="cognome">Cognome</label>
						   	<input type="text" id="cognome" name="cognome" placeholder="Cognome">
						    
						    <label for="cf">Codice Fiscale</label>
						    <input type="text" id="cf" name="cf" placeholder="CF">
						    
						    <label for="indirizzo">Indirizzo di residenza</label>
						    <input type="text" id="indirizzo" name="indirizzo" placeholder="Via/Piazza...">
						    
						    <br>
						    <label for="ruoloDropdown">Ruolo</label>
						    <select id="ruoloDropdown" name="ruolo">
							        <option value='4'>Amministrativo</option>
							        <option value='3'>Commerciale</option>
							        <option value='2'>Sviluppatore</option>
							        <option value='1'>PM</option>
							        <option value='5'>Admin</option>
					      		</select>	
					      	
					      	<label for="dataInizio">Data inizio contratto</label>
						    <input type="date" id="dataInizio" name = "dataI">
						    
						    <label for="dataFine">Data fine contratto</label>
						    <input type="date" id="dataFine" name ="dataF">
				</div>
						<div class="modal-footer">
  							<input type="submit" class="btn btn-primary btn-md" value="Conferma Modifiche"/>
  							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
						</div>  
 					</form> 
			</div>
			</div>
	</div>
	</div>
	</div>
		<!--  This is Modal Box To hold Complete Content in Div-->
			<div id="myModalNuovo" class="modal fade">
			<div class="modal-dialog">
			<div class="modal-content">
					<!--   This is the Div for HEADER-->
			<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h2>Nuovo Dipendente</h2>
			</div>
			<!--   This is the Div for BODY-->
				<div class="modal-body">
				<div id="newDip">
					
					<form method="post" action="/amm/insDip"> 
 						<div class="form-group">
 					 		<input type="number" id="idDip2" name="id" style="display: none;">
		  		
					  		<label for="nome">Nome</label>
						    <input type="text" id="nome" name="nome" placeholder="Nome">
						   
						   	<label for="cognome">Cognome</label>
						   	<input type="text" id="cognome" name="cognome" placeholder="Cognome">
						    
						    <label for="cf">Codice Fiscale</label>
						    <input type="text" id="cf" name="cf" placeholder="CF">
						    
						    <label for="indirizzo">Indirizzo di residenza</label>
						    <input type="text" id="indirizzo" name="indirizzo" placeholder="Via/Piazza...">
						    
						    <label for="emailDip">Email</label>
						    <input type="email" id="emailDip" name="email" placeholder="abc@sincrono.it">
						    
						    <label for="password">Password</label>
						    <input type="text" id="pass" name="psw" placeholder="">
						    
						    <br>
						    <label for="ruoloDropdown">Ruolo</label>
						    <select id="ruoloDropdown" name="ruolo">
							        <option value="4">Amministrativo</option>
							        <option value="3">Commerciale</option>
							        <option value="2">Sviluppatore</option>
							        <option value="1">PM</option>
							        <option value="5">Admin</option>
					      		</select>	
					      	
					      	<label for="dataInizio">Data inizio contratto</label>
						    <input type="date" id="dataInizio" name = "dataI">
						    
						    <label for="dataFine">Data fine contratto</label>
						    <input type="date" id="dataFine" name ="dataF">	    
  						</div>
						<div class="modal-footer">
  							<input type="submit" class="btn btn-primary btn-md" value="Crea Dipendente"/>
  							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
						</div>  
 					</form> 
			</div>
			</div>
	</div>
	</div>
	</div>
</div>

<script>
	$(document).ready(function(){
	  $("#myInput").on("keyup", function() {
	    var value = $(this).val().toLowerCase();
	    $("#myTable tr").filter(function() {
	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    });
	  });
	});
	</script>
	

</body>
</html>