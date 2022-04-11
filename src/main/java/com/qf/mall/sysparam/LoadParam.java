package com.qf.mall.sysparam;

import com.qf.mall.mapper.SysParamMapper;
import com.qf.mall.pojo.SysParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.List;

@WebListener
public class LoadParam implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();
        WebApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(servletContext);
        SysParamMapper bean = ac.getBean(SysParamMapper.class);
        List<SysParam> sysParamList = bean.findAllSysParam();
        for (SysParam sysParam : sysParamList) {

            servletContext.setAttribute(sysParam.getParamName(),sysParam.getParamPath());
        }

    }
}
