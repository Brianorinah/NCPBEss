using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ImprestRequisition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 5;
        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                //String requisitionNo = imprestRequisitionToApprove.Text.Trim();
                //// Convert.ToString(Session["employeeNo"]),
                //String status = Config.ObjNav.SendImprestRequisitionApproval(Convert.ToString(Session["employeeNo"]),
                //    requisitionNo);
                //String[] info = status.Split('*');
                //documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void cancelApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String tDocumentNo = cancelImprestRequisitionNo.Text.Trim();
                //String status = Config.ObjNav.CancelRecordApproval(Convert.ToString(Session["employeeNo"]), tDocumentNo, "imprest");
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
                //else
                //{
                //    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //}

            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

    }
}