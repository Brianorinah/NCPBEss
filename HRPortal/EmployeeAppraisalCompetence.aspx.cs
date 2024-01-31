using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRPortal.Models;

namespace HRPortal
{
    public partial class EmployeeAppraisalCompetence : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String job = Config.ObjNav1.fnGetAppraisalRatings();
                List<ItemList> itms = new List<ItemList>();
                String[] allinfo = job.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (allinfo != null)
                {
                    foreach (var oneItem in allinfo)
                    {
                        String[] arr = oneItem.Split('*');
                        ItemList md1 = new ItemList();
                        md1.code = arr[1];
                        md1.description = arr[1];
                        itms.Add(md1);
                    }

                    myemployeerating.DataSource = itms;
                    myemployeerating.DataTextField = "description";
                    myemployeerating.DataValueField = "code";
                    myemployeerating.DataBind();
                    myemployeerating.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    mysupervisorrating.DataSource = itms;
                    mysupervisorrating.DataTextField = "description";
                    mysupervisorrating.DataValueField = "code";
                    mysupervisorrating.DataBind();
                    mysupervisorrating.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    selfrating.DataSource = itms;
                    selfrating.DataTextField = "description";
                    selfrating.DataValueField = "code";
                    selfrating.DataBind();
                    selfrating.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    appraiserrating.DataSource = itms;
                    appraiserrating.DataTextField = "description";
                    appraiserrating.DataValueField = "code";
                    appraiserrating.DataBind();
                    appraiserrating.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                }
            }
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

        protected void eyupdateBehaviourLine_Click(object sender, EventArgs e)
        {
            String tselfrating = selfrating.Text.Trim();
            String tappraiseeremarks = appraiseeremarks.Text.Trim();
            int lineNo = Convert.ToInt32(lineno3.Text.Trim());

            try
            {
                String appraisalNo = Request.QueryString["applicationNo"];
                Int32 categoryLineNo = Convert.ToInt32(Request.QueryString["CategoryLineNo"]);

                String status = Config.ObjNav2.createeyBehaviourLines(appraisalNo, categoryLineNo, lineNo, tselfrating, tappraiseeremarks);
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

        protected void eyLineManagerUpdateBehaviourLine_Click(object sender, EventArgs e)
        {
            String tappraiserrating = appraiserrating.Text.Trim();
            String toverallremarks = overallremarks.Text.Trim();
            int lineNo = Convert.ToInt32(lineno4.Text.Trim());

            try
            {
                String appraisalNo = Request.QueryString["applicationNo"];
                Int32 categoryLineNo = Convert.ToInt32(Request.QueryString["CategoryLineNo"]);

                String status = Config.ObjNav2.createeyLineManagerBehaviourLines(appraisalNo, categoryLineNo, lineNo, tappraiserrating, toverallremarks);
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