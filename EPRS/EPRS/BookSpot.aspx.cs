using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPRS
{
    public partial class BookSpot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CustomerId"] == null || Session["CustomerId"].ToString() == "")
            {
                Response.Redirect("Login.aspx");
            }
            if (!(Session["alreadybooked"] == null))
            {
                ShowMessage(Session["alreadybooked"].ToString());
                Session["alreadybooked"] = "";
            }
            if (!(Session["bookingerror"] == null))
            {
                ShowMessage(Session["bookingerror"].ToString());
                Session["bookingerror"] = "";
            }
        }

        protected void ShowMessage(string Message)
        {
            if (!string.IsNullOrEmpty(Message))
            {
                lblMessage.Text = Message;
                lblMessage.Visible = true;
                return;
            }
            lblMessage.Text = string.Empty;
            lblMessage.Visible = false;
        }

        protected void clBook_SelectionChanged(object sender, EventArgs e)
        {
            string SelectedDay = DateTime.Parse(clBook.SelectedDate.Date.ToString()).ToString("MM-dd-yyyy");
            Session["SelectedDay"] = SelectedDay;
            bindGrid();
            lblHead.Text = "See all the available parking spots for Selected Day: " + SelectedDay;
            divCity.Visible = true;
        }

        private void bindGrid()
        {
            if (!(Session["City"] == null))
            {
                DataTable dt = DB.GetAvailableParkingSpots(Session["SelectedDay"].ToString(), Session["CustomerId"].ToString(), Session["City"].ToString());
                gvAvailableSpot.DataSource = dt;
                gvAvailableSpot.EmptyDataText = "There are no available parking in the searched city.";
                gvAvailableSpot.DataBind();

            }
            else
            {
                DataTable dt = DB.GetAvailableParkingSpots(Session["SelectedDay"].ToString(), Session["CustomerId"].ToString());
                gvAvailableSpot.DataSource = dt;
                gvAvailableSpot.EmptyDataText = "There are no available parking for the selected date.";
                gvAvailableSpot.DataBind();
            }

        }

        protected void gvAvailableSpot_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = int.Parse(e.CommandArgument.ToString());
            if (e.CommandName == "BookSpot")
            {
                String spotId = gvAvailableSpot.DataKeys[index].Value.ToString();
                Session["ReserveSpotID"] = spotId.ToString();
                Response.Redirect("ConfirmAndPay.aspx");
            }
        }

        protected void clBook_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.Date < DateTime.Now.Date)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = System.Drawing.Color.Gray;
            }
        }

        protected void btnSearchCity_Click(object sender, EventArgs e)
        {
            Session["City"] = txtSearchCity.Text.ToString();
            string date = Session["SelectedDay"].ToString();
            DataTable dt = DB.GetAvailableParkingSpots(Session["SelectedDay"].ToString(), Session["CustomerId"].ToString(), Session["City"].ToString());
            gvAvailableSpot.DataSource = dt;
            gvAvailableSpot.EmptyDataText = "There are no available parking in the searched city.";
            gvAvailableSpot.DataBind();
        }

        protected void btnNearMe_Click(object sender, EventArgs e)
        {
            var city = hdnCity.Value.ToString();
            if (city == "")
            {
                DataTable dt = DB.GetAvailableParkingSpots(Session["SelectedDay"].ToString(), Session["CustomerId"].ToString());
                gvAvailableSpot.DataSource = dt;
                gvAvailableSpot.EmptyDataText = "There are no available parking in the searched city.";
                gvAvailableSpot.DataBind();
            }
            else
            {
                DataTable dt = DB.GetAvailableParkingSpots(Session["SelectedDay"].ToString(), Session["CustomerId"].ToString(), city);
                gvAvailableSpot.DataSource = dt;
                gvAvailableSpot.EmptyDataText = "There are no available parking for the selected date.";
                gvAvailableSpot.DataBind();
            }
        }

    }
}