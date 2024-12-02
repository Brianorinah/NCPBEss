using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Imprest1 : System.Web.UI.Page
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String userName = Convert.ToString(Session["username"]);
                var jobs = Config.ObjNav1.fnGetPayingBankAccount(userName);
                List<ItemList> itms = new List<ItemList>();
                string[] infoz = jobs.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infoz.Count() > 0)
                {
                    foreach (var allInfo in infoz)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[0] + "-" + arr[1];
                        itms.Add(mdl);
                    }
                }

                payingbankaccount.DataSource = itms;
                payingbankaccount.DataTextField = "description";
                payingbankaccount.DataValueField = "code";
                payingbankaccount.DataBind();
                payingbankaccount.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                var jobs1 = Config.ObjNav1.fnGLAccount();
                List<ItemList> itms1 = new List<ItemList>();
                string[] infoz1 = jobs1.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infoz1.Count() > 0)
                {
                    foreach (var allInfo in infoz1)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[0] + "-" + arr[1];
                        itms1.Add(mdl);
                    }
                }

                glaccount.DataSource = itms1;
                glaccount.DataTextField = "description";
                glaccount.DataValueField = "code";
                glaccount.DataBind();
                glaccount.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                ContentPlaceHolder1_glAccs.DataSource = itms1;
                ContentPlaceHolder1_glAccs.DataTextField = "description";
                ContentPlaceHolder1_glAccs.DataValueField = "code";
                ContentPlaceHolder1_glAccs.DataBind();
                ContentPlaceHolder1_glAccs.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var jobs2 = Config.ObjNav1.fnGetDimension(1);
                List<ItemList> itms2 = new List<ItemList>();
                string[] infoz2 = jobs2.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infoz2.Count() > 0)
                {
                    foreach (var allInfo in infoz2)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[0] + "-" + arr[1];
                        itms2.Add(mdl);
                    }
                }

                functioncode.DataSource = itms2;
                functioncode.DataTextField = "description";
                functioncode.DataValueField = "code";
                functioncode.DataBind();
                functioncode.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var budgetCenterFilters = Config.ObjNav1.fnGetDimension(2);
                List<ItemList> allbudgetCenterFilters = new List<ItemList>();
                string[] infobudgetCenterFilters = budgetCenterFilters.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infobudgetCenterFilters.Count() > 0)
                {
                    foreach (var allInfo in infobudgetCenterFilters)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[0] + "-" + arr[1];
                        allbudgetCenterFilters.Add(mdl);
                    }
                }

                budgetCenterFilter.DataSource = allbudgetCenterFilters;
                budgetCenterFilter.DataTextField = "description";
                budgetCenterFilter.DataValueField = "code";
                budgetCenterFilter.DataBind();
                budgetCenterFilter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                ContentPlaceHolder1_functionCds.DataSource = itms2;
                ContentPlaceHolder1_functionCds.DataTextField = "description";
                ContentPlaceHolder1_functionCds.DataValueField = "code";
                ContentPlaceHolder1_functionCds.DataBind();
                ContentPlaceHolder1_functionCds.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                //get ImprestApplication

                String imprestNo = Request.QueryString["imprestNo"];
                String empNo = Convert.ToString(Session["employeeNo"]);
                if (!String.IsNullOrEmpty(imprestNo))
                {
                    var nav = Config.ObjNav1;

                    String results = nav.fnGetImprestApplications(empNo);
                    String[] info = results.Split(new string[] { "::::" },StringSplitOptions.RemoveEmptyEntries);
                    if (info.Count() > 0)
                    {
                        if(info != null)
                        {
                            foreach(var allinfo in info)
                            {
                                String[] arr = allinfo.Split('*');

                                payingbankaccount.SelectedValue = arr[7];
                            
                                requestdate.Text = string.IsNullOrEmpty(arr[8]) ? "" : arr[8]; 
                                traveldate.Text = string.IsNullOrEmpty(arr[9]) ? "" : arr[9];
                                purpose.Text = arr[1];
                            }
                        }
                    }

                }
                int step = 1;
                step = Convert.ToInt32(Request.QueryString["step"]);
                try
                {
                    if (step > 3 || step < 1)
                    {
                        step = 1;
                    }
                }
                catch (Exception)
                {
                    step = 1;
                }
                if (step == 3)
                {
                    String appNo = Request.QueryString["imprestNo"];                   
                    string status = Config.ObjNav2.ImprestRequestReport(appNo);
                    if (status != "danger" && !string.IsNullOrEmpty(status))
                    {
                        bool downloaded = ConvertAndDownloadToLocal(status, "Imprest");
                        if (downloaded)
                        {
                            p9form.Attributes.Add("src", ResolveUrl("~/Downloads/" + string.Format("{0}.pdf", empNo)));
                        }
                        else if (status == "danger")
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Document could not be found.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>An error occured while generating your document.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>An error ocuured while pulling your document.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }

        }

        protected void addGeneralDetails_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                string userName = Convert.ToString(Session["username"]);
                String tpayingbankaccount = payingbankaccount.SelectedValue.Trim();
                DateTime trequestdate = Convert.ToDateTime(requestdate.Text.Trim());
                DateTime ttraveldate = Convert.ToDateTime(traveldate.Text.Trim());
                //string dateFormat = "dd/MM/yyyy"; // Or "MM/dd/yyyy" depending on your requirement
                //string dateFormat1 = "dd/MM/yyyy"; // Or "MM/dd/yyyy" depending on your requirement
                //DateTime trequestdate;
                //DateTime ttraveldate;

                //try
                //{
                //    trequestdate = DateTime.ParseExact(requestdate.Text.Trim(), dateFormat, CultureInfo.InvariantCulture);
                //   ttraveldate = DateTime.ParseExact(traveldate.Text.Trim(), dateFormat, CultureInfo.InvariantCulture);
                //}
                //catch (Exception ex)
                //{
                //     trequestdate = DateTime.ParseExact(requestdate.Text.Trim(), dateFormat1, CultureInfo.InvariantCulture);
                //     ttraveldate = DateTime.ParseExact(traveldate.Text.Trim(), dateFormat1, CultureInfo.InvariantCulture);
                //}

                //string[] dateFormats = { "dd/MM/yyyy", "MM/dd/yyyy" }; // Add more formats if needed
                //DateTime trequestdate;
                //DateTime ttraveldate;

                //if (DateTime.TryParseExact(requestdate.Text.Trim(), dateFormats, CultureInfo.InvariantCulture, DateTimeStyles.None, out trequestdate) &&
                //    DateTime.TryParseExact(traveldate.Text.Trim(), dateFormats, CultureInfo.InvariantCulture, DateTimeStyles.None, out ttraveldate))
                //{
                //    // Dates parsed successfully
                //    Console.WriteLine($"Request Date: {trequestdate}");
                //    Console.WriteLine($"Travel Date: {ttraveldate}");
                //}

                //DateTime trequestdate = Convert.ToDateTime(traveldate.Text.Trim());
                //DateTime ttraveldate = Convert.ToDateTime(traveldate.Text.Trim());
                String tpurpose = purpose.Text.Trim();
                Boolean error = false;
                String message = "";
                //DateTime myTravelDate = new DateTime();
                if (String.IsNullOrEmpty(tpayingbankaccount))
                {
                    error = true;
                    message = "Please specify the paying bank account of the imprest";
                }
                if (String.IsNullOrEmpty(tpayingbankaccount))
                {
                    error = true;
                    message = "Please specify the paying bank account of the imprest";
                }
                if (String.IsNullOrEmpty(tpayingbankaccount))
                {
                    error = true;
                    message = "Please specify the paying bank account of the imprest";
                }
                //try
                //{
                //    myTravelDate = DateTime.ParseExact(ttraveldate, "d/M/yyyy", CultureInfo.InvariantCulture);

                //}
                //catch(Exception)
                //{
                //    error = true;
                //    message += message.Length > 0 ? "<br/>" : "";
                //    message += "Please provide a valid date for travel date";
                //}
                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String imprestNo = "";
                    Boolean newImprest = false;
                    try
                    {

                        imprestNo = Request.QueryString["imprestNo"];
                        if (String.IsNullOrEmpty(imprestNo))
                        {
                            imprestNo = "";
                            newImprest = true;
                        }
                    }
                    catch (Exception)
                    {

                        imprestNo = "";
                        newImprest = true;
                    }

                    String status = Config.ObjNav2.createImprest(imprestNo, employeeNo, tpayingbankaccount, trequestdate, ttraveldate, tpurpose, userName);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        log.Info($"Login attempt -> Email address: {info}.");
                        if (newImprest)
                        {
                            imprestNo = info[2];
                        }
                        String redirectLocation = "Imprest1.aspx?step=2&&imprestNo=" + imprestNo;
                        Response.Redirect(redirectLocation, false);
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                log.Error($"Login attempt -> Email address: {m.Message}.");
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }


        protected void addItem_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                string message = "";
                string imprestNo = Request.QueryString["imprestNo"];
                string tglaccount = glaccount.SelectedValue.Trim();
                string tfunctioncode = functioncode.SelectedValue.Trim();
                string tbudgetCenterFilter = budgetCenterFilter.SelectedValue.Trim();
                decimal tamount = Convert.ToDecimal(amount.Text.Trim());

                if (string.IsNullOrEmpty(tfunctioncode))
                {
                    error = true;
                    message = "Kindly enter function code";
                }
                if (string.IsNullOrEmpty(tbudgetCenterFilter))
                {
                    error = true;
                    message = "Kindly enter budget center";
                }

                if (error)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" +message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String status = Config.ObjNav2.createImprestApplicationLines(imprestNo, tglaccount, tfunctioncode, tbudgetCenterFilter, tamount);
                    String[] info = status.Split('*');

                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest1.aspx?step=3&&imprestNo=" + imprestNo);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            Response.Redirect("Imprest1.aspx?step=2&&imprestNo=" + imprestNo);
        }
        protected void previous_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["imprestNo"];
            int step = Convert.ToInt16(Request.QueryString["step"]) - 1;
            Response.Redirect("Imprest1.aspx?step="+step+"&&imprestNo=" + imprestNo);
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest/";
            String filesFolder = Server.MapPath("~/downloads/Imprest/");

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);

                        if(new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["imprestNo"];
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');

                            String documentLibrary = filesFolder + imprestNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentLibrary))
                                {
                                    Directory.CreateDirectory(documentLibrary);
                                }
                            }
                            catch (Exception)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                            if (createDirectory)
                            {
                                String filename = documentLibrary + document.FileName;
                                if (Directory.Exists(filename))
                                {
                                    documentsfeedback.InnerHtml =
                                                                       "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }
                                else
                                {
                                    document.SaveAs(filename);
                                    if (File.Exists(filename))
                                    {
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                    else
                                    {
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                }
                            }
                        }
                        else
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch(Exception ex)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest/";
                String filesFolder1 = Server.MapPath("~/downloads/Imprest/");
                String imprestNo = Request.QueryString["imprestNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder1 + imprestNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            catch(Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["imprestNo"];
                // Convert.ToString(Session["employeeNo"]),
                String status = Config.ObjNav2.sendImprestApplicationApproval(requisitionNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deleteLine_Click(object sender, EventArgs e)
        {

            try
            {
                String docNo = imprestNo.Text.Trim();
                String lineN = lneNo.Text.Trim();
                int lineNo = Convert.ToInt32(lineN);
                String status = Config.ObjNav2.deleteImprestApplicationLines(docNo, lineNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            catch (Exception ed)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ed.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void editLine_Click(object sender, EventArgs e)
        {
            //String lineN = ContentPlaceHolder1_lineNo.Text.Trim();
            //int lineNo = Convert.ToInt32(lineN);
            //Response.Redirect("Dashboard.aspx?&&lineno="+lineN);

            try
            {
                String lineN = ContentPlaceHolder1_lineNo.Text.Trim();
                int lineNo = Convert.ToInt32(lineN);
                String docNo = Request.QueryString["re"];
                String gLAcc = ContentPlaceHolder1_glAccs.SelectedValue.Trim();
                String functionCode = ContentPlaceHolder1_functionCds.SelectedValue.Trim();
                String amts = ContentPlaceHolder1_amounts.Text.Trim();
                decimal amt = Convert.ToDecimal(amts);
                String status = Config.ObjNav2.editImprestApplicationLines(docNo, lineNo, gLAcc, functionCode, amt);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                

            }
            catch (Exception ed)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ed.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        public bool ConvertAndDownloadToLocal(string base64String, string docType)
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
    }
}