package com.gsitm.sample.batch;

import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;

public class StoredProcedureTasklet implements Tasklet {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	@Override
	public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("list_type", "receive");
		parameters.put("user_id", "CJ65");
		parameters.put("code", null);
		parameters.put("cust_nm", null);
		parameters.put("user_nm", null);
		parameters.put("subject", null);
		parameters.put("order_by", "MAKEDATE");
		parameters.put("page_no", "1");
		parameters.put("max_rec", "20");
		parameters.put("sys_type", "D");
		
		SimpleJdbcCall procedure = new SimpleJdbcCall(dataSource).withProcedureName("GET_PAPER_LIST4");
		SqlParameterSource parameterSource = new MapSqlParameterSource(parameters);
		Map<String, Object> result = procedure.execute(parameterSource);
		
		logger.debug(result.toString());
		
		return RepeatStatus.FINISHED;
	}
}