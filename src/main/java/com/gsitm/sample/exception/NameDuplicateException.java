package com.gsitm.sample.exception;

@SuppressWarnings("serial")
public class NameDuplicateException extends RuntimeException {
	public NameDuplicateException(String message) {
		super(message);
	}

    public NameDuplicateException(String message, Throwable cause) {
        super(message, cause);
    }
}