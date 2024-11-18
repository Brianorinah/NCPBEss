using HRPortal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRPortal
{
    public partial class SafariRequest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int step = 1;
                try
                {
                    step = Convert.ToInt32(Request.QueryString["step"]);
                    if (step > 4 || step < 1)
                    {
                        step = 1;
                    }
                }
                catch (Exception)
                {
                    step = 1;
                }
                if (step == 1)
                {
                    var jobs1 = Config.ObjNav1.fnGetDimension(1);
                    List<ItemList> itms1 = new List<ItemList>();
                    string[] infoz1 = jobs1.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoz1.Count() > 0)
                    {
                        foreach (var allInfo in infoz1)
                        {
                            String[] arr1 = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr1[0];
                            mdl.description = arr1[0]+" - "+arr1[1];
                            itms1.Add(mdl);

                        }
                    }

                    functionCode.DataSource = itms1;
                    functionCode.DataTextField = "description";
                    functionCode.DataValueField = "code";
                    functionCode.DataBind();
                    functionCode.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    var jobs17 = Config.ObjNav1.fnGetDimension(2);
                    List<ItemList> itms17 = new List<ItemList>();
                    string[] infoz17 = jobs17.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoz17.Count() > 0)
                    {
                        foreach (var allInfo in infoz17)
                        {
                            String[] arr2 = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr2[0];
                            mdl.description = arr2[0]+" - "+ arr2[1];
                            itms17.Add(mdl);

                        }
                    }

                    bgtCenterCode.DataSource = itms17;
                    bgtCenterCode.DataTextField = "description";
                    bgtCenterCode.DataValueField = "code";
                    bgtCenterCode.DataBind();
                    bgtCenterCode.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    //Get safari request details
                    string cultureVariant = "en-US";
                    String appNo = Request.QueryString["requisitionNo"];
                    if (!String.IsNullOrEmpty(appNo))
                    {
                        var job18 = Config.ObjNav1.fnGetSafariApplicationDetails(appNo);

                        String[] arr = job18.Split('*');

                        exptTravelDate.Text = arr[0];
                        exptReturnDate.Text = arr[1];
                        functionCode.Text = arr[3];
                        bgtCenterCode.Text = arr[4];
                        purpose.Text = arr[5];
                        //DateTime dateVariable = DateTime.ParseExact(arr[0], "dd-MM-yyyy", CultureInfo.GetCultureInfo(cultureVariant));
                        //exptTravelDate.Text = Convert.ToString(dateVariable);

                        if (arr[2] == "Personal Vehicle")
                        {
                            transMode.SelectedValue = "0";
                        }
                        if (arr[2] == "Company Vehicle")
                        {
                            transMode.SelectedValue = "1";
                        }
                        if (arr[2] == "Public Transport 1st Class")
                        {
                            transMode.SelectedValue = "2";
                        }
                        if (arr[2] == "Public Transport Business")
                        {
                            transMode.SelectedValue = "3";
                        }
                        else if (arr[2] == "Public Transport Economy")
                        {
                            transMode.SelectedValue = "4";
                        }
                    }
                    
                }
                if (step == 2)
                {
                    var jobs118 = Config.ObjNav1.fnGetTowns();
                    List<ItemList> itms118 = new List<ItemList>();
                    string[] infoz118 = jobs118.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoz118.Count() > 0)
                    {
                        foreach (var allInfo in infoz118)
                        {
                            String[] arr = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr[0];
                            mdl.description = arr[1];
                            itms118.Add(mdl);

                        }
                    }

                    travelFrom.DataSource = itms118;
                    travelFrom.DataTextField = "description";
                    travelFrom.DataValueField = "code";
                    travelFrom.DataBind();
                    travelFrom.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    travelTo.DataSource = itms118;
                    travelTo.DataTextField = "description";
                    travelTo.DataValueField = "code";
                    travelTo.DataBind();
                    travelTo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    ContentPlaceHolder1_travelFrom.DataSource = itms118;
                    ContentPlaceHolder1_travelFrom.DataTextField = "description";
                    ContentPlaceHolder1_travelFrom.DataValueField = "code";
                    ContentPlaceHolder1_travelFrom.DataBind();
                    ContentPlaceHolder1_travelFrom.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    ContentPlaceHolder1_travelTo.DataSource = itms118;
                    ContentPlaceHolder1_travelTo.DataTextField = "description";
                    ContentPlaceHolder1_travelTo.DataValueField = "code";
                    ContentPlaceHolder1_travelTo.DataBind();
                    ContentPlaceHolder1_travelTo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                }
                else if (step == 3)
                {
                    var jobs11 = Config.ObjNav1.fnGetSafariEntitlements();
                    List<ItemList> itms11 = new List<ItemList>();
                    string[] infoz11 = jobs11.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoz11.Count() > 0)
                    {
                        foreach (var allInfo in infoz11)
                        {
                            String[] arr = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr[0];
                            mdl.description = arr[0]+" - "+ arr[1];
                            itms11.Add(mdl);

                        }
                    }

                    entitlement.DataSource = itms11;
                    entitlement.DataTextField = "description";
                    entitlement.DataValueField = "code";
                    entitlement.DataBind();
                    entitlement.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    entitlement1.DataSource = itms11;
                    entitlement1.DataTextField = "description";
                    entitlement1.DataValueField = "code";
                    entitlement1.DataBind();
                    entitlement1.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    var jobs1 = Config.ObjNav1.fnGetDimension(1);
                    List<ItemList> itms1 = new List<ItemList>();
                    string[] infoz1 = jobs1.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoz1.Count() > 0)
                    {
                        foreach (var allInfo in infoz1)
                        {
                            String[] arr1 = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr1[0];
                            mdl.description = arr1[0] + " - " + arr1[1];
                            itms1.Add(mdl);

                        }
                    }

                    functionCode1.DataSource = itms1;
                    functionCode1.DataTextField = "description";
                    functionCode1.DataValueField = "code";
                    functionCode1.DataBind();
                    functionCode1.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    var jobs17 = Config.ObjNav1.fnGetDimension(2);
                    List<ItemList> itms17 = new List<ItemList>();
                    string[] infoz17 = jobs17.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    if (infoz17.Count() > 0)
                    {
                        foreach (var allInfo in infoz17)
                        {
                            String[] arr2 = allInfo.Split('*');

                            ItemList mdl = new ItemList();
                            mdl.code = arr2[0];
                            mdl.description = arr2[0] + " - " + arr2[1];
                            itms17.Add(mdl);

                        }
                    }

                    bgtCenterCode1.DataSource = itms17;
                    bgtCenterCode1.DataTextField = "description";
                    bgtCenterCode1.DataValueField = "code";
                    bgtCenterCode1.DataBind();
                    bgtCenterCode1.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                    //var glAccounts = Config.ObjNav1.fnGLAccount();
                    //List<ItemList> itmsGLAccount = new List<ItemList>();
                    //string[] infoGLAccounts = glAccounts.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                    //if (infoGLAccounts.Count() > 0)
                    //{
                    //    foreach (var allInfo in infoGLAccounts)
                    //    {
                    //        String[] arr = allInfo.Split('*');

                    //        ItemList mdl = new ItemList();
                    //        mdl.code = arr[0];
                    //        mdl.description = arr[0] + "-" + arr[1];
                    //        itmsGLAccount.Add(mdl);
                    //    }
                    //}

                    //glAccount.DataSource = itmsGLAccount;
                    //glAccount.DataTextField = "description";
                    //glAccount.DataValueField = "code";
                    //glAccount.DataBind();
                    //glAccount.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                }

            }

        }
        protected void next_Click(object sender, EventArgs e)
        {
            try
            {                
                
                DateTime texptTravelDate = Convert.ToDateTime(exptTravelDate.Text.Trim());
                DateTime texptReturnDate = Convert.ToDateTime(exptReturnDate.Text.Trim());
                int ttransMode = Convert.ToInt16(transMode.SelectedValue.Trim());
                string tbgtCenterCode = bgtCenterCode.SelectedValue.Trim();
                string tfunctionCode = functionCode.SelectedValue.Trim();
                string tpurpose = purpose.Text.Trim();


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

                String employeeNo = Convert.ToString(Session["employeeNo"]);
                String userName = Convert.ToString(Session["username"]).ToString().ToUpper(); 
                String status = Config.ObjNav2.createSafariRequestHeader(requisitionNo, employeeNo, texptTravelDate, texptTravelDate, ttransMode, tfunctionCode, tbgtCenterCode, tpurpose,userName);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newRequisition)
                    {
                        requisitionNo = info[2];
                    }
                    String redirectLocation = "SafariRequest.aspx?step=2&&requisitionNo=" + requisitionNo;
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
                string requisitionNo = Request.QueryString["requisitionNo"];
                DateTime texpencDate = Convert.ToDateTime(expencDate.Text.Trim());
                DateTime treturnDate = Convert.ToDateTime(returnDate.Text.Trim());
                string ttravelFrom = travelFrom.SelectedValue.Trim();
                string ttravelTo = travelTo.SelectedValue.Trim();                


                String status = Config.ObjNav2.createSafariRequestLines(requisitionNo, texpencDate, treturnDate, ttravelFrom, ttravelTo);
                String[] info = status.Split('*');

                linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void addItem1_Click(object sender, EventArgs e)
        {
            try
            {
                string requisitionNo = Request.QueryString["requisitionNo"];                

                string tentitlement = entitlement.SelectedValue.Trim();
                string tbgtCenterCode = bgtCenterCode1.SelectedValue.Trim();
                string tfunctionCode = functionCode1.SelectedValue.Trim();
                //string tglAccount = glAccount.SelectedValue.Trim();

                decimal trate = Convert.ToDecimal(rate.Text.Trim());
                int tquantity = Convert.ToInt16(quantity.Text.Trim());
                string ttown = town.Text.Trim();


                String status = Config.ObjNav2.createSafariRequestEntitlements(requisitionNo, tentitlement, tquantity, trate, ttown, tfunctionCode, tbgtCenterCode);
                String[] info = status.Split('*');

                linesFeedback1.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            catch (Exception n)
            {
                linesFeedback1.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void Unnamed3_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("SafariRequest.aspx?step=3&&requisitionNo=" + requisitionNo);
        }
        protected void Unnamed2_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("SafariRequest.aspx?step=4&&requisitionNo=" + requisitionNo);
        }
        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("SafariRequest.aspx?step=3&&requisitionNo=" + requisitionNo);
        }
        protected void previous_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("SafariRequest.aspx?step=1&&requisitionNo=" + requisitionNo);
        }
        protected void previous1_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["requisitionNo"];
            Response.Redirect("SafariRequest.aspx?step=2&&requisitionNo=" + requisitionNo);
        }
        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["requisitionNo"];
                String userName = Convert.ToString(Session["username"]).ToUpper();
                // Convert.ToString(Session["employeeNo"]),
                String status = Config.ObjNav2.sendSafariRequestApplicationApproval(requisitionNo,userName);
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
        protected void uploadDocument_Click(object sender, EventArgs e)
        {

            String filesFolder = "~"+ConfigurationManager.AppSettings["FileFolderApplication"] +"/"+ "Safari Request/";

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

        protected void uploadDocument_Click1(object sender, EventArgs e)
        {
            
            String filesFolder = Server.MapPath("~/downloads/Safari Request/");

            if (document.HasFile)
            {
                try
                {

                    if (Directory.Exists(filesFolder))
                    {

                        String imprestNo = Request.QueryString["requisitionNo"];
                        string extension = System.IO.Path.GetExtension(document.FileName);
                        //string filename1 = imprestNo + extension;
                        if (new Config().IsAllowedExtension(extension))
                        {
                            imprestNo = imprestNo.Replace('/', '_');
                            imprestNo = imprestNo.Replace(':', '_');
                            String documentDirectory = filesFolder + imprestNo;
                            Boolean createDirectory = true;
                            try
                            {
                                //string fullPath = documentDirectory + document.FileName;

                                //if (System.IO.File.Exists(fullPath))
                                //{
                                //    System.IO.File.Delete(fullPath);
                                //}


                                //document.PostedFile.SaveAs(fullPath);

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
                            string filename = documentDirectory+"\\" + document.FileName;
                            if (File.Exists(filename))
                            {
                                documentsfeedback.InnerHtml =
                                                                   "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                            else
                            {
                                document.PostedFile.SaveAs(filename);
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
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Safari Request/";
                String filesFolder1 = Server.MapPath("~/downloads/Safari Request/");
                String imprestNo = Request.QueryString["requisitionNo"];
                imprestNo = imprestNo.Replace('/', '_');
                imprestNo = imprestNo.Replace(':', '_');
                String documentDirectory = filesFolder1 + imprestNo + "\\";
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
        protected void deleteLine_Click(object sender, EventArgs e)
        {
            try
            {
                String doc = docNos.Text.Trim();
                String ent = entitle.Text.Trim();
                String twn = towns.Text.Trim();
                String status = Config.ObjNav2.deleteSafarirequestEntitlement(doc,ent,twn);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else if (info[0] == "danger")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            catch (Exception ed)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ed.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void deleteLines_Clicks(object sender, EventArgs e)
        {
            try
            {
                String docNo = documentNumber.Text.Trim();
                String dt = expenseDate.Text.Trim();
                DateTime expdate = Convert.ToDateTime(dt);
                string formattedDate = expdate.ToString("MM/dd/yy");
                DateTime date = Convert.ToDateTime(formattedDate);
                String status = Config.ObjNav2.deleteSafariRequestLines(docNo, date);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else if(info[0]=="danger")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            catch (Exception ed)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ed.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void editItem_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    string requisitionNo = Request.QueryString["requisitionNo"];

            //    string tentitlement = entitlement1.SelectedValue.Trim();

            //    decimal trate = Convert.ToDecimal(rate1.Text.Trim());
            //    int tquantity = Convert.ToInt16(quantity1.Text.Trim());
            //    string ttown = town1.Text.Trim();


            //    String status = Config.ObjNav2.editSafariRequestEntitlements(requisitionNo, tentitlement, tquantity, trate, ttown);
            //    String[] info = status.Split('*');

            //    linesFeedback2.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //}
            //catch (Exception n)
            //{
            //    linesFeedback2.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
        }
        protected void editLine_Click(object sender, EventArgs e)
        {

            try
            {
                DateTime expDate = Convert.ToDateTime(ContentPlaceHolder1_expenseDate.Text.Trim());
                String docNo = ContentPlaceHolder1_documentNumber.Text.Trim();
                DateTime returnDte = Convert.ToDateTime(ContentPlaceHolder1_returnDate.Text.Trim());
                String travFrom = ContentPlaceHolder1_travelFrom.SelectedValue.Trim();
                String travTo = ContentPlaceHolder1_travelTo.SelectedValue.Trim();
                String status = Config.ObjNav2.editSafariRequestLines(docNo, expDate, returnDte, travFrom, travTo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    documentsfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            catch (Exception ed)
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>" + ed.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void Entitlement_SelectedIndexChanged(object sender, EventArgs e)
        {


            var nav = Config.ObjNav1;
            var result = nav.fnGetEntitlementDetails(entitlement.Text.Trim());
            String[] info = result.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
            if (info.Count() > 0)
            {
                if (info != null)
                {
                    foreach (var allinfo in info)
                    {
                        String[] arr = allinfo.Split('*');
                        rate.Text = arr[1];
                        app.Text = arr[2];

                    }
                }
            }
        }

        protected void Entitlement_SelectedIndexChanged1(object sender, EventArgs e)
        {


            var nav = Config.ObjNav1;
            var result = nav.fnGetEntitlementDetails(entitlement1.Text.Trim());
            String[] info = result.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
            if (info.Count() > 0)
            {
                if (info != null)
                {
                    foreach (var allinfo in info)
                    {
                        String[] arr = allinfo.Split('*');
                        rate.Text = arr[1];
                        app.Text = arr[2];

                    }
                }
            }
        }

        protected void entitlemets_Click(object sender, EventArgs e)
        {
            string appNo = Request.QueryString["requisitionNo"];

            Config.ObjNav2.createSafariEntitlements(appNo);
        }
    }
}