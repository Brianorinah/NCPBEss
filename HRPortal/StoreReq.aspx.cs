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
    public partial class StoreReq : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var nav = new Config().ReturnNav();

            //var jobs = Config.ObjNav1.fnGetItems();
            //List<ItemList> itms = new List<ItemList>();
            //string[] infoz = jobs.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
            //if (infoz.Count() > 0)
            //{
            //    foreach (var allInfo in infoz)
            //    {
            //        String[] arr = allInfo.Split('*');

            //        ItemList mdl = new ItemList();
            //        mdl.code = arr[0];
            //        mdl.description = arr[1] + "--" + arr[2] + "--" + arr[3] + "--" + arr[4] + "--" + arr[5] + "--" + arr[6] + "--" + arr[7];
            //        itms.Add(mdl);

            //    }
            //}

            if (!IsPostBack)
            {
                //datereq.Text = Convert.ToDateTime(DateTime.Now).ToString("dd/MM/yyyy");
                
                try
                {
                    var jobs = Config.ObjNav1.fnGetItems();
                    List <ItemList> itms = new List<ItemList>();
                    string[] infoz = jobs.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoz.Count() > 0)
                    {
                        foreach (var allInfo in infoz)
                        {
                            String[] arr = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr[0];
                            mdl.description = arr[1] + "--" + arr[2] + "--" + arr[3] + "--" + arr[4] + "--" + arr[5] + "--" + arr[6] + "--" + arr[7];
                            itms.Add(mdl);

                        }
                    }

                    item.DataSource = itms;
                    item.DataTextField = "description";
                    item.DataValueField = "code";
                    item.DataBind();
                    item.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                    item.Items.Insert(1, new System.Web.UI.WebControls.ListItem("Decription--PartNo--Alt ItemNo --Alt PartNo1 --Alt PartNo2--Alt PartNo3--Alt PartNo4", ""));

                    String requisitionNo = Request.QueryString["requisitionNo"];
                    String employeeNo = Convert.ToString(Session["employeeNo"]);
                    

                    if (!string.IsNullOrEmpty(requisitionNo))
                    {
                        var request = Config.ObjNav1.fnStoreRequisitionsSingle(employeeNo, requisitionNo);
                        String[] info = request.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info != null)
                        {
                            foreach (var allinfo in info)
                            {
                                String[] arr = allinfo.Split('*');                                
                                description.Text = arr[4];

                            }
                        }
                    }
                }
                catch (Exception)
                {

                }
                int step = 1;
                try
                {
                    step = Convert.ToInt32(Request.QueryString["step"]);
                    if (step > 2 || step < 1)
                    {
                        step = 1;
                    }
                }
                catch (Exception)
                {
                    step = 1;
                }
                if (step == 2)
                {
                    //var items = nav.Items;
                    //item.DataSource = items;
                    //item.DataValueField = "No";
                    //item.DataTextField = "Description";
                    //item.DataBind();

                }

                //var um = nav.UnitofMeasure;
                //uom.DataSource = um;
                //uom.DataTextField = "Description";
                //uom.DataValueField = "Code";
                //uom.DataBind();
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

                string ndesc = description.Text.Trim();
                DateTime tdatereq = Convert.ToDateTime(datereq.Text.Trim());
                String employeeNo = Convert.ToString(Session["employeeNo"]);

                String status = Config.ObjNav2.createStoreRequisition(employeeNo, requisitionNo, ndesc, "", tdatereq,"","","");
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newRequisition)
                    {
                        requisitionNo = info[2];
                    }
                    String redirectLocation = "StoreReq.aspx?step=2&&requisitionNo=" + requisitionNo;
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

        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StoreReq.aspx?step=1&&requisitionNo=" + requisitionNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                // Convert.ToString(Session["employeeNo"]),
                String status = Config.ObjNav.SendPurchaseRequisitionApproval(Convert.ToString(Session["employeeNo"]),
                    requisitionNo);
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

        protected void deleteLine_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    String employeeName = Convert.ToString(Session["employeeNo"]);
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    String status = Config.ObjNav.DeleteRequisitionLine(employeeName, requisitionNo, tLineNo, 6);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void addItem_Click(object sender, EventArgs e)
        {
            try
            {
                String tItem = item.SelectedValue.Trim();
                String tQuantity = quantityRequested.Text.Trim();
                int nQuantity = 0;
                Boolean error = false;
                try
                {
                    nQuantity = Convert.ToInt16(tQuantity);
                }
                catch (Exception)
                {
                    error = true;
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>Please enter a correct value for quantity<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

                if (!error)
                {
                    String requisitionNo = Request.QueryString["requisitionNo"];
                    string tuom = uom.SelectedValue;
                   
                    String status = Config.ObjNav2.createStoreRequisitionLine(requisitionNo, "", tItem, nQuantity);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Store Requisition/";

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
                            catch (Exception)
                            {
                                createDirectory = false;
                                documentsfeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }


        }
        protected void deleteFile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Non-Project Store Requisition/";
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

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            String itemcategory = Request.QueryString["itemcategory"];
            Response.Redirect("StoreReq.aspx?step=3&&requisitionNo=" + requisitionNo + "&&itemcategory=" + itemcategory);
        }

        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            String itemcategory = Request.QueryString["itemcategory"];
            Response.Redirect("StoreReq.aspx?step=2&&requisitionNo=" + requisitionNo + "&&itemcategory=" + itemcategory);
        }

        protected void print_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("StoreReqPrintOut.aspx?docNo=" + requisitionNo);
        }

        protected void item_SelectedIndexChanged(object sender, EventArgs e)
        {
            string itmNo = item.SelectedValue;
            var nav = new Config().ReturnNav();
            var allitems = nav.Items.Where(x => x.No == itmNo).ToList();
            foreach(var it in allitems)
            {
                inventory.Text = Convert.ToString(it.Indirect_Cost);
                unitofmeasure.Text = it.Base_Unit_of_Measure;
            }
        }
    }
}