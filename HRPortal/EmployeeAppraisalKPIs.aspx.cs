using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRPortal.Models;

namespace HRPortal
{
    public partial class EmployeeAppraisalKPIs : System.Web.UI.Page
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
                    myassessment.DataSource = itms;
                    myassessment.DataTextField = "description";
                    myassessment.DataValueField = "code";
                    myassessment.DataBind();
                    myassessment.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    mysupervisorassessment.DataSource = itms;
                    mysupervisorassessment.DataTextField = "description";
                    mysupervisorassessment.DataValueField = "code";
                    mysupervisorassessment.DataBind();
                    mysupervisorassessment.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    appraiseeselfrating.DataSource = itms;
                    appraiseeselfrating.DataTextField = "description";
                    appraiseeselfrating.DataValueField = "code";
                    appraiseeselfrating.DataBind();
                    appraiseeselfrating.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

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
            Decimal tweight = Convert.ToDecimal( weight.Text.Trim());
           // String tmyappraiseeassesment = myappraiseeassesment.Text.Trim();
            //String tmyappraiseecomments = myappraiseecomments.Text.Trim();
            //String tappraiseeselfrating = appraiseeselfrating.Text.Trim();
            //String temployeecomments = employeecomments.Text.Trim();
            //String tmydisagreement = mydisagreement.Text.Trim();
            //String tmydisagreementcomment = mydisagreementcomment.Text.Trim();
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
            catch(Exception ex)
            {
                feedback1.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void myupdateKPIsLine_Click(object sender, EventArgs e)
        {
            String tmyassessment = myassessment.Text.Trim();
            String tmycomment = mycomment.Text.Trim();
            Int32 lineNo = Convert.ToInt32(lineno8.Text.Trim());

            try
            {
                String appraisalNo = Request.QueryString["applicationNo"];
                Int32 kpaLineNo = Convert.ToInt32(Request.QueryString["kraLineNo"]);

                String status = Config.ObjNav2.createmyKPILines(appraisalNo, kpaLineNo, lineNo, tmyassessment, tmycomment);
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
        protected void mySupervisorUpdateKPIsLine_Click(object sender, EventArgs e)
        {
            String tmysupervisorassessment = mysupervisorassessment.Text.Trim();
            String tmysupervisorcomment = mysupervisorcomment.Text.Trim();
            //String ttarget = target.Text.Trim();
            //Decimal tweight = Convert.ToDecimal(weight.Text.Trim());
            // String tmyappraiseeassesment = myappraiseeassesment.Text.Trim();
            //String tmyappraiseecomments = myappraiseecomments.Text.Trim();
            //String tappraiseeselfrating = appraiseeselfrating.Text.Trim();
            //String temployeecomments = employeecomments.Text.Trim();
            //String tmydisagreement = mydisagreement.Text.Trim();
            //String tmydisagreementcomment = mydisagreementcomment.Text.Trim();
            Int32 lineNo = Convert.ToInt32(lineno.Text.Trim());

            try
            {
                String appraisalNo = Request.QueryString["applicationNo"];
                Int32 kpaLineNo = Convert.ToInt32(Request.QueryString["kraLineNo"]);

                String status = Config.ObjNav2.createLineManagerMyKPILines(appraisalNo, kpaLineNo, lineNo, tmysupervisorassessment, tmysupervisorcomment);
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
        protected void eyupdateKPIsLine_Click(object sender, EventArgs e)
        {
            String tappraiseeselfrating = appraiseeselfrating.Text.Trim();
            String temployeecomment = employeecomment.Text.Trim();
            Int32 lineNo = Convert.ToInt32(lineno3.Text.Trim());

            try
            {
                String appraisalNo = Request.QueryString["applicationNo"];
                Int32 kpaLineNo = Convert.ToInt32(Request.QueryString["kraLineNo"]);

                String status = Config.ObjNav2.createeyKPILines(appraisalNo, kpaLineNo, lineNo, tappraiseeselfrating, temployeecomment);
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
        protected void eyupdateKPIsLineLineManager_Click(object sender, EventArgs e)
        {
            String tappraiserrating = appraiserrating.Text.Trim();
            String teysupervisorcomments = eysupervisorcomments.Text.Trim();
            Int32 lineNo = Convert.ToInt32(lineno5.Text.Trim());

            try
            {
                String appraisalNo = Request.QueryString["applicationNo"];
                Int32 kpaLineNo = Convert.ToInt32(Request.QueryString["kraLineNo"]);

                String status = Config.ObjNav2.createLineManagerEyKPILines(appraisalNo, kpaLineNo, lineNo, tappraiserrating, teysupervisorcomments);
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