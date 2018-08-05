package com.gsitm.base.datatables.mapping;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.github.miemiedev.mybatis.paginator.domain.PageList;

import lombok.Data;

@Data
public class DataTablesOutput<T> {
	private int draw;
	private long recordsTotal = 0L;
	private List<T> data = Collections.emptyList();
	private String error;

	public DataTablesOutput() {}

	public DataTablesOutput(List<T> data) {
		this.data = data;
	}

	public Integer getDraw() {
		try {
			ServletRequestAttributes sra = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
			HttpServletRequest request = sra.getRequest();
			draw = Integer.parseInt(request.getParameter("draw"));
		} catch (Exception e) {
			draw = 1;
		}
		return draw;
	}

	public long getRecordsTotal() {
		if (data instanceof PageList) {
			PageList<T> pageList = (PageList<T>)data;
			recordsTotal = pageList.getPaginator().getTotalCount();
		}
		return recordsTotal;
	}

	public long getRecordsFiltered() {
		return getRecordsTotal();
	}
}