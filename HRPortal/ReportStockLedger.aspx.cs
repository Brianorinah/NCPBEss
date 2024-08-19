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
    public partial class ReportStockLedger : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    var jobs1 = Config.ObjNav1.fnGetLocations();
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

                    locationFilter.DataSource = itms1;
                    locationFilter.DataTextField = "description";
                    locationFilter.DataValueField = "code";
                    locationFilter.DataBind();
                    locationFilter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                    var items = Config.ObjNav1.fnGetItems();
                    List<ItemList> itms= new List<ItemList>();
                    string[] infoItems = items.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoItems.Count() > 0)
                    {
                        foreach (var allInfo in infoItems)
                        {
                            String[] arr = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr[0];
                            mdl.description = arr[0] + "-" + arr[1];
                            itms.Add(mdl);
                        }
                    }

                    accNo.DataSource = itms;
                    accNo.DataTextField = "description";
                    accNo.DataValueField = "code";
                    accNo.DataBind();
                    accNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    accNo1.DataSource = itms;
                    accNo1.DataTextField = "description";
                    accNo1.DataValueField = "code";
                    accNo1.DataBind();
                    accNo1.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    accNo2.DataSource = itms;
                    accNo2.DataTextField = "description";
                    accNo2.DataValueField = "code";
                    accNo2.DataBind();
                    accNo2.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

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
                string taccNo1 = accNo1.SelectedValue.Trim();
                string taccNo2 = accNo2.SelectedValue.Trim();
                string tlocationFilter = locationFilter.SelectedValue.Trim();
                string tfunctionFilter = functionFilter.SelectedValue.Trim();
                string tbudgetCenterFilter = budgetCenterFilter.SelectedValue.Trim();
                DateTime tdateFilter = new DateTime();
                DateTime tdateFilterEnd = new DateTime();
                Boolean tdangeCheckbox = dangeCheckbox.Checked;

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
                if (string.IsNullOrEmpty(taccNo))
                {
                    taccNo = "";
                }
                if (string.IsNullOrEmpty(taccNo1))
                {
                    taccNo1 = "";
                }
                if (string.IsNullOrEmpty(tlocationFilter))
                {
                    tlocationFilter = "";
                }
                if (string.IsNullOrEmpty(tbudgetCenterFilter))
                {
                    tbudgetCenterFilter = "";
                }
                if (string.IsNullOrEmpty(tfunctionFilter))
                {
                    tfunctionFilter = "";
                }

                string status = Config.ObjNav2.StockLedgerReport(taccNo, tlocationFilter, tfunctionFilter, tbudgetCenterFilter, tdateFilter, tdateFilterEnd, tdangeCheckbox, taccNo1, taccNo2);
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
        protected void dangeCheckbox_CheckedChanged(object sender, EventArgs e)
        {
            if (dangeCheckbox.Checked)
            {
                rangeDiv.Visible = true;
                itemDiv.Visible = false;
            }
            else
            {
                rangeDiv.Visible = false;
                itemDiv.Visible = true;
            }
        }
    }
}