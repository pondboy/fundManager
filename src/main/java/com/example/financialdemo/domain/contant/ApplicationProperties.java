package com.example.financialdemo.domain.contant;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @Auther: jinhaihao
 * @Date: 2020/3/24 23:38
 */
@Component
@ConfigurationProperties(prefix = "application")
public class ApplicationProperties {

    private String url;


}
