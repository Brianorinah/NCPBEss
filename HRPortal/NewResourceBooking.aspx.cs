using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class NewResourceBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                var jobs = nav.Resources.Where(r => r.Type == "Information Materials" || r.Type == "Machine" || r.Type == "Boardroom" || r.Type == "Grounds").ToList();
                List<Employee> allJobs = new List<Employee>();
                foreach (var myJob in jobs)
                {
                    Employee employee = new Employee();
                    employee.EmployeeNo = myJob.No;
                    employee.EmployeeName = myJob.Name;
                    allJobs.Add(employee);
                }
                resource.DataSource = allJobs;
                resource.DataValueField = "EmployeeNo";
                resource.DataTextField = "EmployeeName";
                resource.DataBind();

                var customer = nav.Resources.Where(r => r.Type == "Information Materials" || r.Type == "Machine" || r.Type == "Boardroom" || r.Type == "Grounds").ToList();
                editResource.DataSource = customer;
                editResource.DataValueField = "No";
                editResource.DataTextField = "Name";
                editResource.DataBind();

                string empNo = Convert.ToString(Session["employeeNo"]);
                var users = nav.Employees.Where(x => x.No == empNo).ToList();
                foreach (var user in users)
                {
                    //division.Text = user.Division;
                    //department.Text = user.Department_Code;
                }

                ntype.Text = "Reservation";
            }
        }

        protected void nextTostep2_Click(object sender, EventArgs e)
        {
            try
            {
                String tDescription = description.Text.Trim();
                Boolean error = false;
                String message = "";

                if (String.IsNullOrEmpty(tDescription))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter description";
                }
                if (error)
                {
                    generalfeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String ResourceNo = "";
                    try
                    {

                        ResourceNo = Request.QueryString["ResourceNo"];
                        if (String.IsNullOrEmpty(ResourceNo))
                        {
                            ResourceNo = "";
                        }
                    }
                    catch (Exception)
                    {

                        ResourceNo = "";
                    }
                    //String status = Config.ObjNav.FnCreateResourceBooking(ResourceNo, Convert.ToString(Session["employeeNo"]), tDescription);
                    //String[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    ResourceNo = info[2];
                    //    Response.Redirect("NewResourceBooking.aspx?step=2&&ResourceNo=" + ResourceNo);
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

        protected void previuosTostep1_Click(object sender, EventArgs e)
        {
            string ResourceNo = Request.QueryString["ResourceNo"];
            Response.Redirect("NewResourceBooking.aspx?step=1&&ResourceNo=" + ResourceNo);
        }

        protected void sendforapproval_Click(object sender, EventArgs e)
        {
            try
            {
                String ResourceNo = Request.QueryString["ResourceNo"];
                //String status = Config.ObjNav.FnSendResourceForApproval(Convert.ToString(Session["employeeNo"]), ResourceNo);
                //String[] info = status.Split('*');
                //linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                //"setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);

            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeresourceallocationlines_Click(object sender, EventArgs e)
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
                    String ResourceNo = Request.QueryString["ResourceNo"];
                    //String status = Config.ObjNav.FnDeleteResourceLines(mLineno, ResourceNo);
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

        protected void EditStandingImprestLine_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineno = Convert.ToInt32(originalNo.Text.Trim());
                int tType = Convert.ToInt32(editType.Text.Trim());
                String tResource = editResource.SelectedValue;
                String tReason = editReason.Text.Trim();
                String tStartTime = editStartTime.Text.Trim();
                String tEndTime = editEnddate.Text.Trim();
                String tDate = tr_EndDate.Text.Trim();
                int tCapacity = Convert.ToInt32(editCapacity.Text.Trim());
                Boolean error = false;
                String message = "";
                DateTime mDate = new DateTime();
                DateTime mStartTime = new DateTime();
                DateTime mEndTime = new DateTime();

                try
                {
                    mDate = DateTime.ParseExact(tDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please provide a valid date";
                }
                try
                {
                    mStartTime = DateTime.ParseExact(tStartTime, "HH:mm", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter start time";
                }
                try
                {
                    mEndTime = DateTime.ParseExact(tEndTime, "HH:mm", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter end time";
                }

                if (error)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String ResourceNo = Request.QueryString["ResourceNo"];
                    //String status = Config.ObjNav.FnEditResourceLines(tLineno, ResourceNo, tType, tResource, mDate, mStartTime, mEndTime, tReason, tCapacity);
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

        protected void addreservationlines_Click(object sender, EventArgs e)
        {
            try
            {
                int tType = 1;
                String tResource = resource.SelectedValue;
                String tReason = reason.Text.Trim();
                String tStartTime = starttime.Text.Trim();
                String tEndTime = endtime.Text.Trim();
                String tDate = tr_StartDate.Text.Trim();
                int tCapacity = Convert.ToInt32(capacity.Text.Trim());
                Boolean error = false;
                String message = "";
                DateTime mDate = new DateTime();
                DateTime mStartTime = new DateTime();
                DateTime mEndTime = new DateTime();

                try
                {
                    mDate = DateTime.ParseExact(tDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please provide a valid date";
                }
                try
                {
                    mStartTime = DateTime.ParseExact(tStartTime, "HH:mm", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter start time";
                }
                try
                {
                    mEndTime = DateTime.ParseExact(tEndTime, "HH:mm", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter end time";
                }

                if (String.IsNullOrEmpty(tReason))
                {
                    error = true;
                    message += message.Length > 0 ? "<br/>" : "";
                    message += "Please enter reason";
                }
                if (error)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String ResourceNo = Request.QueryString["ResourceNo"];
                    //String status = Config.ObjNav.FnInsertResourceLines(ResourceNo, tType, tResource, mDate, mStartTime, mEndTime, tReason, tCapacity);
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
    }
}