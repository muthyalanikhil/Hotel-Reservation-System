using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["connString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void loginButton_Click(object sender, EventArgs e)
    {
        var username = UserName.Text;
        var password = Password.Text;
     
        MySqlConnection connection = new MySqlConnection(connString);
        try
        {
            connection.Open();
            MySqlCommand cmd = new MySqlCommand("select id, username, email, role, isBlocked from user where email=@user and password=@pass", connection);
            cmd.Parameters.AddWithValue("user", @username);
            cmd.Parameters.AddWithValue("pass", @password);
            MySqlDataAdapter da = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                var role = "user";
                var isBlocked = "0";
                foreach (DataRow row in dt.Rows)
                {
                    Session["userID"] = row.ItemArray[0].ToString();
                    role = row.ItemArray[3].ToString();
                    isBlocked = row.ItemArray[4].ToString();
                    Session["email"] = row.ItemArray[2].ToString();
                    Session["username"] = row.ItemArray[1].ToString();
                    Session["role"] = row.ItemArray[3].ToString();
                    Session["isBlocked"] = row.ItemArray[4].ToString();
                }
                connection.Close();
                if (isBlocked == "1")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "Authentication Error", "<script language='javascript'>alert('You donot have permission to loggin. Please contact Admin.')</script>");
                }
                else
                {
                    if (role == "admin")
                    {
                        Response.Redirect("~/AdminView", false);
                    }
                    if (role == "employee")
                    {
                        Response.Redirect("~/EmployeeView", false);
                    }
                    if (role == "user")
                    {
                        Response.Redirect("~/CustomerView", false);
                    }
                }
            }
            else
            {
                connection.Close();
                ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('Invalid Username and Password')</script>");
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Error");
        }
        finally
        {
            if (connection.State == ConnectionState.Open)
            {
                connection.Close();
            }
        }
    }
}