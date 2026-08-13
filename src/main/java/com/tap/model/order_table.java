package com.tap.model;

import java.util.Date;


public class order_table {
	private int orderID;
	private int userID;
	private Date orderDate;
	private double totalAmount;
	private String status;
	private String paymentMethod;
	private int restaurantID;
	
	
	
	
	
	
	public order_table(int userID, Date orderDate, double totalAmount, String status, String paymentMethod,
			int restaurantID) {
		super();
		this.userID = userID;
		this.orderDate = orderDate;
		this.totalAmount = totalAmount;
		this.status = status;
		this.paymentMethod = paymentMethod;
		this.restaurantID = restaurantID;
	}
	public order_table(int orderID, int userID, Date orderDate, double totalAmount, String status, String paymentMethod,
			int restaurantID) {
		super();
		this.orderID = orderID;
		this.userID = userID;
		this.orderDate = orderDate;
		this.totalAmount = totalAmount;
		this.status = status;
		this.paymentMethod = paymentMethod;
		this.restaurantID = restaurantID;
	}
	
	
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	/**
	 * @return the orderID
	 */
	public int getOrderID() {
		return orderID;
	}
	/**
	 * @param orderID the orderID to set
	 */
	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}
	/**
	 * @return the userID
	 */
	public int getUserID() {
		return userID;
	}
	/**
	 * @param userID the userID to set
	 */
	public void setUserID(int userID) {
		this.userID = userID;
	}
	/**
	 * @return the orderDate
	 */
	
	/**
	 * @return the totalAmount
	 */
	public double getTotalAmount() {
		return totalAmount;
	}
	/**
	 * @param totalAmount the totalAmount to set
	 */
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return the paymentMethod
	 */
	public String getPaymentMethod() {
		return paymentMethod;
	}
	/**
	 * @param paymentMethod the paymentMethod to set
	 */
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	/**
	 * @return the restaurantID
	 */
	public int getRestaurantID() {
		return restaurantID;
	}
	/**
	 * @param restaurantID the restaurantID to set
	 */
	public void setRestaurantID(int restaurantID) {
		this.restaurantID = restaurantID;
	}


	@Override
	public String toString() {
		return "order_table [orderID=" + orderID + ", userID=" + userID + ", orderDate=" + orderDate + ", totalAmount="
				+ totalAmount + ", status=" + status + ", paymentMethod=" + paymentMethod + ", restaurantID="
				+ restaurantID + "]";
	}
	
	
	
	
	
	
	
	
}
