package controllers;

import entities.Client;
import entities.SessionFormation;
import services.ClientService;
import services.SessionService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UsersController", urlPatterns = {"/users/UsersController"})
public class UsersController extends HttpServlet {

    private ClientService clientService;
    private SessionService sessionService;

    @Override
    public void init() throws ServletException {
        super.init();
        clientService = new ClientService();
        sessionService = new SessionService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Client> clients = clientService.findAllWithSessions();
            request.setAttribute("clients", clients);
            request.getRequestDispatcher("participants.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("participants.jsp?error=true");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "UsersController";
    }
}
