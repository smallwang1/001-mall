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
        .head{
            width: 200px;
            height: 200px;
            border-radius: 50%;

        }

    </style>
</head>
<body>
<div class="layui-container">
    <div class="layui-form layuimini-form">
        <div class="layui-row">
            <div class="layui-col-md4 layui-col-md-offset1">
                <div class="layui-form-item">
                    <label class="layui-form-label required">菜单名称</label>
                    <div class="layui-input-block">
                        <input type="text" name="title" lay-verify="required" lay-reqtext="菜单名称不能为空" placeholder="请输入菜单名称" value="" class="layui-input">
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-row">
            <div class="layui-col-md4 layui-col-md-offset1">
                <div class="layui-form-item">
                    <label class="layui-form-label required">菜单图标</label>
                    <div class="layui-input-block">
                        <input type="text" name="icon" lay-verify="required" lay-reqtext="菜单图标不能为空" placeholder="请输入菜单图标" value="" class="layui-input">
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" name="head">
        <div class="layui-row">
            <div class="layui-col-md4 layui-col-md-offset2">
                <div class="layui-form-item">
                    <label class="layui-form-label required">超链接</label>
                    <div class="layui-input-block">
                        <input type="text" id="href" name="href" lay-verify="required" lay-reqtext="页面地址不能为空" placeholder="请输入页面地址" value="" class="layui-input">
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" name="parentId">
        <div class="layui-row">
            <div class="layui-col-md-offset5 layui-col-md1">
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>

<script>
    layui.use(['form','layer'], function () {
        var form = layui.form,
            layer = layui.layer,
             $ = layui.$;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            data=data.field
            $.ajax({
                url:'${pageContext.request.contextPath}/menu/add',
                data:data,
                type: 'post',
                dataType: 'json',
                success:function (res) {
                    if (res.code==200){
                        layer.msg(res.msg);
                        // 关闭弹出层
                        var iframeIndex = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(iframeIndex);
                        parent.menuTable.reload();//刷新menuList表格


                    }
                }
            })
            return false;
        });

    });
</script>
</body>
</html>