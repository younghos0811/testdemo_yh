package com.gsitm.sample.batch;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.launch.JobLauncher;

public class PaperJobScheduler {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private final Format dateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	private JobLauncher jobLauncher;

	private Job job;

	public void setJobLauncher(JobLauncher jobLauncher) {
		this.jobLauncher = jobLauncher;
	}

	public void setJob(Job job) {
		this.job = job;
	}

	public void run() throws Exception {
		JobExecution execution = jobLauncher.run(job, new JobParameters());

		logger.info("Executed: {}", job.getName());
		logger.info("Exit Status: {}", execution.getStatus());
		logger.info("Exit Status: {}", execution.getAllFailureExceptions());
		logger.info("End: {}", dateFormatter.format(new Date()));
		logger.info("Done");
	}
}