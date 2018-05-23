using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPRS
{
    public partial class AdminReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] == null || Session["AdminId"].ToString() == "")
            {
                Response.Redirect("AdminLogin.aspx");
            }
        }
    }
}