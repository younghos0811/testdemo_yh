package com.gsitm.base.datatables.mapping;

import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

import com.github.miemiedev.mybatis.paginator.domain.Order;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.gsitm.base.datatables.parameter.ColumnParameter;
import com.gsitm.base.datatables.parameter.OrderParameter;
import com.gsitm.base.datatables.parameter.SearchParameter;

import lombok.Data;

@Data
public class DataTablesInput {
	@NotNull
	@Min(0)
	private Integer draw = 1;

	@NotNull
	@Min(0)
	private Integer start = 0;

	@NotNull
	@Min(-1)
	private Integer length = 10;

	@NotNull
	private SearchParameter search = new SearchParameter();

	@NotEmpty
	private List<OrderParameter> order = new ArrayList<OrderParameter>();

	@NotEmpty
	private List<ColumnParameter> columns = new ArrayList<ColumnParameter>();

	public PageBounds toPageBounds() {
		List<Order> boundOrders = new ArrayList<Order>();
		for (OrderParameter orderParam : getOrder()) {
			String columnName = CaseFormat.convertPropertyNameToUnderscoreName(columns.get(orderParam.getColumn()).getData());
			String direction = orderParam.getDir();
			boundOrders.add(Order.create(columnName, direction));
		}
		return new PageBounds((getStart() / getLength()) + 1, getLength(), boundOrders);
	}
}