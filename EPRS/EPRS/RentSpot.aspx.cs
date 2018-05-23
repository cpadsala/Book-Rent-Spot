using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPRS
{
    public partial class RentSpot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CustomerId"] == null || Session["CustomerId"].ToString() == "")
            {
                Response.Redirect("Login.aspx");
            }
            ddlStatus.SelectedValue = "1";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string parkingname = txtParkingName.Text;
            string streetname = txtStreet.Text;
            string aptno = txtAptNo.Text;
            string state = txtState.Text;
            string city = txtCity.Text;
            string zip = txtZip.Text;
            int noofparking = 1;
            int statusid = int.Parse(ddlStatus.SelectedValue.ToString());
            
            string starttime = ddlStartTime.SelectedValue.ToString();
            string closetime = ddlCloseTime.SelectedValue.ToString();
            
            int check = checkDuplicateParking(Session["CustomerId"].ToString(), streetname, aptno, state, city, zip, noofparking, statusid, parkingname);
            if (statusid != 1 && check == 1)
            {
                var db = new DB();
                int result = AddParking(Session["CustomerId"].ToString(), statusid, parkingname, streetname, aptno, state, city, zip, noofparking);
                if (result > 1)
                {
                    string head = "Parking Added Succesfully!";
                    string body = "Parking added. FYI- Your Id is: " + result + ".";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
                }
                else {
                    string head = "Error!!!";
                    string body = "Parking not added, some error occured.";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
                }
            }
            else if (check != -1 && statusid == 1)
            {
                string date = (DateTime.Parse(txtDateAvailable.Text.ToString())).ToString("MM/dd/yyyy HH:mm:ss.fff", CultureInfo.InvariantCulture);
                int price = int.Parse(txtPrice.Text.ToString());
                var db = new DB();
                int spotid = AddParking(Session["CustomerId"].ToString(), statusid, parkingname, streetname, aptno, state, city, zip, noofparking);
                int spotadded = -1;
                if (spotid > 0)
                {
                    spotadded = db.AddRentDetails(int.Parse(Session["CustomerId"].ToString()), spotid, statusid, DateTime.Now, date, starttime, closetime, price);
                }
                else {
                    string head = "Error!!!";
                    string body = "Parking not added, some error occured.";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
                }
                if (spotid > 0 && spotadded == 1)
                {
                    string head = "Parking Added & Rent Details Updated!";
                    string body = "Parking added. FYI- Your Id is: " + spotid + ".";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
                }
            }
        }

        public int checkDuplicateParking(string p, string streetname, string aptno, string state, string city, string zip, int noofparking, int statusid, string parkingname)
        {
            var db = new DB();
            int checkDuplicateParking = db.CheckDuplicateParking(Session["CustomerId"].ToString(), streetname, aptno, state, city, zip, noofparking);
            if (checkDuplicateParking == -1)
            {
                string head = "Duplicate Parking!!!";
                string body = "Parking already exist please check View Added Spot page.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);

            }
            else if (checkDuplicateParking > 1)
            {

                string head = "Sorry, We are experiencing problem.";
                string body = "Please try again in sometime.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }
            return checkDuplicateParking;
        }

        public int AddParking(string p, int statusid, string parkingname, string streetname, string aptno, string state, string city, string zip, int noofparking)
        {
            int custid = int.Parse(p);
            var db = new DB();
            int result = db.AddParkingSpot(custid, statusid, parkingname, streetname, aptno, state, city, zip, noofparking);
            if (result == -1)
            {
                string head = "Error!!!";
                string body = "Parking not added, some error occured.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal('" + head + "','" + body + "');", true);
            }
            return result;
        }

        protected void ddlStartTime_DataBound(object sender, EventArgs e)
        {
            ddlStartTime.Items.Insert(0, new ListItem("-- Select Open Time --", "1"));
        }

        protected void ddlCloseTime_DataBound(object sender, EventArgs e)
        {
            ddlCloseTime.Items.Insert(0, new ListItem("-- Select Close Time --", "1"));
        }

    }
}