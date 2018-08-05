package com.gsitm.base.datatables.parameter;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import lombok.Data;

@Data
public class OrderParameter {
	@NotNull
	@Min(0)
	private Integer column;

	@NotNull
	@Pattern(regexp = "(desc|asc)")
	private String dir;

	public OrderParameter() {}

	public OrderParameter(Integer column, String dir) {
		super();
		this.column = column;
		this.dir = dir;
	}
}