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
    public partial class SafariRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var jobs1 = Config.ObjNav1.fnGetDimension(1);
                List<ItemList> itms1 = new List<ItemList>();
                string[] infoz1 = jobs1.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infoz1.Count() > 0)
                {
                    foreach (var allInfo in infoz1)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[1];
                        itms1.Add(mdl);

                    }
                }

                functionCode.DataSource = itms1;
                functionCode.DataTextField = "description";
                functionCode.DataValueField = "code";
                functionCode.DataBind();
                functionCode.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var jobs17 = Config.ObjNav1.fnGetDimension(2);
                List<ItemList> itms17 = new List<ItemList>();
                string[] infoz17 = jobs17.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infoz17.Count() > 0)
                {
                    foreach (var allInfo in infoz17)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[1];
                        itms17.Add(mdl);

                    }
                }

                bgtCenterCode.DataSource = itms17;
                bgtCenterCode.DataTextField = "description";
                bgtCenterCode.DataValueField = "code";
                bgtCenterCode.DataBind();
                bgtCenterCode.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));



                var jobs11 = Config.ObjNav1.fnGetSafariEntitlements();
                List<ItemList> itms11 = new List<ItemList>();
                string[] infoz11 = jobs11.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infoz11.Count() > 0)
                {
                    foreach (var allInfo in infoz11)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[1];
                        itms11.Add(mdl);

                    }
                }

                entitlement.DataSource = itms11;
                entitlement.DataTextField = "description";
                entitlement.DataValueField = "code";
                entitlement.DataBind();
                entitlement.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var jobs118 = Config.ObjNav1.fnGetTowns();
                List<ItemList> itms118 = new List<ItemList>();
                string[] infoz118 = jobs118.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infoz118.Count() > 0)
                {
                    foreach (var allInfo in infoz118)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[1];
                        itms118.Add(mdl);

                    }
                }

                travelFrom.DataSource = itms118;
                travelFrom.DataTextField = "description";
                travelFrom.DataValueField = "code";
                travelFrom.DataBind();
                travelFrom.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                travelTo.DataSource = itms118;
                travelTo.DataTextField = "description";
                travelTo.DataValueField = "code";
                travelTo.DataBind();
                travelTo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));



            }

        }
        protected void next_Click(object sender, EventArgs e)
        {
            try
            {                
                
                DateTime texptTravelDate = Convert.ToDateTime(exptTravelDate.Text.Trim());
                DateTime texptReturnDate = Convert.ToDateTime(exptReturnDate.Text.Trim());
                int ttransMode = Convert.ToInt16(transMode.SelectedValue.Trim());
                string tbgtCenterCode = bgtCenterCode.SelectedValue.Trim();
                string tfunctionCode = functionCode.SelectedValue.Trim();
                string tpurpose = purpose.Text.Trim();


                String requisitionNo = "";
                Boolean newRequisition = false;
                try
                {
                    requisitionNo = Request.QueryString["requisitionNo"];

                    if (String.IsNullOrEmpty(requisitionNo))
                    {
                        requisitionNo = "";
                        newRequisition = true;
                    }
                }
                catch (Exception)
                {
                    newRequisition = true;
                    requisitionNo = "";
                }

                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String status = Config.ObjNav2.createSafariRequestHeader(requisitionNo, employeeNo, texptTravelDate, texptTravelDate, ttransMode, tfunctionCode, tbgtCenterCode, tpurpose);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newRequisition)
                    {
                        requisitionNo = info[2];
                    }
                    String redirectLocation = "SafariRequest.aspx?step=2&&requisitionNo=" + requisitionNo;
                    Response.Redirect(redirectLocation, false);

                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                string requisitionNo = Request.QueryString["requisitionNo"];
                DateTime texpencDate = Convert.ToDateTime(expencDate.Text.Trim());
                DateTime treturnDate = Convert.ToDateTime(returnDate.Text.Trim());
                string ttravelFrom = travelFrom.SelectedValue.Trim();
                string ttravelTo = travelTo.SelectedValue.Trim();                


                String status = Config.ObjNav2.createSafariRequestLines(requisitionNo, texpencDate, treturnDate, ttravelFrom, ttravelTo);
                String[] info = status.Split('*');

                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void addItem1_Click(object sender, EventArgs e)
        {
            try
            {
                string requisitionNo = Request.QueryString["requisitionNo"];                

                string tentitlement = entitlement.SelectedValue.Trim();
                
                decimal trate = Convert.ToDecimal(rate.Text.Trim());
                int tquantity = Convert.ToInt16(quantity.Text.Trim());
                string ttown = town.Text.Trim();


                String status = Config.ObjNav2.createSafariRequestEntitlements(requisitionNo, tentitlement, tquantity, trate, ttown);
                String[] info = status.Split('*');

                linesFeedback1.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception n)
            {
                linesFeedback1.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void Unnamed3_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("SafariRequest.aspx?step=3&&requisitionNo=" + requisitionNo);
        }
        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("SafariRequest.aspx?step=4&&requisitionNo=" + requisitionNo);
        }
        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("SafariRequest.aspx?step=3&&requisitionNo=" + requisitionNo);
        }
        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("SafariRequest.aspx?step=1&&requisitionNo=" + requisitionNo);
        }
        protected void previous1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("SafariRequest.aspx?step=2&&requisitionNo=" + requisitionNo);
        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                // Convert.ToString(Session["employeeNo"]),
                String status = Config.ObjNav2.sendSafariRequestApplicationApproval(requisitionNo);
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
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Safari Request/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["requisitionNo"];
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
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Safari Request/";
                String imprestNo = Request.QueryString["requisitionNo"];
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
        protected void deleteLine_Click(object sender, EventArgs e)
        {
        }
        protected void editItem_Click(object sender, EventArgs e)
        {
        }
    }
}