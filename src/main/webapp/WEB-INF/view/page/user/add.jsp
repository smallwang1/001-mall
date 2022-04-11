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
        <div class="layui-col-md3"  >
            <div class="layui-upload-drag head" id="addPic">
                <div class="layui-hide" id="uploadDemoView">
                    <img src="" class="head" alt="上传成功后渲染" style="max-width: 196px">
                </div>
            </div>
        </div>

        <div class="layui-col-md9" >
            <div class="layui-form-item">
                <label class="layui-form-label required">用户名</label>
                <div class="layui-input-block">
                    <input type="text" name="username" lay-verify="required" lay-reqtext="用户名不能为空" placeholder="请输入用户名" value="" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="userSex" value="男" title="男" checked="">
                    <input type="radio" name="userSex" value="女" title="女">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">手机号码</label>
                <div class="layui-input-block">
                    <input type="text" name="phone" lay-verify="required" lay-reqtext="手机号码不能为空" placeholder="请输入手机号码" value="" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">权限</label>
                <div class="layui-input-block">
                    <select name="userRoleId" id="roleId">

                    </select>
                </div>
            </div>

            <input type="hidden" name="head">
            <div class="layui-row">
                    <div class="layui-form-item">
                        <label class="layui-form-label required">出生日期</label>
                        <div class="layui-input-block">
                            <input type="text" id="birthDayId" name="birthday" lay-verify="required" lay-reqtext="出生日期不能为空" placeholder="yyyy-MM-dd" value="" class="layui-input">
                        </div>
                    </div>
            </div>

            <div class="layui-row">
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
    layui.use(['form','layer','upload','laydate'], function () {
        var form = layui.form,
            layer = layui.layer,
            upload=layui.upload,
            laydate = layui.laydate,
             $ = layui.$;

        laydate.render({
            elem:'#birthDayId'
        });
        //监听提交
        form.on('submit(saveBtn)', function (data) {
            data=data.field
            $.ajax({
                url:'${pageContext.request.contextPath}/user/add',
                data:data,
                type: 'post',
                dataType: 'json',
                success:function (res) {
                    if (res.code==200){
                        layer.msg(res.msg);
                        // 关闭弹出层
                        var iframeIndex = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(iframeIndex);
                        parent.userTable.reload();//刷新userList表格
                    }
                }
            })
            return false;
        });
        //拖拽上传
        upload.render({
            elem: '#addPic'
            ,url: '${pageContext.request.contextPath}/image/upload' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
            ,done: function(res){
                layer.msg('上传成功');
                layui.$('#uploadDemoView').removeClass('layui-hide').find('img').attr('src', '${pageContext.request.contextPath}/image/load?head='+res.data.src);
                $('input[type="hidden"]').val(res.data.src);
            }
        });
        $.ajax({
            url:'${pageContext.request.contextPath}/role/roleAll',
            type:'post',
            dataType:'json',
            success:function (res) {
                var str="";
                for (var i=0;i<res.length;i++){
                    str+='<option value="'+res[i].roleId+'">'+res[i].roleName+'</option>'
                }
                $('#roleId').append(str);
                form.render();//把页面重新加载
            }
        })
    });
</script>
</body>
</html>