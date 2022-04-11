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
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">
    <div class="layui-form-item">
        <label class="layui-form-label required">商品名</label>
        <div class="layui-input-block">
            <input type="text" name="username" lay-verify="required" lay-reqtext="商品名不能为空" placeholder="请输入商品名" value="" class="layui-input">
            <tip>填写自己管理账号的名称。</tip>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label required">商品种类</label>
        <div class="layui-input-block">
            <select name="goodsTypeId" id="typeId">

            </select>
        </div>
    </div>
    <input type="hidden" name="userId">
    <div class="layui-form-item">
        <label class="layui-form-label required">商品描述</label>
        <div class="layui-input-block">
            <input type="text" name="phone" lay-verify="required" placeholder="请输入商品描述" value="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
        </div>
    </div>
</div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            $.ajax({
                url:'${pageContext.request.contextPath}/goods/update',
                data:data.field,
                type:'post',
                dataType:'json',
                success:function (res) {
                    layer.msg(res.msg);
                    var iframeIndex = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(iframeIndex);
                    parent.userTable.reload();

                }
            })
            return false;
        });
        $.ajax({
            url:'${pageContext.request.contextPath}/type/typeAll',
            type:'post',
            dataType:'json',
            success:function (res) {
                var str="";
                for (var i=0;i<res.length;i++){
                    str+='<option value="'+res[i].goodsTypeId+'">'+res[i].goodsTypeName+'</option>'
                }
                $('#typeId').append(str);
                form.render();//把页面重新加载
            }
        })
    });
</script>
</body>
</html>