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
    public partial class ReportGeneralLedgerStatement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {

                    //var jobs1 = Config.ObjNav1.fnGetBankPostingGroup();
                    //List<ItemList> itms1 = new List<ItemList>();
                    //string[] infoz1 = jobs1.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    //if (infoz1.Count() > 0)
                    //{
                    //    foreach (var allInfo in infoz1)
                    //    {
                    //        String[] arr = allInfo.Split('*');

                    //        ItemList mdl = new ItemList();
                    //        mdl.code = arr[0];
                    //        mdl.description = arr[0] + "-" + arr[1];
                    //        itms1.Add(mdl);
                    //    }
                    //}

                    //bankAccountPostingGroup.DataSource = itms1;
                    //bankAccountPostingGroup.DataTextField = "description";
                    //bankAccountPostingGroup.DataValueField = "code";
                    //bankAccountPostingGroup.DataBind();
                    //bankAccountPostingGroup.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                    var glAccounts = Config.ObjNav1.fnGLAccount();
                    List<ItemList> itmsGLAccount = new List<ItemList>();
                    string[] infoGLAccounts = glAccounts.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoGLAccounts.Count() > 0)
                    {
                        foreach (var allInfo in infoGLAccounts)
                        {
                            String[] arr = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr[0];
                            mdl.description = arr[0] + "-" + arr[1];
                            itmsGLAccount.Add(mdl);
                        }
                    }

                    accNo.DataSource = itmsGLAccount;
                    accNo.DataTextField = "description";
                    accNo.DataValueField = "code";
                    accNo.DataBind();
                    accNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    var functionFilters = Config.ObjNav1.fnGetDimension(1);
                    List<ItemList> allFunctionFilters = new List<ItemList>();
                    string[] infofunctionFilters = functionFilters.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infofunctionFilters.Count() > 0)
                    {
                        foreach (var allInfo in infofunctionFilters)
                        {
                            String[] arr = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr[0];
                            mdl.description = arr[0] + "-" + arr[1];
                            allFunctionFilters.Add(mdl);
                        }
                    }

                    functionFilter.DataSource = allFunctionFilters;
                    functionFilter.DataTextField = "description";
                    functionFilter.DataValueField = "code";
                    functionFilter.DataBind();
                    functionFilter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    var budgetCenterFilters = Config.ObjNav1.fnGetDimension(2);
                    List<ItemList> allbudgetCenterFilters = new List<ItemList>();
                    string[] infobudgetCenterFilters = budgetCenterFilters.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infobudgetCenterFilters.Count() > 0)
                    {
                        foreach (var allInfo in infobudgetCenterFilters)
                        {
                            String[] arr = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr[0];
                            mdl.description = arr[0] + "-" + arr[1];
                            allbudgetCenterFilters.Add(mdl);
                        }
                    }

                    budgetCenterFilter.DataSource = allbudgetCenterFilters;
                    budgetCenterFilter.DataTextField = "description";
                    budgetCenterFilter.DataValueField = "code";
                    budgetCenterFilter.DataBind();
                    budgetCenterFilter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

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
                string tIncOrBalance = IncOrBalance.SelectedValue.Trim();
                string tDebitOrCredit = DebitOrCredit.SelectedValue.Trim();
                string tfunctionFilter = functionFilter.SelectedValue.Trim();
                string tbudgetCenterFilter = budgetCenterFilter.SelectedValue.Trim();
                DateTime tdateFilter = new DateTime();
                int InttIncOrBalance = 10;
                int InttDebitOrCredit = 10;

                if (!string.IsNullOrEmpty(dateFilter.Text.Trim()))
                {
                    tdateFilter = Convert.ToDateTime(dateFilter.Text.Trim());
                }
                if (string.IsNullOrEmpty(taccNo))
                {
                    taccNo = "";
                }
                if (!string.IsNullOrEmpty(tIncOrBalance))
                {
                    InttIncOrBalance = Convert.ToInt16(tIncOrBalance);
                }
                if (!string.IsNullOrEmpty(tDebitOrCredit))
                {
                    InttDebitOrCredit = Convert.ToInt16(tDebitOrCredit);
                }
                if (string.IsNullOrEmpty(tbudgetCenterFilter))
                {
                    tbudgetCenterFilter = "";
                }
                if (string.IsNullOrEmpty(tfunctionFilter))
                {
                    tfunctionFilter = "";
                }

                string status = Config.ObjNav2.GeneralLedgerStatementReport(taccNo, tfunctionFilter, tbudgetCenterFilter, InttIncOrBalance, InttDebitOrCredit, tdateFilter);
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