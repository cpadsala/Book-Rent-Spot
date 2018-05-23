using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace EPRS
{
    public class DB
    {

        #region Register&Login
        public int RegisterUser(string username, string fname, string lname, string email, string password, string phone, string streetname, string aptno, string zip, string city, string state, string country, string user)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_RegisterUser", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@fname", fname));
            myCommand.Parameters.Add(new SqlParameter("@lname", lname));
            myCommand.Parameters.Add(new SqlParameter("@username", username));
            myCommand.Parameters.Add(new SqlParameter("@email", email));
            myCommand.Parameters.Add(new SqlParameter("@password", password));
            myCommand.Parameters.Add(new SqlParameter("@phone", phone));
            myCommand.Parameters.Add(new SqlParameter("@streetname", streetname));
            myCommand.Parameters.Add(new SqlParameter("@aptno", aptno));
            myCommand.Parameters.Add(new SqlParameter("@zip", zip));
            myCommand.Parameters.Add(new SqlParameter("@city", city));
            myCommand.Parameters.Add(new SqlParameter("@state", state));
            myCommand.Parameters.Add(new SqlParameter("@country", country));
            myCommand.Parameters.Add(new SqlParameter("@user", user));

            try
            {
                myConnection.Open();
                int register = Convert.ToInt32(myCommand.ExecuteScalar());
                return register;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public int ValidateUser(string username)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_ValidateUser", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@username", username));

            try
            {
                myConnection.Open();
                int validate = Convert.ToInt32(myCommand.ExecuteScalar());
                return validate;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public int ValidateAdmin(string username)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_ValidateAdmin", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@username", username));

            try
            {
                myConnection.Open();
                int validate = Convert.ToInt32(myCommand.ExecuteScalar());
                return validate;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public DataTable LoginUser(string username, string password, string type)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_LoginUser", myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@username", username));
            myCommand.Parameters.Add(new SqlParameter("@password", password));
            myCommand.Parameters.Add(new SqlParameter("@type", type));

            DataTable dt = new DataTable();
            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            myCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                myCommand.Dispose();
            }
        }
        #endregion

        #region Parking&Places

        public int CheckDuplicateParking(string cust_id, string streetname, string aptno, string state, string city, string zip, int noofparking)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_CheckDuplicateParking", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;
            int custid = int.Parse(cust_id);
            myCommand.Parameters.Add(new SqlParameter("@cust_id", custid));
            myCommand.Parameters.Add(new SqlParameter("@streetname", streetname));
            myCommand.Parameters.Add(new SqlParameter("@aptno", aptno));
            myCommand.Parameters.Add(new SqlParameter("@state", state));
            myCommand.Parameters.Add(new SqlParameter("@city", city));
            myCommand.Parameters.Add(new SqlParameter("@zip", zip));
            myCommand.Parameters.Add(new SqlParameter("@noofparking", noofparking));


            try
            {
                myConnection.Open();
                int register = Convert.ToInt32(myCommand.ExecuteScalar());
                return register;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static DataTable GetRentedSpotDetails(string rentid)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Get_Rent_Spots_Details", myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@rentid", rentid));

            DataTable dt = new DataTable();
            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            myCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static DataTable GetSpotDetails(string spotid)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Get_Spot_Details", myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@spotid", spotid));

            DataTable dt = new DataTable();
            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            myCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static DataTable GetSpotList(string custid)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Get_All_Spots", myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@custid", custid));

            DataTable dt = new DataTable();
            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            myCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static DataTable GetRentList(string custid)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Get_All_Rent_Spots", myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@custid", custid));

            DataTable dt = new DataTable();
            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            myCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static int UpdatePrice(string rentid, string price)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Update_Price", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@price", price));
            myCommand.Parameters.Add(new SqlParameter("@rentid", rentid));

            try
            {
                myConnection.Open();
                int pswdupdated = Convert.ToInt32(myCommand.ExecuteScalar());
                return pswdupdated;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static DataTable GetAvailableParkingSpots(string date, string custid, string city = "")
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Get_Available_Parking_Spots", myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@date", date));
            myCommand.Parameters.Add(new SqlParameter("@city", city));
            myCommand.Parameters.Add(new SqlParameter("@custid", custid));

            DataTable dt = new DataTable();
            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            myCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static DataTable GetBookedSpot(string spotId)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Get_Booked_Spot", myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@spotId", spotId));

            DataTable dt = new DataTable();
            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            myCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static int PayAndBookSpot(DateTime dateTime, string spotid, string custid)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Pay_Book_Spot", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@dateTime", dateTime));
            myCommand.Parameters.Add(new SqlParameter("@spotid", spotid));
            myCommand.Parameters.Add(new SqlParameter("@custid", custid));

            try
            {
                myConnection.Open();
                int pswdupdated = Convert.ToInt32(myCommand.ExecuteScalar());
                return pswdupdated;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static int CheckIfBooked(string rentid)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Check_If_Booked", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@rentid", rentid));

            try
            {
                myConnection.Open();
                int pswdupdated = Convert.ToInt32(myCommand.ExecuteScalar());
                return pswdupdated;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static void UpdateStatusAndPrice(string rentid, string status, string price)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Update_Status_And_Price", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@rentid", rentid));
            myCommand.Parameters.Add(new SqlParameter("@statusid", status));
            myCommand.Parameters.Add(new SqlParameter("@price", price));

            try
            {
                myConnection.Open();
                myCommand.ExecuteScalar();
            }
            catch (Exception ex)
            {

                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public int AddParkingSpot(int custid, int statusid, string parkingname, string streetname, string aptno, string state, string city, string zip, int noofparking)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Add_New_Parking", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@cust_id", custid));
            myCommand.Parameters.Add(new SqlParameter("@statusid", statusid));
            myCommand.Parameters.Add(new SqlParameter("@parkingname", parkingname));
            myCommand.Parameters.Add(new SqlParameter("@streetname", streetname));
            myCommand.Parameters.Add(new SqlParameter("@aptno", aptno));
            myCommand.Parameters.Add(new SqlParameter("@state", state));
            myCommand.Parameters.Add(new SqlParameter("@city", city));
            myCommand.Parameters.Add(new SqlParameter("@zip", zip));
            myCommand.Parameters.Add(new SqlParameter("@noofparking", noofparking));

            try
            {
                myConnection.Open();
                int register = Convert.ToInt32(myCommand.ExecuteScalar());
                return register;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public int AddRentDetails(int custid, int spotid, int statusid, DateTime datenow, string date, string starttime, string closetime, int price)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Rent_Spot", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@custid", custid));
            myCommand.Parameters.Add(new SqlParameter("@spotid", spotid));
            myCommand.Parameters.Add(new SqlParameter("@statusid", statusid));
            myCommand.Parameters.Add(new SqlParameter("@datenow", datenow));
            myCommand.Parameters.Add(new SqlParameter("@date", date));
            myCommand.Parameters.Add(new SqlParameter("@starttime", starttime));
            myCommand.Parameters.Add(new SqlParameter("@closetime", closetime));
            myCommand.Parameters.Add(new SqlParameter("@price", price));


            try
            {
                myConnection.Open();
                int register = Convert.ToInt32(myCommand.ExecuteScalar());
                return register;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }


        #endregion

        #region UserInfo
        public DataTable GetUserInfo(int custid)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Get_User_Info", myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@custid", custid));

            DataTable dt = new DataTable();
            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            myCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public int UpdateProfileInfo(int custid, string fname, string lname, string phone)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Update_Profile_Info", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@custid", custid));
            myCommand.Parameters.Add(new SqlParameter("@fname", fname));
            myCommand.Parameters.Add(new SqlParameter("@lname", lname));
            myCommand.Parameters.Add(new SqlParameter("@phone", phone));

            try
            {
                myConnection.Open();
                int updated = Convert.ToInt32(myCommand.ExecuteScalar());
                return updated;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public int ChangePassword(int custid, string oldpswd, string newpswd)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Change_User_Password", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@custid", custid));
            myCommand.Parameters.Add(new SqlParameter("@oldpswd", oldpswd));
            myCommand.Parameters.Add(new SqlParameter("@newpswd", newpswd));

            try
            {
                myConnection.Open();
                int pswdupdated = Convert.ToInt32(myCommand.ExecuteScalar());
                return pswdupdated;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }

        #endregion

        #region Admin
        public static DataTable GetCustomerReservations(string custid)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Get_Reservations_By_User", myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@custid", custid));

            DataTable dt = new DataTable();
            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            myCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                myCommand.Dispose();
            }
        }

        public static DataTable GetUser(string Username)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_Get_User", myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@Username", Username));

            DataTable dt = new DataTable();
            SqlDataAdapter myAdapter = new SqlDataAdapter(myCommand);
            myCommand.CommandType = CommandType.StoredProcedure;
            try
            {
                myAdapter.SelectCommand = myCommand;
                myAdapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw ex;
            }
            finally
            {
                myCommand.Dispose();
            }
        }



        public static int UpdateUserInfo(string custid, string fname, string lname, string streetName, string aptNo, string zip, string city, string state, string country)
        {
            SqlConnection myConnection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["constr"].ToString());
            SqlCommand myCommand = new SqlCommand("spx_UpdateUser_Info", myConnection);

            myCommand.CommandType = CommandType.StoredProcedure;

            myCommand.Parameters.Add(new SqlParameter("@custid", custid));
            myCommand.Parameters.Add(new SqlParameter("@fname", fname));
            myCommand.Parameters.Add(new SqlParameter("@lname", lname));
            myCommand.Parameters.Add(new SqlParameter("@streetName", streetName));
            myCommand.Parameters.Add(new SqlParameter("@zip", zip));
            myCommand.Parameters.Add(new SqlParameter("@aptNo", aptNo));
            myCommand.Parameters.Add(new SqlParameter("@city", city));
            myCommand.Parameters.Add(new SqlParameter("@state", state));
            myCommand.Parameters.Add(new SqlParameter("@country", country));

            try
            {
                myConnection.Open();
                int updated = Convert.ToInt32(myCommand.ExecuteScalar());
                return updated;
            }
            catch (Exception ex)
            {
                return (-1);
                throw ex;

            }
            finally
            {
                myCommand.Dispose();
            }
        }
    }
        #endregion

    #region Utils
    public static class Utils
    {
        //"0123456789".ReplaceAt(2, 2, "Hello") = "01Hello456789"
        public static string ReplaceAt(string str, int index, int length, string replace)
        {
            str = str.Remove(index, length);
            str = str.Insert(index, replace);
            return str;
        }
    }
    #endregion
}