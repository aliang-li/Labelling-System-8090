package demo.servlet;

import java.io.File; 
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;




/**
 * Servlet implementation class CatalogServlet
 */
@WebServlet("/CatalogServlet")
public class CatalogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CatalogServlet() {
//        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		// 修改resPATH、jsonPath、commentsJsonPath
		String name = (String)session.getAttribute("name");
		int x = name.indexOf("_");//前为医院名，后为医生名
		String hospital = name.substring(0, x);
		
		String dirName = request.getParameter("name");
		String patientName = request.getParameter("pName");
		File file = null;
		File[] childs = null;
		String path = "/data/leichao/asd/" + hospital + "/" + patientName + "/" + dirName;//之后要改的
		file = new File(path);
		childs = file.listFiles();
		String[] resPathArray = new String[childs.length];
		String[] resPath = new String[childs.length];
		String githubRaw = "http://222.24.62.190:8090/test/";
		String absPath;
		String temp = "/data/leichao/asd";
		ArrayList<String> dicomList = new ArrayList<String>();
		for (int i = 0; i < childs.length; i++) {
			resPathArray[i] = childs[i].getAbsolutePath();
			System.out.println("resPathArray:" + resPathArray[i]);
			absPath = childs[i].getAbsolutePath().replaceAll("\\\\", "/");
			absPath = absPath.replace(temp, "");
			resPath[i] = githubRaw + absPath.replace("/", "/").trim();
			dicomList.add(resPath[i]);
			System.out.println("resPath:" + resPath[i]);
		}
		session.setAttribute("resPATH", resPath);//session也需要改是因为刷新页面index.jsp,最初是通过session拿dicomList
		
		//修改session中的resParentPath、 jsonPath以及commentsJsonPath
		String patientPath = githubRaw + "/" + hospital + "/" + patientName + "/" + dirName;
		String jsonPath = patientPath + "_mask" + "/state.json";
		String commentsJsonPath = patientPath + "_mask" + "/comments.json";
		String resParentPath = temp + "/" + hospital + "/" + patientName + "/" + dirName + "_mask";
		session.setAttribute("commentsJsonPath", commentsJsonPath);
		session.setAttribute("jsonPath", jsonPath);
		session.setAttribute("resParentPath", resParentPath);
		String loadIf = "0";
		file = new File(path + "_mask/state.json");
		
		if (file.exists()) {
			loadIf = "1";
		}else {
			loadIf = "0";
		}
		session.setAttribute("loadIf", loadIf);
		ArrayList<String> pathList = new ArrayList<String>();
		pathList.add(jsonPath);//[0]
		pathList.add(commentsJsonPath);//[1]
		pathList.add(loadIf);//[2]
		pathList.add(resParentPath);//[3]
		//修改index.jsp中的name，表示当前位置
		String cpos = "";
	    cpos = patientName + ">>" + dirName + ">>";
	    pathList.add(cpos);//[3]
		
		Map<String, ArrayList<String>> resData = new HashMap<String, ArrayList<String>>();
		resData.put("dicomList", dicomList);
		resData.put("path", pathList);
        JSONObject jsonObject = JSONObject.fromObject(resData);
		String jsonData = jsonObject.toString();
		response.setContentType("text/plain");
	    response.setContentType("application/json");
		response.getWriter().print(jsonData);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	

}
