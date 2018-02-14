using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmployeeView : System.Web.UI.Page
{
    string connString = ConfigurationManager.ConnectionStrings["connString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null && (Session["role"].ToString() == "employee"))
        {
            if (!IsPostBack)
            {
                LoadCurrentBookings();
            }          
        }
        else
        {
            Response.Redirect("~/Error");
        }
    }

    protected void addCustomer_Click(object sender, EventArgs e)
    {
        string username = userName.Text;
        string email = Email.Text;
        string password = "bearcats";
        string role = "user";

        if (username != "" && email != "")
        {
            MySqlConnection connection = new MySqlConnection(connString);
            MySqlCommand cmd;
            connection.Open();
            try
            {
                cmd = connection.CreateCommand();
                cmd.CommandText = "INSERT INTO user(username,email,password,address,phone,role) VALUES(@username,@email,@password,@address,@phone,@role)";
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@role", role);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@address", address.Text);
                cmd.Parameters.AddWithValue("@phone", phone.Text);
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
                }
                ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('Customer Added Succcessfully');", true);
            }
        }
    }

    protected void LoadCurrentBookings()
    {
        currentBookingPH.Visible = true;
        bookRoomPH.Visible = false;
        DataTable dt = null;
        MySqlConnection connection = new MySqlConnection(connString);
        connection.Open();
        try
        {
            MySqlCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select b.id,b.userId,u.username,b.roomType,b.numberOfPeople,b.fromDate,b.toDate,b.airportPickUp,b.bookedBy,b.status from bookings as b join user as u where u.id = b.userId;";
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
            bookingsGV.DataSource = dt;
            bookingsGV.DataBind();
        }
    }

    protected void searchButton_Click(object sender, EventArgs e)
    {
        string custName = searchBox.Text;
        string custId = "";
        MySqlConnection connection = new MySqlConnection(connString);
        try
        {
            connection.Open();
            MySqlCommand cmd = new MySqlCommand("select id,userName,email,address,phone from user where userName=@userName", connection);
            cmd.Parameters.AddWithValue("userName", custName);
            MySqlDataAdapter da = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                customerID.Value = dt.Rows[0]["id"].ToString();
                custId = dt.Rows[0]["id"].ToString();
                uName.Text = dt.Rows[0]["userName"].ToString();
                addressLINE.Text = dt.Rows[0]["address"].ToString();
                customerPhone.Text = dt.Rows[0]["phone"].ToString();
                customerEmail.Text = dt.Rows[0]["email"].ToString();
                customerDetailsPH.Visible = true;
                currentBookingPH.Visible = false;
            }
            else
            {
                ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('Customer Not Found');", true);
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
            LoadIndividualCustomerBookings(custId);
        }
    }

    private void LoadIndividualCustomerBookings(string userId)
    {
        DataTable dt = null;
        MySqlConnection connection = new MySqlConnection(connString);
        connection.Open();
        try
        {
            MySqlCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select b.id,b.userId,u.username,b.roomType,b.numberOfPeople,b.fromDate,b.toDate,b.airportPickUp,b.bookedBy,b.status from bookings as b join user as u where u.id = b.userId and u.id=@userId;";
            cmd.Parameters.AddWithValue("@userId", userId);
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
            customerIndividualBookingGV.DataSource = dt;
            customerIndividualBookingGV.DataBind();
        }
    }

    protected void bookRoom_Click(object sender, EventArgs e)
    {
        string customerId = customerID.Value.ToString();

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
                cmd.Parameters.AddWithValue("userId", customerId);
                cmd.Parameters.AddWithValue("roomType", type);
                cmd.Parameters.AddWithValue("numberOfPeople", number);
                cmd.Parameters.AddWithValue("fromDate", from);
                cmd.Parameters.AddWithValue("toDate", to);
                cmd.Parameters.AddWithValue("airportPickUp", airportPickUp);
                cmd.Parameters.AddWithValue("bookedBy", Session["userName"].ToString());
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
                ClientScript.RegisterStartupScript(Page.GetType(), "Success", "<script language='javascript'>alert('You booked a room successfully.')</script>");
                currentBookingPH.Visible = true;
                bookRoomPH.Visible = false;
                customerDetailsPH.Visible = false;
                Response.Redirect("~/EmployeeView");
            }
        }
        currentBookingPH.Visible = true;
        bookRoomPH.Visible = false;
        customerDetailsPH.Visible = false;
    }

    protected void bookRoomFor_Click(object sender, EventArgs e)
    {
        currentBookingPH.Visible = false;
        bookRoomPH.Visible = true;
    }
    
    protected void cancelReservation_Click(object sender, EventArgs e)
    {
        //Get the button that raised the event
        Button btn = (Button)sender;
        //Get the row that contains this button
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowIndex = gvr.RowIndex; // Get the current row
        string bookingId = bookingsGV.Rows[rowIndex].Cells[0].Text;
        string status = bookingsGV.Rows[rowIndex].Cells[9].Text;
        if (status == "confirmed")
        {
            status = "cancel";
        }
        else
        {
            status = "confirmed";
        }

        MySqlConnection connection = new MySqlConnection(connString);
        MySqlCommand cmd;
        connection.Open();
        try
        {
            cmd = connection.CreateCommand();
            cmd.CommandText = "Update bookings set status=@status where id=@id";
            cmd.Parameters.AddWithValue("id", bookingId);
            cmd.Parameters.AddWithValue("status", status);
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
            LoadCurrentBookings();
            ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert('Reservation Status Changed.');", true);
        }
    }

    protected void bookingsGV_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TableCell statusCell = e.Row.Cells[9];
            if (statusCell.Text == "confirmed")
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Button btnButton = (Button)e.Row.FindControl("cancelReservation");
                    btnButton.Text = "Cancel Reservation";
                    btnButton.CssClass = "btn btn-danger";
                }
            }
            else
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Button btnButton = (Button)e.Row.FindControl("cancelReservation");
                    btnButton.Text = "Confirm Reservation";
                    btnButton.CssClass = "btn btn-success";
                }

            }
        }
    }

    protected void Cancel_Click(object sender, EventArgs e)
    {
        currentBookingPH.Visible = false;
        bookRoomPH.Visible = false;
    }
}