using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserProfile : System.Web.UI.Page
{
    String connString = ConfigurationManager.ConnectionStrings["connString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetUserDetails();
        }
    }

    private void GetUserDetails()
    {
        MySqlConnection connection = new MySqlConnection(connString);
        try
        {
            connection.Open();
            MySqlCommand cmd = new MySqlCommand("select userName,email,address,phone from user where id=@userId", connection);
            cmd.Parameters.AddWithValue("userId", Session["userID"].ToString());
            MySqlDataAdapter da = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                userName.Text = dt.Rows[0]["userName"].ToString();
                addressLine1.Text = dt.Rows[0]["address"].ToString();
                phone.Text = dt.Rows[0]["phone"].ToString();
                email.Text = dt.Rows[0]["email"].ToString();
            }
            else
            {
                userName.Text = "";
                addressLine1.Text = "";
                phone.Text = "";
                email.Text = "";
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

    protected void updateProfile_Click(object sender, EventArgs e)
    {
        int result = 0;
        MySqlConnection connection1 = new MySqlConnection(connString);
        connection1.Open();
        try
        {
            MySqlCommand mysqlcmd = connection1.CreateCommand();
            mysqlcmd.CommandText = "SELECT count(*) FROM user WHERE id=@userId";
            mysqlcmd.Parameters.AddWithValue("userId", Session["userID"].ToString());
            result = Convert.ToInt32(mysqlcmd.ExecuteScalar());
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Error");
        }
        finally
        {
            if (connection1.State == ConnectionState.Open)
            {
                connection1.Close();
            }
        }
        if (result > 0)
        {
            MySqlConnection connection = new MySqlConnection(connString);
            MySqlCommand cmd;
            connection.Open();
            try
            {
                cmd = connection.CreateCommand();
                cmd.CommandText = "Update user set userName=@userName,address=@addressLine1,phone=@phone,email=@email where id=@userId";
                cmd.Parameters.AddWithValue("userId", Session["userID"].ToString());
                cmd.Parameters.AddWithValue("userName", userName.Text);
                cmd.Parameters.AddWithValue("addressLine1", addressLine1.Text);
                cmd.Parameters.AddWithValue("phone", phone.Text);
                cmd.Parameters.AddWithValue("email", email.Text);
                cmd.ExecuteNonQuery();
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
                ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('Profile Updated Succcessfully');", true);
            }
            GetUserDetails();
        }      
    }
}