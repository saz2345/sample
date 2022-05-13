package com.globalin.service;

public interface SampleTxService {

	//실제로 데이터를 추가해주는 메소드
	//데이터를 추가하려면 mapper 를 통해서 
	//sample1mapper, sampel2maper가 필요합니다.
	public void addData(String value);
}
