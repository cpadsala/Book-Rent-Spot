using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPRS
{
    public partial class Confirm_Pay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["CustomerId"] == null || Session["CustomerId"].ToString() == "") && (Session["ReserveSpotID"] == null || Session["ReserveSpotID"].ToString() == ""))
            {
                Response.Redirect("Login.aspx");
            }
            bindData();
        }

        private void bindData()
        {
            DataTable dt = DB.GetBookedSpot(Session["ReserveSpotID"].ToString());
            lblApt.Text = dt.Rows[0]["Apt_No"].ToString();
            lblBookingDate.Text = Session["SelectedDay"].ToString();
            lblCityState.Text = dt.Rows[0]["City"].ToString() + ", " + dt.Rows[0]["State"].ToString();
            lblEmail.Text = dt.Rows[0]["OwnerEmail"].ToString();
            lblOpenCloseTime.Text = dt.Rows[0]["OpenTime"].ToString() + "- " + dt.Rows[0]["CloseTime"].ToString();
            lblOwnerName.Text = dt.Rows[0]["OwnerFirstName"].ToString() + " " + dt.Rows[0]["OwnerLastName"].ToString();
            lblPhone.Text = dt.Rows[0]["OwnerPhone"].ToString();
            lblStreet.Text = dt.Rows[0]["Street_Name"].ToString();
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            int booked = DB.PayAndBookSpot(DateTime.Now, Session["ReserveSpotID"].ToString(), Session["CustomerId"].ToString());
            if (booked == 1)
            {
                var db = new DB();
                DataTable ownerDetails = DB.GetBookedSpot(Session["ReserveSpotID"].ToString());
                int custid = int.Parse(Session["CustomerId"].ToString());
                DataTable customerDetails = db.GetUserInfo(custid);
                string customerEmailId = customerDetails.Rows[0]["Email"].ToString();
                string customerPhone = customerDetails.Rows[0]["Phone"].ToString();
                string ownerEmailId = ownerDetails.Rows[0]["OwnerEmail"].ToString();
                string ownerPhone = ownerDetails.Rows[0]["OwnerPhone"].ToString();
                Send_Confirmation_Mail_Customer(customerEmailId, ownerEmailId, ownerPhone);
                Send_Confirmation_Mail_Owner(ownerEmailId, customerEmailId, customerPhone);
                Send_Receipt_Mail_Customer(ownerDetails, customerDetails);
                Session["booked"] = "Parking Spot Booked Successfully";
                Response.Redirect("Dashboard.aspx");
            }
            else if (booked == 0)
            {
                Session["alreadybooked"] = "Sorry you are a bit late. <br />Parking spot was booked by someone else.<br />You can book another spot.";
                Response.Redirect("BookSpot.aspx");
            }
            else
            {
                Session["bookingerror"] = "Some error occured. <br />You can try again in sometime.";
                Response.Redirect("BookSpot.aspx");
            }
        }

        public void Send_Receipt_Mail_Customer(DataTable ownerDetails, DataTable customerDetails)
        {
            try
            {
                string customerEmailId = customerDetails.Rows[0]["Email"].ToString();
                SmtpClient SmtpServer = new SmtpClient();
                MailMessage mail = new MailMessage();
                SmtpServer.Credentials = new System.Net.NetworkCredential("cmpnace@gmail.com", "chiragrohit");
                SmtpServer.Port = 587;
                SmtpServer.EnableSsl = true;
                SmtpServer.Host = "smtp.gmail.com";
                mail = new MailMessage();
                mail.From = new MailAddress("EPRS@gmail.com");
                mail.IsBodyHtml = true;
                mail.To.Add(customerEmailId);
                mail.Subject = "Print this receipt and put on your dashboard";
                mail.Body = "Customer has paid for the reservation of this parking space. Please find reserved timings below:<br /><br /><br /> Reservation Date: " + Session["SelectedDay"].ToString() + "<br /><br /> Reservation Time: " + ownerDetails.Rows[0]["OpenTime"].ToString() + "- " + ownerDetails.Rows[0]["CloseTime"].ToString() + "<br /><br /> -Reserved via Electronic Parking Rental System.";
                SmtpServer.Send(mail);

            }
            catch (Exception ex)
            {
                lblError.Text = "mail Sending fail";
            }
        }

        public void Send_Confirmation_Mail_Owner(string ownerEmail, string customerEmail, string customerPhone)
        {
            try
            {
                SmtpClient SmtpServer = new SmtpClient();
                MailMessage mail = new MailMessage();
                SmtpServer.Credentials = new System.Net.NetworkCredential("cmpnace@gmail.com", "chiragrohit");
                SmtpServer.Port = 587;
                SmtpServer.EnableSsl = true;
                SmtpServer.Host = "smtp.gmail.com";
                mail = new MailMessage();
                mail.From = new MailAddress("Bookyourspot@gmail.com");
                mail.IsBodyHtml = true;
                mail.To.Add(ownerEmail);
                mail.Subject = "Parking Spot Rented by Customer";
                mail.Body = "This is to inform you that your parking spot was reserved by customer successful. <br />Just for your reference, Customer Details are listed below, in case if you need to contact. <br /> Email Id - " +  customerEmail.ToString() + "<br />Phone - " + customerPhone.ToString() + ".";
                SmtpServer.Send(mail);

            }
            catch (Exception ex)
            {
                lblError.Text = "mail Sending fail";
            }
        }

        public void Send_Confirmation_Mail_Customer(string customerEmailId, string ownerEmail, string ownerPhone)
        {
            try
            {
                SmtpClient SmtpServer = new SmtpClient();
                MailMessage mail = new MailMessage();
                SmtpServer.Credentials = new System.Net.NetworkCredential("cmpnace@gmail.com", "chiragrohit");
                SmtpServer.Port = 587;
                SmtpServer.EnableSsl = true;
                SmtpServer.Host = "smtp.gmail.com";
                mail = new MailMessage();
                mail.From = new MailAddress("Bookyourspot@gmail.com");
                mail.IsBodyHtml = true;
                mail.To.Add(customerEmailId);
                mail.Subject = "Reservation Confirmation";
                mail.Body = "This is to inform you that your reservation is successful. <br />Just for your reference, Parking Spot Owner Details are listed below, in case if you need to contact. <br /> Email Id - " + ownerEmail.ToString() + "<br />Phone - " + ownerPhone.ToString() + ".";
                SmtpServer.Send(mail);

            }
            catch (Exception ex)
            {
                lblError.Text = "mail Sending fail";
            }
        }


    }
}