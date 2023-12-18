using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

namespace HRPortal
{
    public partial class SalaryAdvance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 14;
        }

        protected void RequestSalaryAdvance_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            string message = "";
            string tsalaryadvance = salaryadvance.Text;
            string tpurpose = purpose.Text;
            string tnumberofmonths = numberofmonths.Text;
            string trecoverymonth = recoverymonth.Text;
            //string tSalaryAdvanceDate = travelDate.Text.Trim();
            decimal nMonths = 0;
            decimal nSalaryAdvance = 0;
            //DateTime mySalaryAdvanceDate = new DateTime();
            //try
            //{
            //    mySalaryAdvanceDate = DateTime.ParseExact(tSalaryAdvanceDate, "d/M/yyyy", CultureInfo.InvariantCulture);
            //}
            //catch (Exception)
            //{
            //    error = true;
            //    message += message.Length > 0 ? "<br/>" : "";
            //    message += "Please provide a valid date for travel date";
            //}
            try
            {
                nSalaryAdvance = Convert.ToDecimal(tsalaryadvance);
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br/>" : "";
                message += "Please enter salary advance amount";
            }
            if (string.IsNullOrEmpty(tpurpose))
            {
                error = true;
                message = "Please enter salary advance purpose ";

            }
            try
            {
                nMonths = Convert.ToDecimal(tnumberofmonths);
            }
            catch (Exception)
            {
                error = true;
                message += message.Length > 0 ? "<br/>" : "";
                message += "Please provide a valid number of months to be deducted";
            }
            if (string.IsNullOrEmpty(trecoverymonth))
            {
                error = true;
                message = "Please enter recovery month ";

            }
            if (error == true)
            {
                salaryFeedback.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
                try
                {
                    String salaryAdvanceNo = "";
                    Boolean newsalaryAdvanceNo = false;
                    try
                    {

                        salaryAdvanceNo = Request.QueryString["salaryAdvanceNo"];
                        if (String.IsNullOrEmpty(salaryAdvanceNo))
                        {
                            salaryAdvanceNo = "";
                            newsalaryAdvanceNo = true;
                        }
                    }
                    catch (Exception)
                    {

                        salaryAdvanceNo = "";
                        newsalaryAdvanceNo = true;
                    }
                    string empNo = Session["employeeNo"].ToString();

                    //var status = Config.ObjNav.AddNewSalaryAdvance(salaryAdvanceNo, empNo, nSalaryAdvance, tpurpose, nMonths, trecoverymonth);

                    //string[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    if (newsalaryAdvanceNo)
                    //    {
                    //        salaryAdvanceNo = info[2];

                    //    }
                    //    salaryFeedback.InnerHtml = "<div class='alert alert-success'> '" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    //    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);

                    //}
                    //else
                    //{
                    //    salaryFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}

                }
                catch (Exception ex)
                {

                    salaryFeedback.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }



            }

        }
    }
}