package com.gsitm.base.datatables.parameter;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@Data
public class ColumnParameter {
	@NotBlank
	private String data;

	private String name;

	@NotNull
	private Boolean searchable;

	@NotNull
	private Boolean orderable;

	@NotNull
	private SearchParameter search;

	public ColumnParameter() {}

	public ColumnParameter(String data, String name, Boolean searchable, Boolean orderable, SearchParameter search) {
		super();
		this.data = data;
		this.name = name;
		this.searchable = searchable;
		this.orderable = orderable;
		this.search = search;
	}

	public void setSearchValue(String searchValue) {
		this.search.setValue(searchValue);
	}
}