package com.gsitm.base;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.AbstractErrorController;
import org.springframework.boot.autoconfigure.web.ErrorAttributes;
import org.springframework.boot.autoconfigure.web.ErrorProperties;
import org.springframework.boot.autoconfigure.web.ErrorProperties.IncludeStacktrace;
import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

/**
 * TODO SQLException에 대한 처리 추가
 *
 * @author YongSang
 */
@Controller
@RequestMapping("/error")
public class DefaultHandlerExceptionController extends AbstractErrorController {
	private final ErrorProperties errorProperties;
	private final ErrorAttributes errorAttributes;

	@Autowired
	public DefaultHandlerExceptionController(ErrorAttributes errorAttributes, ServerProperties properties) {
		super(errorAttributes);
		this.errorAttributes = errorAttributes;
		this.errorProperties = properties.getError();
	}

	@RequestMapping(produces="text/html")
	public ModelAndView errorHtml(HttpServletRequest request, HttpServletResponse response) {
		response.setStatus(getStatus(request).value());
		Map<String, Object> model = getErrorAttributes(request, isIncludeStackTrace(request, MediaType.TEXT_HTML));
		int status = Integer.parseInt(model.get("status").toString());
		return new ModelAndView(status == 404 ? "404" : "error", model);
	}

	@RequestMapping
	@ResponseBody
	public ResponseEntity<Map<String, Object>> error(HttpServletRequest request) {
		Map<String, Object> body = getErrorAttributes(request, isIncludeStackTrace(request, MediaType.ALL));
		HttpStatus status = getStatus(request);
		return new ResponseEntity<Map<String, Object>>(body, status);
	}

	@RequestMapping(value="/alert", method=RequestMethod.GET)
	public String getAlertDialog() {
		return "alert";
	}

	protected boolean isIncludeStackTrace(HttpServletRequest request, MediaType produces) {
		IncludeStacktrace include = getErrorProperties().getIncludeStacktrace();
		if (include == IncludeStacktrace.ALWAYS) {
			return true;
		}
		if (include == IncludeStacktrace.ON_TRACE_PARAM) {
			return getTraceParameter(request);
		}
		return false;
	}

	protected ErrorProperties getErrorProperties() {
		return this.errorProperties;
	}

	@Override
	protected Map<String, Object> getErrorAttributes(HttpServletRequest request, boolean includeStackTrace) {
		RequestAttributes requestAttributes = new ServletRequestAttributes(request);
		Map<String, Object> attr = errorAttributes.getErrorAttributes(requestAttributes, includeStackTrace);

		Throwable error = errorAttributes.getError(requestAttributes);
		Throwable rootCause = ExceptionUtils.getRootCause(error);
		if (rootCause instanceof SQLException) {
			attr.put("message", "데이터베이스 처리 과정 중에 에러가 발생 했습니다.");
		}

		int status = Integer.parseInt(attr.get("status").toString());
		if (status == 404) {
			attr.put("message", "Not Found.");
		}
		return attr;
	}

	@Override
	public String getErrorPath() {
		return this.errorProperties.getPath();
	}
}