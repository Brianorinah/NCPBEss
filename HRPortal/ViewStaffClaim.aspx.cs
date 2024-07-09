using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ViewStaffClaim : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String userName = Session["username"].ToString().ToUpper();

                String jobs = Config.ObjNav1.fnGetUser1(userName);
                List<ItemList> itms = new List<ItemList>();
                string[] infoz = jobs.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infoz.Count() > 0)
                {
                    foreach (var allInfo in infoz)
                    {
                        String[] arr = allInfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[0];
                        itms.Add(mdl);
                    }
                }

                seleceteduser.DataSource = itms;
                seleceteduser.DataTextField = "description";
                seleceteduser.DataValueField = "code";
                seleceteduser.DataBind();
                seleceteduser.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                string docNo = Request.QueryString["docNo"].Trim();

                if (!string.IsNullOrEmpty(docNo))
                {
                    var request = Config.ObjNav1.fnGetStaffClaimIndividual(docNo);
                    String[] info = request.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (info != null)
                    {
                        foreach (var allinfo in info)
                        {
                            String[] arr = allinfo.Split('*');
                            empName.Text = arr[0];
                            safariNumber.Text = arr[1];
                            functionCode.Text = arr[3];                            
                        }
                    }
                }

            }
        }
        protected void approvalRequestClick(object sender, EventArgs e)
        {
            try
            {
                String tDocumentNo = approveDocumentNo.Text.Trim();
                String tDocType = doctype.Text.Trim();
                int tApprovalLevel = Convert.ToInt32(approvallevel.Text.Trim());
                string username = (String)Session["username"];
                String status = Config.ObjNav2.Approve(tDocumentNo, tDocType, tApprovalLevel, username.ToUpper());
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
        protected void rejectRequestClick(object sender, EventArgs e)
        {
            try
            {
                String tDocumentNo = rejectDocumentNo.Text.Trim();
                String tDocType = doctype1.Text.Trim();
                int tApprovalLevel = Convert.ToInt32(approvallevel1.Text.Trim());
                string approverComment = comment.Text.Trim();
                string username = Session["username"].ToString().ToUpper();
                //String status = Config.ObjNav.fnRejectRequest(tDocumentNo,username, approverComment);
                String status = Config.ObjNav2.Reject(tDocumentNo, tDocType, tApprovalLevel, username, approverComment);
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

        protected void delegateRequestClick(object sender, EventArgs e)
        {
            try
            {
                String tDocumentNo = delegateDocumentNo.Text.Trim();
                String tDocType = doctype2.Text.Trim();
                int tApprovalLevel = Convert.ToInt32(approvallevel2.Text.Trim());
                String tSelectedUser = seleceteduser.Text.Trim();
                string username = (String)Session["username"].ToString().ToUpper();
                String status = Config.ObjNav2._Delegate(tDocumentNo, tDocType, tApprovalLevel, username, tSelectedUser);
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
        protected void Unnamed10_Click(object sender, EventArgs e)
        {
            Response.Redirect("RequestToApprove.aspx");
        }
    }
}