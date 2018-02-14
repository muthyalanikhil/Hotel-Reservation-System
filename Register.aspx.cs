using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Register : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["connString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void register_Click(object sender, EventArgs e)
    {
        string username = UserName.Text;    
        string email = Email.Text;
        string password = Password.Text;
        string role = "user";

        MySqlConnection connection = new MySqlConnection(connString);
        MySqlCommand cmd;
        connection.Open();
        try
        {
            cmd = connection.CreateCommand();
            cmd.CommandText = "INSERT INTO user(username,email,password,role) VALUES(@username,@email,@password,@role)";
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@role", role);
            cmd.Parameters.AddWithValue("@password", password);
            cmd.ExecuteNonQuery();
        }
        catch (Exception)
        {
            Response.Redirect("~/Error");
        }
        finally
        {
            if (connection.State == ConnectionState.Open)
            {
                connection.Close();
                Response.Redirect("~/Logout.aspx");
            }
        }
    }
}