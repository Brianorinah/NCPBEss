﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class OpenStandingImprestSurrender : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 5;
        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                //Convert.ToString(Session["employeeNo"])
                String imprestNo = imprestMemoToApprove.Text.Trim();
                //String status = Config.ObjNav.SendStandingImprestSurrenderApproval(Convert.ToString(Session["employeeNo"]), imprestNo);
                //String[] info = status.Split('*');
                //feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void cancelApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String tDocumentNo = cancelImprestMemoNo.Text.Trim();
                //String status = Config.ObjNav.CancelStandingImprestSurrenderApproval((String)Session["employeeNo"], tDocumentNo);
                //String[] info = status.Split('*');
                //feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                //                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}