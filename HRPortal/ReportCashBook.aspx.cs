using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HRPortal.Models;

namespace HRPortal
{
    public partial class ReportCashBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    var jobs1 = Config.ObjNav1.fnGetBankPostingGroup();
                    List<ItemList> itms1 = new List<ItemList>();
                    string[] infoz1 = jobs1.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoz1.Count() > 0)
                    {
                        foreach (var allInfo in infoz1)
                        {
                            String[] arr = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr[0];
                            mdl.description = arr[0] + "-" + arr[1];
                            itms1.Add(mdl);
                        }
                    }

                    bankAccountPostingGroup.DataSource = itms1;
                    bankAccountPostingGroup.DataTextField = "description";
                    bankAccountPostingGroup.DataValueField = "code";
                    bankAccountPostingGroup.DataBind();
                    bankAccountPostingGroup.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                    var bankAccounts = Config.ObjNav1.fnGetBankAccounts();
                    List<ItemList> itmsBankAccount= new List<ItemList>();
                    string[] infoBankAccounts = bankAccounts.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoBankAccounts.Count() > 0)
                    {
                        foreach (var allInfo in infoBankAccounts)
                        {
                            String[] arr = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr[0];
                            mdl.description = arr[0] + "-" + arr[1];
                            itmsBankAccount.Add(mdl);
                        }
                    }

                    accNo.DataSource = itmsBankAccount;
                    accNo.DataTextField = "description";
                    accNo.DataValueField = "code";
                    accNo.DataBind();
                    accNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                }
                catch (Exception ex)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message +
                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
        }       

        protected void generate_Click(object sender, EventArgs e)
        {
            try
            {
                string empNo = (String)Session["employeeNo"];               
                string taccNo = accNo.SelectedValue.Trim();
                string tbankAccountPostingGroup = bankAccountPostingGroup.SelectedValue.Trim();
                DateTime tdateFilterEnd = new DateTime();
                DateTime tdateFilter = new DateTime();

                if (!string.IsNullOrEmpty(dateFilter.Text.Trim()))
                {
                    tdateFilter = Convert.ToDateTime(dateFilter.Text.Trim());
                }
                if (!string.IsNullOrEmpty(endDate.Text.Trim()))
                {
                    tdateFilterEnd = Convert.ToDateTime(endDate.Text.Trim());
                }
                if (string.IsNullOrEmpty(taccNo))
                {
                    taccNo = "";
                }
                if (string.IsNullOrEmpty(tbankAccountPostingGroup))
                {
                    tbankAccountPostingGroup = "";
                }


                string status = Config.ObjNav2.CashBookReport(taccNo, tbankAccountPostingGroup, tdateFilter, tdateFilterEnd);
                if (status != "danger" && !string.IsNullOrEmpty(status))
                {
                    bool downloaded = ConvertAndDownloadToLocal(status);
                    if (downloaded)
                    {
                        reportViewFrame.Attributes.Add("src", ResolveUrl("~/Downloads/" + string.Format("{0}.pdf", empNo)));
                    }
                    else if (status == "danger")
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>Document could not be found.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>An error occured while generating your document.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>An error ocuured while pulling your document.The provided filter does not have ant data.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message +
                                            "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        public bool ConvertAndDownloadToLocal(string base64String)
        {
            Boolean uploaded = false;
            try
            {

                string employeeNumber = (String)Session["employeeNo"];

                string filesFolder = Server.MapPath("~/Downloads/");
                string fileName = employeeNumber + ".pdf";
                string documentDirectory = filesFolder + "/";
                string filePath = documentDirectory + fileName;

                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }

                byte[] fileBytes = Convert.FromBase64String(base64String);


                using (StreamWriter writer = new StreamWriter(filePath, false))
                {
                    writer.BaseStream.Write(fileBytes, 0, fileBytes.Length);
                }

                return true;


            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., invalid base64 string)
                //TempData["error"] = ex.Message;
                return false;
            }
        }
    }
}