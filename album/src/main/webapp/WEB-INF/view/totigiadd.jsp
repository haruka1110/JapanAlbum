<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>栃木県に写真を追加</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/Totigiadd" method="post" enctype="multipart/form-data">
    <label for="date">日付:</label> <input type="date" name="date" id="date"  required><br>
    <br> <label for="location">場所:</label>
   <h4>栃木県に写真を追加します</h4> 
    <input type="hidden" name="location" value="栃木県"> <!-- 隠しフィールドとしてlocationを追加 -->
    <br> <label for="photo">写真:</label> <input type="file" name="photo" id="photo"  required><br> <br>
    <input type="submit" value="送信">
</form>

	<form action="<%=request.getContextPath()%>/Totigilist" method="get">
		<input type="submit" value="戻る">
	</form>
</body>
</html>
