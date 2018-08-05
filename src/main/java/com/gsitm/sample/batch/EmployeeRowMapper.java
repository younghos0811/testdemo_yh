package com.gsitm.sample.batch;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.gsitm.sample.model.Employee;

public class EmployeeRowMapper implements RowMapper<Employee> {
	@Override
	public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
		Employee employee = new Employee();
		employee.setNo(rs.getLong("no"));
		employee.setName(rs.getString("name"));
		employee.setHireDate(rs.getDate("hire_date"));
		employee.setSalary(rs.getInt("salary"));
		employee.setDept(rs.getString("dept"));

		return employee;
	}
}