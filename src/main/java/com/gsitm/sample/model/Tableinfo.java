package com.gsitm.sample.model;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.gsitm.base.model.Domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class Tableinfo extends Domain {
	private String oricolname;

	private String colname;

	private String datastr;

	private String oridatastr;

	private String comments;

	private String contactlinks;

	private String pkey;

	@Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}