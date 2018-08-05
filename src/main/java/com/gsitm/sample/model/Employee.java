package com.gsitm.sample.model;

import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.gsitm.base.json.serialize.CurrencySerializer;
import com.gsitm.base.json.serialize.DateSerializer;
import com.gsitm.base.model.Domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class Employee extends Domain {
	private Long no;

	private String name;

	@NumberFormat(style = Style.NUMBER, pattern = "#,###.###")
	@JsonSerialize(using=CurrencySerializer.class)
	private Integer salary;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonSerialize(using=DateSerializer.class)
	private Date hireDate;

	private String dept;

	@Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}