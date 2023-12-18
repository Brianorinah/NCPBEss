using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class EmployeeSurveySection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void backtosurveys_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmployeeSurveyResponse.aspx");
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {
                string empNo = Convert.ToString(Session["employeeNo"]);
                String docNo = Request.QueryString["docNo"];
                //String status = Config.ObjNav.FnSubmitSurvey(docNo);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    feedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                //    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                //}
                //else
                //{
                //    feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}