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
    public partial class StandingImprest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var jobs = nav.jobs.ToList().OrderBy(r => r.Description);
                List<Employee> allJobs = new List<Employee>();
                foreach (var myJob in jobs)
                {
                    Employee employee = new Employee();
                    employee.EmployeeNo = myJob.No;
                    employee.EmployeeName = myJob.No + " - " + myJob.Description;
                    allJobs.Add(employee);
                }
                job.DataSource = allJobs;
                job.DataValueField = "EmployeeNo";
                job.DataTextField = "EmployeeName";
                job.DataBind();

                //var customer = nav.Customers;
                //transferto.DataSource = customer;
                //transferto.DataValueField = "No";
                //transferto.DataTextField = "Name";
                //transferto.DataBind();

                //var customer1 = nav.Customers;
                //editTransferTo.DataSource = customer1;
                //editTransferTo.DataValueField = "No";
                //editTransferTo.DataTextField = "Name";
                //editTransferTo.DataBind();
            }
        }
        protected void job_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadJobTasks();
        }

        protected void LoadJobTasks()
        {
            //var nav = new Config().ReturnNav();
            //var myJob = job.SelectedValue;
            //var jobTasks = nav.JobTask.Where(r => r.Job_No == myJob && r.Job_Task_Type == "Posting");
            //jobtask.DataSource = jobTasks;
            //jobtask.DataValueField = "Job_Task_No";
            //jobtask.DataTextField = "Description";
            //jobtask.DataBind();
        }

        protected void nextTostep2_Click(object sender, EventArgs e)
        {
            try
            {              
                String tPaymentNarration = paymentnarration.Text.Trim();
                String tJob = job.SelectedValue;
                String tJobTask = jobtask.SelectedValue;
                Boolean error = false;
                String message = "";


                if (String.IsNullOrEmpty(tJob))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the project";
                }
                if (String.IsNullOrEmpty(tJobTask))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please select the Vote Item";
                }
                if (String.IsNullOrEmpty(tPaymentNarration))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter payment narration";
                }
                if (error)
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String SimprestNo = "";
                    Boolean newSimprestNo = false;
                    try
                    {

                        SimprestNo = Request.QueryString["SimprestNo"];
                        if (String.IsNullOrEmpty(SimprestNo))
                        {
                            SimprestNo = "";
                            newSimprestNo = true;
                        }
                    }
                    catch (Exception)
                    {

                        SimprestNo = "";
                        newSimprestNo = true;
                    }
                        //String status = Config.ObjNav.FnCreateNewStandingImprest(Convert.ToString(Session["employeeNo"]), SimprestNo, tJob, tJobTask, tPaymentNarration);
                        //String[] info = status.Split('*');
                        //if (info[0] == "success")
                        //{
                        //    if (newSimprestNo)
                        //    {
                        //    SimprestNo = info[2];

                        //    }
                        //    Response.Redirect("StandingImprest.aspx?step=2&&SimprestNo=" + SimprestNo);
                        //}
                        //else
                        //{
                        //    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        //}

                }

            }
            catch (Exception m)
            {
                generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void AddStandingImprestLine_Click(object sender, EventArgs e)
        {
            try
            {
                String tAmount = amount.Text.Trim();
                Boolean error = false;
                String message = "";
                Decimal mAmount = 0;

                try
                {
                    mAmount = Convert.ToDecimal(tAmount);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter amount";
                }

                if (error)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String SimprestNo = Request.QueryString["SimprestNo"];
                    //String status = Config.ObjNav.FnCreateStandingImprestLines(SimprestNo, mAmount, Convert.ToString(Session["employeeNo"]));
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

            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Standing Imprest Requsition/";
            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Staff Claim/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String SimprestNo = Request.QueryString["SimprestNo"];
                            string imprest = SimprestNo;
                            SimprestNo = SimprestNo.Replace('/', '_');
                            SimprestNo = SimprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + SimprestNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception ex)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //We could not create a directory for your documents
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

                                        //Config.navExtender.AddLinkToRecord("Imprest Memo", imprestNo, filename, "");
                                        Config.navExtender.AddLinkToRecord("Standing Imprest Requsition", imprest, filename, "");
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
                    //The document could not be uploaded
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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Standing Imprest Requsition/";
                String SimprestNo = Request.QueryString["SimprestNo"];
                SimprestNo = SimprestNo.Replace('/', '_');
                SimprestNo = SimprestNo.Replace(':', '_');
                String documentDirectory = filesFolder + SimprestNo + "/";
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

        protected void EditStandingImprestLine_Click(object sender, EventArgs e)
        {
            try
            {
                String tAmount = editAmount.Text.Trim();
                String tLineno = originalNo.Text.Trim();
                Boolean error = false;
                String message = "";
                Decimal mAmount = 0;
                int mLineno = 0;

                try
                {
                    mAmount = Convert.ToDecimal(tAmount);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter amount";
                }
                try
                {
                    mLineno = Convert.ToInt32(tLineno);
                }
                catch (Exception)
                {

                }

                if (error)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String SimprestNo = Request.QueryString["SimprestNo"];
                    //String status = Config.ObjNav.FnEditStandingImprestLines(mLineno, SimprestNo, mAmount);
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

            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void RemoveStandingImprestLine_Click(object sender, EventArgs e)
        {
            try
            {
                String tLineno = removeNumber.Text.Trim();
                Boolean error = false;
                String message = "";
                int mLineno = 0;

                try
                {
                    mLineno = Convert.ToInt32(tLineno);
                }
                catch (Exception)
                {

                }

                if (error)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String SimprestNo = Request.QueryString["SimprestNo"];
                    //String status = Config.ObjNav.FnDeleteStandingImprestLines(mLineno, SimprestNo);
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

            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void sendforapproval_Click(object sender, EventArgs e)
        {
            try
            {
                String SimprestNo = Request.QueryString["SimprestNo"];
                //String status = Config.ObjNav.FnSendStandingImprestApproval(SimprestNo, Convert.ToString(Session["employeeNo"]));
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                //    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                //}
                //else
                //{
                //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}

            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void nextTostep3_Click(object sender, EventArgs e)
        {
            String SimprestNo = Request.QueryString["SimprestNo"];
            Response.Redirect("StandingImprest.aspx?step=3&&SimprestNo=" + SimprestNo);
        }

        protected void previuosTostep1_Click(object sender, EventArgs e)
        {
            String SimprestNo = Request.QueryString["SimprestNo"];
            Response.Redirect("StandingImprest.aspx?step=1&&SimprestNo=" + SimprestNo);
        }

        protected void PreviousTostep2_Click(object sender, EventArgs e)
        {
            String SimprestNo = Request.QueryString["SimprestNo"];
            Response.Redirect("StandingImprest.aspx?step=2&&SimprestNo=" + SimprestNo);
        }
    }
}