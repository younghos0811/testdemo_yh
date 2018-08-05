package com.gsitm.sample.batch;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.jdbc.core.RowMapper;

public class PaperRowMapper implements RowMapper<Map<String, Object>> {
	@Override
	public Map<String, Object> mapRow(ResultSet rs, int rowNum) throws SQLException {
		Map<String, Object> row = new HashMap<String, Object>();
		row.put("apprId", rs.getString(1));
		row.put("status", rs.getInt(2));
		row.put("subject", rs.getString(4));

		return row;
	}

}