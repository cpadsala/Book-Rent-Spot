using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPRS
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CustomerId"] == null || Session["CustomerId"].ToString() == "")
            {
                Response.Redirect("Login.aspx");
            }
            if (!(Session["booked"] == null))
            {
                ShowMessage(Session["booked"].ToString());
                Session["booked"] = "";
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
    }
}