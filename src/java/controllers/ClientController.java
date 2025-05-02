package controllers;

import entities.Client;
import services.ClientService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ClientController", urlPatterns = {"/ClientController"})
public class ClientController extends HttpServlet {

    private ClientService clientService;

    @Override
    public void init() throws ServletException {
        super.init();
        clientService = new ClientService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String operation = request.getParameter("op");
        String idStr = request.getParameter("id");

        if (operation == null) {
            response.sendRedirect("users/participants.jsp?error=missing_params");
            return;
        }

        try {
            if ("delete".equals(operation) && idStr != null) {
                int id = Integer.parseInt(idStr);
                Client client = clientService.findById(id);
                if (client != null) {
                    clientService.delete(client);
                    response.sendRedirect(request.getContextPath() + "/users/UsersController?success=deleted");
                } else {
                    response.sendRedirect("users/participants.jsp?error=client_not_found");
                }
            } else if ("update".equals(operation) && idStr != null) {
                int id = Integer.parseInt(idStr);
                Client client = clientService.findById(id);
                if (client != null) {
                    request.setAttribute("client", client);
                    request.getRequestDispatcher("users/updateClient.jsp").forward(request, response);
                } else {
                    response.sendRedirect("users/participants.jsp?error=client_not_found");
                }
            } else if ("saveUpdate".equals(operation) && idStr != null) {
                int id = Integer.parseInt(idStr);
                String nom = request.getParameter("nom");
                String email = request.getParameter("email");

                Client client = clientService.findById(id);
                if (client != null) {
                    client.setNom(nom);
                    client.setEmail(email);
                    clientService.update(client);
                    response.sendRedirect(request.getContextPath() + "/users/UsersController?success=updated");
                } else {
                    response.sendRedirect(request.getContextPath() + "/users/UsersController?error=client_not_found");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/users/UsersController?error=invalid_operation");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/users/UsersController?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/users/UsersController?error=server_error");
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
        return "ClientController";
    }
}
