package com.gsitm.sample.web;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.gsitm.base.datatables.mapping.DataTablesInput;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EmployeeSearchCriteria extends DataTablesInput {
	private String name;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startHireDate;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endHireDate;

	private String dept;
}