using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class PettyCashRequisition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Session["pCashNo"] = "PC-" + Session["employeeNo"].ToString();
                var nav = new Config().ReturnNav();

                //var ex = nav.ReceiptAndPaymentTypes.Where(x => x.Type == "Payment").ToList();
                //expenditure.DataSource = ex;
                //expenditure.DataTextField = "Description";
                //expenditure.DataValueField = "Code";
                //expenditure.DataBind();

                var tNo = "";
                if (Request.QueryString["requisitionNo"] != null)
                {
                    tNo = Request.QueryString["requisitionNo"].ToString();

                    var query = nav.Payments.Where(x => x.No == tNo).ToList();
                    foreach (var item in query)
                    {
                        pnarration.Text = item.Payment_Narration;
                    }
                }

                //var expenditureTypes = nav.ReceiptAndPaymentTypes.Where(x => x.Type == "Payment").ToList();
                //editexpenditure.DataSource = expenditureTypes;
                //editexpenditure.DataTextField = "Description";
                //editexpenditure.DataValueField = "Code";
                //editexpenditure.DataBind();
            }
           
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = "";
                Boolean newRequisition = false;
                try
                {

                    requisitionNo = Request.QueryString["requisitionNo"];
                    requisitionNo = requisitionNo.Replace('_', ':');
                    if (String.IsNullOrEmpty(requisitionNo))
                    {
                        requisitionNo = "";
                        newRequisition = true;
                    }
                }
                catch (Exception)
                {

                    newRequisition = true;
                    requisitionNo = "";
                }

                var empNo = Session["employeeNo"].ToString();
                var pcashNo = Session["pCashNo"].ToString();
                string txtnarration = pnarration.Text.Trim();

                //var status = Config.ObjNav.CreateNewPettyCashRequisition(requisitionNo, empNo, pcashNo, txtnarration);
                //string[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    if (newRequisition == true)
                //    {
                //        requisitionNo = info[2];
                //    }
                //    Response.Redirect("PettyCashRequisition.aspx?step=2&&requisitionNo=" + requisitionNo);
                //}
                //else
                //{
                //    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception ex)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void AddLine_Click(object sender, EventArgs e)
        {
            try
            {

                var requisitionNo = Request.QueryString["requisitionNo"];
                var txtexpenditure = expenditure.Text.Trim();
                decimal txtamount = Convert.ToDecimal(amount.Text);
                decimal maxamount = 10000;
                if (txtamount <= maxamount)
                {
                    //var status = Config.ObjNav.AddPettyCashRequisitionLines(requisitionNo, txtexpenditure, txtamount);

                    //string[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    feedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
                    //else
                    //{
                    //    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + "Petty cash requisition must not exceed Ksh. 10,000, kindly try again with a lower amount!" + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void Previous_Click(object sender, EventArgs e)
        {
            var reqNo = "";
            if (Request.QueryString["requisitionNo"] != null)
            {
                reqNo = Request.QueryString["requisitionNo"].ToString();
            }
            Response.Redirect("PettyCashRequisition.aspx?step=1&&requisitionNo=" + reqNo);
        }
        
        protected void RemovePettyCashRequisition_Click(object sender, EventArgs e)
        {
            try
            {
                var id = removeLineNo.Text;
                var docNo = removedocNo.Text;
                //var status = Config.ObjNav.DeletePettyCashRequisitionLines(docNo, Convert.ToInt32(id));
                //string[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    feedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void EditPettyCashRequisition_Click(object sender, EventArgs e)
        {
            try
            {
                var desc = editexpenditure.SelectedValue;
                var id = lineNo.Text;
                var reqNo = docNo.Text;
                var amt = editAmount.Text;
                //var status = Config.ObjNav.EditPettyCashRequisitionLines2(reqNo, Convert.ToInt32(id), desc, Convert.ToDecimal(amt));

                //string[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    feedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //}


            }
            catch (Exception ex)
            {

                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void SendApprovalRequest_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                //requisitionNo = requisitionNo.Replace('_', ':');
                Convert.ToString(Session["employeeNo"]);
                String status = Config.ObjNav.SendPettyCashRequestApproval(Convert.ToString(Session["employeeNo"]),
                    requisitionNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);

                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Petty Cash Voucher/";
            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Staff Claim/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["requisitionNo"];
                            string imprest = imprestNo;
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception ex)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //We could not create a directory for your documents
                            }
                            if (createDirectory)
                            {
                                string filename = documentDirectory + document.FileName;
                                if (File.Exists(filename))
                                {
                                    documentsfeedback.InnerHtml =
                                            "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }
                                else
                                {
                                    document.SaveAs(filename);
                                    if (File.Exists(filename))
                                    {

                                        //Config.navExtender.AddLinkToRecord("Imprest Memo", imprestNo, filename, "");
                                        Config.navExtender.AddLinkToRecord("Petty Cash Voucher", imprest, filename, "");
                                        documentsfeedback.InnerHtml =
                                        "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                    else
                                    {
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                }
                            }
                        }
                        else
                        {
                            documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception ex)
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //The document could not be uploaded
                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
        }

        protected void nextpage_Click(object sender, EventArgs e)
        {
            try
            {

                var reqNo = "";
                if (Request.QueryString["requisitionNo"] != null)
                {
                    reqNo = Request.QueryString["requisitionNo"].ToString();
                }
                var nav = new Config().ReturnNav();
               
                int data = nav.PVLines.Where(x => x.No == reqNo).ToList().Count;
                if(data < 1)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>Kindly enter atleast one item in the petty cash requisition lines.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    Response.Redirect("PettyCashRequisition.aspx?step=3&&requisitionNo=" + reqNo);
                }
            }
            catch(Exception m)
            {

            }
        }

        protected void GoBackStep2_Click(object sender, EventArgs e)
        {
            var reqNo = "";
            if (Request.QueryString["requisitionNo"] != null)
            {
                reqNo = Request.QueryString["requisitionNo"].ToString();
            }
            Response.Redirect("PettyCashRequisition.aspx?step=2&&requisitionNo=" + reqNo);
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Petty Cash Voucher/";
                String imprestNo = Request.QueryString["requisitionNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder + imprestNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        documentsfeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }
    }
}