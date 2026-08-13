package com.tap.model;

public class Restaurant {
	
	private int restaurant_id;
	private String Name;
	private String CustomerType;
	private String DeliveryTime;
	private String Address;
	private Double Rating ;
	private boolean IsActive ;
	private String ImagePath;
	
	
	
	
	
	
	
	
	
	public Restaurant(String name, String customerType, String deliveryTime, String address, Double rating,
			boolean isActive, String imagePath) {
		super();
		Name = name;
		CustomerType = customerType;
		DeliveryTime = deliveryTime;
		Address = address;
		Rating = rating;
		IsActive = isActive;
		ImagePath = imagePath;
	}
	
	
	
	
	
	
	
	
	public Restaurant(int restaurant_id, String name, String customerType, String deliveryTime, String address,
			Double rating, boolean isActive, String imagePath) {
		super();
		this.restaurant_id = restaurant_id;
		Name = name;
		CustomerType = customerType;
		DeliveryTime = deliveryTime;
		Address = address;
		Rating = rating;
		IsActive = isActive;
		ImagePath = imagePath;
	}








	public int getRestaurant_id() {
		return restaurant_id;
	}
	public void setRestaurant_id(int restaurant_id) {
		this.restaurant_id = restaurant_id;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getCustomerType() {
		return CustomerType;
	}
	public void setCustomerType(String customerType) {
		CustomerType = customerType;
	}
	public String getDeliveryTime() {
		return DeliveryTime;
	}
	public void setDeliveryTime(String deliveryTime) {
		DeliveryTime = deliveryTime;
	}
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	public Double getRating() {
		return Rating;
	}
	public void setRating(Double rating) {
		Rating = rating;
	}
	public boolean isIsActive() {
		return IsActive;
	}
	public void setIsActive(boolean isActive) {
		IsActive = isActive;
	}
	public String getImagePath() {
		return ImagePath;
	}
	public void setImagePath(String imagePath) {
		ImagePath = imagePath;
	}
	@Override
	public String toString() {
		return "Restaurant [restaurant_id=" + restaurant_id + ", Name=" + Name + ", CustomerType=" + CustomerType
				+ ", DeliveryTime=" + DeliveryTime + ", Address=" + Address + ", Rating=" + Rating + ", IsActive="
				+ IsActive + ", ImagePath=" + ImagePath + "]";
	}
	
	
	
	
	
	
	
	

}
