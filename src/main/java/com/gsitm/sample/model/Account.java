package com.gsitm.sample.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class Account {
	private String id;
	private String username;
	private String password;

	public Account() {
	}

	public Account(String username, String password) {
		this.username = username;
		this.password = password;
	}

}
