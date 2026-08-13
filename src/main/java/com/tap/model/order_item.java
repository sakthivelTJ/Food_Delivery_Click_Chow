package com.tap.model;

public class order_item {
	private int orderItemID;
	private int orderID;
	private int menuID;
	private int quantity;
	private double itemTotal;
	
	
	
	
	
	public order_item(int orderID, int menuID, int quantity, double itemTotal) {
		super();
		this.orderID = orderID;
		this.menuID = menuID;
		this.quantity = quantity;
		this.itemTotal = itemTotal;
	}
	public order_item(int orderItemID, int orderID, int menuID, int quantity, double itemTotal) {
		super();
		this.orderItemID = orderItemID;
		this.orderID = orderID;
		this.menuID = menuID;
		this.quantity = quantity;
		this.itemTotal = itemTotal;
	}
	/**
	 * @return the orderItemID
	 */
	public int getOrderItemID() {
		return orderItemID;
	}
	/**
	 * @param orderItemID the orderItemID to set
	 */
	public void setOrderItemID(int orderItemID) {
		this.orderItemID = orderItemID;
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
	 * @return the menuID
	 */
	public int getMenuID() {
		return menuID;
	}
	/**
	 * @param menuID the menuID to set
	 */
	public void setMenuID(int menuID) {
		this.menuID = menuID;
	}
	/**
	 * @return the quantity
	 */
	public int getQuantity() {
		return quantity;
	}
	/**
	 * @param quantity the quantity to set
	 */
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	/**
	 * @return the itemTotal
	 */
	public double getItemTotal() {
		return itemTotal;
	}
	/**
	 * @param itemTotal the itemTotal to set
	 */
	public void setItemTotal(double itemTotal) {
		this.itemTotal = itemTotal;
	}
	@Override
	public String toString() {
		return "order_item [orderItemID=" + orderItemID + ", orderID=" + orderID + ", menuID=" + menuID + ", quantity="
				+ quantity + ", itemTotal=" + itemTotal + "]";
	}
	
	
	
	
	
	
	
	
}
