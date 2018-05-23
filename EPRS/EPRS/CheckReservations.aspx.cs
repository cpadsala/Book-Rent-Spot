using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPRS
{
    public partial class CheckReservations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CustomerId"] == null || Session["CustomerId"].ToString() == "")
            {
                Response.Redirect("Login.aspx");
            }
            bindReservations();
        }

        private void bindReservations()
        {
            DataTable reservation = DB.GetCustomerReservations(Session["CustomerId"].ToString());
            gvReservations.DataSource = reservation;
            gvReservations.DataBind();
        }

        
    }
}