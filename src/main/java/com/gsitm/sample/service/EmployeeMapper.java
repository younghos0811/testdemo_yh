package com.gsitm.sample.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.gsitm.base.datatables.mapping.DataTablesInput;
import com.gsitm.sample.model.Employee;
import com.gsitm.sample.web.EmployeeSearchCriteria;

@Repository
public interface EmployeeMapper {
	List<Employee> findAll();

	PageList<Employee> findEmployeesByColumn(@Param("input") DataTablesInput input, PageBounds pageBounds);

	PageList<Employee> findEmployeesByCustom(EmployeeSearchCriteria criteria, PageBounds pageBounds);

	Employee getEmployeeByNo(Integer no);

	List<Employee> findEmployeesByName(String name);

	int addEmployee(Employee employee);

	int editEmployee(Employee employee);

	int delEmployee(Integer no);
}