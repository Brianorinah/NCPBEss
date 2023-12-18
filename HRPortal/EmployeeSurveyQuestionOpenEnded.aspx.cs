using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class EmployeeSurveyQuestionOpenEnded : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = new Config().ReturnNav();
                string docNo = Request.QueryString["docNo"];
                string sectionCode = Request.QueryString["sectionCode"];
                string questionId = Request.QueryString["questionId"];
                //var res = nav.BRResponseScoreGuide.Where(x => x.Survey_Response_ID == docNo && x.Section_Code == sectionCode && x.Question_ID == questionId);
                //answerdropdown1.DataSource = res;
                //answerdropdown1.DataTextField = "Response_Value";
                //answerdropdown1.DataValueField = "Response_Value";
                //answerdropdown1.DataBind();

                //var ans = nav.BRResponseQuestion.Where(x => x.Survey_Response_ID == docNo && x.Section_Code == sectionCode && x.Question_ID == questionId);
                //foreach (var itm in ans)
                //{
                //    if (itm.Rating_Type == "Open Ended")
                //    {
                //        answer.Text = itm.General_Response_Statement;
                //    }
                //    if (itm.Rating_Type == "Close Ended")
                //    {
                //        answerdropdown1.SelectedValue = itm.Response_Value;
                //    }
                //}
            }
        }

        protected void backtoquestions_Click(object sender, EventArgs e)
        {
            string docNo = Request.QueryString["docNo"];
            string sectionCode = Request.QueryString["sectionCode"];
            string sectionName = Request.QueryString["sectionName"];
            Response.Redirect("EmployeeSurveyQuestion.aspx?docNo=" + docNo + "&&sectionCode=" + sectionCode + "&&sectionName=" + sectionName);
        }

        protected void save_Click(object sender, EventArgs e)
        {
            try
            {
                string docNo = Request.QueryString["docNo"];
                string sectionCode = Request.QueryString["sectionCode"];
                string sectionName = Request.QueryString["sectionName"];
                string ratingType = Request.QueryString["ratingType"];
                string questionId = Request.QueryString["questionId"];
                if (ratingType == "Open Ended")
                {
                    string tanswer = answer.Text.Trim();
                    //String status = Config.ObjNav.FnSaveSurveyOpenEndedQuestion(docNo, sectionCode, questionId, tanswer);
                    //String[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    Response.Redirect("EmployeeSurveyQuestion.aspx?docNo=" + docNo + "&&sectionCode=" + sectionCode + "&&sectionName=" + sectionName);
                    //    //generalFeedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //    //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    //    //"setTimeout(function() { window.location.replace('EmployeeSurveyQuestion.aspx?docNo=') }, 5000);", true);
                    //}
                    //else
                    //{
                    //    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
                }
                if (ratingType == "Close Ended")
                {
                    string nanswer = answerdropdown1.SelectedValue;
                    //String status = Config.ObjNav.FnSaveSurveyClosedEndedQuestion(docNo, sectionCode, questionId, nanswer);
                    //String[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    Response.Redirect("EmployeeSurveyQuestion.aspx?docNo=" + docNo + "&&sectionCode=" + sectionCode + "&&sectionName=" + sectionName);
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
    }
}