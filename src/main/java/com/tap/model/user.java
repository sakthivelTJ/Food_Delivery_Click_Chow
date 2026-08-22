package com.tap.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class user {

	
		private int user_id;
		private String user_name;
		private String email;
		private String password;
		private String role;
		private String createdDate;
		private String lastLogIN;
		private String address;
		private String phoneNumber;
		
		public user() {
			// TODO Auto-generated constructor stub
		}
		
		
		

		public user(String user_name, String email, String password, String role, String address) {
			super();
			this.user_name = user_name;
			this.email = email;
			this.password = password;
			this.role = role;
			this.address = address;
		}

		public user(String user_name, String email, String password, String role, String address, String phoneNumber) {
			super();
			this.user_name = user_name;
			this.email = email;
			this.password = password;
			this.role = role;
			this.address = address;
			this.phoneNumber = phoneNumber;
		}

		public user(int user_id, String user_name, String email, String password, String role, String createdDate,
				String lastLogIN, String address) {
			super();
			this.user_id = user_id;
			this.user_name = user_name;
			this.email = email;
			this.password = password;
			this.role = role;
			this.createdDate = createdDate;
			this.lastLogIN = lastLogIN;
			this.address = address;
		}

		public user(int user_id, String user_name, String email, String password, String role, String createdDate,
				String lastLogIN, String address, String phoneNumber) {
			super();
			this.user_id = user_id;
			this.user_name = user_name;
			this.email = email;
			this.password = password;
			this.role = role;
			this.createdDate = createdDate;
			this.lastLogIN = lastLogIN;
			this.address = address;
			this.phoneNumber = phoneNumber;
		}




		public user(int user_id) {
			super();
			this.user_id = user_id;
		}


		public user(String user_name, String email, String password, String role) {
			super();
			this.user_name = user_name;
			this.email = email;
			this.password = password;
			this.role = role;
		}





		/**
		 * @param user_name the user_name to set
		 */
		public void setUser_name(String user_name) {
			this.user_name = user_name;
		}


		/**
		 * @param email the email to set
		 */
		public void setEmail(String email) {
			this.email = email;
		}


		/**
		 * @param password the password to set
		 */
		public void setPassword(String password) {
			this.password = password;
		}


		/**
		 * @param role the role to set
		 */
		public void setRole(String role) {
			this.role = role;
		}


		/**
		 * @param createdDate the createdDate to set
		 */
		public void setCreatedDate(String createdDate) {
			this.createdDate = createdDate;
		}


		/**
		 * @param lastLogIN the lastLogIN to set
		 */
		public void setLastLogIN(String lastLogIN) {
			this.lastLogIN = lastLogIN;
		}


		/**
		 * @return the user_id
		 */
		public int getUser_id() {
			return user_id;
		}


		/**
		 * @return the user_name
		 */
		public String getUser_name() {
			return user_name;
		}


		/**
		 * @return the email
		 */
		public String getEmail() {
			return email;
		}


		/**
		 * @return the password
		 */
		public String getPassword() {
			return password;
		}


		/**
		 * @return the role
		 */
		public String getRole() {
			return role;
		}


		/**
		 * @return the createdDate
		 */
		public String getCreatedDate() {
			return createdDate;
		}


		/**
		 * @return the lastLogIN
		 */
		public String getLastLogIN() {
			return lastLogIN;
		}


		
		
		


		public String getAddress() {
			return address;
		}




		public void setAddress(String address) {
			this.address = address;
		}




		public void setUser_id(int user_id) {
			this.user_id = user_id;
		}

		public String getPhoneNumber() {
			return phoneNumber;
		}

		public void setPhoneNumber(String phoneNumber) {
			this.phoneNumber = phoneNumber;
		}

		@Override
		public String toString() {
			return "user [user_id=" + user_id + ", user_name=" + user_name + ", email=" + email + ", password="
					+ password + ", role=" + role + ", createdDate=" + createdDate + ", lastLogIN=" + lastLogIN
					+ ", address=" + address + ", phoneNumber=" + phoneNumber + "]";
		}


		

		
		

}
