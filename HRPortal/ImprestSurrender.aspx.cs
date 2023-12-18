using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ImprestSurrender : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 5;
            var nav = new Config().ReturnNav();

            if (!IsPostBack)
            {
                var openImprests = nav.Payments.Where(r => r.Payment_Type == "Imprest" && r.Posted == true && r.Surrendered == false && r.Account_No == Convert.ToString(Session["employeeNo"]));
                imprest.DataSource = openImprests;
                imprest.DataValueField = "No";
                imprest.DataTextField = "No";
                imprest.DataBind();

                var receipts = nav.receipts.Where(r => r.Fully_Allocated_Imprest == false && r.Posted == true && r.Fully_Allocated == false);
                txtreceiptNumber.DataSource = receipts;
                txtreceiptNumber.DataValueField = "No";
                txtreceiptNumber.DataTextField = "No";
                txtreceiptNumber.DataBind();

            }
            String surrenderNo = "";
            Boolean existingSurrender = false;
            try
            {
                surrenderNo = Request.QueryString["surrenderNo"];
                {
                    //existingSurrender = true;
                    if (!String.IsNullOrEmpty(surrenderNo))
                    {
                        var imprestSurrenders = nav.Payments.Where(
                            r =>
                                r.Payment_Type == "Surrender" && r.Document_Type == "Surrender" &&
                                r.Account_No == Convert.ToString(Session["employeeNo"]) && r.No == surrenderNo);
                        foreach (var surrender in imprestSurrenders)
                        {
                            existingSurrender = true;
                            if (!IsPostBack)
                            {
                                imprest.SelectedValue = surrender.Imprest_Issue_Doc_No;
                            }
                        }
                        if (!existingSurrender)
                        {
                            Response.Redirect("ImprestSurrender.aspx");
                        }
                    }
                }
            }
            catch (Exception)
            {
                surrenderNo = "";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            String surrenderNo = Request.QueryString["surrenderNo"];
            Response.Redirect("ImprestSurrender.aspx");
        }

        protected void sendForApproval_Click(object sender, EventArgs e)
        {

            try
            {
                String surrenderNo = Request.QueryString["surrenderNo"];
                String status = Config.ObjNav.SendImprestSurrenderApproval(Convert.ToString(Session["employeeNo"]), surrenderNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);

            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document has already been sent for approval<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void save_Click(object sender, EventArgs e)
        {
            try
            {
                String surrenderNo = Request.QueryString["surrenderNo"];
                int myLineNo = Convert.ToInt32(lineNo.Text.Trim());
                decimal ttxtactualamount = Convert.ToDecimal(txtactualamount.Text.Trim());
                decimal ttxtoverexpenditure = Convert.ToDecimal(txtoverexpenditure.Text);
                string ttxtreceiptNumber = txtreceiptNumber.SelectedValue.Trim();

                if(string.IsNullOrEmpty(ttxtreceiptNumber))
                {
                    ttxtreceiptNumber = "";
                }

                //String status = Config.ObjNav.UpdateSurrenderLine(Convert.ToString(Session["employeeNo"]), surrenderNo, myLineNo, ttxtactualamount, ttxtreceiptNumber, ttxtoverexpenditure);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //}
                //else
                //{
                //    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception r)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + r.Message +
                                          " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Surrender/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["surrenderNo"];
                            string imprest = imprestNo;
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                            if (createDirectory)
                            {
                                string filename = documentDirectory + document.FileName;
                                if (File.Exists(filename))
                                {
                                    documentsfeedback.InnerHtml =
                                                                       "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }
                                else
                                {
                                    document.SaveAs(filename);
                                    if (File.Exists(filename))
                                    {
                                        Config.navExtender.AddLinkToRecord("Imprest Surrender", imprest, filename, "");
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
                catch (Exception ex)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Imprest Surrender/";
                String imprestNo = Request.QueryString["surrenderNo"];
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
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                String surrenderNo = "";
                try
                {
                    surrenderNo = Request.QueryString["surrenderNo"];
                    if (String.IsNullOrEmpty(surrenderNo))
                    {
                        surrenderNo = "";
                    }
                }
                catch (Exception)
                {
                    surrenderNo = "";
                }
                String tImprestNo = String.IsNullOrEmpty(imprest.SelectedValue.Trim()) ? "" : imprest.SelectedValue.Trim();
                //String status = Config.ObjNav.CreateImprestSurrender(Convert.ToString(Session["employeeNo"]), tImprestNo, surrenderNo);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    surrenderNo = info[2];
                //    Response.Redirect("ImprestSurrender.aspx?step=2&&surrenderNo=" + surrenderNo);
                //}
                //else
                //{
                //    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {

            String surrenderNo = Request.QueryString["surrenderNo"];
            Response.Redirect("ImprestSurrender.aspx?step=3&&surrenderNo=" + surrenderNo);

        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String surrenderNo = Request.QueryString["surrenderNo"];
            Response.Redirect("ImprestSurrender.aspx?step=2&&surrenderNo=" + surrenderNo);
        }
    }
}