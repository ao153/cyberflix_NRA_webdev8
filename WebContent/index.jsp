<%@ page import="com.mysql.*" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import = "edu.txstate.internet.cyberflix.data.db.FilmDAO" %>
<%@ page import = "edu.txstate.internet.cyberflix.data.film.Film" %>
<%@ page import = "edu.txstate.internet.cyberflix.data.DataSource" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<% List<Film> newFilms = DataSource.findNewestFilms(5);%>
<% request.getSession().setAttribute("newFilms", newFilms);%>
<html> 
<head><title>CyberFlix</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="http://localhost:8080/CyberFlix_NRA/stylesheet.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
  src="https://code.jquery.com/jquery-3.2.1.min.js"
  integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
  crossorigin="anonymous"></script>
</head> 
<style>
div.galleryIndex {
    margin: 5px;
    border: 1px solid #ccc;
    float: left;
    width: 180px;
}
div.hoverIndex {
    border: 1px solid #777;
}
div.galleryIndex img {
    width:180px;
    height:270px;
}
div.descIndex {
    padding: 15px;
    text-align: center;
    background-color: rgba(255, 255, 255, 0.6); 
}
</style>
<body> 
<div class="container w3-black">      
      <img class="logo"
           src="http://localhost:8080/CyberFlix_NRA/images/logo.jpg" 
           alt="Logo" 
           style="width:auto;height:200px"
      >
      <div class="topleft">Welcome to...</div>
      <!--  LOGIN CODE -->
      <a style="color:red;" href="login.jsp" target="_blank">LOGIN</a>
      <!-- END LOGIN CODE -->
</div>
<br>
<div class="w3-card-4 w3-section card center">
    <header class="w3-container color1">
    <c:set var="alphabet" value="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z" />
<table cellspacing="4">
<tr>
    <td>Browse Alphabetically:</td>
    <c:forTokens var="letter" items="${alphabet}" delims=",">
   <td align="center"></td> <td><a href="CyberFlixServlet?alpha=${letter}">${letter}</a></td>
    </c:forTokens>
     
 </tr>
 </table>
 <div class="w3-dropdown-click">
 <c:set var="categories" value="ACTION,ANIMATION,CHILDREN,CLASSICS
 							  ,COMEDY,DOCUMENTARY,DRAMA,FAMILY,FOREIGN
 							  ,GAMES,HORROR,MUSIC,NEW,SCI_FI,SPORTS,TRAVEL" />
  <button onclick="myFunction()" class="w3-button w3-black">Browse by Genre</button>
  <div id="DropDown" class="w3-dropdown-content w3-bar-block w3-border">
   <c:forTokens var="category" items="${categories}" delims=",">
	   <td align= "center"></td> 
	   <td>
	   <a href="CyberFlixServlet?category=${category}" 
	  	class="w3-bar-item w3-button">${category}</a>
	   </td>
   </c:forTokens>  
  </div>
</div>

<script>
function myFunction() {
    var x = document.getElementById("DropDown");
    if (x.className.indexOf("w3-show") == -1) {  
        x.className += " w3-show";
    } else { 
        x.className = x.className.replace(" w3-show", "");
    }
}
</script>
    <h1 class="w3-text-white" style="text-shadow: 1px 0px 0 #444">Search</h1>
    </header>
    <form action="http://localhost:8080/CyberFlix_NRA/CyberFlixServlet" method="get">
    <div class="w3-container">
    <br><label>Film Title</label>
    <input class="w3-input" type="text" name="film_title">
    <label>Film Description</label>
    <input class="w3-input" type="text" name="film_description">
    <hr>
    <label>Max Film Rating</label> <br>
    <input class="w3-check" type ="radio" name="film_rating" value ="G">
    <label>G</label>
    <input class="w3-check" type ="radio" name="film_rating" value ="PG">
    <label>PG</label>
    <input class="w3-check" type ="radio" name="film_rating" value ="PG_13">
    <label>PG-13</label>
    <input class="w3-check" type ="radio" name="film_rating" value ="R">
    <label>R</label>
    <input class="w3-check" type ="radio" name="film_rating" value ="NC_17">
    <label>NC-17</label>
    <input class="w3-check" type ="radio" name="film_rating" value ="X">
    <label>X</label>
    <input class="w3-check" type ="radio" name="film_rating" value ="UR" checked>
    <label>Unrated</label>
    <hr>
    <label>Max Running Time (in minutes)</label><br>
    <input class = "w3-check" type="radio" name = "length" value = "30"> 
    <label>30</label>
    <input class = "w3-check" type="radio" name = "length" value = "60">
    <label>60</label>
    <input class = "w3-check" type="radio" name = "length" value = "90">
    <label>90</label>
    <input class = "w3-check" type="radio" name = "length" value = "120">
    <label>120</label>
    <input class = "w3-check" type="radio" name = "length" value = "150">
    <label>150</label>
    <input class = "w3-check" type="radio" name = "length" value = "200">
    <label>200</label>
    <input class = "w3-check" type="radio" name = "length" value = "Any" checked>
    <label>Any</label> <br><br>
    </div>
    <button class="w3-button w3-block w3-light-grey w3-right-align" type = "submit" value = "Submit">Submit</button>
    </form>
    </div>
    
<table class = "center">
<tr>
    <% int i = 0; %>
    <c:forEach var="film" items="${newFilms}">
    <td>
    <div id="new" class = "gallery container1">
    <%String source ="http://localhost:8080/CyberFlix_NRA/images/" + i + ".jpeg";  %>
<%--     <a href="http://localhost:8080/CyberFlix_NRA/CyberFlixMovieDetailServlet?film_title=${film.getTitle()}&source=<%=source%>"> --%>
    <img src=<%=source %> alt="${film.getTitle()}" width="180px" height="270px">
    <div class ="middle">
    <a class="coverButton" href="CyberFlixMovieDetailServlet?film_title=${film.getTitle()}&source=<%=source%>" >
    <button class = "w3-button w3-middle-align details" value = "details">More Info</button>
    </a><br>
    <a class="coverButton" href="#" onclick="myFunction()"><button class = "w3-button w3-middle-align cart" value = "cart">Add to Cart </button></a>
    <script>
	function myFunction() {
    $.ajax({
        type : "POST",
        url : "addCartServlet?addFilm=${film.title}",
        	datatype: "text",
        success : function(response){/*alert("success")*/},
        error : function(jqXHR, exception){/*alert("error")*/}
	 });
	}
	</script>
    </div>
    <div class="desc">${film.getTitle()} (${film.getReleaseYear()})</div>
    </div>
    
    </td>
    <% i++;%>
    </c:forEach>
</tr>
</table>

</body>
</html>