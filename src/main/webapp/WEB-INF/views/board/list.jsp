<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../inclueds/Header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board List Page
			<button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
			</div>
			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
								<th>#번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>수정일</th>
						</tr>
					</thead>
					
					<!-- 모든 등록된 board list 출력  -->
					<c:forEach items="${list }" var="board">
					<tr>
						<td><c:out value="${board.bno }"/></td>	
						<td><a class="move" href="<c:out value='${board.bno}'/>">
						<c:out value="${board.title }" />
						<b>[<c:out value="${board.replyCnt }"/>]</b>
						</a></td>
						<td><c:out value="${board.writer }"/></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }"/></td>
					</tr>
					</c:forEach>
				</table>
				<!-- 검색 기능
					페이지 번호 파라미터는 유지 + 검색조건, 키워드
					화면에서 검색을 하면 새로 검색을 한다는 의미 => 1페이지 -->
				<div class="row">
					<div class="col-lg-12">
					<form id="searchForm" action="/board/list" method="get">
					<select name="type">
					<option value="" <c:out value="${pageMaker.cri.type == null? 'selected' : '' }"/>>--</option>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>
					<option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
					<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }"/>>제목+작성자</option>
					<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목+내용</option>
					<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }"/>>모두 검색</option>
					</select>
					<input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword }'/>"/>
					<!-- 페이지 정보 포함 (hidden) -->
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
               		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
               		<button class="btn btn-default">검색</button>
					</form>
					</div>
				</div>
				
			<!-- 페이지 처리 -->
            <!-- 페이지 정보를 저장하는 form 사용자에게 보여주지 않는다 -->
            <!-- 이 폼을 submit하면 pageNum에 맞는 페이지를 보여주도록 한다 -->
            <form id="actionForm" action="/board/list" method="get">
               <input type="hidden" name="pageNum"
                  value="${pageMaker.cri.pageNum }"> <input type="hidden"
                  name="amount" value="${pageMaker.cri.amount }">
                  <input type="hidden" name="type" value="<c:out value='${pageMaker.cri.type }'/>">
                  <input type="hidden" name="keyword" value="<c:out value='${pageMaker.cri.keyword }'/>">
            </form>
            <div class="pull-right">
               <ul class="pagination">
                <c:if test="${pageMaker.prev }">
                     <li class="paginate_button previous"><a
                        href="${pageMaker.startPage }">First</a></li>
                  </c:if>
                  <c:if test="${pageMaker.prev }">
                     <li class="paginate_button previous"><a
                        href="${pageMaker.startPage-1 }">Prev</a></li>
                  </c:if>
                  <!-- 이전 1 2 3 4 5 다음 -->
                  <c:forEach var="num" begin="${pageMaker.startPage }"
                     end="${pageMaker.endPage }">
                     <li class="paginate_button"><a href="${num }">${num }</a></li>
                  </c:forEach>
                 
                  <c:if test="${pageMaker.next }">
                     <li class="paginate_button next"><a
                        href="${pageMaker.endPage+1 }">Next</a></li>
                  </c:if>
                   <c:if test="${pageMaker.next }">
                     <li class="paginate_button next"><a
                        href="${pageMaker.endPage+1 }">End</a></li>
                  </c:if>
               </ul>
            </div>
	
				
				<!-- 알림 추기
				우리가 지금까지 사용한 알림 방법 : alert() 브라우저에서 제공하는 기본함수
				우리는 이제 이걸 안쓰고  Modal이라고 해서 우리가 커스터마이징한 창을 띄워서 알려줌-->
				 <!-- Modal -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">
                                        	처리가 완료되었습니다.	
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
			</div>
		</div>
	</div>
