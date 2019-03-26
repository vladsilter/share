<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>Note</title>
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

#card{margin-top:60px;}
#info{margin-top:60px; padding-left:50px;}

 
</style>
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
  			<button class="logoutBtn" style="background-color: red;" onclick="" >Logout</button>
  </form>
</nav> 
<br/>
<br/>
<!-- Sezione NOTE -->
<div id="Note" style= "margin-bottom:50px;">
	<div class="my">
	<div class="container">
			<div class=infiltrato></div>
			<div class="col-sm-9">
			<h2>Gestione Note</h2>	
			</div>
 			<div class="col-sm-3" style= "padding-top:20px;">
 			<p> INSERISCI NUOVA NOTA: </p>
 			<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal">
        	<span class="glyphicon glyphicon-plus"></span> Nota
       		</button>
			</div>
			
		<div class="container" style= "padding-top:20px;">
			<h3>Lista Note</h3>
 		 <input class="form-control" id="myInput" type="text" placeholder="Search..">
 		 <br>
 		 <div  class="table-wrapper-scroll-y my-custom-scrollbar">
  		<table class="table table-bordered table-striped">
   			 <thead>
     			 <tr>
       			 <th>Progetto</th>
       			 <th>Autore</th>
       			 <th>Nota</th>
       			 <th></th>
     			 </tr>
  			 </thead>
   			 <tbody id="myTable">			
   			 	<c:forEach items="${lista}" var="x">
				<tr>
       			 	<% 
					String stringa=(String)pageContext.getAttribute("x");
					String[] myArray=(stringa.split(":"));
					pageContext.setAttribute("idNota", myArray[0]);
					pageContext.setAttribute("Progetto", myArray[1]);
					pageContext.setAttribute("Autore", myArray[2]);
					pageContext.setAttribute("Nota", myArray[3]);
					%>
				<td>${Progetto}</td>
				<td>${Autore}</td>
				<td>${Nota}</td>
				<td><a href = "/dev/deleteNota?id=${idNota}" class = "btn btn-default btn-xs">Elimina</a></td>
				</tr>
				</c:forEach>
			</tbody>
 		</table>
 		</div>
	</div>
	</div>
	</div>
	

	<!--  This is Modal Box To hold Complete Content in Div-->
	<div id="myModal" class="modal fade">
	<div class="modal-dialog">
	<div class="modal-content">
	<!--   This is the Div for HEADER-->
		<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		<h4 class="modal-title">Nuova Nota</h4>
		</div>
	<!--   This is the Div for BODY-->
		<div class="modal-body">
		<div id="newRil">
			<h2>Nuova Nota</h2>
				<form method="post" name="formnote" onsubmit="return validateForm()" action="/dev/addNota"> 
 					
 					 <label for="progetto">Select Project:</label>
 						<select  name="progetto">
    						<c:forEach items="${progTend}" var="titolo">
				  			 
				  			  <option value="${titolo}">${titolo}</option>
				   			  
				  			  </c:forEach>
  						</select>
					 
				
 						<label for="newNote">Note:</label>
 						<textarea class="form-control" rows="5" name="nota"></textarea>
 					
  					<br>
					<div class="modal-footer">
  						<input type="submit" class="btn btn-primary btn-md" value="invia"/> 
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


function validateForm()
{
    var a=document.forms["formnote"]["nota"].value;
    if (a==null || a=="")
    {
        alert("Inserisci una nota");
        return false;
    }
}
</script>

</body>
</html>