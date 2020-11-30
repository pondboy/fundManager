package com.example.financialdemo.config.listener;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/14 19:59
 */
@WebListener
@Slf4j
public class ServerStartUpListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext servletContext = servletContextEvent.getServletContext();
        String contextPath = servletContext.getContextPath();
        servletContext.setAttribute("APP_PATH",contextPath);
        log.info("路径为："+contextPath);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
