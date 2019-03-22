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
.dropdown {
  position: absolute;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 99;
}

.dropdown-content a {
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  z-index: 99;
}

.dropdown:hover .dropdown-content {
  display: block;
  z-index: 99;
}
.pointer {cursor: pointer;}
</style>

<meta charset="ISO-8859-1">
<title>Cespiti</title>


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

<!-- Sezione  CESPITI-->
<div class="container">
			<div class=infiltrato></div>
			<div class="col-sm-6">
  			<h2> Gestione Cespiti</h2>
  			</div>
  			
  			<div class="col-sm-3" style= "padding-top:20px;">
  					<p>INSERISCI NUOVO CESPITE:</p>
       				<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModalNuovo">
        			<span class="glyphicon glyphicon-plus"></span> Inserisci
       				</button>
			</div> 
  			
 			<div class="col-sm-3" style= "padding-top:20px;">
  					<p>TUTTE LE ASSEGNAZIONI:</p>
       				<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModalViewAss">
        			<span class="glyphicon glyphicon-zoom-in"></span> Vedi
       				</button>
			</div> 
			
			
				<div class="container" style= "padding-top:20px;">
				<h3>Lista Cespiti</h3>
 				<input class="form-control" id="myInput" type="text" placeholder="Search..">
 		 		<br>
 			<div class="table-wrapper-scroll-y my-custom-scrollbar" >
		 		<table class="table table-bordered table-striped" style="z-index:'1'" >
				    <thead>
				      <tr>
				        <th>Id_cespite</th>
						<th>Descrizione</th>
						<th>Stato</th>
						<th>Tipologia</th>
						<th></th>
				      </tr>
				    </thead>
				    <tbody id="myTable" >
				      
					    <c:forEach items="${listaCespiti}" var="x">
							  <tr>
							  	<td>${x.id_cespite}</td>
								<td>${x.descrizione}</td>
								<td>${x.stato}</td>
								<td>${x.tipologia}</td>
								<td>
							    	<div class="dropdown" style="overflow: visible;">
									  <button class="btn btn-default btn-xs"><span class="glyphicon glyphicon-cog">Opzioni</span></button>
										  <div class="dropdown-content" style="z-index: '100'" >
										  <a href="#containerFormCespiti"
										  	data-toggle="modal" data-target="#myModalCespite" class="btn btn-default btn-xs"
										   	onclick="autoFillForm('${x.id_cespite}','${x.descrizione}', '${x.stato}','${x.tipologia}')">
										   		Modifica Cespite</a>
										   
										   <a href="/amm/deleteCesp?id=${x.id_cespite}" class="btn btn-default btn-xs">Elimina Cespite</a> 	
										   
										   	<c:if test= "${x.stato eq 'Assegnato' }">
										   		<a href="/amm/delAssCesp?id=${x.id_cespite}" class="btn btn-default btn-xs">Elimina Assegnazione Cespite</a>
										   	</c:if>
										   	<c:if test= "${x.stato eq 'Non Assegnato' }">
										   		<a href="#containerFormCespiti" class="btn btn-default btn-xs"
										  	 		data-toggle="modal" data-target="#myModalAssignDip"
										   			onclick="autoFillFormDip('${x.id_cespite}')"> Assegna a Dipendente </a>
										   		<a href="#containerFormCespiti" class="btn btn-default btn-xs"
										  	 		data-toggle="modal" data-target="#myModalAssignStr"
										   			onclick="autoFillFormStr('${x.id_cespite}')"> Assegna a Struttura </a>
										  	</c:if>
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
	<div id="myModalCespite" class="modal fade">
	<div class="modal-dialog">
	<div class="modal-content">
		<!--   This is the Div for HEADER-->
			<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h2 class="modal-title">Modifica Cespite</h2>
			</div>
			<!--   This is the Div for BODY-->
				<div class="modal-body">
				<div id="modCli">
					
					<form method="post" action="/amm/editCesp"> 
 						<div class="form-group">
						 					 		
						<input type="number" id="id_cespite" name="idCespite" style="display: none;">
						<input type="text" id="stato" name="stato" style="display: none;">
						
						<label for="descrizione">Descrizione</label>
						<input type="text" id="descrizione" name="descrizione" placeholder="Inserisci descrizione...">			
						
						<label for="tipoDropdown">Tipologia</label>
						<select id="tipoDropdown" name="tipologiaCespite">
							<option value="Elettronica">Elettronica</option>
							<option value="Arredamento">Arredamento</option>
					    </select>	


