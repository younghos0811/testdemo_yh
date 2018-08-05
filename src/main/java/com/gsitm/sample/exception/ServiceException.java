package com.gsitm.sample.exception;

@SuppressWarnings("serial")
public class ServiceException extends RuntimeException {
    public ServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}
