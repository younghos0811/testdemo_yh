package com.gsitm.base.datatables.mapping;

public class CaseFormat {
	public static final String REGEX = "([a-z])([A-Z]+)";
	public static final String REPLACEMENT = "$1_$2";

	public static String convertPropertyNameToUnderscoreName(String name) {
		return name.replaceAll(REGEX, REPLACEMENT).toLowerCase();
	}
}