<!-- 						    <input style="float: left;" type="button" value="Annulla" onclick="resetForm()"> -->
<!-- 						    <input style="float: right;" type="submit" onclick="resetForm()" value="Salva"> -->
			    
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
			<h2>Nuovo Cespite</h2>
			</div>
			<!--   This is the Div for BODY-->
				<div class="modal-body">
				<div id="newDip">
					
					<form method="post" action="/amm/insCesp"> 
 						<div class="form-group">
						 					 		
						<input type="number" id="id_cespite" name="idCespite" style="display: none;">
						<input type="text" id="stato" name="stato" style="display: none;">
						
						<label for="descrizione">Descrizione</label>
						<input type="text" id="descrizione" name="descrizione" placeholder="Inserisci descrizione...">			
						
						<label for="tipoDropdown">Tipologia</label>
						<select id="tipoDropdown" name="tipologiaCespite">
							<option value="Elettronica">Elettronica</option>
							<option value="Arredamento">Arredamento</option>
					    </select>	


<!-- 						    <input style="float: left;" type="button" value="Annulla" onclick="resetForm()"> -->
<!-- 						    <input style="float: right;" type="submit" onclick="resetForm()" value="Salva"> -->
			    
  						</div>
						<div class="modal-footer">
  							<input type="submit" class="btn btn-primary btn-md" value="Conferma Modifiche"/>
  							<button type="button" class="btn btn-default" data-dismiss="modal">Chiudi</button> 
						</div>  
 					</form>  
			</div>
			</div>
	</div>
	</div>
	</div>
	
	
	<!--  MODAL DI ASSEGNAMENTO A DIPENDENTE-->
	<div id="myModalAssignDip" class="modal fade">
	<div class="modal-dialog">
	<div class="modal-content">
		<!--   This is the Div for HEADER-->
			<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h2>Assegna ad un dipendente</h2>
			</div>
			<!--   This is the Div for BODY-->
				<div class="modal-body">
				<div id="modDip">
					
					<form method="post" action="/amm/assignCespDip"> 
 						<div class="form-group">
						 					 		
						<input type="number" id="idCesp" name="idCesp" style="display: none;">
						<input type="number" id="idDipDaPassare" name="idDip" style="display: none;">
							
							<div class="table-wrapper-scroll-y my-custom-scrollbar">
				 				<table class="table table-bordered table-striped" id="MyAddingTable">
								    <thead>
								      <tr >
								      	<th>Id</th>
								        <th>Nome</th>
									    <th>Cognome</th>
									    <th>Codice fiscale</th>
				
								      </tr>
								    </thead>
								    <tbody id="myDips">
								  		<c:forEach items="${listaDipendenti}" var="x">
										 <tr class="pointer">
										  <td>${x.id_dipendente}</td>
										  <td>${x.nome}</td>
										  <td>${x.cognome}</td>
										  <td>${x.cod_fiscale}</td>
										 </tr>
									    </c:forEach>
								    </tbody>
								 </table>
				  			</div>
				  			<label for="dataInizio">Data inizio assegnazione</label>
						    <input type="date" id="dataInizio" name = "dataI">
						    <br/>
						    <label for="dataFine">Data fine assegnazione</label>
						    <input type="date" id="dataFine" name ="dataF">
  					 </div>
						<div class="modal-footer">
  							<input type="submit" class="btn btn-primary btn-md" value="Assegna"/>
  							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button> 
						</div>  
 					</form> 
			</div>
			</div>
	</div>
	</div>
	</div>
	
	<!--  MODAL DI ASSEGNAMENTO A STRUTTURA-->
	<div id="myModalAssignStr" class="modal fade">
	<div class="modal-dialog">
	<div class="modal-content">
		<!--   This is the Div for HEADER-->
			<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h2>Assegna ad una Struttura</h2>
			</div>
			<!--   This is the Div for BODY-->
				<div class="modal-body">
				<div id="modStr">
					
					<form method="post" action="/amm/assignCespStr"> 
 						<div class="form-group">
						 					 		
						<input type="number" id="idCesp2" name="idCesp2" style="display: none;">
						<input type="number" id="idStrDaPassare" name="idStruct" style="display: none;">
							
							<div class="table-wrapper-scroll-y my-custom-scrollbar">
				 				<table class="table table-bordered table-striped" id="MyAddingTable2">
								    <thead>
								      <tr>
								        <th>Id Struttura</th>
									    <th>Nome Struttura</th>  			
								      </tr>
								    </thead>
								    <tbody id="myStruts">
								  		<c:forEach items="${listaStrutture}" var="x">
										 <tr class="pointer">
										  <td>${x.id_struttura}</td>
										  <td>${x.descrizione}</td>
										 </tr>
									    </c:forEach>
								    </tbody>
								 </table>
				  			</div>
				  			<label for="dataInizio">Data inizio assegnazione</label>
						    <input type="date" id="dataInizio2" name = "dataIn">
						    <br/>
						    <label for="dataFine">Data fine assegnazione</label>
						    <input type="date" id="dataFine2" name ="dataFn">
  					 </div>
						<div class="modal-footer">
  							<input type="submit" class="btn btn-primary btn-md" value="Assegna"/>
  							<button type="button" class="btn btn-default" data-dismiss="modal">Annulla</button> 
						</div>  
 					</form> 
			</div>
			</div>
	</div>
	</div>
	</div>
	
	<!--  MODAL DELLA VIEW DELLE ASSEGNAZIONI  -->
	<div id="myModalViewAss" class="modal fade">
	<div class="modal-dialog modal-lg">
	<div class="modal-content">
		<!--   This is the Div for HEADER-->
			<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h2>Tutte le Assegnazioni</h2>
			</div>
			<!--   This is the Div for BODY-->
				<div class="modal-body">
				<div id="modDip">
					
					<form method="post" action="/amm/assignCespDip"> 
 						<div class="form-group">
						 					 		
						<input type="number" id="idCesp" name="idCesp" style="display: none;">
						<input type="number" id="idDipDaPassare" name="idDip" style="display: none;">
							
							<div class="table-wrapper-scroll-y my-custom-scrollbar">
				 				<table class="table table-bordered table-striped">
								    <thead>
								      <tr>
								        <th style="display:none">Id</th>
									    <th>Tipo</th>
									    <th>Id Assegnatario</th>
									    <th>Nome Assegnatario</th>
									    <th>Id Cespite</th>
									    <th>Descrizione Cespite</th>
									    <th>Inizio</th>
									    <th>Fine</th>
								      </tr>
								    </thead>
								    <tbody id="myTable">
								      
									    <c:forEach items="${listaAssegnazioniMod}" var="x">
											  <tr>
											  	<td style="display:none">${x.id_assegnazione_cespiti}</td>
											    <td>${x.id_tipologia eq '1'?"Dipendente":"Struttura"}</td>
											    <td>${x.id_assegnatario}</td>
											    <td>${x.nomeAss}</td>
											    <td>${x.id_cespite}</td>
											    <td>${x.nomeCespite}</td>
											     <fmt:formatDate value="${x.data_inizio}" var="dataInizio" 
               			 							type="date" pattern="dd-MM-yyyy" />
               			 						 <fmt:formatDate value="${x.data_fine}" var="dataFine" 
               										type="date" pattern="dd-MM-yyyy" />
											    <td>${dataInizio}</td>
											    <td>${dataFine}</td>
										  </tr>
									  </c:forEach>
								    </tbody>
								  </table>
				  			</div>
				  			
  					 </div>
						<div class="modal-footer">
  					
  							<button type="button" class="btn btn-default" data-dismiss="modal">Chiudi</button> 
						</div>  
 					</form> 
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
	
