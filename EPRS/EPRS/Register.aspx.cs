using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPRS
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string fname = txtFirstName.Text;
            string lname = txtLastName.Text;
            string username = txtUsername.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string phone = txtPhone.Text;
            string streetname = txtStreetName.Text;
            string aptno = txtAptNo.Text;
            string zip = txtZipCode.Text;
            string city = txtCity.Text;
            string state = txtState.Text;
            string country = txtCountry.Text;
            string user = "User";
            var db = new DB();
            int register = db.RegisterUser(username,fname,lname,email,password,phone,streetname,aptno,zip,city,state,country, user);
            if (register == 1){
                string head = "Register Succesful.";
                string body = " You are all set. Please Login to continue.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }
            else if (register == 0)
            {
                string head = "You are already registered.";
                string body = "Please Login to continue.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }
            else {
                string head = "Error occured.";
                string body = "Please try again in sometime.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }

        }

    }
}