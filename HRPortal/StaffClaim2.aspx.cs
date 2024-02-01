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
    public partial class StaffClaim2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int step = 1;
                try
                {
                    step = Convert.ToInt32(Request.QueryString["step"]);
                    if (step > 3 || step < 1)
                    {
                        step = 1;
                    }
                }
                catch (Exception)
                {
                    step = 1;
                }
                if (step == 1)
                {
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    var jobs = Config.ObjNav1.fnGetSafariCode(employeeNo);
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

                    safariNumber.DataSource = itms;
                    safariNumber.DataTextField = "description";
                    safariNumber.DataValueField = "code";
                    safariNumber.DataBind();
                    safariNumber.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


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

                    String appNo = Request.QueryString["requisitionNo"];
                    if (!string.IsNullOrEmpty(appNo))
                    {
                        String job12 = Config.ObjNav1.fnGetClaimApplicationDetails(appNo);

                        String[] arr3 = job12.Split('*');

                        safariNumber.Text = arr3[0];
                        functionCode.Text = arr3[1];
                    }
                }
                else if (step == 2)
                {
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
                            mdl.description = arr[0] + "-" + arr[1];
                            itms11.Add(mdl);

                        }
                    }

                    claimtype.DataSource = itms11;
                    claimtype.DataTextField = "description";
                    claimtype.DataValueField = "code";
                    claimtype.DataBind();
                    claimtype.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                }


           

            }

        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                string tsafariNumber = safariNumber.Text.Trim();
                string tfunctionCode = functionCode.SelectedValue.Trim();
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
                String status = Config.ObjNav2.createStaffApplication(requisitionNo, employeeNo, tsafariNumber, tfunctionCode);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newRequisition)
                    {
                        requisitionNo = info[2];
                    }
                    String redirectLocation = "StaffClaim2.aspx?step=2&&requisitionNo=" + requisitionNo;
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
                string tclaimtype = claimtype.Text.Trim();
                int tnoOfNightsSpent = Convert.ToInt16(noOfNightsSpent.Text.Trim());
                int tnoOfDaysSpent = Convert.ToInt16(noOfDaysSpent.Text.Trim());
                string treasonForClaim = reasonForClaim.Text.Trim();
                int trate = Convert.ToInt16(rate.Text.Trim());
                int tquantity = Convert.ToInt16(quantity.Text.Trim());

                String status = Config.ObjNav2.createStaffClaimApplicationLines(requisitionNo, tclaimtype, tnoOfDaysSpent, tnoOfNightsSpent,tquantity,trate,treasonForClaim);
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
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StaffClaim2.aspx?step=3&&requisitionNo=" + requisitionNo);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StaffClaim2.aspx?step=2&&requisitionNo=" + requisitionNo);
        }
        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StaffClaim2.aspx?step=1&&requisitionNo=" + requisitionNo);
        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                // Convert.ToString(Session["employeeNo"]),
                String status = Config.ObjNav2.sendStaffClaimApplicationApproval(requisitionNo);
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

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Staff Claim/";

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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Non-Project Store Requisition/";
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
        protected void copySafariLines_Click(object sender, EventArgs e)
        {
            try
            {
                String safNumber = safariNumber.Text.Trim();
                String clmNumber = Request.QueryString["requisitionNo"];
                var nav = Config.ObjNav2;
                String result = nav.copySafariLines(safNumber, clmNumber);
                String[] safari = result.Split('*');
                if (safari[0] == "success") {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + safari[0] + safari[1]+"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
            }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + safari[0] + safari[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception ed) {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ed.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}