using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Settings : System.Web.UI.Page
{
    String connString = ConfigurationManager.ConnectionStrings["connString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["username"] != null && Session["role"].ToString() == "admin")
            {
                LoadUserGV();
            }
            else
            {
                Response.Redirect("~/Error");
            }
        }
    }

    private void LoadUserGV()
    {
        MySqlConnection connection = new MySqlConnection(connString);
        connection.Open();
        try
        {
            MySqlCommand cmd = connection.CreateCommand();
            cmd.CommandText = "SELECT id,userName,email,role,isBlocked FROM user";
            MySqlDataAdapter adap = new MySqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adap.Fill(ds);
            userListGV.DataSource = ds.Tables[0].DefaultView;
            userListGV.DataBind();
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


    protected void blockUser_Click(object sender, EventArgs e)
    {
        if (blockEmail.Text != null && blockEmail.Text != "")
        {
            string userName = blockEmail.Text;
            MySqlConnection connection = new MySqlConnection(connString);
            MySqlCommand cmd;
            connection.Open();
            try
            {
                cmd = connection.CreateCommand();
                cmd.CommandText = "UPDATE user SET isBlocked = 1 where email = @email ";
                cmd.Parameters.AddWithValue("@email", userName);
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected == 0)
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('User not present or something went wrong. Contact Admin')</script>");
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
                Response.Redirect(Request.Url.AbsoluteUri);
            }
            LoadUserGV();
        }
    }

    protected void unblockUser_Click(object sender, EventArgs e)
    {
        if (unblockEmail.Text != null && unblockEmail.Text != "")
        {
            string userName = unblockEmail.Text;
            MySqlConnection connection = new MySqlConnection(connString);
            MySqlCommand cmd;
            connection.Open();
            try
            {
                cmd = connection.CreateCommand();
                cmd.CommandText = "UPDATE user SET isBlocked = 0 where email = @email ";
                cmd.Parameters.AddWithValue("@email", userName);
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected == 0)
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('User not present or something went wrong. Contact Admin')</script>");
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
                Response.Redirect(Request.Url.AbsoluteUri);
            }
            LoadUserGV();
        }
    }

    protected void deleteUser_Click(object sender, EventArgs e)
    {
        if (deleteEmail.Text != null && deleteEmail.Text != "")
        {
            string userName = deleteEmail.Text;
            MySqlConnection connection = new MySqlConnection(connString);
            MySqlCommand cmd;
            connection.Open();
            try
            {
                cmd = connection.CreateCommand();
                cmd.CommandText = "DELETE FROM user where email = @email ";
                cmd.Parameters.AddWithValue("@email", userName);
                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected == 0)
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('User not present or something went wrong. Contact Admin')</script>");
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
                Response.Redirect(Request.Url.AbsoluteUri);
            }
            LoadUserGV();
        }
    }

    protected void userRole_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        //Get the row that contains this button
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowIndex = gvr.RowIndex; // Get the current row
        string userId = userListGV.Rows[rowIndex].Cells[0].Text;
        string role = userListGV.Rows[rowIndex].Cells[2].Text;
        if (role == "employee")
        {
            role = "user";
        }
        else
        {
            role = "employee";
        }
        MySqlConnection connection = new MySqlConnection(connString);
        try
        {
            connection.Open();
            MySqlCommand cmd = new MySqlCommand("Update user set role=@role where id=@userId", connection);
            cmd.Parameters.AddWithValue("userId", userId);
            cmd.Parameters.AddWithValue("role", role);
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
            LoadUserGV();
        }
    }

    protected void userListGV_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TableCell roleCell = e.Row.Cells[2];
            if (roleCell.Text == "employee")
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Button btnButton = (Button)e.Row.FindControl("userRole");
                    btnButton.Text = "Make User";
                    btnButton.CssClass = "btn btn-success";
                }
            }
            else
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Button btnButton = (Button)e.Row.FindControl("userRole");
                    btnButton.Text = "Make Employee";
                    btnButton.CssClass = "btn btn-primary";
                }
            }
        }
    }
}