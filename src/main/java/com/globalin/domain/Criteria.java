package com.globalin.domain;

public class Criteria {

	
	 private int pageNum;
	 private int amount;
	 
	 //검색타입 : 제목, 작성자, 내용.. (제목 + 내용)
	 //타입이 여러개일 경우 처리가 필요하다.
	 //제목 : T , 작성자 : W, 내용 : C
	 //제목 + 내용 TC / 작성자 + 내용 WC
	 //전부 포함 TWC
	 //복합 조건일떄를 대비해서 문자열을 쪼갠다음에 배열로 리턴해준다
	 private String type;
	 //검색할 키워드
	 private String keyword;
	 
	 public Criteria() {
		 //첫페이지 번호는 1, 기본적으로 한페이지에 10개씩
		 this.pageNum = 1;
		 this.amount = 10;
	 }
	 
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", type=" + type + ", keyword=" + keyword + "]";
	}
	
	
	//type 을 쪼개서 문자열 배열로 만들어서 리턴해주는 메소드
	//type = "TWC"
	//String[] typeArrr = { "T" , "W" , "C"};
	public String[] getTypeArr() {
		String[] result = {};
		if(type == null) {
			//type이 null이면 검색 조건이 없다
			//빈 배열을 리턴해준다
		}else {
			//type 이 null 이 아니면 검색조건이 하나 이상 있다
			//type 을 쪼개서 배열로 만들어준다
			result = type.split("");
		}
		return result;
		//return type == null ? new String[] {} : type.split("");
 	}
	
	 
	 
}
