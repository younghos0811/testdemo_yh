package com.gsitm.base.datatables.parameter;

import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
public class SearchParameter {
	@NotNull
	private String value;

	@NotNull
	private Boolean regex;

	public SearchParameter() {}

	public SearchParameter(String value, Boolean regex) {
		super();
		this.value = value;
		this.regex = regex;
	}
}