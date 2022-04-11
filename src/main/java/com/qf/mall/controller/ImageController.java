package com.qf.mall.controller;

import com.qf.mall.common.DataResult;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("image")
public class ImageController {
    @Autowired
    private ServletContext servletContext;
    @RequestMapping("load")
    public void loadImage(String head, HttpServletResponse response) throws Exception {
        String imagePath = servletContext.getAttribute("imagePath").toString();

        InputStream is=new FileInputStream(imagePath+"/"+head);

        IOUtils.copy(is,response.getOutputStream());
    }
    @PostMapping("upload")
    @ResponseBody
    public DataResult fileUpload(MultipartFile file) throws Exception {
        String imagePath = servletContext.getAttribute("imagePath").toString();

        String realName = file.getOriginalFilename();
        String ext = FilenameUtils.getExtension(realName);
        String imageName= UUID.randomUUID().toString().replace("-","")+"."+ext;
        File f=new File(imagePath,imageName);

        OutputStream out=new FileOutputStream(f);
        IOUtils.copy(file.getInputStream(),out);
        Map<String,Object> map=new HashMap<>();
        map.put("src",imageName);
        return DataResult.returnData(0,map);

    }
}
