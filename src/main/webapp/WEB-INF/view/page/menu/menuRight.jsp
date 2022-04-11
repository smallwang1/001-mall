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
        <script type="text/html" id="menuToolBar">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
            </div>
        </script>

        <table class="layui-hide" id="menuTableId" lay-filter="menuTableFilter"></table>

        <script type="text/html" id="menuTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    var menuTable;
    var parentId;
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        menuTable = table.render({
            elem: '#menuTableId',
            url: '${pageContext.request.contextPath}/menu/list',
            toolbar: '#menuToolBar',
            cols: [[
                {field: 'menuId', width: 50, title: 'ID'},
                {field: 'title', width: 150, title: '菜单标题'},
                {field: 'icon', width: 150, title: '菜单图标'},
                {field: 'href', width: 150, title: '超链接'},
                {field: 'target', title: '显示方式'},
                {field: 'parentId', width: 100, title: '父ID'},
                {field: 'parentIs', width: 120, title: '父节点？',templet:function(res){
                        if(res.parentIs){
                            return '<div><span class="layui-badge layui-bg-orange">是</span></div>'
                        }else{
                            return '<div><span class="layui-badge layui-bg-red">否</span></div>'
                        }
                    }},
                {field: 'open', width: 150, title: '是否打开',templet:function(res){
                        if(res.open){
                            return '<div><span class="layui-badge layui-bg-orange">是</span></div>'
                        }else{
                            return '<div><span class="layui-badge layui-bg-red">否</span></div>'
                        }
                    }},
                {title: '操作', minWidth: 120, toolbar: '#menuTableBar', align: "center"}
            ]]
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(menuTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                // 在js中 没有布尔类型，可以直接判断一个数值型值，只要这个值不是数值型0，都为真
                // 除此之外 NAN 和未定义都表示假的意思
                if (parentId){
                    var index = layer.open({
                        title: '添加用户',
                        type: 2,
                        shade: 0.2,
                        maxmin:true,
                        shadeClose: true,
                        area: ['60%', '60%'],
                        content: '${pageContext.request.contextPath}/page/menu/add',
                        success:function(layero, index){
                            var body=layer.getChildFrame("body",index);
                            body.find("input[name='parentId']").val(parentId);
                        }
                    });

                }else{
                    layer.msg("请在树结构中选择父节点");
                }

            }
        });
        table.on('tool(menuTableFilter)', function (obj) {
            if(obj.event=='edit'){
                var index = layer.open({
                    title: '编辑菜单',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '${pageContext.request.contextPath}/page/menu/edit',
                    success:function(layero, index){
                        var body=layer.getChildFrame("body",index);
                        body.find("input[name='menuId']").val(obj.data.menuId);
                        body.find("input[name='href']").val(obj.data.href);
                    }
                });
            }else{
                    // 删除数据，父节点不允许删除的，因为父节点有子节点
                if ((obj.data.parentIs+"") != 'true'){
                    layer.confirm('确认要删除【'+obj.data.title+'】节点吗？',function(layero,index){
                        $.ajax({
                            url:'${pageContext.request.contextPath}/menu/delete',
                            data:{menuId:obj.data.menuId},
                            type:'post',
                            dataType:'json',
                            success:function(res){
                                layer.msg(res.msg);
                                menuTable.reload();
                            }
                        });
                    });
                }else{
                    layer.msg("父节点不允许删除");
                }

            }

        })

    });
    // 给menuLeft页面进行调用的一个全局函数
    function rightFun(parentId){
        this.parentId=parentId;
       // 刷新表格，将表格重新加载即可
        //执行搜索重载
        menuTable.reload({
            url:'${pageContext.request.contextPath}/menu/list',
           where: {
               parentId: parentId
            }
        }, 'data');
    }

</script>

</body>
</html>
