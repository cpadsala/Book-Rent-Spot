using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPRS
{
    public partial class ViewRentList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CustomerId"] == null || Session["CustomerId"].ToString() == "")
            {
                Response.Redirect("Login.aspx");
            }
            if ((!string.IsNullOrEmpty(Session["Message"] as string)))
            {
                ShowMessage(Session["Message"].ToString());
                Session["Message"] = null;
            }
            else
            {
                lblMessage.Visible = false;
            }
            bindGrid();
            if (Page.IsPostBack == false)
            {
                if (Request.QueryString["mode"] == "edit" && Request.QueryString["rentid"] != null)
                {

                    if (divUpdate.Visible == false)
                    {
                        divUpdate.Visible = true;
                    }
                    bindGrid();
                    editstatus();
                }
                if (Request.QueryString["mode"] == "edit" && Request.QueryString["spotid"] != null)
                {
                    if (divUpdate.Visible == false)
                    {
                        divUpdate.Visible = true;
                    }
                    bindGrid();
                    rent();
                }
            }
        }


        private void bindGrid()
        {
            DataTable spotlist = DB.GetSpotList(Session["CustomerId"].ToString());
            gvSpotList.DataSource = spotlist;
            gvSpotList.DataBind();
            DataTable rentlist = DB.GetRentList(Session["CustomerId"].ToString());
            gvRentList.DataSource = rentlist;
            gvRentList.DataBind();
        }

        protected void editstatus()
        {
            lblId.Text = "Rent Id";
            lblHead.Text = "Update Spot Details";
            var rentid = Request.QueryString["rentid"].ToString();

            DataTable details = DB.GetRentedSpotDetails(rentid);
            if (details.Rows.Count > 0)
            {
                txtParkingId.Text = details.Rows[0]["Rent_Id"].ToString();
                var temp = details.Rows[0]["Date_Available"].ToString();
                DateTime date = DateTime.Parse(temp);
                txtDate.Text = date.ToShortDateString();
                txtPrice.Text = details.Rows[0]["Price"].ToString();
            }
            else
            {
                lblMessage.Text = "";
                lblMessage.Text = "Error, Invalid Parking Id. Contact Admin.";
            }
        }

        protected void rent()
        {
            lblId.Text = "Spot Id:";
            lblHead.Text = "Rent Spot";
            btnUpdate.Text = "Rent";
            var spotid = Request.QueryString["spotid"].ToString();
            divDdls.Visible = true;
            ddlCloseTime.DataBind();
            ddlStartTime.DataBind();
            txtDate.Attributes.Remove("disabled");
            txtPrice.Text = "0";
            txtParkingId.Text = spotid;
        }

        protected void ddlStartTime_DataBinding(object sender, EventArgs e)
        {
            //ddlStartTime.Items.Insert(0, new ListItem("-- Select Open Time --", "1"));
        }

        protected void ddlCloseTime_DataBinding(object sender, EventArgs e)
        {
            //ddlCloseTime.Items.Insert(0, new ListItem("-- Select Close Time --", "1"));
        }



        protected void gvRentList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditRentSpot")
            {
                Response.Redirect("ViewRentList.aspx?mode=edit&rentid=" + e.CommandArgument);
            }
        }

        protected void btn_edit_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "EditRentSpot")
            {
                Response.Redirect("ViewRentList.aspx?mode=edit&rentid=" + e.CommandArgument);
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["spotid"] != null)
            {
                int spotid = int.Parse(Request.QueryString["spotid"].ToString());
                string date = (DateTime.Parse(txtDate.Text.ToString())).ToString("MM/dd/yyyy HH:mm:ss.fff", CultureInfo.InvariantCulture);
                string starttime = ddlStartTime.SelectedValue.ToString();
                string closetime = ddlCloseTime.SelectedValue.ToString();
                int price = int.Parse(txtPrice.Text.ToString());
                int statusid = int.Parse(ddlStatus.SelectedValue.ToString());
                var db = new DB();
                int spotadded = db.AddRentDetails(int.Parse(Session["CustomerId"].ToString()), spotid, statusid, DateTime.Now, date, starttime, closetime, price);
                if (spotid > 0 && spotadded == 1)
                {
                    Session["Message"] = "Parking Rented Successfully!";
                    Response.Redirect("ViewRentList.aspx");
                }
                else if (spotid > 0 && spotadded == 0)
                {
                    Session["Message"] = "Parking Already Rented for the same day!";
                    Response.Redirect("ViewRentList.aspx");
                }
                else
                {
                    Session["Message"] = "Parking not rented, some error occured.";
                    Response.Redirect("ViewRentList.aspx");
                }
            }
            else if (Request.QueryString["rentid"] != null)
            {
                string status = ddlStatus.SelectedValue.ToString();
                if (status == "1")
                {
                    string price = txtPrice.Text;
                    string rentid = Request.QueryString["rentid"].ToString();
                    int priceupdated = DB.UpdatePrice(rentid, price);
                    if (priceupdated == 1)
                    {
                        Session["Message"] = "Price Updated Successfully!";
                        Response.Redirect("ViewRentList.aspx");
                    }
                    else
                    {
                        Session["Message"] = "Price not updated, some error occured.";
                        Response.Redirect("ViewRentList.aspx");
                    }
                }
                else
                {
                    int alreadybooked = DB.CheckIfBooked(Request.QueryString["rentid"].ToString());
                    if (alreadybooked == 1)
                    {
                        Session["Message"] = "Parking spot is already booked by a customer. <br /> Status cannot be changed.";
                        Response.Redirect("ViewRentList.aspx");
                    }
                    else if (alreadybooked == 0)
                    {
                        DB.UpdateStatusAndPrice(Request.QueryString["rentid"].ToString(), status,txtPrice.Text.ToString());
                        Session["Message"] = "Information Updated Successfully.";
                        Response.Redirect("ViewRentList.aspx");
                    }
                    else
                    {
                        Session["Message"] = "Some error occured. <br /> Please try again in sometime.";
                        Response.Redirect("ViewRentList.aspx");
                    }
                }
            }
        }

        protected void gvSpotList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditSpot")
            {
                Response.Redirect("ViewRentList.aspx?mode=edit&spotid=" + e.CommandArgument);
            }
        }


    }
}