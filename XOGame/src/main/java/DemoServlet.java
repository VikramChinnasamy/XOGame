import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


public class DemoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DemoServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id=request.getParameter("idc");
		String name=request.getParameter("name");
		String pass=request.getParameter("password");
		String email=request.getParameter("email");
		String phone=request.getParameter("phone");
		//System.out.println(str);
		Database obj=new Database(id,name,pass,email,phone);
	    obj.store();
	    request.setAttribute("registrationSuccess", true);

        // Forward the request to the registration success page
        request.getRequestDispatcher("Login.html").forward(request, response);
        
		//response.getWriter().append(str);
		doGet(request, response);
	}
}
