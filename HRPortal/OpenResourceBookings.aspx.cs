using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class OpenResourceBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cancelapproval_Click(object sender, EventArgs e)
        {
            try
            {
                String ResourceNo = cancelImprestRequisitionNo.Text.Trim();
                //String status = Config.ObjNav.FnCancelResourceForApproval(ResourceNo, Convert.ToString(Session["employeeNo"]));
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
                //else
                //{
                //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}

            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void sendapproval_Click(object sender, EventArgs e)
        {
            try
            {
                String ResourceNo = imprestRequisitionToApprove.Text.Trim();
                //String status = Config.ObjNav.FnSendResourceForApproval(ResourceNo, Convert.ToString(Session["employeeNo"]));
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
                //else
                //{
                //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}

            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}