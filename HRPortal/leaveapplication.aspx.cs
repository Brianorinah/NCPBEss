using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class leaveapplication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {                      
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();

                string emp = Convert.ToString(Session["employeeNo"]);
                //var empList = nav.Employees.Where(x=> x.No != emp && x.Employee_Posting_Group == "IMREST").ToList();
                //List<Item> list = new List<Item>();
                //foreach (var item in empList)
                //{
                //    Item itm = new Item();
                //    itm.Description = item.No + "_" + item.First_Name + " " + item.Last_Name;
                //    itm.No = item.No;
                //    list.Add(itm);
                //}

                //reliver.DataSource = list;
                //reliver.DataValueField = "No";
                //reliver.DataTextField = "Description";
                //reliver.DataBind();

                //string gender = Convert.ToString(Session["gender"]);
                //if (gender == "Male")
                //{
                //    var leaveTypes = nav.LeaveTypes.Where(x=> x.Gender == "Male" || x.Gender == "Both").ToList();
                //    leaveType.DataSource = leaveTypes;
                //    leaveType.DataValueField = "Code";
                //    leaveType.DataTextField = "Description";
                //    leaveType.DataBind();
                //}
                //else if (gender == "Female")
                //{
                //    var leaveTypes = nav.LeaveTypes.Where(x => x.Gender == "Female" || x.Gender == "Both").ToList(); 
                //    leaveType.DataSource = leaveTypes;
                //    leaveType.DataValueField = "Code";
                //    leaveType.DataTextField = "Description";
                //    leaveType.DataBind();
                //}

                String leaveNo = "";
                try
                {
                    leaveNo = Request.QueryString["leaveno"];
                    if (string.IsNullOrEmpty(leaveNo))
                    {
                        leaveNo = "";
                    }
                }
                catch (Exception)
                {
                    
                }
                if (!String.IsNullOrEmpty(leaveNo))
                {
                    //var leaves = nav.HrLeaveApplication.Where(r => r.Employee_No == (String)Session["employeeNo"] && r.Application_Code == leaveNo);
                    //foreach (var leave in leaves)
                    //{
                    //    reliver.SelectedValue = leave.Reliever;
                    //    leaveType.SelectedValue = leave.Leave_Type;
                    //    if (leave.Leave_Type == "ANNUAL")
                    //    {
                    //        divAnnualLeaveType.Visible = true;
                    //        annualLeaveType.SelectedValue = leave.Annual_Leave_Type;
                    //    }
                    //    else
                    //    {
                    //        divAnnualLeaveType.Visible = false;
                    //    }
                    //    daysApplied.Text = leave.Days_Applied.ToString();
                    //    String myDate = Convert.ToDateTime(leave.Start_Date).ToString("dd/MM/yyyy");
                    //    myDate = myDate.Replace("-", "/");
                    //    leaveStartDate.Text = myDate;
                    //    phoneNumber.Text = leave.Cell_Phone_Number;
                    //    emailAddress.Text = leave.E_mail_Address;
                    //    returnDate.Text = Convert.ToDateTime(leave.Return_Date).ToString("dd/MM/yyyy");
                    //    if (leave.Leave_Type == "EXAM")
                    //    {
                    //        divExamDetails.Visible = true;
                    //        divDateExam.Visible = true;
                    //        examDetails.Text = leave.Details_of_Examination;
                    //        String examDate = Convert.ToDateTime(leave.Date_of_Exam).ToString("dd/MM/yyyy");
                    //        examDate = myDate.Replace("-", "/");
                    //        dateOfExam.Text = examDate;
                    //    }
                    //    else
                    //    {
                    //        divExamDetails.Visible = false;
                    //        divDateExam.Visible = false;
                    //    }
                    //}
                }

            }
        }
        protected void apply_Click(object sender, EventArgs e)
        {
            Boolean error = false;
            string message = "";
            String treliever = reliver.SelectedValue;
            //String tLeaveType = leaveType.SelectedValue;
            //String mAnnualLeaveType = annualLeaveType.SelectedValue;
            //int tannual = 0;
            //if (mAnnualLeaveType == "Annual Leave")
            //{
            //    tannual = 1;
            //}
            //if (mAnnualLeaveType == "Emergency Leave")
            //{
            //    tannual = 2;
            //}
            String tDaysApplied = daysApplied.Text.Trim();
            String tLeaveStartDate = leaveStartDate.Text.Trim();
            //String tPhoneNumber = phoneNumber.Text.Trim();
            //if (tPhoneNumber.Length < 10 || tPhoneNumber.Length > 10)
            //{
            //    error = true;
            //    message = "Please provide a valid phone number! It should be like 07xxxxxxxx";
            //}
            //String tEmailAddress = emailAddress.Text.Trim();           
            //bool isValid = IsValidEmail(tEmailAddress);
            //if (isValid == false)
            //{
            //    error = true;
            //    message = "Please enter a valid email address! It should be like test@gmail.com";
            //}
            //String tExamDetails = examDetails.Text.Trim();
            //String tDateOfExam = dateOfExam.Text.Trim();
         
            int dApplied = 0;
            DateTime lStartDate = new DateTime();
            //dOfExam = new DateTime();

            //if (tLeaveType != "ANNUAL")
            //{
            //    annualLeaveType.Visible = false;
            //}

            try
            {
                dApplied = Convert.ToInt32(tDaysApplied);
                if (dApplied < 1)
                {
                    throw new Exception();
                }
            }
            catch (Exception)
            {
                error = true;
                message = "Please provide a valid number of days applied";
            }
            try
            {
                CultureInfo culture = new CultureInfo("ru-RU");
                lStartDate = DateTime.ParseExact(tLeaveStartDate, "d/M/yyyy", CultureInfo.InvariantCulture);

            }
            catch (Exception)
            {
                error = true;
                message = "Please provide a valid leave start date";
            }
            //try
            //{
            //    if (!String.IsNullOrEmpty(tDateOfExam))
            //    {
            //        CultureInfo culture = new CultureInfo("ru-RU");
            //        dOfExam = DateTime.ParseExact(tDateOfExam, "d/M/yyyy", CultureInfo.InvariantCulture);
            //    }

            //}
            //catch (Exception)
            //{
            //    error = true;
            //    message = "Please provide a valid exam date";
            //}
            var nav = new Config().ReturnNav();
            decimal days = Convert.ToDecimal(daysApplied.Text.Trim());
            //var data = nav.LeaveTypes.Where(x => x.Code == tLeaveType).ToList();
            decimal maxdays = 0;
            //foreach (var item in data)
            //{
            //    //maxdays = Convert.ToDecimal(item.Days);
            //}
            if (days > maxdays)
            {
                error = true;
                message = "You have applied " + days + " days which is more than the maximum days for this leave type(" + maxdays + "). Kindly apply days lower than the maximum value.";
            }
            if (error)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>"+message+"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {
                try
                {
                    String leaveno = "";
                    try
                    {
                        leaveno = Request.QueryString["leaveno"];
                        if (string.IsNullOrEmpty(leaveno))
                        {
                            leaveno = "";
                        }
                    }
                    catch (Exception)
                    {
                        leaveno = "";
                    }

                    //String status = Config.ObjNav.FnCreateLeaveApplication(leaveno, (String)Session["employeeNo"], tLeaveType, tannual, dApplied, lStartDate, treliever, tPhoneNumber, tEmailAddress, tExamDetails, dOfExam);
                    //String[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    String leaveNo = info[2];
                    //    Response.Redirect("leaveapplication.aspx?leaveno=" + leaveNo + "&step=2" + "&type=" +tLeaveType);
                    //}
                    //else
                    //{
                    //    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}

                }
                catch (Exception t)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String leaveNo = Request.QueryString["leaveno"];
                bool err = false;
                string flag = "";
                //String status1 = Config.ObjNav.FnValidateLeaveAttachments(leaveNo);
                //String[] info1 = status1.Split('*');
                //if (info1[0] != "success")
                //{
                //    err = true;
                //    flag = info1[1];
                //}
                if (err)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + flag +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    
                    String tLeaveNo = leaveNo;
                    //String status = Config.ObjNav.SendLeaveForApproval((String)Session["employeeNo"], tLeaveNo);
                    //String[] info = status.Split('*');
                    //documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                    //"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    //"setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                }

            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Leave Application Card/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["leaveno"];
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
                            catch (Exception ex)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                            "<div class='alert alert-danger'>'"+ex.Message+"'. Please try again" +
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
                                        Config.navExtender.AddLinkToRecord("Leave Application card", imprestNo, filename, "");
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
                    //documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'"+ex.Message+"'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Leave Application card/";
                String imprestNo = Request.QueryString["leaveno"];
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

        protected void Unnamed10_Click(object sender, EventArgs e)
        {
            String imprestNo = Request.QueryString["leaveno"];
            Response.Redirect("leaveapplication.aspx?step=1&&leaveno=" + imprestNo);
        }

        //protected void leaveType_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    if(leaveType.SelectedValue =="ANNUAL")
        //    {
        //        divAnnualLeaveType.Visible = true;
        //    }
        //    else
        //    {
        //        divAnnualLeaveType.Visible = false;
        //    }
        //    if(leaveType.SelectedValue == "EXAM")
        //    {
        //        divExamDetails.Visible = true;
        //        divDateExam.Visible = true;
        //    }
        //    else
        //    {
        //        divExamDetails.Visible = false;
        //        divDateExam.Visible = false;
        //    }

        //}

        protected void leaveStartDate_TextChanged(object sender, EventArgs e)
        {
            try
            {
                //String tLeaveType = leaveType.SelectedValue;
                //String mAnnualLeaveType = annualLeaveType.SelectedValue;
                //int tannual = 0;
                //if (mAnnualLeaveType == "Annual Leave")
                //{
                //    tannual = 1;
                //}
                //if (mAnnualLeaveType == "Emergency Leave")
                //{
                //    tannual = 2;
                //}
                String tLeaveStartDate = leaveStartDate.Text.Trim();
                Boolean error = false;
                string message = "";
                DateTime lStartDate = new DateTime();
                DateTime examdate = new DateTime();
                string days = daysApplied.Text.Trim();
                int ndays = 0;

                if (string.IsNullOrEmpty(days))
                {
                    error = true;
                    message = "Please enter days applied to get return date.";
                }
                else
                {
                    ndays = Convert.ToInt32(days);
                }

                try
                {
                    CultureInfo culture = new CultureInfo("ru-RU");
                    lStartDate = DateTime.ParseExact(tLeaveStartDate, "d/M/yyyy", CultureInfo.InvariantCulture);

                }
                catch (Exception)
                {
                    error = true;
                    message = "Please provide a valid leave start date.";
                }

                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";                    
                }
                else
                {
                    String leaveno = "";
                    try
                    {
                        leaveno = Request.QueryString["leaveno"];
                        if (string.IsNullOrEmpty(leaveno))
                        {
                            leaveno = "";
                        }
                    }
                    catch (Exception)
                    {
                        leaveno = "";
                    }
                    //String status = Config.ObjNav.FnCreateLeaveApplication(leaveno, (String)Session["employeeNo"], tLeaveType, tannual, ndays, lStartDate, "", "", "", "", examdate);
                    //String[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    var nav = new Config().ReturnNav();
                    //    var data = nav.HrLeaveApplication.Where(x => x.Application_Code == info[2]);
                    //    foreach(var item in data)
                    //    {
                    //        returnDate.Text = Convert.ToDateTime(item.End_Date).ToString("dd/MM/yyyy");
                    //    }
                    //    Response.Redirect("leaveapplication.aspx?leaveno=" + info[2]);
                    //}
                    //else
                    //{
                    //    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
                }
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        public static bool IsValidEmail(string email)
        {
            string pattern = @"^(?!\.)(""([^""\r\\]|\\[""\r\\])*""|" + @"([-a-z0-9!#$%&'*+/=?^_`{|}~]|(?<!\.)\.)*)(?<!\.)" + @"@[a-z0-9][\w\.-]*[a-z0-9]\.[a-z][a-z\.]*[a-z]$";
            var regex = new Regex(pattern, RegexOptions.IgnoreCase);
            return regex.IsMatch(email);
        }

        protected void daysApplied_TextChanged(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            //String tLeaveType = leaveType.SelectedValue;
            decimal days = Convert.ToDecimal(daysApplied.Text.Trim());
            //var data = nav.LeaveTypes.Where(x => x.Code == tLeaveType).ToList();
            decimal maxdays = 0;
            //foreach(var item in data)
            //{
            //    //maxdays = Convert.ToDecimal(item.Days);
            //}
            if(days > maxdays)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>You have applied "+days+" days which is more than the maximum days for this leave type("+maxdays+").<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}