<script>
function autoFillForm(id_cespite,descrizione,stato,tipologia){
document.getElementById('id_cespite').value = id_cespite;
document.getElementById('descrizione').value = descrizione;
document.getElementById('stato').value = stato;
document.getElementById('tipologia').value = tipologia;
}

function autoFillFormDip(id_cespite){
	document.getElementById('idCesp').value = id_cespite;
	
	}
function autoFillFormStr(id_cespite){
	document.getElementById('idCesp2').value = id_cespite;
	
	}
</script>

<script>

var table = document.getElementById("MyAddingTable");
var tbody = table.getElementsByTagName("tbody")[0];

tbody.onclick = function (e) {
    e = e || window.event;
    var data = [];
    var nome=[];
    var cognome=[];
    var target = e.srcElement || e.target;
    while (target && target.nodeName !== "TR") {
        target = target.parentNode;
    }
    if (target) {
        var cells = target.getElementsByTagName("td");
            data.push(cells[0].innerHTML);
            nome.push(cells[1].innerHTML);
            cognome.push(cells[2].innerHTML);
        	
    }
    document.getElementById("idDipDaPassare").value=data;
    alert("Hai scelto "+nome+ " " +cognome);
};
</script>

<script>

var table2 = document.getElementById("MyAddingTable2");
var tbody2 = table2.getElementsByTagName("tbody")[0];

tbody2.onclick = function (e) {
    e = e || window.event;
    var data = [];
    var nome =[];
    var target = e.srcElement || e.target;
    while (target && target.nodeName !== "TR") {
        target = target.parentNode;
    }
    if (target) {
        var cells = target.getElementsByTagName("td");
        
            data.push(cells[0].innerHTML);
            nome.push(cells[1].innerHTML);
            
        
    }
    document.getElementById("idStrDaPassare").value=data;
    alert("Hai scelto "+nome);
};

</script>
</body>
</html>