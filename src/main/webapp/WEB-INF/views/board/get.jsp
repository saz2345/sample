<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ include file="../inclueds/Header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Read Page</div>

			<div class="panel-body">
				<div class="form-group">
					<label>Bno</label> <input class="form-control" name="bno"
						value='<c:out value="${board.bno }"/>' readonly>
				</div>
				<div class="form-group">
					<label>Title</label> <input class="form-control" name="title"
						value='<c:out value="${board.title }"/>' readonly>
				</div>
				<div class="form-group">
					<label>Textarea</label>
					<textarea class="form-control" rows="3" name="content" readonly>
<c:out value="${board.content }" />
                  </textarea>
				</div>
				<div class="form-group">
					<label>Writer</label> <input class="form-control" name="writer"
						value='<c:out value="${board.writer }"/>' readonly>
				</div>
				<!-- 리스트 화면으로 되돌아가는 버튼 + 수정화면으로 가는 버튼  -->
				<sec:authentication property="principal" var="principal"/>
				<sec:authorize access="isAuthenticated()">
				<c:if test="${principal.username eq board.writer }">				
				<button data-oper="modify" class="btn btn-default">Modify</button>
				</c:if>
				</sec:authorize>
				<!-- button[data-oper='modify'] -->
				<button data-oper="list" class="btn btn-info">List</button>
				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" id="bno" name="bno"
						value='<c:out value="${board.bno }"/>'>
					<!-- 우리가 보고있던 페이지 정보 숨겨놓기 -->
					<input type="hidden" name="pageNum"
						value='<c:out value="${cri.pageNum }"/>'> <input
						type="hidden" name="amount"
						value='<c:out value="${cri.amount }"/>'> <input
						type="hidden" name="keyword"
						value='<c:out value="${cri.keyword }"/>'> <input
						type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
				</form>
			</div>
		</div>
	</div>
</div>

<!-- 댓글 등록용 새창 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
aria-labelledby="myModallabel" aria-hidden="true">
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
		<button type="button" class="close" data-dissmiss="modal" aria-hidden="true">
		&times;</button>
		<h4 class="modal-title" id="myModallabel">REPLY MODAL</h4>
		</div>
		<div class="modal-body">
		 <div class="form-group">
		 <label>Reply</label>
		 <input class="form-control" name="reply" placeholder="NEW REPLY!">
		 </div>
		 <div class="form-group">
		 <label>Replyer</label>
		 <input class="form-control" name="replyer" placeholder="replyer">
		 </div>
		</div>
		<!-- 버튼 모음 (수정, 삭제, 등록 , 닫기) -->
		<div class="modal-footer">	
			<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
			<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>	
			<button id="modalRegisterBtn" type="button" class="btn btn-primary">Register</button>
			<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
			</div>
	</div>
</div>

</div>


