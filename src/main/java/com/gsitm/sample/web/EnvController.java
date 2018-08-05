package com.gsitm.sample.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/sample")
public class EnvController {
	@RequestMapping(value="/env", method=RequestMethod.GET)
    public String index(HttpServletRequest request) {
        return "sample:sample/env/index";
    }
}