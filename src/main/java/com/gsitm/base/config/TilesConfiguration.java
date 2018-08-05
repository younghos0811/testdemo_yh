package com.gsitm.base.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

@Configuration
public class TilesConfiguration {
	@Autowired
	ContentNegotiationManager manager;
    @Bean
    public TilesConfigurer tilesConfigurer() {
        final TilesConfigurer configurer = new TilesConfigurer();
        configurer.setDefinitions(new String[] {"classpath:tiles/tiles-def.xml"});
        configurer.setCheckRefresh(true);
        return configurer;
    }

    @Bean
    public ViewResolver tilesViewResolver() {
        return new TilesViewResolver();
    }
}