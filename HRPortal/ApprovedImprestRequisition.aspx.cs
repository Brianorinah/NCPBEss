using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class ApprovedImprestRequisition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void createImprest_Click(object sender,EventArgs e)
        {
            try
            {
                String docNumber = documentNumber.Text.Trim();
                var nav = Config.ObjNav2;
                String result = nav.createImprestRequest(docNumber);
                String[] safari = result.Split('*');
                if (safari[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-success'>" + safari[0] + safari[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + safari[0] + safari[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception ed)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ed.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
    }
}