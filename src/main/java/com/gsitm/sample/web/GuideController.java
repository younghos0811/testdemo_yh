package com.gsitm.sample.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/sample")
public class GuideController {
	@RequestMapping(value="/guide", method=RequestMethod.GET)
	public ModelAndView index() {
		return new ModelAndView("sample:sample/guide/index");
	}
}