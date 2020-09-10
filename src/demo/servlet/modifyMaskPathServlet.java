package demo.servlet;

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
@WebServlet("/modefyMaskServlet")
public class modifyMaskPathServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public modifyMaskPathServlet() {
		//super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String resParentPath = request.getParameter("resParentPath");
		HttpSession session = request.getSession();
		String megString = "no restore resParentPath";
		
		if(!("".equals(resParentPath)) ){
			session.setAttribute("resParentPath", resParentPath);
			megString = "restore successful resParentPath ";
		}
		//System.out.println("modefyMaskServlet::"+"".equals(resParentPath));
		//System.out.println("modefyMaskServlet::"+resParentPath);
		//System.out.println("session中的resParentPath："+session.getAttribute("resParentPath"));
		Map<String, ArrayList<String>> resData = new HashMap<String, ArrayList<String>>();
		ArrayList<String> pathList = new ArrayList<String>();
		
		pathList.add(megString);
		resData.put("flag",pathList);
		JSONObject jsonObject = JSONObject.fromObject(resData);
		String jsonData = jsonObject.toString();
		response.setContentType("text/plain");
	    response.setContentType("application/json");
		response.getWriter().print(jsonData);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	
}
