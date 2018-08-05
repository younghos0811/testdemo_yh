package com.gsitm.base.json.serialize;

import java.io.IOException;
import java.text.DecimalFormat;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

public class CurrencySerializer extends JsonSerializer<Number> {
	private static final DecimalFormat doubleFormatter = new DecimalFormat("#,###.###");

	@Override
	public void serialize(Number value, JsonGenerator gen, SerializerProvider serializers)
			throws IOException, JsonProcessingException {
		gen.writeString(doubleFormatter.format(value));
	}
}