package com.qf.mall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PageController {
    @RequestMapping({"/","login"})
    public String loginPage(){
        return "login";
    }

    @RequestMapping("index")
    public String indexPage(){

        return "index";
    }

    @RequestMapping({"/page/{p}"})
    public String page(@PathVariable String p){
        return "page/"+p;
    }

    /*@RequestMapping({"/page/user/{p}"})
    public String pageUser(@PathVariable String p){
        return "page/user/"+p;
    }

    @RequestMapping({"/page/goods/{p}"})
    public String pagegoods(@PathVariable String p){
        return "page/goods/"+p;
    }
*/
    @RequestMapping({"/page/{dir}/{p}"})
    public String pageDir(@PathVariable String dir,@PathVariable  String p){
        return "page/"+dir+"/"+p;
    }
}