</div>
       <script type="text/javascript">
   $(document).ready(function() {
      // 사용자에게 방금 등록한 게시물이 몇번으로 등록됬는지 알려주기 위해 작성
      var result = "<c:out value = '${result}'/>";

      checkModal(result);

      function checkModal(result) {
         if (result == "") {
            return;
         }
         if (result > 0) {
            // result (사용자가 등록한 게시물의 번호)가 0보다 크면
            $(".modal-body").html("게시글" + parseInt(result) + "번이 등록되었습니다");
         }
         $("#myModal").modal("show");// 작성한 modal 창을 보여주는 함수
      }

      // 화면이동 버튼 이벤트 처리
      $("#regBtn").on("click", function() {
         // controller 한테 get 방식으로 /board/register 요청
         self.location = "/board/register";
      })

      // 페이지 버튼 처리
      // 숨김처리 해놨던 form 가져오기
      var actionForm = $("#actionForm")

      // 페이지 버튼에다가 이벤트 함수 달기
      $(".paginate_button a").on("click", function(e) {
         // 이벤트 객체 e를 받아와서
         // a 태그의 원래 이벤트 없애주기
         e.preventDefault();
         console.log("click");
         // page 정보를 controller로 보낸다
         // 클릭한 a 택그의 번호를 pageNum으로 해서 보내야 한다
         // action form의 value를 수정해 보내면 된다

         // actionForm에서 name 속성이 pageNum인 input 태그 찾기
         // input 태그의 값을 현재 내가 클릭한 a 태그의 href 값으로 바꿔준다
         actionForm.find("input[name='pageNum']").val($(this).attr("href"));
         actionForm.attr("action","/board/list");
         actionForm.submit();
      })
      
      //게시물 조회를 위한 이벤트 처리추가
      //게시글 제목을 눌렀을떄 이벤트를 여기서 정의할것
      $(".move").on("click",function(e){
         //move클래스가 추가된 요소의 이벤트 처리
         //게시글 제목을 눌렀을때 이벤트 처리
         //a 태그에 달린 기본이벤트를 동작하지 않도록 preventDefault
         e.preventDefault();
         //페이지 정보를 같이 전달해줄거다.(게시물 조회페이지에는 페이지 정보가 없다)
         //조회 페이지에서 리스트 페이지로 돌아오면 1페이지부터 시작하게 되니까 조회페이지도
         //페이지 정보를 알수 있도록 해준다.
         //기존에는 a 링크의 href에 게시글 번호를 붙여서 줬었는데
         //여기서는 a링크 기본클릭 이벤트를 막았다.
         //form을 보낼때 게시글번호 정보를 담아서 보내야한다.
         if(actionForm.find("input[name='bno']").val()==null){
         actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href")+"'>")
         actionForm.attr("action","/board/get");
         }else{
        	 //name 이 bno 인 input 태그가 있으면 그 값을 현재 선택한 게시물의 번호로 바꿔줌
        	  actionForm.find("input[name='bno']").val($(this).attr("href"));
         }
         actionForm.submit();
      })
      //검색 폼 이벤트 처리
      var searchForm = $("#searchForm");
      
      //검색 폼의 버튼 클릭시 이벤트 처리
      $("#searchForm button").on("click", function(e) {
    	  //기본 submit 동작 정지
    	  e.preventDefault();
    	  
    	  //검색 조건을 선택하도록 알림
    	  //검색 조건을 선택하지 않앗을때 알림을 띄운다
    	  if(!searchForm.find("option:selected").val()){
    		  alert("검색 조건을 선택하세요.");
    		  return false;
    	  }
    	  //검색 내용을 입력하도록 알림
    	  //키워드를 입력하지 않앗을때 알림을 띄운다
    	   if(!searchForm.find("input[name='keyword']").val()){
    		   alert("키워드를 입력하세요");
    		   return false;
    	   }
    	  //여기까지 왔다면 검색 조건도 있고 키워드도 있다
    	  //검색후 페이지 번호를 1번으로 지정해준다
    	   searchForm.find("input[name='pageNum']").val("1");
    	  
    	  //form에 전송
    	   searchForm.submit();
      })
      
   })
</script>

<%@ include file="../inclueds/Footer.jsp"%>