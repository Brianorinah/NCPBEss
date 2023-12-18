using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ImprestRequisitionEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                loadRequisition();
            }
        }

        protected void Previous_Click(object sender, EventArgs e)
        {

            var reqNo = "";
            if (Request.QueryString["requisitionNo"] != null)
            {
                reqNo = Request.QueryString["requisitionNo"].ToString();
            }

            Response.Redirect("ImprestRequisitionEdit.aspx?step=1&&requisitionNo=" + reqNo);
           // Response.Redirect("Imprest.aspx?step=5&&imprestNo=" + imprestNo);

        }

        protected void next_Click(object sender, EventArgs e)
        {

            var reqNo = "";
            if (Request.QueryString["requisitionNo"] != null)
            {
                reqNo = Request.QueryString["requisitionNo"].ToString();
            }

            Response.Redirect("ImprestRequisitionEdit.aspx?step=2&&requisitionNo=" + reqNo);
        }

        public void loadRequisition()
        {
            var reqNo = "";
            if(Request.QueryString["requisitionNo"] != null)
            {
                reqNo = Request.QueryString["requisitionNo"].ToString();
            }
            var nav = new Config().ReturnNav();
            //var query = nav.ImprestRequisition.Where(x => x.No == reqNo);

            //foreach(var item in query)
            //{
            //    docNo.Text = item.No;
            //    accountType.Text = item.Account_Type;
            //    accountNo.Text = item.Account_No;
            //    paymentNarration.Text = item.Payment_Narration;
            //    accountName.Text = item.Account_Name;
            //    imprestDeadline.Text = Convert.ToDateTime(item.Imprest_Deadline).ToShortDateString();

            //}
        }

        protected void SendForApproval_Click(object sender, EventArgs e)
        {
            try
            {
                var reqNo = "";
                if (Request.QueryString["requisitionNo"] != null)
                {
                    reqNo = Request.QueryString["requisitionNo"].ToString();
                }
                
                //// Convert.ToString(Session["employeeNo"]),
                //String status = Config.ObjNav.SendImprestRequisitionApproval(Convert.ToString(Session["employeeNo"]),
                //    reqNo);
                //String[] info = status.Split('*');
                //lineFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                lineFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}