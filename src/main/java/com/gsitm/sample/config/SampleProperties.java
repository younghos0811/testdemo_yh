package com.gsitm.sample.config;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
@ConfigurationProperties(prefix="sample", locations="classpath:sample.yml")
public class SampleProperties {
	private String author;
	private Mail mail;
	private Mime mime;

	@Data
	public static class Mail {
		private String host;
		private int port;
		private String from;
	}

	@Data
	public static class Mime {
		private List<MimeMapping> mimeMappings = new ArrayList<MimeMapping>();

		@Data
		public static class MimeMapping {
			private String extension;
			private String mimeType;
		}
	}

	@Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}