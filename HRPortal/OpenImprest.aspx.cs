using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class OpenImprest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void sendApproval_Click1(object sender, EventArgs e)
        {
            //try
            //{
            //    String requisitionNo = Request.QueryString["imprestNo"];
            //    // Convert.ToString(Session["employeeNo"]),
            //    String status = Config.ObjNav2.sendImprestApplicationApproval(requisitionNo);
            //    String[] info = status.Split('*');
            //    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
            //    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
            //}
            //catch (Exception t)
            //{
            //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                string approveNo = imprestMemoToApprove.Text.Trim();
                string userName = Convert.ToString(Session["username"]).ToUpper();
                String status = Config.ObjNav2.sendImprestApplicationApproval(approveNo);
                String[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void cancelApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String tDocumentNo = cancelImprestMemoNo.Text.Trim();
                String status = Config.ObjNav2.CancelImprestApproval(tDocumentNo);
                String[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}