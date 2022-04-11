<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui_ext/dtree/dtree.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui_ext/dtree/font/dtreefont.css">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-container">
    <ul id="demoTree" class="dtree" data-id="0"></ul>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>

    layui.extend({
        dtree: '${pageContext.request.contextPath}/layui_ext/dtree/dtree'   // {/}的意思即代表采用自有路径，即不跟随 base 路径
    }).use(['dtree','layer','jquery'], function(){
        var dtree = layui.dtree, layer = layui.layer, $ = layui.jquery;
        // 初始化树
        var DemoTree = dtree.render({
            elem: "#demoTree",
           // data: demoTree, // 使用data加载
            url: "${pageContext.request.contextPath}/menu/tree" // 使用url加载（可与data加载同时存在）
        });
        // 绑定节点点击
        dtree.on("node('demoTree')" ,function(obj){
            // 获取点击的节点的id
            var nodeId=obj.param.nodeId;
            //layer.msg(JSON.stringify(obj.param));
            window.parent.right.rightFun(nodeId);
        });
    });
</script>
</body>
</html>
