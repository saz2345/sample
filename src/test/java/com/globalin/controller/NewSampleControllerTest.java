package com.globalin.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.aspectj.lang.annotation.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.globalin.domain.Ticket;
import com.google.gson.Gson;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
public class NewSampleControllerTest {

	//web 전용 설정 불러오기
	@Autowired
	private WebApplicationContext ctx;
	
	//테스트할때는 가짜 MVC 패턴을 만들어주는 MOCK MVC
	private MockMvc mockMvc;
	
	//테스트 시작 전에 항상 실행될 메소드
	@org.junit.Before
	public void setup() {
		//rkWk rorcp aksemfdjwnrl
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	@Test
	public void test() throws Exception {
		Ticket ticket = new Ticket();
		ticket.setTno(123);
		ticket.setGrade("aaa");
		ticket.setOwner("admin");
		/*
		 * {
		 * "tno" : "123",
		 * "owner" : "admin",
		 * "grade" : "aaa"
		 * }
		 * Gson 을 사용해서 객체를 json 형식으로 바꿔준다
		 * 
		 * */
		String jsonStr = new Gson().toJson(ticket);
		System.out.println(jsonStr);
		
		mockMvc.perform(
				post("/sample/ticket") //post 요청을 보낸다
				.contentType(MediaType.APPLICATION_JSON) //요청의 타입이 json 타입
				.content(jsonStr))
		.andExpect(status().is(200)); //그 결과가 200일것이라고 기대합니다
	}
}
