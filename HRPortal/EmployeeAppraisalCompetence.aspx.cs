using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class EmployeeAppraisalCompetence : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void updateKPIsLine_Click(object sender, EventArgs e)
        {
            String tiniative = iniative.Text.Trim();
            String tkpi = kpi.Text.Trim();
            String ttarget = target.Text.Trim();
            Decimal tweight = Convert.ToDecimal(weight.Text.Trim());
            Int32 lineNo = Convert.ToInt32(lineno.Text.Trim());

            try
            {
                String appraisalNo = Request.QueryString["applicationNo"];
                Int32 kpaLineNo = Convert.ToInt32(Request.QueryString["kraLineNo"]);

                String status = Config.ObjNav2.createKPILines(appraisalNo, kpaLineNo, lineNo, tiniative, tkpi, ttarget, tweight);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback1.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    feedback1.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback1.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void myupdateBehaviourLine_Click(object sender, EventArgs e)
        {
            String tmyemployeerating = myemployeerating.Text.Trim();
            String tmyemployeecomment = myemployeecomment.Text.Trim();
            int lineNo = Convert.ToInt32(lineno1.Text.Trim());

            try
            {
                String appraisalNo = Request.QueryString["applicationNo"];
                Int32 categoryLineNo = Convert.ToInt32(Request.QueryString["CategoryLineNo"]);

                String status = Config.ObjNav2.createmyBehaviourLines(appraisalNo, categoryLineNo, lineNo, tmyemployeerating, tmyemployeecomment);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback1.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    feedback1.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback1.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void mySupervisorUpdateBehaviourLine_Click(object sender, EventArgs e)
        {
            String tmysupervisorrating = mysupervisorrating.Text.Trim();
            String tmysupervisorcomment = mysupervisorcomment.Text.Trim();
            Int32 lineNo = Convert.ToInt32(lineno2.Text.Trim());

            try
            {
                String appraisalNo = Request.QueryString["applicationNo"];
                Int32 categoryLineNo = Convert.ToInt32(Request.QueryString["CategoryLineNo"]);

                String status = Config.ObjNav2.createmyLineManagerBehaviourLines(appraisalNo, categoryLineNo, lineNo, tmysupervisorrating, tmysupervisorcomment);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    feedback1.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    feedback1.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback1.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}