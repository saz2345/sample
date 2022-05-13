/**
 * 
 */

console.log("Reply module......");

var replyService = (function() {

	function add(reply, callback, error) {
		// reply : 댓글 객체
		// callback : 롤백 함수 어떤 함수를 실행시키고 난 이후에
		// 결과를 받을 함수 또는 그 다음에 실행될 함수
		console.log("add reply")

		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				// 성공했으면 실행할 함수
				if (callback) { // 콜백 함수가 있으면
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				// 에러가 발생하면 실행할 함수
				if (error) { // 에러를 처리하는 함수가 있으면
					error(er);
				}
			}
		})
	}

	// 댓글 목록을 불러오는 함수
	// 댓글 목록을 불러올 때는 페이지 정보가 필요한데, 필요한 정보들은 모두 param에
	function getList(param, callback, error) {

		var page = param.page || 1; // 페이지 정보가 없을 수도 있다
		// 페이지 정보가 있다면 그대로 쓰고
		// 만약 페이지 정복 없다면 1로 세팅
		var bno = param.bno;
		$.getJSON("/replies/pages/" + bno + "/" + page + ".json",
				function(data) {
					// 요청 처리 성공시 실행되는 함수

					// 롤백 함수가 있으면 롤백함수를 실행
					if (callback) {
						//callback(data);
						//data 자리에 list 가 온다
						callback(data.replyCnt, data.list)
					}

				}).fail(function(xhr, status, err) {
			// 요청 처리 실패시 실행되는 함수

			// 에러처리 함수가 있으면 에러 함수를 실행
			if (error) {
				error();
			}
		});
	} // getList 함수 끝

	// 댓글 지우기
	// 댓글 치울떄 필요한것 : 댓글의 번호 (rno)
	function remove(rno, replyer, callback, error) {

        $.ajax({
           type : 'delete',
           url : '/replies/' + rno,
           data : JSON.stringify({rno : rno, replyer:replyer}),
           contentType: "application/json; charset=utf-8",
           success : function(result, status, xhr) {
              // 성공하면 callback 호출
              if (callback) {
                 callback(result);
              }
           },
           error : function(xhr, status, err) {
              // 실패하면 error 함수 호출
              if (error) {
                 error(err);
              }
           }
        })
     } // remove 함수 끝

	// 댓글 수정
	   function update(reply, callback, error) {
	      console.log(reply);

	      $.ajax({
	         type : 'put',
	         url : '/replies/' + reply.rno,
	         data : JSON.stringify(reply),
	         contentType : "application/json; charset = utf-8",
	         success : function(result, status, xhr) {
	            if (callback) {
	               callback(result);
	            }
	         },
	         error : function(xhr, status, err) {
	            if (error) {
	               error(err);
	            }
	         }
	      })
	   } // update 함수 끝

	// 댓글 하나 조회하는 함수
	// 댓글 하나 조회하려면 필요한ㄱ ? rno 댓글 번호
	function get(rno, callback, error) {
	      $.get("/replies/" + rno + ".json",
	              function(result){
	           if(callback){
	              callback(result);
	           }
	        }).fail(function(xhr, status, err) {
	           if(error) {
	              error();
	           }
	        });
	     }//get 함수 끝
	
	//날짜 변환 기능
	function displayTime(timeValue) {
		// 오늘 작성한 댓글
		// 어제 이전에 작성한 댓글
		// 오늘 작성한 댓글은 시간으로 표시해주고
		// 어제 이전에 작성한 댓글은 날짜로 표시해주기
		var today = new Date();
		
		//오늘 날짜와 댓글의 날짜가 얼마나 차이나는지
		var gap = today.getTime() - timeValue;
		//gap 값도 밀리초단위로 저장
		//몇밀리초가 하루일까요
		//1000 * 60 * 60 * 24 ==> 하루를 밀리초 단위로 바꾼것
		//밀리초 * 1분=60초 *1시간=60분 * 하루 =24시간
		
		
		//댓글 날짜
		var dateObj = new Date(timeValue);
		
		var str = ""; //리턴할 날짜 (오늘 댓글이면 시간, 어제 이전 댓글이면 날짜)
		
		//오늘 작성한 댓글이면 시간
		if(gap <(1000 * 60 * 60 * 24)) {
			//시간
			var hh = dateObj.getHours();
			//분
			var ml = dateObj.getMinutes();
			//초
			var ss = dateObj.getSeconds();
			
			//9시
			//09시
			//현재 시간이 9보다 크면 앞에 아무것도 안붙여주고,
			//9 이하이면 앞에 0을 붙혀준다
			//현재시간이 10시면 0을 붙여줄 필요가 없다.
			str = [ (hh > 9 ? '' : '0') + hh, ':' ,
					(ml > 9 ? '' : '0') + ml, ':',
					(ss > 9 ? '' : '0') + ss].join("");
			//.join ==> 배열안에 원소들이 이어붙여진다.
			//시간
		}else {
			//24시간 이전에 작성한 댓글
			//날짜로 보여주기
			var yy = dateObj.getFullYear(); //4자리로 된 연도
			//월
			var mm = dateObj.getMonth() + 1; //컴퓨터는 달을 0부터 샌다.
			//일
			var dd = dateObj.getDate();
			//여기도 똑같이 한자리로 된 숫자는 앞에 0 붙혀주기
			str += yy + "/";
			str += (mm > 9 ? '' : '0') + mm + "/";
			str += (dd > 9 ? '' : '0') + dd;
		}
		return str;
	}

	return {
		add : add,
		getList : getList,
		remove : remove,
		update : update,
		get : get,
		displayTime : displayTime
	};
	// replyservice() 함수를 부르고 나서 그 결과값에 객체가 들어오는데
	// 그 안에 add를 가져오면 댓글 등록 기능 함수를 사용할 수 있다
	// var service = replyservice();
	// service.add();
})();