<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<frameset cols="15%,*" noresize >
    <frame src="${pageContext.request.contextPath}/page/menu/menuLeft" name="left">
    <frame src="${pageContext.request.contextPath}/page/menu/menuRight" name="right">
</frameset>

<script>
    window.name='menuLeftAndRight';
</script>
</html>
