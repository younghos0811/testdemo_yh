package com.gsitm.base.bind;

import java.beans.PropertyEditor;

import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;

@ControllerAdvice
public class WebBindingInitializer {
	private final PropertyEditor stringTrimmerEditor = new StringTrimmerEditor(true);

    @InitBinder
    public void initBinder(WebDataBinder binder) {
    	binder.registerCustomEditor(String.class, stringTrimmerEditor);
    }
}