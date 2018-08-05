package com.gsitm.base.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

/**
 * 파일 다운로드를 위한 전용 View class 이다.
 * 해당 view를 사용하기 위해서는 Controller 클래스내 메소드에서 ModelAndView 클래스를 리턴해야 한다.
 *
 * @author YongSang
 */
public class FileDownloadView extends AbstractView {
	public static final String FILE = "downloadFile";
	public static final String FILENAME = "originalFilename";
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (model.get(FILE) != null) {
            InputStream in = null;
            OutputStream out = response.getOutputStream();
            
			try {
	            int size = -1;
	            String originalFilename = (String)model.get(FILENAME);
	            
	            if (model.get(FILE) instanceof File) {
	                File file = (File)model.get(FILE);
	                in = new FileInputStream(file);
	                size = (int)file.length();
	            } else {
	                in = (InputStream)model.get(FILE);
	            }

	            response.setContentType(getContentType());
	            response.setContentLength(size);
	            response.setHeader("Content-Transfer-Encoding", "binary");
	            response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(originalFilename, "utf-8") + "\";");
	            
				FileCopyUtils.copy(in, out);
			} finally {
				if(in != null){
					try{
						in.close();
					} catch(Exception e) {
						logger.error(e.getMessage(), e);
					}
				}
			}
			out.flush();
		} else {
			logger.warn("[download uri:{}, filename:{}] file inputstream is null", 
					request.getRequestURI(), model.get(FILENAME));
		}
	}
	
	@Override
	public String getContentType() {
		return MediaType.APPLICATION_OCTET_STREAM.toString();
	}
}