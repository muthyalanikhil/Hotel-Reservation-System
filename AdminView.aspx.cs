using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminView : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["connString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null && (Session["role"].ToString() == "admin"))
        {
            if (!Page.IsPostBack)
            {
                LoadRoomGridView();
            }
        }
        else
        {
            Response.Redirect("~/Error");
        }
    }

    private void LoadRoomGridView()
    {
        MySqlConnection connection = new MySqlConnection(connString);
        connection.Open();
        try
        {
            MySqlCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select id,roomNumber,roomType,description,status from rooms";
            MySqlDataAdapter adap = new MySqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adap.Fill(ds);
            DataTable dt = ds.Tables[0];
            roomGridView.DataSource = dt;
            roomGridView.DataBind();
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

    protected void updateInfo_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        //Get the row that contains this button
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowIndex = gvr.RowIndex; // Get the current row
        roomId.Text = roomGridView.Rows[rowIndex].Cells[0].Text;
        numberTB.Text = roomGridView.Rows[rowIndex].Cells[1].Text;
        roomType.Text = roomGridView.Rows[rowIndex].Cells[2].Text;
        descriptionTB.Text = roomGridView.Rows[rowIndex].Cells[3].Text;
        string a = roomGridView.Rows[rowIndex].Cells[4].Text;
        statusUpdateDD.SelectedValue = roomGridView.Rows[rowIndex].Cells[4].Text;
        updateRoomInfoPH.Visible = true;
    }

    protected void update_Click(object sender, EventArgs e)
    {
        string id = roomId.Text;
        string roomNum = numberTB.Text;
        string type = roomType.SelectedValue;
        string desc = descriptionTB.Text;
        string roomStatus = statusUpdateDD.SelectedValue;

        MySqlConnection connection = new MySqlConnection(connString);
        MySqlCommand cmd;
        connection.Open();
        try
        {
            cmd = connection.CreateCommand();
            cmd.CommandText = "UPDATE rooms set roomNumber=@roomNumber,roomType=@roomType,description=@description,status=@status where id=@id";
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@roomNumber", roomNum);
            cmd.Parameters.AddWithValue("@roomType", type);
            cmd.Parameters.AddWithValue("@description", desc);
            cmd.Parameters.AddWithValue("@status", roomStatus);
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
            updateRoomInfoPH.Visible = false;
            LoadRoomGridView();
        }
    }

    protected void closeUpdate_Click(object sender, EventArgs e)
    {
        updateRoomInfoPH.Visible = false;
    }

    protected void addRoom_Click(object sender, EventArgs e)
    {
        string roomNum = roomNumber.Text;
        string type = roomTypeDD.SelectedValue.ToString();
        string desc = description.Text;
        string roomStatus = statusDD.SelectedValue.ToString();

        MySqlConnection connection = new MySqlConnection(connString);
        MySqlCommand cmd;
        connection.Open();
        try
        {
            cmd = connection.CreateCommand();
            cmd.CommandText = "INSERT INTO rooms(roomNumber,roomType,description,status) VALUES(@roomNumber,@roomType,@description,@status)";
            cmd.Parameters.AddWithValue("@roomNumber", roomNum);
            cmd.Parameters.AddWithValue("@roomType", type);
            cmd.Parameters.AddWithValue("@description", desc);
            cmd.Parameters.AddWithValue("@status", roomStatus);
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
            LoadRoomGridView();
        }
    }

    protected void delete_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        //Get the row that contains this button
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowIndex = gvr.RowIndex; // Get the current row
        string id = roomGridView.Rows[rowIndex].Cells[0].Text;

        MySqlConnection connection = new MySqlConnection(connString);
        connection.Open();
        try
        {
            MySqlCommand cmd = connection.CreateCommand();
            cmd.CommandText = "delete from rooms where id=@id";
            cmd.Parameters.AddWithValue("@id", id);
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
            LoadRoomGridView();
        }
    }
}