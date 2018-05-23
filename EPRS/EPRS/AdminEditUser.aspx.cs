using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPRS
{
    public partial class AdminEditUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] == null || Session["AdminId"].ToString() == "")
            {
                Response.Redirect("AdminLogin.aspx");
            }
            if ((!string.IsNullOrEmpty(Session["Updated"] as string)))
            {
                ShowMessage(Session["Updated"].ToString());
                Session["Updated"] = null;
            }
            else
            {
                lblMessage.Visible = false;
            }
            
            if (Page.IsPostBack == false)
            {
                if (Request.QueryString["custid"] != null)
                {
                    if (divUpdate.Visible == false)
                    {
                        divUpdate.Visible = true;
                    }
                    bindGrid();
                    bindUser();
                }
            }
        }

        private void bindUser()
        {
            var db = new DB();
            DataTable userInfo = db.GetUserInfo(int.Parse(Session["userid"].ToString()));
            txtFName.Text = userInfo.Rows[0]["First_Name"].ToString();
            txtLName.Text = userInfo.Rows[0]["Last_Name"].ToString();
            txtStreetName.Text = userInfo.Rows[0]["Street_Name"].ToString();
            txtApt.Text = userInfo.Rows[0]["Apt_No"].ToString();
            txtZip.Text = userInfo.Rows[0]["ZipCode"].ToString();
            txtCity.Text = userInfo.Rows[0]["City"].ToString();
            txtState.Text = userInfo.Rows[0]["State"].ToString();
            txtCountry.Text = userInfo.Rows[0]["Country"].ToString(); 

        }

        private void bindGrid()
        {
            DataTable user = DB.GetUser(Session["usernametosearch"].ToString());
            gvUser.DataSource = user;
            gvUser.DataBind();
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
            string fname = txtFName.Text.ToString();
            string lname = txtLName.Text.ToString();
            string streetName = txtStreetName.Text.ToString();
            string aptNo = txtApt.Text.ToString();
            string zip = txtZip.Text.ToString();
            string city = txtCity.Text.ToString();
            string state = txtState.Text.ToString();
            string country = txtCountry.Text.ToString();
            string custid = Request.QueryString["custid"].ToString();
            int updated = DB.UpdateUserInfo(custid,fname, lname, streetName, aptNo, zip, city, state, country);
            if (updated == 1)
            {
                Session["Updated"] = "Information Updated Successfully.";
                Response.Redirect("AdminEditUser.aspx");
            }
            else
            {
                Session["Updated"] = "Some error occured. <br /> Please try again in sometime.";
                Response.Redirect("AdminEditUser.aspx");
            }
        }

        protected void btn_edit_Command(object sender, CommandEventArgs e)
        {
        }

        protected void btnSearchUser_Click(object sender, EventArgs e)
        {
            string username = txtUsernametoSearch.Text.ToString();
            Session["usernametosearch"] = username.ToString();
            DataTable user = DB.GetUser(username);
            gvUser.DataSource = user;
            gvUser.DataBind();
        }

        protected void gvUser_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditUser")
            {
                Session["userid"] = e.CommandArgument.ToString();
                Response.Redirect("AdminEditUser.aspx?custid=" + e.CommandArgument);
            }
        }
    }
}