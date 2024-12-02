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
    public partial class LeaveApplication2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var jobs = Config.ObjNav1.fnGetRelieverDetails();
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

                reliever.DataSource = itms;
                reliever.DataTextField = "description";
                reliever.DataValueField = "code";
                reliever.DataBind();
                reliever.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var jobs1 = Config.ObjNav1.fnGetLeaveCode();
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

                leaveType.DataSource = itms1;
                leaveType.DataTextField = "description";
                leaveType.DataValueField = "code";
                leaveType.DataBind();
                leaveType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                String leaveNo = Request.QueryString["leaveNo"];
                if (!String.IsNullOrEmpty(leaveNo))
                {
                    String job = Config.ObjNav1.fnGetHrLeaveApplicationDetails(leaveNo);
                    String[] arr = job.Split('*');
                    reliever.SelectedValue = arr[0];
                    contactAddress.Text = arr[2];
                    description.Text = arr[1];
                }

                int step = 1;
                try
                {
                    step = Convert.ToInt32(Request.QueryString["step"].Trim());
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
                    string status = Config.ObjNav2.LeaveRequestReport(leaveNo);
                    string empNo = (String)Session["employeeNo"];
                    if (status != "danger" && !string.IsNullOrEmpty(status))
                    {
                        bool downloaded = ConvertAndDownloadToLocal(status, "Leave");
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

        protected void leaveType_SelectedIndexChanged(object sender, EventArgs e)
        {
            String employeeNo = Convert.ToString(Session["employeeNo"]);
            string tleaveType = leaveType.Text.Trim();

            var jobs1 = Config.ObjNav1.fnGetLeaveBalances(employeeNo, tleaveType);
            List<ItemList> itms1 = new List<ItemList>();
            string[] infoz1 = jobs1.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
            if (infoz1.Count() > 0)
            {
                foreach (var allInfo in infoz1)
                {
                    String[] arr = allInfo.Split('*');

                    ItemList mdl = new ItemList();
                    leaveBalance.Text = arr[0];
                    //mdl.code = arr[0];                    
                    itms1.Add(mdl);

                }
            }


        }

        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                string treliever = reliever.Text.Trim();
                string tcontactAddress = contactAddress.Text.Trim();
                string tdescription = description.Text.Trim();
                String requisitionNo = "";
                Boolean newRequisition = false;
                try
                {
                    requisitionNo = Request.QueryString["leaveNo"];
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
                String userName = Session["username"].ToString().ToUpper();
                String status = Config.ObjNav2.createLeaveApplication(requisitionNo, employeeNo, treliever, tcontactAddress, tdescription, userName);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newRequisition)
                    {
                        requisitionNo = info[2];
                    }
                    String redirectLocation = "LeaveApplication2.aspx?step=2&&leaveNo=" + requisitionNo;
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
                String requisitionNo = Request.QueryString["leaveNo"];
                string tleaveType = leaveType.Text.Trim();
                DateTime tstartDate = Convert.ToDateTime(startDate.Text.Trim());
                //DateTime tendDate = Convert.ToDateTime(endDate.Text.Trim());
                Int32 tdaysApplied = Convert.ToInt32(daysapplied.Text);

                var leavebal = leaveBalance.Text;

                String status = Config.ObjNav2.createLeaveApplicationLines(requisitionNo, tleaveType, tstartDate, tdaysApplied);
                String[] info = status.Split('*');
                //try adding the line
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["leaveNo"];
            Response.Redirect("LeaveApplication2.aspx?step=3&&leaveNo=" + requisitionNo);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["leaveNo"];
            Response.Redirect("LeaveApplication2.aspx?step=2&&leaveNo=" + requisitionNo);
        }
        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["leaveNo"];
            Response.Redirect("LeaveApplication2.aspx?step=1&&leaveNo=" + requisitionNo);
        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["leaveNo"];
                String userName = Convert.ToString(Session["username"]);
                // Convert.ToString(Session["employeeNo"]),
                String status = Config.ObjNav2.sendLeaveApplicationApproval(requisitionNo, userName.ToUpper());
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

            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Leave Application card/";
            //String filesFolder = "~" + ConfigurationManager.AppSettings["FileFolderApplication"] + "/" + "Leave Application card/";
            String filesFolder = Server.MapPath("~/downloads/Leave Application card/");

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["leaveNo"];
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
                //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Non-Project Store Requisition/";
                String filesFolder = Server.MapPath("~/downloads/Leave Application card/");
                String imprestNo = Request.QueryString["leaveNo"];
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
        protected void deleteLine(object sender, EventArgs e)
        {
            try
            {
                String linNo = lineNo.Text.Trim();
                String leavNo = leaveNo.Text.Trim();
                int linNos = Convert.ToInt32(linNo);
                String status = Config.ObjNav2.deleteLeaveApplicationLines(leavNo, linNos);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";



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