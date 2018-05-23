﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPRS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;
            var db = new DB();
            var validate = db.ValidateUser(username);
            if (validate == -1)
            {
                string head = "You are not registered.";
                string body = "Please Register to continue.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }
            var LoginDatatable = db.LoginUser(username, password,"User");
            
            if (LoginDatatable.Rows.Count == 1)
            {
                Session["CustomerId"] = LoginDatatable.Rows[0]["Customer_Id"].ToString();
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                string head = "Password Incorrect.";
                string body = "Please check your username and password.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }
            
        }



    }
}