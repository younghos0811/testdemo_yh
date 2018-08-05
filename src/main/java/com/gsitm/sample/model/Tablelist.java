package com.gsitm.sample.model;

import org.apache.commons.lang3.builder.ToStringBuilder;

import com.gsitm.base.model.Domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class Tablelist extends Domain {
	private String tableName;

	private String tableId;

	@Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}