﻿using HRPortal.Models;
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
    public partial class StaffCreditSales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                string empNo = Convert.ToString(Session["employeeNo"]);

                var reg = Config.ObjNav1.fnGetRegionAndBudgetCenters(empNo);
                string[] inf = reg.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (inf.Count() > 0)
                {
                    foreach (var allin in inf)
                    {
                        string[] arr10 =allin.Split('*');
                        string regionCode = arr10[0];
                        string budgetCode = arr10[1];
                        region.Text = arr10[0];
                        budget.Text = arr10[1];
                
                var depot = Config.ObjNav1.fnGetDepotInfo(regionCode,budgetCode);
                List<ItemList> lctz = new List<ItemList>();
                string[] infz = depot.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (infz.Count() > 0)
                {
                    foreach (var allinfo in infz)
                    {
                        string[] arr = allinfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[0]+ "-" + arr[1];
                        lctz.Add(mdl);
                                

                            }
                }

                DepotCode.DataSource = lctz;
                DepotCode.DataTextField = "description";
                DepotCode.DataValueField = "code";
                DepotCode.DataBind();
                DepotCode.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                    }
                }

                var period = Config.ObjNav1.fnGetPayrollPeriods();
                List<ItemList> im = new List<ItemList>();
                string[] info = period.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (info.Count() > 0)
                {
                    foreach (var allinfo in info)
                    {
                        string[] arr = allinfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[0];
                        im.Add(mdl);
                     

                    }
                }

                RecoveryCode.DataSource = im;
                RecoveryCode.DataTextField = "description";
                RecoveryCode.DataValueField = "code";
                RecoveryCode.DataBind();
                RecoveryCode.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                

                var product = Config.ObjNav1.fnGetProductCodes();
            
                List<ItemList> itmprdd = new List<ItemList>();
                string[] infoprd = product.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                if (info.Count() > 0)
                {
                    foreach (var allinfo in infoprd)
                    {
                        string[] arr = allinfo.Split('*');

                        ItemList mdl = new ItemList();
                        mdl.code = arr[0];
                        mdl.description = arr[0] + "-" + arr[1] + "-" +arr[2] + "-" +arr[3];
                        itmprdd.Add(mdl);

                    }
                }

                ProductCode.DataSource = itmprdd;
                ProductCode.DataTextField = "description";
                ProductCode.DataValueField = "code";
                ProductCode.DataBind();
                ProductCode.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                String documentNo = Request.QueryString["documentNo"];
                if (!string.IsNullOrEmpty(documentNo))
                {
                    String credit = Config.ObjNav1.fnGetStaffCreditSalesHeader(documentNo);
                    String[] allInfo = credit.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (allInfo != null)
                    {
                        foreach (var item in allInfo)
                        {
                            String[] oneItem = item.Split('*');
                            currentBalance.Text = oneItem[3];
                            total.Text = oneItem[5];

                        }
                    }
                    DocumentDate.Text = DateTime.Now.ToString("MM-dd-yyyy");
                    UnitPrice.Text = "0.00"; 
            


                }
                


            }
        }
     
        protected void depot_SelectedIndexChanged(object sender, EventArgs e)
        {

            string regCodes = region.Text.Trim();
            string locateCodes = DepotCode.Text.Trim();
            string budgetCodes = budget.Text.Trim();
            var locate = Config.ObjNav1.fnGetStoreCode(regCodes,budgetCodes,locateCodes);
            List<ItemList> itms1 = new List<ItemList>();
            string[] infoz1 = locate.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
            if (infoz1.Count() > 0)
            {
                foreach (var allinfo in infoz1)
                {
                    string[] arr = allinfo.Split('*');

                    ItemList mdl = new ItemList();
                    mdl.code = arr[0];
                    mdl.description = arr[3];
                    itms1.Add(mdl);

                }
            }
            LocationCode.DataSource = itms1;
            LocationCode.DataTextField = "description";
            LocationCode.DataValueField = "code";
            LocationCode.DataBind();
            LocationCode.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


            }
        protected void product_SelectedIndexChanged(object sender, EventArgs e)
        {


            var nav = Config.ObjNav1;
            var result = nav.fnGetProductDetails(ProductCode.Text.Trim());
            String[] info = result.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
            if (info.Count() > 0)
            {
                if (info != null)
                {
                    foreach (var allinfo in info)
                    {
                        String[] arr = allinfo.Split('*');
                        ProductDescription.Text = arr[1];
                        measure.Text = arr[2];
                        UnitPrice.Text = arr[3];
                    }
                }
            }
        }

        protected void apply_Click(object sender, EventArgs e)
        {
            try
            {
                String employeeNo = Convert.ToString(Session["employeeNo"]);
                string trecovery = RecoveryCode.Text.Trim();
                string tlocation = LocationCode.Text.Trim();
                string tdepot = DepotCode.Text.Trim();
                string documentNo = "";
                Boolean newCreditSale = false;
                try
                { 
                    if (String.IsNullOrEmpty(documentNo))
                    {
                        documentNo = "";
                        newCreditSale = true;
                    }
                }
                catch (Exception)
                {
                    newCreditSale = true;
                    documentNo = "";
                }
                String status = Config.ObjNav2.fnCreateSalesCreditHeader(documentNo, employeeNo, trecovery,tdepot, tlocation);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newCreditSale)
                    {
                        documentNo = info[2];
                    }
                    String redirectLocation = "StaffCreditSales.aspx?step=2&&documentNo=" + documentNo;
                    Response.Redirect(redirectLocation, false);

                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void addItem_Click(object sender, EventArgs e)
        {
            try
            {
                String documentNo = Request.QueryString["documentNo"];
                string productCode = ProductCode.Text.Trim();
                decimal quant = Convert.ToDecimal(quantity.Text.Trim());

                String status = Config.ObjNav2.fnCreateStaffCreditLines(documentNo, productCode, quant);
                String[] info = status.Split('*');
                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            String documentNo = Request.QueryString["documentNo"];
            Response.Redirect("StaffCreditSales.aspx?step=3&&documentNo=" + documentNo);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String documentNo = Request.QueryString["documentNo"];
            Response.Redirect("StaffCreditSales.aspx?step=2&&documentNo=" + documentNo);
        }
        protected void previous_Click(object sender, EventArgs e)
        {
            String documentNo = Request.QueryString["documentNo"];
            Response.Redirect("StaffCreditSales.aspx?step=1&&documentNo=" + documentNo);
        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String documentNo = Request.QueryString["documentNo"];
                String status = Config.ObjNav2.sendStaffCreditSaleApproval(documentNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void createSales(object sender, EventArgs e)
        {
            try
            {
                String documentNo = Request.QueryString["documentNo"];
                String status = Config.ObjNav2.CreateSalesOrder(documentNo);
                String[] info = status.Split('*');
                documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
            }
            catch (Exception t)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }


    }
}