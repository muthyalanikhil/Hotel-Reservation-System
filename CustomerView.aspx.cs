using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomerView : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["connString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null && (Session["role"].ToString() == "user"))
        {
            updateAllBookings();
        }
        else
        {
            Response.Redirect("~/Error");
        }
    }

    protected void bookRoom_Click(object sender, EventArgs e)
    {
        string type = roomTypeDD.SelectedValue.ToString();
        string number = totalNumber.Text;
        string from = fromDate.Text;
        string to = toDate.Text;
        string airportPickUp = airportPickup.Checked.ToString();

        if (type != "" && number != "" && from != "")
        {
            MySqlConnection connection = new MySqlConnection(connString);
            MySqlCommand cmd;
            connection.Open();
            try
            {
                cmd = connection.CreateCommand();
                cmd.CommandText = "INSERT INTO bookings(userId,roomType,numberOfPeople,fromDate,toDate,airportPickUp,bookedBy) VALUES(@userId,@roomType,@numberOfPeople,@fromDate,@toDate,@airportPickUp,@bookedBy)";
                cmd.Parameters.AddWithValue("userId", Session["userID"].ToString());
                cmd.Parameters.AddWithValue("roomType", type);
                cmd.Parameters.AddWithValue("numberOfPeople", number);
                cmd.Parameters.AddWithValue("fromDate", from);
                cmd.Parameters.AddWithValue("toDate", to);
                cmd.Parameters.AddWithValue("airportPickUp", airportPickUp);
                cmd.Parameters.AddWithValue("bookedBy", "Self");
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
                roomTypeDD.Text = "";
                fromDate.Text = "";
                toDate.Text = "";
                totalNumber.Text = "";
                airportPickup.Checked = false;
                ClientScript.RegisterStartupScript(Page.GetType(), "Success", "<script language='javascript'>alert('Yout booked a room successfully.')</script>");
                updateAllBookings();
            }
        }
    }

    protected void updateAllBookings()
    {
        Literal resultHTML = new Literal();
        string htmlSample = "";
        DataTable dt = null;
        MySqlConnection connection = new MySqlConnection(connString);
        connection.Open();
        try
        {
            MySqlCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select userId,roomType,numberOfPeople,fromDate,toDate,airportPickUp,bookedBy,status from bookings where userId=@userId";
            cmd.Parameters.AddWithValue("userId", Session["userID"].ToString());
            MySqlDataAdapter adap = new MySqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            adap.Fill(ds);
            dt = ds.Tables[0];
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
        if (dt.Rows.Count > 0)
        {
            previousBookingsLBL.Text = "Your Previous Bookings";
            int count = 1;
            foreach (DataRow row in dt.Rows)
            {

                string resultInnerHTML = "<hr /><div class='container'>" +
                     "<div class='container' style='width: 100%;'>" +
                     "<div class='panel panel-default'>" +
                     "<div class='panel-heading' style='align-content: center; font-weight: bold'>Booking " + count + "</div>" +
                     "<div class='panel-body'>" +
                     "<h5 style='line-height:20px;'><b>Room Type: </b>" + row["roomType"].ToString() + "<br /><b>Number of People: </b>" +
                     row["numberOfPeople"].ToString() + "<br /><b>From:</b>" + row["fromDate"].ToString() + "<br /><b>To:</b>" + 
                     row["toDate"].ToString() + "<br /><b>Airport Pickup:</b>" + row["airportPickUp"].ToString() + 
                     "<br /><b>Status:</b>" + row["status"].ToString() + "</h5>" +
                     "</div></div></div></div>";
                htmlSample = htmlSample + resultInnerHTML;
                count++;
            }
        }
        resultHTML.Text = htmlSample;
        allBookinigsPH.Controls.Add(resultHTML);
    }
}