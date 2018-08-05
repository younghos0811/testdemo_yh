package com.gsitm.sample.web;

import java.io.IOException;
import java.util.List;
import java.util.Scanner;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gsitm.base.datatables.mapping.DataTablesInput;
import com.gsitm.base.datatables.mapping.DataTablesOutput;
import com.gsitm.sample.model.Employee;
import com.gsitm.sample.service.EmployeeService;

@RestController
@RequestMapping({"/sample", "/sample/client"})
public class ClientSideController {
	@Autowired
	private EmployeeService employeeService;

    @RequestMapping
    public ModelAndView index() {
        return new ModelAndView("sample:sample/client/index");
    }

	@RequestMapping(value="/employees", method=RequestMethod.GET)
	public List<Employee> findAll() {
		return employeeService.findAll();
	}

	@RequestMapping(value="/employees", method=RequestMethod.GET, headers="identity=column")
	public DataTablesOutput<Employee> findEmployees(DataTablesInput input) {
		List<Employee> employees = employeeService.findEmployeesByColumn(input, input.toPageBounds());
		DataTablesOutput<Employee> output = new DataTablesOutput<Employee>(employees);
		return output;
	}

	@RequestMapping(value="/employees", method=RequestMethod.GET, headers="identity=custom")
	public DataTablesOutput<Employee> findEmployees(EmployeeSearchCriteria criteria) {
		List<Employee> employees = employeeService.findEmployeesByCustom(criteria, criteria.toPageBounds());
		DataTablesOutput<Employee> output = new DataTablesOutput<Employee>(employees);
		return output;
	}

	@RequestMapping(value="/organizations", method=RequestMethod.GET)
	public String getOrganizationChart() {
		ClassPathResource resource = new ClassPathResource("com/gsitm/sample/web/organization.json");
		try (Scanner scanner = new Scanner(resource.getInputStream())) {
			scanner.useDelimiter("\\A");
			return scanner.hasNext() ? scanner.next() : "";
		} catch (IOException e) {
			return "";
		}
	}

	@RequestMapping(value="/modals/{id}", method=RequestMethod.GET)
	public ModelAndView getModalContent(@PathVariable int id, String value) {
		ModelAndView mv = new ModelAndView("sample/client/modal/content#" + id);
		mv.addObject("value", value);
		return mv;
	}
}