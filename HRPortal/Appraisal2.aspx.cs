using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class Appraisal2 : System.Web.UI.Page
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
                    String applicationNumber = Request.QueryString["applicationNo"];
                    if (!string.IsNullOrEmpty(applicationNumber))
                    {
                        var jobs = Config.ObjNav1.fnGetAppraisalApplicationDetails(applicationNumber);

                        String[] arr = jobs.Split('*');
                        jobtitle.Text = arr[0];
                        appraisalperiod.Text = arr[1];
                        appraisalstartdate.Text = arr[2];
                        goalsettingstartdate.Text = arr[3];
                        goalsettingenddate.Text = arr[4];
                        mystartdate.Text = arr[5];
                        myenddate.Text = arr[6];
                        eystartdate.Text = arr[7];
                        eyenddate.Text = arr[8];
                        supervisor.Text = arr[9];
                        overviewmanager.Text = arr[10];
                    }
                }
            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            String appNo = Request.QueryString["applicationNo"];
            Response.Redirect("Appraisal2.aspx?step=2&&applicationNo=" + appNo);
        }
        protected void competence_Click(object sender, EventArgs e)
        {
            String appNo = Request.QueryString["applicationNo"];
            Response.Redirect("Appraisal2.aspx?step=3&&applicationNo=" + appNo);
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {
                String appNo = Request.QueryString["applicationNo"];
                if (!string.IsNullOrEmpty(appNo))
                {
                    String status = Config.ObjNav2.sendObjectiveSettingsToLineManager(appNo);
                    String[] info = status.Split('*');

                    feedback.InnerHtml = "<div class='info[0]'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);

                }
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }

        protected void sentAgreement_Click(object sender, EventArgs e)
        {
            try
            {
                String appNo = Request.QueryString["applicationNo"];
                if (!string.IsNullOrEmpty(appNo))
                {
                    String status = Config.ObjNav2.sendToAppraiseeForAgreement(appNo);
                    String[] info = status.Split('*');

                    feedback.InnerHtml = "<div class='info[0]'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);

                }
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void sendBack_Click(object sender, EventArgs e)
        {
            try
            {
                String appNo = Request.QueryString["applicationNo"];
                if (!string.IsNullOrEmpty(appNo))
                {
                    String status = Config.ObjNav2.sendObjectiveSettingsBackToAppraisee(appNo);
                    String[] info = status.Split('*');

                    feedback.InnerHtml = "<div class='info[0]'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);

                }
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
    }
}