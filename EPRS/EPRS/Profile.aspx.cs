using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace EPRS
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CustomerId"] == null || Session["CustomerId"].ToString() == "")
            {
                Response.Redirect("Login.aspx");
            }
            if (!(Page.IsPostBack))
            {
                UpdateProfileInfo();
            }
        }

        public void UpdateProfileInfo()
        {
            var db = new DB();
            DataTable dt = db.GetUserInfo(int.Parse(Session["CustomerId"].ToString()));
            if (dt.Rows.Count > 0)
            {
                lblusername.Text = dt.Rows[0]["First_Name"].ToString() + " " + dt.Rows[0]["Last_Name"].ToString();
                txtID.Text = dt.Rows[0]["Customer_Id"].ToString();
                txtUsername.Text = dt.Rows[0]["Username"].ToString();
                txtEmail.Text = dt.Rows[0]["Email"].ToString();
                txtFirstname.Text = dt.Rows[0]["First_Name"].ToString();
                txtLastName.Text = dt.Rows[0]["Last_Name"].ToString();
                txtPhone.Text = dt.Rows[0]["Phone"].ToString();
                txtStreetNApt.Text = dt.Rows[0]["Street_Name"].ToString() + ", Apt: " + dt.Rows[0]["Apt_No"].ToString();
                txtCountryNZip.Text = dt.Rows[0]["Country"].ToString() + " - " + dt.Rows[0]["ZipCode"].ToString();
                txtCity.Text = dt.Rows[0]["City"].ToString();
                txtState.Text = dt.Rows[0]["State"].ToString();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string fname = txtFirstname.Text.ToString();
            string lname = txtLastName.Text.ToString();
            string phone = txtPhone.Text.ToString();
            var db = new DB();
            int updated = db.UpdateProfileInfo(int.Parse(Session["CustomerId"].ToString()), fname, lname, phone);
            if (updated == 1)
            {
                string head = "Profile Information Updated Succesfully!";
                string body = "You can continue Booking or Renting a spot.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }
            else
            {
                string head = "Problem Updating Information!";
                string body = "Please try again or Contact Admin.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }
            UpdateProfileInfo();
        }

        protected void btnChangePswd_Click(object sender, EventArgs e)
        {
            string oldpswd = txtOldPswd.Text.ToString();
            string newpswd = txtNewPswd.Text.ToString();
            var db = new DB();
            int pswdupdated = db.ChangePassword(int.Parse(Session["CustomerId"].ToString()), oldpswd, newpswd);
            if (pswdupdated == 1)
            {
                string head = "Password Updated Succesfully!";
                string body = "You can continue Booking or Renting a spot.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }
            else
            {
                string head = "Problem Updating Password!";
                string body = "Please try again with correct password or Contact Admin.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }
            UpdateProfileInfo();
        }
    }
}