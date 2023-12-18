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
    public partial class FleetRequisition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadImprestMemo();

                var nav = new Config().ReturnNav();
                var employees = nav.Employees;
                List<Employee> allEmployees = new List<Employee>();
                foreach (var eachEmployee in employees)
                {
                    Employee emp = new Employee();
                    emp.EmployeeNo = eachEmployee.No;
                    emp.EmployeeName = eachEmployee.No + "_" + eachEmployee.First_Name + " " + eachEmployee.Middle_Name + " " +eachEmployee.Last_Name;
                    allEmployees.Add(emp);
                }
                employee.DataSource = allEmployees;
                employee.DataValueField = "EmployeeNo";
                employee.DataTextField = "EmployeeName";
                employee.DataBind();

                var project = nav.jobs.Where(x => x.Description != "").ToList().ToList().OrderBy(r => r.Description);
                List<Employee> allprojects = new List<Employee>();
                foreach (var projects in project)
                {
                    Employee generalprojects = new Employee();
                    generalprojects.EmployeeNo = projects.No;
                    generalprojects.EmployeeName = projects.No + " " + projects.Description;
                    allprojects.Add(generalprojects);
                }
            }
            try
            {
                Boolean exists = false;
                var nav = new Config().ReturnNav();
                String requisitionNo = Request.QueryString["requisitionNo"].Trim();
                String employeeNo = Convert.ToString(Session["employeeNo"]);

                if (!String.IsNullOrEmpty(requisitionNo))
                {
                    var transportRequisitions =
                        nav.TransportRequisition.Where(r => r.Transport_Requisition_No == requisitionNo && r.Employee_No == employeeNo);
                    foreach (var requisition in transportRequisitions)
                    {
                        exists = true;
                        if (!IsPostBack)
                        {
                            from.Text = requisition.Commencement;
                            destination.Text = requisition.Destination;
                            String myDate = Convert.ToDateTime(requisition.Date_of_Trip).ToString("dd/MM/yyyy");
                            //dd/mm/yyyy
                            myDate = myDate.Replace("-", "/");
                            dateofTrip.Text = myDate;
                            journeyRoute.Text = requisition.Journey_Route;
                            //purposeOfTrip.Text = requisition.Purpose_of_Trip;
                            // comments.Text = requisition.Comments;
                            noOfDays.Text = requisition.No_of_Days_Requested + "";
                            imprestNo.SelectedValue = requisition.Approved_Imprest_Memo;
                            //if(requisition.Travel_Type == "Local Travel")
                            //{
                            //    travelType.SelectedValue = "0";
                            //}
                            //else
                            //{
                            //    travelType.SelectedValue = "1";
                            //}
                            //String tTimeOut = requisition.Time_out;
                            //String[] nTime = tTimeOut.Split(':');
                            //try
                            //{
                            //    int mHour = Convert.ToInt32(nTime[0]);
                            //    int mMinute = Convert.ToInt32(nTime[1]);
                            //    if (mHour == 0)
                            //    {
                            //        hour.SelectedValue = "12";
                            //    }
                            //    if (mHour > 11)
                            //    {
                            //        amPM.SelectedValue = "PM";
                            //        if (mHour > 12)
                            //        {
                            //            hour.SelectedValue = (mHour - 12) + "";
                            //        }
                            //    }
                            //    if (mHour <= 12)
                            //    {
                            //        hour.SelectedValue = mHour + "";
                            //    }
                            //    minute.SelectedValue = mMinute + "";
                            // if 00 then its 12 Am

                            //}
                            //catch (Exception)
                            //{

                            //}
                            //String hourOut = hour.SelectedValue;
                            //String minuteOut = minute.SelectedValue;
                            //String amPMOut = amPM.SelectedValue;
                        }

                    }
                }

            }
            catch (Exception)
            {

            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                String tFrom = String.IsNullOrEmpty(from.Text.Trim()) ? "" : from.Text.Trim();
                String tDestination = String.IsNullOrEmpty(destination.Text.Trim()) ? "" : destination.Text.Trim();
                String tDateOfTrip = String.IsNullOrEmpty(dateofTrip.Text.Trim()) ? "" : dateofTrip.Text.Trim();
                String tJourneyRoute = String.IsNullOrEmpty(journeyRoute.Text.Trim()) ? "" : journeyRoute.Text.Trim();
                String tNoOfDays = String.IsNullOrEmpty(noOfDays.Text.Trim()) ? "" : noOfDays.Text.Trim();
                String tPurpose = String.IsNullOrEmpty(purposeOfTrip.Text.Trim()) ? "" : purposeOfTrip.Text.Trim();
                String tComments = "";
                decimal ttriphours = 0;
                String requisitionNo = "";
                var imprest = "";
                var tTypes = travelType.SelectedValue;
                if (tTypes == "1")
                {
                    imprest = "";
                    ttriphours = Convert.ToDecimal(triphours.Text.Trim());
                }
                else
                {
                    imprest = imprestNo.SelectedValue;
                }
                Decimal nDays = 0;
                Boolean error = false;
                String message = "";
                DateTime travelDate = new DateTime();
                try
                {
                    travelDate = DateTime.ParseExact(tDateOfTrip, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message = "Please select a valid value for date of trip";
                }
                DateTime ttimeoftrips = new DateTime();
                string txttimeoftrip = timeoftrip.Text.Trim();
                if (tTypes == "1")
                {
                    tTypes = "1";
                    ttimeoftrips = DateTime.ParseExact(txttimeoftrip, "HH:mm", CultureInfo.InvariantCulture);

                }
                else
                {
                    try
                    {
                        nDays = Convert.ToDecimal(tNoOfDays);
                    }
                    catch (Exception)
                    {
                        nDays = 0;
                    }
                }

                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //String status = Config.ObjNav.CreateFleetRequisition(Convert.ToString(Session["employeeNo"]),
                    //    requisitionNo, tFrom, tDestination, travelDate, ttimeoftrips, tJourneyRoute, nDays, tPurpose, tComments, imprest, Convert.ToInt32(tTypes), ttriphours, Convert.ToInt32(tTypes));
                    //string[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    Response.Redirect("FleetRequisition.aspx?step=2&&requisitionNo=" + info[2]);
                    //}
                    //else
                    //{
                    //    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previousToStepOne_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=1&&requisitionNo=" + requisitionNo);
        }
        protected void previoustosteptwo_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=2&&requisitionNo=" + requisitionNo);
        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                String empNo = Session["employeeNo"].ToString();
                String status = Config.ObjNav.SendFleetRequisitionApproval(empNo, requisitionNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }


        protected void addTeamMember_Click(object sender, EventArgs e)
        {
            try
            {
                String tEmployee = employee.SelectedValue;
                String requisitionNo = Request.QueryString["requisitionNo"];
                String status = Config.ObjNav.AddFleetRequisitionStaff(Convert.ToString(Session["employeeNo"]), requisitionNo, tEmployee);
                String[] info = status.Split('*');
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void addNonStaffMembers_Click(object sender, EventArgs e)
        {
            try
            {
                String tEmployee = employee.SelectedValue;
                int tidnumber = Convert.ToInt32(idnumber.Text.Trim());
                string tnames = names.Text.Trim();
                int tphonumber = Convert.ToInt32(phonumber.Text.Trim());
                string torganization = organization.Text.Trim();
                String requisitionNo = Request.QueryString["requisitionNo"];
                //String status = Config.ObjNav.AddFleetRequisitioNonStaff(Convert.ToString(Session["employeeNo"]), requisitionNo, tidnumber, tphonumber, torganization, tnames);
                //String[] info = status.Split('*');
                //linesFeedback1.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                linesFeedback1.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";

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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Fleet Requisition Card/";
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
        protected void deleteStaffClick(object sender, EventArgs e)
        {
            try
            {
                int tentryNumber = Convert.ToInt32(staffid.Text.Trim());
                String requisitionNo = Request.QueryString["requisitionNo"];
                String status = Config.ObjNav.RemoveStaffFromTravelRequisition(Convert.ToString(Session["employeeNo"]), requisitionNo, tentryNumber);
                String[] info = status.Split('*');
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
        protected void deleteStaff_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    int tnonstaffnumber = Convert.ToInt32(nonstaffnumber.Text.Trim());
            //    String requisitionNo = Request.QueryString["requisitionNo"];
            //    String status = Config.ObjNav.RemoveNonStaffTravelRequisition(Convert.ToString(Session["employeeNo"]), requisitionNo, tnonstaffnumber);
            //    String[] info = status.Split('*');
            //    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
            //catch (Exception t)
            //{
            //    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}


        }

        protected void loadImprestMemo()
        {
            // imprestNo
            var nav = new Config().ReturnNav();
            var query = nav.ImprestMemo.Where(x => x.Status == "Released" && x.Requestor == Convert.ToString(Session["employeeNo"]));
            List<Item> list = new List<Item>();
            foreach (var item in query)
            {
                Item it = new Item();
                it.No = item.No;
                it.Description = item.No + "_" + item.Imprest_Naration;
                list.Add(it);
            }
            imprestNo.DataSource = list;
            imprestNo.DataTextField = "Description";
            imprestNo.DataValueField = "No";
            imprestNo.DataBind();


        }

        protected void NextToStepThree_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=3&&requisitionNo=" + requisitionNo);
        }
        protected void nexttostepfour_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=4&&requisitionNo=" + requisitionNo);
        }

        protected void previoustostepthree_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("FleetRequisition.aspx?step=3&&requisitionNo=" + requisitionNo);
        }

        protected void travelType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (travelType.SelectedValue == "0")
                {
                    divmemo.Visible = true;
                    divdays.Visible = true;
                    divhours.Visible = false;
                }
                else
                {
                    divmemo.Visible = false;
                    divdays.Visible = false;
                    divhours.Visible = true;
                }
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
        protected void imprestselected_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                var nav = new Config().ReturnNav();
                var memmoNumber = imprestNo.SelectedValue;
                var imprest = nav.ImprestMemo.Where(r => r.No == memmoNumber);
                foreach (var myJob in imprest)
                {
                    dateofTrip.Text = Convert.ToDateTime(myJob.Start_Date).ToString("dd/MM/yyyy"); 
                    noOfDays.Text = Convert.ToString(myJob.No_of_days);
                    purposeOfTrip.Text = Convert.ToString(myJob.Imprest_Naration);
                }

            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
    }
}