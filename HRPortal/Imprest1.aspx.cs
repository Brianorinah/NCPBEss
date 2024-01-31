using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Imprest1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var jobs = Config.ObjNav1.fnGetDimension(2);
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

                payingbudgetcenter.DataSource = itms;
                payingbudgetcenter.DataTextField = "description";
                payingbudgetcenter.DataValueField = "code";
                payingbudgetcenter.DataBind();
                payingbudgetcenter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


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

                                payingbudgetcenter.SelectedValue = arr[7];
                                requestdate.Text = arr[8];
                                traveldate.Text = arr[9];
                                purpose.Text = arr[1];
                            }
                        }
                    }

                }

            }

        }

        protected void addGeneralDetails_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String tpayingbudgetcenter = payingbudgetcenter.SelectedValue.Trim();
                DateTime trequestdate = Convert.ToDateTime(requestdate.Text.Trim());
                DateTime ttraveldate = Convert.ToDateTime(traveldate.Text.Trim());
                String tpurpose = purpose.Text.Trim();
                Boolean error = false;
                String message = "";
                //DateTime myTravelDate = new DateTime();
                if (String.IsNullOrEmpty(tpayingbudgetcenter))
                {
                    error = true;
                    message = "Please specify the purpose of the imprest";
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

                    String status = Config.ObjNav2.createImprest(imprestNo, employeeNo, tpayingbudgetcenter, trequestdate, ttraveldate, tpurpose);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
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
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }


        protected void addItem_Click(object sender, EventArgs e)
        {
            try
            {
                string imprestNo = Request.QueryString["imprestNo"];
                string tglaccount = glaccount.SelectedValue.Trim();
                string tfunctioncode = functioncode.SelectedValue.Trim();
                decimal tamount = Convert.ToInt16(amount.Text.Trim());

                String status = Config.ObjNav2.createImprestApplicationLines(imprestNo, tglaccount, tfunctioncode, tamount);
                String[] info = status.Split('*');

                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
            Response.Redirect("Imprest1.aspx?step=1&&imprestNo=" + imprestNo);
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest/";

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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest/";
                String imprestNo = Request.QueryString["imprestNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder + imprestNo + "/";
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

            try
            {
                String lineN = ContentPlaceHolder1_lineNo.Text.Trim();
                int lineNo = Convert.ToInt32(lineN);
                String docNo = ContentPlaceHolder1_documentNumber.Text.Trim();
                String gLAcc = ContentPlaceHolder1_glAccountss.Text.Trim();
                String functionCode = ContentPlaceHolder1_functionCodes.Text.Trim();
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
    }
}