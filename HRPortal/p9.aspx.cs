using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class p9 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 4;
        }

        protected void generate_Click(object sender, EventArgs e)
        {
            feedback.InnerHtml = "";
            
            DateTime mStartDate = new DateTime();
            DateTime mEndDate = new DateTime();
            Boolean Error = false;
            try
            {
               // CultureInfo culture = new CultureInfo("ru-RU");
              //  mStartDate = DateTime.ParseExact(tStartDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
              //  mEndDate = DateTime.ParseExact(startDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                //  ToString("MM/dd/yyyy")
            }
            catch (Exception)
            {
                Error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid start date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            try
            {
                //CultureInfo culture = new CultureInfo("ru-RU");
                // mEndDate = DateTime.ParseExact(tEndDate, "MM/dd/yyyy", CultureInfo.InvariantCulture);
                 //mEndDate = DateTime.ParseExact(endDate.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture);
            }
            catch (Exception)
            {
                Error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid end date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            if (!Error)
            {
                try
                {                    
                    int tyear = Convert.ToInt32(year.Text.Trim());
                    string empNo = (String)Session["employeeNo"];

                    string status = Config.ObjNav2.generateP9(empNo, tyear);
                    if (status != "danger" && !string.IsNullOrEmpty(status))
                    {
                        bool downloaded = ConvertAndDownloadToLocal(status, "P9");
                        if (downloaded)
                        {
                            p9form.Attributes.Add("src", ResolveUrl("~/Downloads/" + string.Format("{0}.pdf", empNo)));
                        }
                        else
                        {
                            feedback.InnerHtml = "<div class='alert alert-danger'>An error occured while generating your payslip.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>An error ocuured while pulling your document.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }


        }
        public bool ConvertAndDownloadToLocal(string base64String, string docType)
        {
            Boolean uploaded = false;
            try
            {
                //string docNo = HttpContext.Request.Query["docNo"].ToString();
                string employeeNumber = (String)Session["employeeNo"];

                string filesFolder = Server.MapPath("~/Downloads/");
                string fileName = employeeNumber + ".pdf";
                string documentDirectory = filesFolder + "/";
                string filePath = documentDirectory + fileName;

                if (System.IO.File.Exists(filePath))
                {

                    System.IO.File.Delete(filePath);
                }

                byte[] fileBytes = Convert.FromBase64String(base64String);


                using (StreamWriter writer = new StreamWriter(filePath, false))
                {
                    writer.BaseStream.Write(fileBytes, 0, fileBytes.Length);
                }

                return true;


            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., invalid base64 string)
                //TempData["error"] = ex.Message;
                return false;
            }
        }
    }
}