package com.gsitm.sample.exception;

@SuppressWarnings("serial")
public class NoAffectedException extends RuntimeException {
	public NoAffectedException(String message) {
		super(message);
	}

    public NoAffectedException(String message, Throwable cause) {
        super(message, cause);
    }
}