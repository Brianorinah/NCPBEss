using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class SecurityIncident : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                datereported.Text = Convert.ToDateTime(DateTime.Now).ToString("dd/MM/yyyy");
                timereported.Text = Convert.ToDateTime(DateTime.Now).ToString("HH:mm tt");

                //var nav = new Config().ReturnNav();
                //var IT = nav.IncidentTypes.ToList();
                //incidenttype.DataSource = IT;
                //incidenttype.DataValueField = "Code";
                //incidenttype.DataTextField = "Description";
                //incidenttype.DataBind();

                //var CS = nav.CompanyStakeholders.ToList();
                //partyinvolved.DataSource = CS;
                //partyinvolved.DataValueField = "No";
                //partyinvolved.DataTextField = "Name";
                //partyinvolved.DataBind();
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            try
            {
                string docNo = "";
                string empNo = Session["employeeNo"].ToString();
                string nseveritylevel = severitylevel.SelectedValue.Trim();
                int txtseveritylevel = 0;
                if (nseveritylevel == "Minor")
                {
                    txtseveritylevel = 1;
                }
                if (nseveritylevel == "Major")
                {
                    txtseveritylevel = 2;
                }
                if (nseveritylevel == "Critical")
                {
                    txtseveritylevel = 3;
                }
                string txtincidenttype = incidenttype.SelectedValue.Trim();
                string txtpartyinvolved = partyinvolved.SelectedValue.Trim();
                string txtdescription = description.Text.Trim();
                string ndatereported = datereported.Text.Trim();
                DateTime txtdatereported = new DateTime();
                try
                {
                    txtdatereported = DateTime.ParseExact(ndatereported, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                }
                string ntimereported = timereported.Text.Trim();
                DateTime txttimereported = new DateTime();
                try
                {
                    txttimereported = DateTime.ParseExact(ntimereported, "HH:mm tt", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                }
                string ndateoccured = tr_StartDate.Text.Trim();
                DateTime txtdateoccured = new DateTime();
                try
                {
                    txtdateoccured = DateTime.ParseExact(ndateoccured, "d/M/yyyy", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                }
                string ntimeoccured = timeoccured.Text.Trim();
                DateTime txttimeoccured = new DateTime();
                try
                {
                    txttimeoccured = DateTime.ParseExact(ntimeoccured, "HH:mm tt", CultureInfo.InvariantCulture);
                }
                catch (Exception)
                {
                }

                //String status = Config.ObjNav.FnReportIncident(docNo, empNo, txtseveritylevel, txtincidenttype, txtdatereported, txttimereported,
                //    txtdateoccured, txttimeoccured, txtpartyinvolved, txtdescription);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    generalFeedback.InnerHtml = "<div class='alert alert-info'>" + info[1] + " on " + Convert.ToDateTime(DateTime.Now).ToString("dd/MM/yyyy") + " at " + Convert.ToDateTime(DateTime.Now).ToString("h:mm:ss tt") + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS",
                //    "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                //}
                //else
                //{
                //    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void incidenttype_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selValue = incidenttype.SelectedValue;
            if (selValue == "OTHER")
            {
                divsincidenttype.Visible = true;
            }
            else
            {
                divsincidenttype.Visible = false;
            }
        }

        protected void partyinvolved_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selValue = partyinvolved.SelectedValue;
            if (selValue == "STAKE0003")
            {
                partyinvolved.Visible = true;
            }
            else
            {
                partyinvolved.Visible = false;
            }
        }
    }
}