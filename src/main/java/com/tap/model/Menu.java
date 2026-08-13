package com.tap.model;

public class Menu {
	private int menuID;
	private int restaurantID;
	private String itemName;
	private String description;
	private double price;
	private boolean isAvailable;
	private String imagePath;
	private Double Rating;
	
	
	
	
	
	



	public Menu(int menuID, int restaurantID, String itemName, String description, double price, boolean isAvailable,
			String imagePath, Double rating) {
		super();
		this.menuID = menuID;
		this.restaurantID = restaurantID;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.isAvailable = isAvailable;
		this.imagePath = imagePath;
		Rating = rating;
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
	/**
	 * @return the itemName
	 */
	public String getItemName() {
		return itemName;
	}
	/**
	 * @param itemName the itemName to set
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return the price
	 */
	public double getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(double price) {
		this.price = price;
	}
	/**
	 * @return the isAvailable
	 */
	public boolean isAvailable() {
		return isAvailable;
	}
	/**
	 * @param isAvailable the isAvailable to set
	 */
	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}
	/**
	 * @return the imagePath
	 */
	public String getImagePath() {
		return imagePath;
	}
	/**
	 * @param imagePath the imagePath to set
	 */
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
	
	
	
	public Double getRating() {
		return Rating;
	}
	public void setRating(Double rating) {
		Rating = rating;
	}
	@Override
	public String toString() {
		return "Menu [menuID=" + menuID + ", restaurantID=" + restaurantID + ", itemName=" + itemName + ", description="
				+ description + ", price=" + price + ", isAvailable=" + isAvailable + ", imagePath=" + imagePath
				+ ", Rating=" + Rating + "]";
	}



	
	
	
	
	
}
