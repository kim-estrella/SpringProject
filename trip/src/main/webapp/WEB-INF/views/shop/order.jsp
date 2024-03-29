<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>가자 GO</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="../assets/css/main.css?after" />
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
$(function(){
	$("#amount").on("propertychange change keyup",function(){
	    var amount = $("#amount").val();
	    var price = $("#price").val();
	    var money = amount * price ;
	    $("#money").html(money);
	});	
});

function showPostcode(){
	new daum.Postcode({
		oncomplete : function(data){
			var fullAddr = "";
			var extraAddr = "";
			
			if(data.userSelectedType === "R"){ // '==='  자료형과 값 모두 검사   '==' 값만 검사
				fullAddr = data.roadAddress;
			} else{
				fullAddr = data.jibunAddress;
			}
			
			if(data.userSelecteType === "R"){
				if(data.bname !== ""){ // === 자료형과 값 모두 검사
					extraAddr += data.bname;
				}
				if(data.buildingName !== ""){
					extraAddr += (extraAddr !== "" ? ", "+ data.buildingName : data.buildingName);
				}
				fullAddr += (extraAddr !== "" ? " (" + extraAddr + ")" : "");	
			}
			document.getElementById("post_code").value = data.zonecode;
			document.getElementById("address").value=fullAddr;
			document.getElementById("address2").focus();
		}
	}).open();
}

function btnPay(){
	var amount = document.form2.amount.value;//인원수
	var name = document.form2.name.value;//성함
	var email = document.form2.email.value; //이메일
	var post_code = document.form2.post_code.value;//우편번호
	var address = document.form2.address.value;//주소
	var address2 = document.form2.address2.value;//상세 주소
	var phone = document.form2.phone.value;//전화번호
	var pay = document.form2.pay.value;//결제 방법
	
	if(amount =="" || amount <= 0){
		alert("인원수를 1명 이상 입력하세요.");
		return;
	}
	if(name ==""){
		alert("성함을 입력하세요.");
		document.form2.name.focus();
		return;
	}
	if(email == ""){
		alert("이메일을 입력하세요.");
		document.form2.email.focus();
		return;
	}
	if(post_code ==""){
		alert("우편번호를 입력하세요.");
		document.form2.post_code.focus();
		return;
	}
	if(address2 ==""){
		alert("상세 주소를 입력하세요.");
		document.form2.address2.focus();
		return;
	}
	if(phone ==""){
		alert("전화번호를 입력하세요.");
		document.form2.phone.focus();
		return;
	}
	if(pay ==""){
		alert("결제 방법을 입력하세요.");
		document.form2.pay.focus();
		return;
	}

	document.form2.action="/order/insert.do";
	document.form2.submit();
}

</script>
</head>

<body class="order_list">
	<div id="page-wrapper">
		<%@ include file="../include/menu.jsp"%>

		<!-- Main -->
		<section id="main">
			<div class="container">
				<h2 style="text-align:center">ORDER</h2> <br>
				<form name="form2" id="form2" method="post" >
					<table>
						<tr>
							<th></th>
							<th>여행 상품명</th>
							<th>가격</th>
							<th></th>
							<th>인원 수</th>
							<th>총 금액 </th>
							<th></th>
						</tr>
						<!-- 상품 정보 (제목, 가격, 인원 수) -->
						<tr>
							<td></td>
							<td>${dto.title}</td>
							<td>${dto.price}</td>
							<td>
     							<input type="hidden" id="price" value="${dto.price}">
  							</td>
  							<td>
      							<input type="number" style="border:solid 1px #dddddd; border-radius:5px; width:50px;" min="0" max="100" name="amount" id="amount"> 명
      							<input type="hidden" name="code" value="${dto.code}">
   							</td>
   							<td><span id="money"></span>원</td>
						</tr>
						<tr>
							<td>예약자 성함</td>
							<td><input id="name" name="name" style="border:solid 1px #dddddd; border-radius:5px;"></td>
						</tr>
						<tr>
							<td>예약자 이메일</td>
							<td><input id="email" name="email" style="border:solid 1px #dddddd; border-radius:5px;"></td>
						</tr>
						<tr>
							<td>우편번호</td>
							<td><input name="zipcode" id="post_code" style="border:solid 1px #dddddd; border-radius:5px;" readonly> &nbsp;&nbsp;&nbsp;
							<input type="button" onclick="showPostcode()" value="우편번호 찾기" style="font-size:12px; text-align:center; padding:0px; width:100px; height:30px;"></td>
						</tr>
						<tr>
							<td>주소</td>
							<td><input name="address" id="address" size="60" style="border:solid 1px #dddddd; border-radius:5px;" readonly></td>
						</tr>
						<tr>
							<td>상세 주소</td>
							<td><input name="address2" id="address2" style="border:solid 1px #dddddd; border-radius:5px;"></td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td><input name="phone" id="phone" style="border:solid 1px #dddddd; border-radius:5px;"></td>
						</tr>
						<tr> 
							<td>결제 방법</td> 
							<td>
								<select name="pay" id="pay" style="width:165px; padding:2.5px;"> 
									<option value="">결제방법 선택</option>
									<option value="1">계좌이체</option>
									<option value="2">신용카드</option>
								</select>
							</td>
						</tr>
					</table>
					<input type="button" onclick="btnPay()" value="결제하기">
				</form>
			</div>
								
		</section>
		
		<!-- Footer -->
		<section id="footer">
			<%@ include file="../include/footer.jsp"%>
		</section>
	</div>
</body>
</html>