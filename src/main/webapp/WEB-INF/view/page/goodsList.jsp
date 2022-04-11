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
                            <label class="layui-form-label">商品名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="goodsName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">商品种类</label>
                            <div class="layui-input-inline">
                                <input type="text" name="goodsTypeName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>


        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
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
            url: '${pageContext.request.contextPath}/goods/list',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {field: 'goodsId', width: 100, title: 'ID', sort: true},
                {field: 'picId', title: '商品头像', Width: 80,templet:function (res) {
                        return '<div><img style="width: 80px;height: 80px;border-radius: 50% " src="${pageContext.request.contextPath}/image/load?head='+res.head+'" ></div>'
                    }},
                {field: 'goodsName', width: 200, title: '商品名',},
                {field: 'goodsTypeName', width: 200, title: '商品种类'},
                {field: 'goodsInstruction', width: 300, title: '商品介绍'},
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
                url:'${pageContext.request.contextPath}/goods/list',
                page: {
                    curr: 1
                }
                , where: {
                    goodsName:data.field.goodsName,
                    goodsTypeName:data.field.goodsTypeName
                }
            }, 'data');

            return false;
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '编辑商品',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['50%', '50%'],
                    content: '${pageContext.request.contextPath}/page/goods/edit',
                    success:function(layero, index){
                        var body=layer.getChildFrame("body",index);
                        body.find("input[name='goodsName']").val(data.goodsName);
                        body.find("input[name='goodsTypeName']").val(data.goodsTypeName);
                        body.find("input[name='goodsInstruction']").val(data.goodsInstruction);
                        body.find("input[name='goodsId']").val(data.goodsId);
                        
                    }
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            }
        });

    });
</script>

</body>
</html>
