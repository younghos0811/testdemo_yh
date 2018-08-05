package com.gsitm.sample.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.gsitm.base.datatables.mapping.DataTablesInput;
import com.gsitm.sample.exception.NameDuplicateException;
import com.gsitm.sample.exception.NoAffectedException;
import com.gsitm.sample.exception.ServiceException;
import com.gsitm.sample.model.Employee;
import com.gsitm.sample.web.EmployeeSearchCriteria;

@Service
@Transactional
public class EmployeeService {
	@Autowired
	private EmployeeMapper employeeMapper;

	public List<Employee> findAll() {
		return employeeMapper.findAll();
	}

	public List<Employee> findEmployeesByColumn(DataTablesInput input, PageBounds pageBounds) {
		return employeeMapper.findEmployeesByColumn(input, pageBounds);
	}

	public List<Employee> findEmployeesByCustom(EmployeeSearchCriteria criteria, PageBounds pageBounds) {
		return employeeMapper.findEmployeesByCustom(criteria, pageBounds);
	}

	public Employee getEmployeeByNo(Integer no) {
		return employeeMapper.getEmployeeByNo(no);
	}

	public void addEmployee(Employee employee) {
		List<Employee> employees = employeeMapper.findEmployeesByName(employee.getName());
		if (employees.size() > 0) {
			throw new NameDuplicateException("[" + employee.getName() + "] 이미 존재하는 이름입니다.");
		}

		try {
			int result = employeeMapper.addEmployee(employee);
			if (result < 1) {
				throw new NoAffectedException("사원정보가 저장되지 않았습니다. 입력 값을 확인하세요.");
			}
		} catch (Exception e) {
			throw new ServiceException(e.getMessage(), e);
		}
	}

	public void editEmployee(Employee employee) {
		employeeMapper.editEmployee(employee);
	}

	public void delEmployee(Integer[] nos) {
		for (Integer no : nos) {
			employeeMapper.delEmployee(no);
		}
	}
}