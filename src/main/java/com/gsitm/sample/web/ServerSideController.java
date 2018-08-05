package com.gsitm.sample.web;

import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gsitm.base.view.FileDownloadView;
import com.gsitm.sample.config.SampleProperties;
import com.gsitm.sample.model.Employee;
import com.gsitm.sample.service.EmployeeService;

@RestController
@RequestMapping("/sample")
public class ServerSideController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private SampleProperties sampleProperties;

	@RequestMapping({"/server", "/popup/server"})
    public ModelAndView index(HttpServletRequest request) {
        logger.debug("This is a debug message");
        logger.info("This is an info message");
        logger.warn("This is a warn message");
        logger.error("This is an error message");

        String layout = request.getRequestURI().contains("/popup") ? "sample-popup" : "sample";
        ModelAndView mv = new ModelAndView(layout + ":sample/server/index");
        mv.addObject("sampleProperties", sampleProperties);

        return mv;
    }

	@RequestMapping(value="/employees/{no}", method=RequestMethod.GET)
	public Employee getEmployee(@PathVariable Integer no) {
		return employeeService.getEmployeeByNo(no);
	}

	@RequestMapping(value="/employees", method=RequestMethod.POST)
	public Employee addEmployee(Employee employee) {
		employeeService.addEmployee(employee);
		return employee;
	}

	@RequestMapping(value="/employees/{no}", method=RequestMethod.PUT)
	public Employee editEmployee(Employee employee) {
		employeeService.editEmployee(employee);
		return employee;
	}

	@RequestMapping(value="/employees/{nos}", method=RequestMethod.DELETE)
	public Integer[] delEmployee(@PathVariable Integer[] nos) {
		employeeService.delEmployee(nos);
		return nos;
	}

	@RequestMapping(value="/download/restapi", method=RequestMethod.GET)
	public ModelAndView downloadRestDocument(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView(new FileDownloadView());
		InputStream is = request.getServletContext().getResourceAsStream("/WEB-INF/views/sample/server/restapi.pdf");
		mv.addObject(FileDownloadView.FILE, is);
		mv.addObject(FileDownloadView.FILENAME, "restapi.pdf");
		return mv;
	}
}