﻿using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class payslip : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["active"] = 3;
            //var nav = new Config().ReturnNav();
            if (!IsPostBack)
            {
                //List<PayPeriod> payPeriods = new List<PayPeriod>();
                //var query = nav.payperiods.Where(x => x.Closed == true);
                //foreach (var item in query)
                //{
                //    PayPeriod p = new PayPeriod();
                //    // p.Starting_Date = Convert.ToDateTime( item.Starting_Date).ToString("dd/MM/yyyy");
                //    p.Starting_Date = Convert.ToDateTime(item.Starting_Date).ToString("MM/dd/yyyy");
                //    p.Name = p.Starting_Date + " " + item.Name;
                //    payPeriods.Add(p);

                //}

                //payperiod.DataSource = payPeriods;

                //payperiod.DataValueField = "Starting_Date";
                //payperiod.DataTextField = "Name";
                //payperiod.DataBind();
                //try
                //{
                //    CultureInfo culture = new CultureInfo("ru-RU");
                //    var selecetdPayPeriod = payperiod.SelectedValue;
                //    String status = Config.ObjNav.GeneratePayslip((String)Session["employeeNo"], Convert.ToDateTime(selecetdPayPeriod));
                //    // Convert.ToDateTime(selecetdPayPeriod,culture));
                //    String[] info = status.Split('*');
                //    if (info[0] == "success")
                //    {
                //        payslipFrame.Attributes.Add("src", ResolveUrl(info[2]));
                //    }
                //    else
                //    {
                //        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                //                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //    }
                //}
                //catch (Exception t)
                //{
                //    feedback.InnerHtml = "<div class='alert alert-danger'>Your payslip could not be generated " + t.Message + "</div>";
                //}
            }
        }

        protected void payperiod_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                feedback.InnerHtml = "";
                int tyear = Convert.ToInt32(year.Text.Trim());
                int tmonth = Convert.ToInt32(month.Text.Trim());
                string empNo = (String)Session["employeeNo"];
                //var selecetdPayPeriod = payperiod.SelectedValue;
                //DateTime startDate = Convert.ToDateTime(selecetdPayPeriod);
                //CultureInfo culture = new CultureInfo("ru-RU");
                string status = Config.ObjNav2.generatePayslip(empNo, tyear, tmonth);
                //String status = Config.ObjNav.GeneratePayslip((String)Session["employeeNo"],
                //   startDate);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    payslipFrame.Attributes.Add("src", ResolveUrl(info[2]));
                }
                else
                {
                    feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>Your payslip could not be generated" + t.Message + "</div>";
            }

        }

        //protected void generatePayslip_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        feedback.InnerHtml = "";
        //        var selecetdPayPeriod = payperiod.SelectedValue;
        //        CultureInfo culture = new CultureInfo("ru-RU");
        //        String status = Config.ObjNav.GeneratePayslip((String)Session["employeeNo"],
        //           Convert.ToDateTime(selecetdPayPeriod));
        //        String[] info = status.Split('*');
        //        if (info[0] == "success")
        //        {
        //            payslipFrame.Attributes.Add("src", ResolveUrl(info[2]));
        //        }
        //        else
        //        {
        //            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
        //                                 "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //    }
        //    catch (Exception t)
        //    {
        //        feedback.InnerHtml = "<div class='alert alert-danger'>Your payslip could not be generated" + t.Message + "</div>";
        //    }

        //}
    }
}