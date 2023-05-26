<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="japan.Photo"%>
<!DOCTYPE html>
<html>
<head>
<title>関東の写真</title>
<style>
/* 拡大表示用のスタイル */
#overlay {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.7);
	z-index: 9999;
}

#overlay img {
	max-width: 70%;
	max-height: 70%;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

/* レスポンシブデザイン */
ul {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	list-style: none;
	padding: 0;
	margin: 0;
}

li {
	width: 20%; /* PCの場合は5列 */
	padding: 1%;
	box-sizing: border-box;
	text-align: center;
}

img {
	width: 100%;
	height: auto;
	object-fit: contain;
	aspect-ratio: 1/1; /* 正方形に設定 */
}

img:hover{
 transform: translateY(-4px);
}

/* スマートフォン向けの表示 */
@media ( max-width : 767px) {
	li {
		width: 30%; /* スマートフォンの場合は3列 */
	}
}
</style>
<script>
        // 写真をクリックして拡大表示するための関数
        function showOverlay(imageUrl, photoId) {
            var overlay = document.getElementById("overlay");
            var image = overlay.querySelector("img");
            var deleteButton = overlay.querySelector("#deleteButton");

            // 拡大表示する写真のURLを設定
            image.src = imageUrl;

            // オーバーレイを表示
            overlay.style.display = "block";

            // 削除ボタンのリンク先にphotoIdを設定
            deleteButton.href = "<%=request.getContextPath()%>/Japandelete?id=" + photoId;
        }

        // オーバーレイをクリックして元のサイズに戻すための関数
        function hideOverlay() {
            var overlay = document.getElementById("overlay");

            // オーバーレイを非表示
            overlay.style.display = "none";
        }
    </script>
</head>
<body>
	<h1>写真一覧</h1>

	<h3>写真を追加する</h3>
	<form action="<%=request.getContextPath()%>/Kantoadd" method="get">
		<input type="submit" value="写真を追加する">
	</form>
	<form action="<%=request.getContextPath()%>/Kanto" method="get">
		<input type="submit" value="戻る">
	</form>

	<h3>写真一覧</h3>
	<ul>
    <%
    List<Photo> photoList = (List<Photo>) request.getAttribute("photoList");

    for (Photo photo : photoList) {
        byte[] photoData = photo.getPhotoData();
        String photoBase64 = java.util.Base64.getEncoder().encodeToString(photoData);
        String imageUrl = "data:image/jpeg;base64, " + photoBase64;

        // 関東地方の県のみ表示する条件を追加
        if (photo.getLocation().equals("東京都") || photo.getLocation().equals("神奈川県")
                || photo.getLocation().equals("埼玉県") || photo.getLocation().equals("千葉県")
                || photo.getLocation().equals("茨城県") || photo.getLocation().equals("栃木県")
                || photo.getLocation().equals("群馬県")) {
    %>
    <li>
        <div>
            <img src="<%=imageUrl%>" alt="写真" onclick="showOverlay('<%=imageUrl%>', <%=photo.getId()%>)">
        </div>
    </li>
    <%
        }
    }
    %>
</ul>


	<!-- 拡大表示用のオーバーレイ -->
	<div id="overlay" onclick="hideOverlay()">
		<img src="" alt="写真">
		<form action="<%=request.getContextPath()%>/Kantodelete" method="post">
			<input type="hidden" name="id" id="deletePhotoId">
			<input type="submit" value="削除">
		</form>
	</div>

	<script>
        function showOverlay(imageUrl, photoId) {
            var overlay = document.getElementById("overlay");
            var image = overlay.querySelector("img");
            var deletePhotoId = overlay.querySelector("#deletePhotoId");

            image.src = imageUrl;
            overlay.style.display = "flex";
            deletePhotoId.value = photoId;
        }

        function hideOverlay() {
            var overlay = document.getElementById("overlay");
            overlay.style.display = "none";
        }
    </script>
</body>
</html>
