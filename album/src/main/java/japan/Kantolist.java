package japan;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Kantolist
 */
@WebServlet("/Kantolist")
public class Kantolist extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// データベースから写真データを取得
		List<Photo> photoList = new ArrayList<>();
		String url = "jdbc:mysql://localhost:3306/album";
		String username = "root";
		String password = "";

		try (Connection connection = DriverManager.getConnection(url, username, password)) {
			String query = "SELECT * FROM photos WHERE location IN ('東京都', '神奈川県', '埼玉県', '千葉県', '茨城県', '栃木県', '群馬県')";
			Statement statement = connection.createStatement();
			ResultSet resultSet = statement.executeQuery(query);

			while (resultSet.next()) {
				int id = resultSet.getInt("id");
				String date = resultSet.getString("date");
				String location = resultSet.getString("location");
				byte[] photoData = resultSet.getBytes("photo");

				photoList.add(new Photo(id, date, location, photoData));
			}

			resultSet.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
			// エラー処理
		}

		// 取得した写真データをリクエスト属性に設定
		request.setAttribute("photoList", photoList);

		// jspにフォワード
		request.getRequestDispatcher("WEB-INF/view/kantolist.jsp").forward(request, response);
	}
}
