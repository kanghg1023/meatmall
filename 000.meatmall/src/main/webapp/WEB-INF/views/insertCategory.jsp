<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
   .catebtn { 
   width: 100%;
    height: 28px;
    padding: 0;
    border: 0;
    background-color: #2AC37D;
    border-radius:5px;
    cursor:pointer;
    color:white;
    font-weight: bold;
}
</style>
</head>
<body>
<form action="insertCategory.do" method="get">
   <table>
      <col width="210px"><col width="180px"><col width="150px">
      <tr>
         <th>추가할 부위 입력</th>
         <td><input type="text" name="kind_name" required="required"/></td>
         <td><input type="submit" value="부위 추가" onclick="opener.document.location.reload(); javascript:self.close();" onclose="opener.parent.location.reload();" class="catebtn"/></td>      
      </tr>
   </table>
</form>
</body>
</html>