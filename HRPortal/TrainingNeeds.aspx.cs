using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class TrainingNeeds : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();
            if (!IsPostBack)
            {
                String NeedsRequestNo = "";
                try
                {
                    NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
                }
                catch (Exception)
                {
                    NeedsRequestNo = "";
                }
                //if (!String.IsNullOrEmpty(NeedsRequestNo))
                //{
                //    var data = nav.TrainingNeedsHeader.Where(r => r.Employee_No == Convert.ToString(Session["employeeNo"]) && r.Code == NeedsRequestNo);
                //    foreach (var item in data)
                //    {
                //        description.Text = item.Description;
                //    }
                //}
            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                String tDescription = description.Text.Trim();
                Boolean error = false;
                String message = "";
                if (String.IsNullOrEmpty(tDescription))
                {
                    error = true;
                    message = "Please enter description";
                }
                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String NeedsRequestNo = "";
                    Boolean newNeedsRequestNo = false;
                    try
                    {

                        NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
                        if (String.IsNullOrEmpty(NeedsRequestNo))
                        {
                            NeedsRequestNo = "";
                            newNeedsRequestNo = true;
                        }
                    }
                    catch (Exception)
                    {

                        NeedsRequestNo = "";
                        newNeedsRequestNo = true;
                    }
                    String empno = Convert.ToString(Session["employeeNo"]);
                    String status = Config.ObjNav.CreateNewTrainingRequest(empno, NeedsRequestNo, tDescription);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newNeedsRequestNo)
                        {
                            NeedsRequestNo = info[2];

                        }
                        Response.Redirect("TrainingNeeds.aspx?step=2&&NeedsRequestNo=" + NeedsRequestNo);
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

        protected void addlinedetails_Click(object sender, EventArgs e)
        {
            try
            {
                String message = "";
                Boolean error = false;
                String tdescription = linedescription.Text.Trim();
                String tComment = comments.Text.Trim();
                int mSource = Convert.ToInt32(source.SelectedValue);

                if (String.IsNullOrEmpty(tdescription))
                {
                    error = true;
                    message = "Please enter description";
                }
                if (String.IsNullOrEmpty(tComment))
                {
                    error = true;
                    message = "Please enter comment";
                }
                if (error)
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
                    String empNo = Request.QueryString["employeeNo"];
                    String status = Config.ObjNav.CreateNewTrainingNeedsLines(NeedsRequestNo, tdescription, mSource, tComment);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            String NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
            Response.Redirect("TrainingNeeds.aspx?step=1&&NeedsRequestNo=" + NeedsRequestNo);
        }

        protected void sendapproval_Click(object sender, EventArgs e)
        {
            try
            {
                String needsNo = Request.QueryString["NeedsRequestNo"];
                String status = Config.ObjNav.SendTrainingNeedsApproval(Convert.ToString(Session["employeeNo"]), needsNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                }
                else
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception t)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void removeneedsrequest_Click(object sender, EventArgs e)
        {
            try
            {
                int ylinenumber = Convert.ToInt32(removeLineNumber.Text.Trim());
                String NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
                String status = Config.ObjNav.FnDeleteTrainingNeedsLines(NeedsRequestNo, ylinenumber);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception m)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void editneedsrequest_Click(object sender, EventArgs e)
        {
            try
            {
                int teditsource = editSource.SelectedIndex;
                String teditdescription = editDescription.Text.Trim();
                String teditcomments = editComments.Text.Trim();
                int mLine = Convert.ToInt32(originalNo.Text.Trim());

                String NeedsRequestNo = Request.QueryString["NeedsRequestNo"];
                String staus = Config.ObjNav.FnEditTrainingNeedsRequestLines(NeedsRequestNo, mLine, teditdescription, teditsource, teditcomments);
                String[] info = staus.Split('*');
                if (info[0] == "success")
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                LinesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}