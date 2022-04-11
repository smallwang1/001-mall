package com.qf.mall.controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import cn.hutool.db.Session;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@Controller
@RequestMapping("captcha")
public class CaptchaController {
    @RequestMapping("create")
    public void createCaptcha(HttpServletResponse response, HttpSession session){
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(100,38,4,10);
        //将验证码放入session中
        session.setAttribute("code",lineCaptcha.getCode());

        try {
            ServletOutputStream outputStream = response.getOutputStream();
            lineCaptcha.write(outputStream);
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
