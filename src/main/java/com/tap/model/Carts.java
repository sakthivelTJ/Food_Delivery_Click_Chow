package com.tap.model;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class Carts {

    private Map<Integer, CartItems> items;

    public Carts() {
        items = new LinkedHashMap<Integer, CartItems>();
    }
    
    public void addItems(CartItems cartItem) {
    	if (cartItem == null) return;
    	int menuId = cartItem.getMenuId();
    	
    	if (items.containsKey(menuId)) {
    		CartItems existingCartItem = items.get(menuId);
    		int addQty = cartItem.getQuantity() > 0 ? cartItem.getQuantity() : 1;
    		existingCartItem.setQuantity(existingCartItem.getQuantity() + addQty);
    		if (cartItem.getName() != null && !cartItem.getName().trim().isEmpty()) {
    			existingCartItem.setName(cartItem.getName());
    		}
    		if (cartItem.getPrice() > 0) {
    			existingCartItem.setPrice(cartItem.getPrice());
    		}
    		if (cartItem.getImagePath() != null && !cartItem.getImagePath().trim().isEmpty()) {
    			existingCartItem.setImagePath(cartItem.getImagePath());
    		}
    		if (cartItem.getRestaurantId() > 0) {
    			existingCartItem.setRestaurantId(cartItem.getRestaurantId());
    		}
    	} else {
    		items.put(menuId, cartItem);
    	}
    }

    public void addItem(CartItems cartItem) {
    	addItems(cartItem);
    }

	public Map<Integer, CartItems> getItems() {
		return items;
	}

	public void setItems(Map<Integer, CartItems> items) {
		this.items = items;
	}

	public void updateItems(int menuId, int quantity) {
		if (items.containsKey(menuId)) {
			CartItems cartItem = items.get(menuId);
			if (quantity < 1) {
				items.remove(menuId);
			} else {
				cartItem.setQuantity(quantity);
				items.put(menuId, cartItem);
			}
		}
	}

	public void updateItem(int menuId, int quantity) {
		updateItems(menuId, quantity);
	}

	public void removeitems(int menuId) {
		items.remove(menuId);
	}

	public void removeItem(int menuId) {
		removeitems(menuId);
	}

	public void clear() {
		items.clear();
	}
}