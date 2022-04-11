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
</head>
<style>
    .layui-table-cell{
        height: auto;
    }
</style>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">用户性别</label>
                            <div class="layui-input-inline">
                                <input type="text" name="userSex" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">手机号码</label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">用户权限</label>
                            <div class="layui-input-inline">
                                <select name="roleName" id="roleId">

                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    var userTable;
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

         userTable = table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/user/list',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'userId', width: 80, title: 'ID', sort: true},
                {field: 'picId', title: '头像', Width: 100,templet:function (res) {
                        return '<div><img style="width: 80px;height: 80px;border-radius: 50% " src="${pageContext.request.contextPath}/image/load?head='+res.head+'" ></div>'
                    }},
                {field: 'username', width: 100, title: '用户名', sort: true},
                {field: 'password', width: 100, title: '用户密码'},
                {field: 'userSex', width: 80, title: '性别', sort: true},
                {field: 'roleName', width: 130, title: '权限'},
                {field: 'phone', width: 180, title: '电话号码'},
                {field: 'birthday', width: 200, title: '生日', sort: true},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            skin: 'line'
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
           /* var result = JSON.stringify(data.field);*/
            //执行搜索重载
            table.reload('currentTableId', {
                url:'${pageContext.request.contextPath}/user/list',
                page: {
                    curr: 1
                }
                , where: {
                    username:data.field.username,
                    userSex:data.field.userSex,
                    phone:data.field.phone,
                    roleName:data.field.roleName
                }
            }, 'data');

            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${pageContext.request.contextPath}/page/user/add',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var data = table.checkStatus('currentTableId').data;
                  //取出选中的ID
                var paramStr = "";
                for ( i = 0;i<data.length-1;i++) {
                    paramStr += data[i].userId + ",";
                }
                    paramStr+=data[data.length-1].userId;
                    layer.confirm("确认要删除["+paramStr+"]数据吗？",function (index) {
                        $.ajax({
                            url:'${pageContext.request.contextPath}/user/batchDelete',
                            data:{ids:paramStr},
                            type:'post',
                            dataType:'json',
                            success:function (res) {
                                layer.msg(res.msg);
                                userTable.reload();
                            }
                        })
                    })

                }

        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '编辑用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '50%'],
                    content: '${pageContext.request.contextPath}/page/user/edit',
                    success:function(layero, index){
                        var body=layer.getChildFrame("body",index);
                        body.find("input[name='phone']").val(data.phone);
                        body.find("input[name='userSex']").val(data.userSex);
                        body.find("input[name='username']").val(data.username);
                        body.find("input[name='userId']").val(data.userId);
                        
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('真的删除'+data.username+'行么', function (index) {
                    $.ajax({
                        url:'${pageContext.request.contextPath}/user/batchDelete',
                        data:{ids:data.userId},
                        type:'post',
                        dataType: 'json',
                        success:function (res) {
                            layer.msg(res.msg);
                            userTable.reload();
                        }
                    })
                    layer.close(index);
                });
            }
        });
        $.ajax({
            url:'${pageContext.request.contextPath}/role/roleAll',
            type:'post',
            dataType:'json',
            success:function (res) {
                var str="";
                for (var i=0;i<res.length;i++){
                    str+='<option value="'+res[i].roleName+'">'+res[i].roleName+'</option>'
                }
                $('#roleId').append(str);
                form.render();//把页面重新加载
            }
        })
    });
</script>

</body>
</html>