<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i>Reply
				
				<sec:authorize access="isAuthenticated()">
				<button id="addReplyBtn"
				class="btn btn-primary btn-xs pull-right">
				New Reply</button>
				</sec:authorize>
				
			</div>
			<div class="panel-body">
			<!-- 댓글 시작 -->
			<ul class="chat">
				<!-- 여기에 댓글이 들어올것이다 -->
			</ul>
			</div>
			<div class="panel-footer">
			<!-- 여기에 페이지 버튼이 들어올것이다. -->
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/resources/js/Reply.js"></script>
<script type="text/javascript">
	//console.log("==========JS TEST ============");

	//var bnoValue = '<c:out value="${board.bno}"/>';

	/*	 replyService.add(
			{reply: "JS TEST" , replyer: "tester", bno:bnoValue},
			function(result) {
				alert("RESULT : " + result);
			}
		 );  */
	//getList 함수 (param, callback, error)
	/*replyService.getList({
		bno : bnoValue,
		page : 1
	}, function(list) {
		//현재 게시글의 댓글 목록을 콘솔에 출력
		for (let i = 0; i < list.length; i++) {
			console.log(list[i]);
		}
	})*/
	//remove 함수 (rno, callback, erro)
	/*	 replyService.remove(6 , function(count) {
			 console.log(count);
			 if(count == "success") {
				 alert("removed");
			 }
		 },
		 function(err){
			 alert("뭔가 잘못됨");
		 }
		 );*/
	//update 함수(reply, callback, error)
	/* replyService.update({
		 rno : 9,
		 bno : bnoValue,
		 reply : "modified reply...."
	 },
	 function(result) {
		 alert("수정 완료");
	 }
	 );*/
	//get 함수()
	/*replyService.get(9, function(date) {
		console.log(date);
	})*/
	$(document).ready(function() {
		var bnoValue = '<c:out value="${board.bno}"/>';
		//우리가 li태그를 동적으로 추가한다는 말은 
		//ul 태그를 찾아서 그 태그의 자손으로 붙여 주겟다.	
		//ul.html(dddddd) : ul 태그의 안의 html 코드를 수정
		var replyUL = $(".chat");
		
		//동적으로 댓글을 만들어서 붙여주는 함수
		//요청이 성공했으면 그때 댓글을 만들어서 붙여주면 된다.
		//요청이 성공했으면 그때 댓글을 만든다 ===> callback 함수에 처리하면 된다.
		showList(1);
		
		function showList(page) {
			
			//params : 페이지 정보, 게시글번호
			replyService.getList({
				bno : bnoValue,
				page : page || 1
			}, function(replyCnt, list) {
				//요청성공시 callback 함수에 list를 받아온다.
				console.log("replyCnt : " + replyCnt);
				console.log("list : " + list);
				
				//만약 페이지 번호가 -1로 전달되면 마지막 페이지로 가도록
				if(page == -1) {
					//댓글 개수가 7개일떄 페이지 몇개? (1페이지 10개라고 하면) 페이지 개수 1개
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				var comments = ""; //여기에 html 코드를 조립
				if(list == null || list.length == 0) {
					//해당 게시물에는 댓글이 없다
					//html 코드를 조립할 필요가 없다.
					replyUL.html("");
					return; // 함수 바로 종료
				}
				//여기로 오면 댓글이 있다는 의미,
				//for 문을 이용해서 list 안에 있는 댓글 목록을
				//<li> 태그로 만들어서 조립해주면 된다.
				for(let i = 0; i<list.length; i++) {
					comments += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
					comments += "<div>";
					comments += "<div class='header'>";
					comments += "<strong class='primary-font'>"+ list[i].replyer + "</strong>";
					comments += "<small class='pull-right text-muted'>";
					comments += replyService.displayTime(list[i].replyDate);
					comments +=	"</small>";	
					comments += "</div>";
					comments += "<p>" + list[i].reply + "</p>";
					comments += "</div>";
					comments += "</li>";
				}
				replyUL.html(comments);
				
				showReplyPage(replyCnt);
			})
		}// end showList()
		
		
		//아까 우리가 추가한 div 요소를 먼저 가져와놓기
		//여기 안에다가 html 코드 조립해서 페이지 버튼 만들겠다
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt) {
			var endNum = Math.ceil(pageNum / 10.0)*10;
			var startNum = endNum-9;
			
			//앞페이지가 존재하는지?
			let prev = startNum != 1;
			//댓글은 마지막 페이지부터 보여주니까 일단 다음 페이지는 없는것으로
			let next = false;
			
			//만약 endNum (마지막 페이지) 포함 댓글 개수가 실제 댓글 개수보다 많으면
			if(endNum * 10 >= replyCnt) {
				endNum = Math.ceil(replyCnt/10.0);	
			}
			//endNum가 댓글 개수보다 적으면 다음 페이지가 있다. next= true
			if(endNum * 10 < replyCnt){
				next = true;
			}
			//댓글 페이지 html 코드조립
			let pageHtml = "<ul class='pagination pull-right'>";
			console.log(startNum);
			console.log(endNum);
			//이전페이지가 존재하면 prev 버튼 활성화
			if(prev) {
				pageHtml += "<li class='page-item'>";
				pageHtml += "<a class='page-link' href='" + (startNum - 1) + "'>";
				pageHtml += "Prev</a></li>";
			}
			//페이지 숫자 버튼 만들기
			for(let i = startNum; i <= endNum; i++) {
				//active : 현재 페이지 번호 푯
				let active = pageNum == i ? "active" : "";
				pageHtml += "<li class='page-item " + active + "'>";
				pageHtml += "<a class='page-link' href='" + i + "'>";
				pageHtml += i + "</a></li>";
				}
			//다음페이지가 존재하면 (10개 단위) next 버튼 활성화
			if(next) {
				pageHtml += "<li class='page-item'>";
				pageHtml += "<a class='page-link' href='" + (endNum + 1) + "'>";
				pageHtml += "Next</a></li>";
			}
			pageHtml += "</ul>";
			
			//html 코드 붙히기
			replyPageFooter.html(pageHtml);
			console.log(pageHtml);
			
		}//end showReplyPage()
		
		//모달 div 가져오기
		var modal = $(".modal");
		
		//사이트 위조 방지 토큰
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		//앞으로 보낼 모든 ajax 요청 헤더에 csrf 토큰 정보를 담아서 보낼수 있도록 설정
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		})//xhr = xmlHttpRequest의 줄인말
		
		
		//사용자 이름 가져오기
		var replyer = null;
		<sec:authorize access="isAuthenticated()">
			replyer ='<sec:authentication property="principal.username"/>';
		</sec:authorize>
		
		$("#addReplyBtn").on("click" , function(e) {
			//#addReplyBtn은 댓글 추가하기 버튼이므로 수정, 삭제 버튼 필요없음
			//보여줄 필요가 없다.
			//클로즈드 버튼 이외는 다른 버튼들 다 숨기고
			
			//name 이 replyer 인 input tag 의 값을 우리가 위에서 가져온 replyer로 설정
			modal.find("input[name='replyer']").val(replyer);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			
			//레지스트 버튼 다시 보이게
			$("#modalRegisterBtn").show();
			$(".close").show();
			
			modal.modal("show");
		});
		//댓글 창 닫기 이벤트
		$("#modalCloseBtn").on("click" , function(e) {
			modal.modal("hide");
 		})
		//x버튼 눌럿을 때 창 닫기
		$(".close").on("click" , function(e) {
			modal.modal("hide");
		})
		//댓글 추가 이벤트
		
		//name 값이 reply인 input 태그 가져오기
		var modalInputReply = modal.find("input[name='reply']");
		//name 값이 replyer인 input 태그 가져오기
		var modalInputReplyer = modal.find("input[name='replyer']");
		
		$("#modalRegisterBtn").on("click", function(e) {
			//name 속성인 reply인 input 찾아오기 : 댓글 내용
			//name 속성이 replyer인 input 찾아오기 : 작성자
			//게시글 번호 bno 가져와서 reply 객체 만든뒤에 댓글 달기 기능 실행
			var reply = {
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val(),
					bno : bnoValue
			}
			//add(reply, callback)
			replyService.add(reply, function(result) {
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
					
				showList(-1);
			})
		})
		
		//댓글 수정 이벤트
		//여기서 li 태그 찾아봣자 못찾는다.
		//동적으로 ajax를 통해서 <li> 태그들이 만들어지면
		//그 <li> 태그들은 현재 스크립트 안에서는 찾을수가 없다.
		//<li> 태그가 생성된 이후에 이벤트를 달아야한다.
		// 지금 여기서 <li> 태그에 이벤트를 달려고하면 찾을수가 없다.
		
		//이벤트 위임
		//동적으로 생성되는 요소에 이벤트를 직접 달아주는게 아니라
		//동적으로 생성될 요소에 부모 또는 형제 요소에다가 달아준다음
		//나중에 이벤트의 대상을 변경해준다.	
		
		//<li> 태그가 동적으로 생성될껀데 여기다 달면 안된다.
		//이미 존재하는 태그 (부모 또는 형제 )=> <ul>
		
		$(".chat").on("click", "li", function(e) {
			//나중에 동적으로 생기는 <li> 태그들에게 이벤트가 발생하도록 한다.
			var rno = $(this).data("rno");
			
			console.log(rno);
			//댓글 가져와서 modal 에 띄워주면 된다
			replyService.get(rno, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modal.data("rno", reply.rno);
				//여기는 register 버튼이 필요가 없음.
				//일단 close qjxms QOrh ek tnarlrh
				//수정버튼과 제거 버튼만 남겨두기
				modal.find("button[id != 'modalCloseBtn']").hide();
				$("#modalModBtn").show();
				$("#modalRemoveBtn").show();
				$(".close").show();
				
				modal.modal("show");
			})
		})
		//댓글 수정 처리
		$("#modalModBtn").on("click", function(e) {
			//댓글 수정 버튼 (modify 버튼)
			
			//댓글의 원래 작성자 정보를 추가로 담아주고
			 let originalReplyer = modalInputReplyer.val();
		var reply = {
				rno : modal.data("rno"),
				reply : modalInputReply.val(),
				replyer : originalReplyer
			};
			//수정할는 사람이 원래 작성자랑 다르면 알림창 띄우고 리턴
			 if(replyer != originalReplyer) {
                              alert("자신이 작성한 댓글만 수정이 가능합니다.");
                              modal.modal("hide");
                              return;
                           }
			//replyService의 update 함수는 수정안해도 됨
			//controller의 put 수정
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				showList(pageNum);
				//댓글 수정 하고 나서 input 값 비우기
				modal.find("input").val("");
			})
		})
		//댓글 삭제 이벤트
		$("#modalRemoveBtn").on("click" , function(e) {
                           
                           // 삭제하기 위해 필요한거 ?? 댓글번호 rno 
                           var rno =
                                  modal.data("rno");
                           // controller 가 댓글을 삭제하려는 사람이 기존 댓글을 등록한 사람과
                           // 같은지 검사를 해야되므로 replyer 파라미터가 필요하게 되었다.
                           // 그래서 파라미터를 추가해준다.
                           let originalReplyer = modalInputReplyer.val();
                           
                           if(replyer != originalReplyer) {
                              alert("자신이 작성한 댓글만 삭제가 가능합니다.");
                              modal.modal("hide");
                              return;
                           }
                           
                           replyService.remove(rno, originalReplyer, function(result) {
                              alert(result);
                              modal.modal("hide");
                              
                              showList(pageNum);
                           })
                           
                        })
		//replyPageFooter한테 이벤트 위임
		//replyPageFooter 안의 li a 요소에다가 이벤트 대상 변경해주기
		replyPageFooter.on("click", "li a", function(e) {
			e.preventDefault(); //a 태그 기본동작 제거
			console.log("page click");
			//이동할 페이지 번호
			//href 의 페이지 번호를 저장해놧으므로 꺼내서 쓰자
			let target = $(this).attr("href");
			console.log("target page: " + target);
			pageNum = target;
			showList(pageNum);
		})
		
	})
</script>
<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function() {
			operForm.submit()
		})

		$("button[data-oper='list']").on("click", function() {
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit()
		})
	})
	<!--
//-->
</script>

<%@ include file="../inclueds/Footer.jsp"%>