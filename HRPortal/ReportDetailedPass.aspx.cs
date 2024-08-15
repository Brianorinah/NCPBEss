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
    public partial class ReportDetailedPass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string empNo = (String)Session["employeeNo"];
                    string requisitionNo = Request.QueryString["docNo"];

                }
                catch (Exception ex)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message +
                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
        }
        public bool ConvertAndDownloadToLocal(string base64String)
        {
            Boolean uploaded = false;
            try
            {

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

        protected void generate_Click(object sender, EventArgs e)
        {
            try
            {
                string empNo = (String)Session["employeeNo"];
                string requisitionNo = Request.QueryString["docNo"];


                string status = Config.ObjNav2.LeaveRequestReport(requisitionNo);
                if (status != "danger" && !string.IsNullOrEmpty(status))
                {
                    bool downloaded = ConvertAndDownloadToLocal(status);
                    if (downloaded)
                    {
                        reportViewFrame.Attributes.Add("src", ResolveUrl("~/Downloads/" + string.Format("{0}.pdf", empNo)));
                    }
                    else if (status == "danger")
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>Document could not be found.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>An error occured while generating your document.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>An error ocuured while pulling your document.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message +
                                            "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}