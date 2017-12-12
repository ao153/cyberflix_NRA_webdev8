<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page import="java.util.*" %>
<%@ page import = "edu.txstate.internet.cyberflix.data.DataSource" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="http://localhost:8080/CyberFlix_NRA/stylesheet.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script
src="https://code.jquery.com/jquery-3.2.1.min.js"
integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
crossorigin="anonymous"></script>

<title>CyberFlix Search Results</title>
</head>
<body>
<div class="w3-container w3-black w3-right-align padding" style = "padding-top:10px">
  <img class = "logo"
       src = "http://localhost:8080/CyberFlix_NRA/images/logo.jpg"
       alt = "logo"
       >
<h1>Movies Matching Your Search</h1>
<p> Here are the movies we found </p>
<!-- shopping cart icon -->
<% String sessionID = request.getSession().getId(); %>
<c:set var="sessionID" value="<%=sessionID%>" />
<c:if test="${DataSource.getCart(sessionID).getSize() != 0}">
<p class = "w3-left-align detailCartStuff"> <a id="cartLink" href="CyberFlixCartServlet" class ="dCS2">Shopping Cart
<i class="material-icons" style="font-size:30px;vertical-align:middle;color:#B82601;">add_shopping_cart</i>
</a>
<!-- CHECKOUT BTN -->
<br>
<a href="CyberFlixCheckoutServlet">
<button 
	class="w3-button w3-large w3-round-large checkoutBtn w3-left-align w3-teal" 
	value="checkout"
>	
	Click to Checkout
</button>
</a>
<!-- END CHECKOUT BTN -->
</p>
</c:if>
<!-- end shopping cart icon -->
</div>
<br>
<c:if test="${empty films}">
<div class = "w3-card-4 card w3-padding center" >
<i> We Couldn't Find Anything That Matched Your Search. </i>
<p> Go Back And Try Again! </p>
</div>
</c:if>
<% int i = 0; %>
<c:forEach var="film" items="${requestScope.films}">
<% String source = "http://localhost:8080/CyberFlix_NRA/images/" + i + ".jpeg"; %>
<div class="w3-card-4 center card" style = "height: 315px; width: 700px">
<div class = "w3-row">
    <div class = "w3-cell">
    <a href="${requestScope.detailServlet}?film_title=${film.getTitle()}&source=<%=source%>">
    <img class="w3-image"
         style = "height: 315px; width: 210px"
         src=<%=source%>
         alt="${film.title}"
    >
    </a>
    </div>
<div class = "w3-cell w3-cell-top w3-padding">
<h3><c:out value="${film.getTitle()}"/></h3><br>
<b>Year: </b><c:out value="${film.getReleaseYear()}"/><br>
<b>Rating: </b><c:out value="${film.getRating()}"/><br>
<b>Running Time: </b><c:out value="${film.getLength()}"/><hr>
<c:out value="${film.getDescription()}"/>
<br>
<a href="${requestScope.detailServlet}?film_title=${film.getTitle()}&source=<%=source%>" class = "srdetails"> View Details... </a>
<button class = "w3-button w3-large w3-round-large srCart" value = "cart" id="${film.getTitle()}">Add to Cart 
<i class="material-icons" style="font-size:30px;vertical-align:middle;">add_shopping_cart</i>
</button>
</div>
</div>

<% i ++;
if(i == 9)
i = 0;
%>
</div>
<br> 
</c:forEach>
<script>
$("button.srCart").click(function() {
  myUrl = "addCartServlet?addFilm=" + $(this).attr('id'); 
  $.ajax({
        type : "POST",
        url : myUrl,
          datatype: "text",
        success : function(response){},
        error : function(jqXHR, exception){}
   });
  $(this).css("backgroundColor", "gray");
});
</script>
</body>
</html>