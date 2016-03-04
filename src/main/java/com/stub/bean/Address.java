package com.stub.bean;

public class Address {
	private String street;
	/***
	 * 单元
	 */
	private String unit;
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	@Override
	public String toString() {
		return "Address [street=" + street + ", unit=" + unit + "]";
	}
	
}
