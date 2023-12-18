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
    public partial class PurchaseReq : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //var nav = new Config().ReturnNav();
            //if (!IsPostBack)
            //{
            //    int step = 1;
            //    try
            //    {
            //        step = Convert.ToInt32(Request.QueryString["step"]);
            //        if (step > 3 || step < 1)
            //        {
            //            step = 1;
            //        }
            //    }
            //    catch (Exception)
            //    {
            //        step = 1;
            //    }
            //    nlocation.Text = "CUEHQ";
            //    var jobs = nav.jobs.Where(x=> x.Budget == true).ToList().OrderBy(r => r.Description);
            //    List<Employee> allJobs = new List<Employee>();
            //    foreach (var myJob in jobs)
            //    {
            //        Employee employee = new Employee();
            //        employee.EmployeeNo = myJob.No;
            //        employee.EmployeeName = myJob.No + " - " + myJob.Description;
            //        allJobs.Add(employee);
            //    }
            //    job.DataSource = allJobs;
            //    job.DataValueField = "EmployeeNo";
            //    job.DataTextField = "EmployeeName";
            //    job.DataBind();

            //    var p = nav.ResponsibilityCenter.Where(x => x.Operating_Unit_Type == "Directorate");
            //    txtdirectorate.DataSource = p;
            //    txtdirectorate.DataTextField = "Name";
            //    txtdirectorate.DataValueField = "Code";
            //    txtdirectorate.DataBind();
            //    LoadData();

            //    var emp = nav.ProcurementSetup.ToList();
            //    foreach (var item in emp)
            //    {                   
            //        string pp = item.Effective_Procurement_Plan;
            //        Session["pp"] = pp;
            //        var dt = nav.ProcurementPlan.Where(x => x.Code == pp).ToList();
            //        foreach (var it in dt)
            //        {
            //            procurementplan.Text = it.Description;
            //        }
            //    }

            //    String requisitionNo = "";
            //    try
            //    {
            //        requisitionNo = Request.QueryString["docNo"];
            //        if (String.IsNullOrEmpty(requisitionNo))
            //        {
            //            requisitionNo = "";
            //        }
            //    }
            //    catch (Exception)
            //    {
            //        requisitionNo = "";
            //    }

            //    if(!string.IsNullOrEmpty(requisitionNo))
            //    {
            //        var data = nav.PurchaseHeader.Where(x => x.Document_Type == "Purchase Requisition" && x.No == requisitionNo).ToList();
            //        foreach(var t in data)
            //        {                       
            //            priorityLevel.SelectedValue = t.Priority_Level;
            //            itemCategory.SelectedValue = t.PP_Planning_Category;
            //            try
            //            {
            //                txtdirectorate.SelectedValue = t.Directorate_Code;
            //                LoadData();
            //            }
            //            catch
            //            {

            //            }
            //            try
            //            {
            //                txtdepartment.SelectedValue = t.Department_Code;
            //            }
            //            catch
            //            {

            //            }
            //            try
            //            {
            //                requisitionProductGroup.SelectedValue = t.Requisition_Product_Group;
            //                LoadPlanCategoryItems();
            //            }
            //            catch
            //            {
                            
            //            }
            //            try
            //            {
            //                itemCategory.SelectedValue = t.PP_Planning_Category;
            //            }
            //            catch
            //            {
                            
            //            }
            //            try
            //            {
            //                job.SelectedValue = t.Job;
            //                LoadJobTasks();
            //            }
            //            catch
            //            {
                            
            //            }
            //            try
            //            {
            //                jobtask.SelectedValue = t.Job_Task_No;
            //            }
            //            catch
            //            {

            //            }
            //        }
            //    }
            //    var um = nav.UnitofMeasure;
            //    uom.DataSource = um;
            //    uom.DataTextField = "Description";
            //    uom.DataValueField = "Code";
            //    uom.DataBind();

            //    if (step == 2)
            //    {
            //        string brequisitionNo = Request.QueryString["docNo"];
            //        var hd = nav.PurchaseHeader.Where(x => x.No == brequisitionNo).ToList();
            //        foreach (var itm in hd)
            //        {
            //            var items = nav.ProcurementPlanEntry.Where(r => r.Procurement_Plan_ID == Convert.ToString(Session["pp"]) && r.Planning_Category == itm.PP_Planning_Category && r.Requisition_Product_Group == itm.Requisition_Product_Group).ToList();
            //            item.DataSource = items;
            //            item.DataValueField = "Entry_No";
            //            item.DataTextField = "Description";
            //            item.DataBind();
            //        }
            //    }
            //}
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                string message = "";

                String requisitionNo = "";
                Boolean newRequisition = false;
                try
                {
                    requisitionNo = Request.QueryString["docNo"];
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
                string priority = priorityLevel.SelectedValue;
                string requisitionPGroup = requisitionProductGroup.SelectedValue;
                string titemcategory = itemCategory.SelectedValue;
                string tdirectorate = txtdirectorate.SelectedValue;
                string tdepartment = txtdepartment.SelectedValue;
                string tjob = job.Text.Trim();
                string tjobtask = jobtask.Text.Trim();
                int nprioritylevel = 0;
                int nreqpgroup = 0;

                if (string.IsNullOrEmpty(priority))
                {
                    error = true;
                    message = "Please choose priority";

                }
                if (string.IsNullOrEmpty(requisitionPGroup))
                {
                    error = true;
                    message = "Please choose product requisition group";
                }
                if (string.IsNullOrEmpty(titemcategory))
                {
                    error = true;
                    message = "Please choose item category";
                }
                if (priority == "Low")
                {
                    nprioritylevel = 1;
                }
                if (priority == "Normal")
                {
                    nprioritylevel = 2;
                }
                if (priority == "High")
                {
                    nprioritylevel = 3;
                }
                if (priority == "Critical")
                {
                    nprioritylevel = 4;
                }

                if (requisitionPGroup == "Goods")
                {
                    nreqpgroup = 0;
                }
                if (requisitionPGroup == "Services")
                {
                    nreqpgroup = 1;
                }
                if (requisitionPGroup == "Works")
                {
                    nreqpgroup = 2;
                }
                if (requisitionPGroup == "Assets")
                {
                    nreqpgroup = 3;
                }

                if (error == true)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    //String status = Config.ObjNav.FncreatePurchaseRequisition(Convert.ToString(Session["employeeNo"]), requisitionNo, nprioritylevel, nreqpgroup, titemcategory, tdirectorate, tdepartment, tjob, tjobtask, "CUE");
                    //String[] info = status.Split('*');
                    //if (info[0] == "success")
                    //{
                    //    if (newRequisition)
                    //    {
                    //        requisitionNo = info[2];
                    //    }
                    //    Response.Redirect("PurchaseReq.aspx?step=2&&docNo=" + requisitionNo, false);
                    //}
                    //else
                    //{
                    //    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    //}
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
                int tquantityRequested = Convert.ToInt32(quantityRequested.Text.Trim());
                int titem = Convert.ToInt32(item.SelectedValue);
                string tuom = uom.SelectedValue;
                decimal tunitcost = Convert.ToDecimal(unitcost.Text.Trim());
                string ttechnical = tecnical.Text.Trim();

                //String requisitionNo = Request.QueryString["docNo"];
                //String status = Config.ObjNav.FncreateRequisitionLine(requisitionNo, titem, tquantityRequested, "", tunitcost, ttechnical);
                //String[] info = status.Split('*');
                //if (info[0] == "success")
                //{
                //    linesFeedback.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
                //else
                //{
                //    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //}
                    
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void backstepone_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["docNo"];
            Response.Redirect("PurchaseReq.aspx?step=1&&docNo=" + requisitionNo);
        }

        protected void Nextstepthree_Click(object sender, EventArgs e)
        {
            try
            {
                var nav = new Config().ReturnNav();
                String requisitionNo = Request.QueryString["docNo"];
                int purhaseLinesCounter = nav.PurchaseLines.Where(r => r.Document_No == requisitionNo).ToList().Count;
                if(purhaseLinesCounter > 0)
                {
                    Response.Redirect("PurchaseReq.aspx?step=3&&docNo=" + requisitionNo);
                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>You must have at least one item in the purchase requisition line to proceed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch(Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void uploadDocument_Click(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Standard Purchase Requisition/";

            if (document.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(document.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String imprestNo = Request.QueryString["docNo"];
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
                                        Config.navExtender.AddLinkToRecord("Standard Purchase Requisition", imprestNo, filename, "");
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";



                                    }
                                    else
                                    {
                                        documentsfeedback.InnerHtml =
                                            "<div class='alert alert-danger'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
                    documentsfeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again. " + ex.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            else
            {
                documentsfeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
        }

        protected void backsteptwo_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["docNo"];
            Response.Redirect("PurchaseReq.aspx?step=2&&docNo=" + requisitionNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            try
            {
                String requisitionNo = Request.QueryString["docNo"];
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

        protected void deletefile_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Standard Purchase Requisition/";
                String imprestNo = Request.QueryString["docNo"];
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

        protected void deleteline_Click(object sender, EventArgs e)
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
                    String requisitionNo = Request.QueryString["docNo"];
                    String status = Config.ObjNav.DeleteRequisitionLine(employeeName, requisitionNo, tLineNo, 7);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void txtdirectorate_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadData();
        }

        private void LoadData()
        {
            var nav = new Config().ReturnNav();
            string mm = txtdirectorate.SelectedValue;
            //var dd = nav.ResponsibilityCenter.Where(x => x.Operating_Unit_Type == "Department/Center" && x.Direct_Reports_To == mm);
            //txtdepartment.DataSource = dd;
            //txtdepartment.DataTextField = "Name";
            //txtdepartment.DataValueField = "Code";
            //txtdepartment.DataBind();
            //txtdepartment.Items.Insert(0, new ListItem("--Select--", "--Select--"));
        }

        protected void print_Click(object sender, EventArgs e)
        {
            String requisitionNo = Request.QueryString["docNo"];
            Response.Redirect("PurchaseReqPrintOut.aspx?docNo=" + requisitionNo);
        }

        protected void item_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int planEntryNo = Convert.ToInt32(item.SelectedValue);
                var nav = new Config().ReturnNav();
                string itemNo = "";
                var pp = nav.ProcurementPlanEntry.Where(x => x.Entry_No == planEntryNo);
                foreach (var itm in pp)
                {
                    //itemNo = itm.Plan_Item_No;
                    unitcost.Text = "";
                    unitofmeasure.Text = "";
                }
                if(string.IsNullOrEmpty(itemNo))
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>The item is not linked to the procurement plan vote, kindly contact supply chain department for more assistance.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    linesFeedback.InnerHtml = "";
                    var items = nav.Items.Where(x => x.No == itemNo);
                    foreach (var itm in items)
                    {
                        unitcost.Text = Convert.ToString(itm.Unit_Cost);
                        unitofmeasure.Text = itm.Base_Unit_of_Measure;
                    }
                }
            }
            catch(Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>The item is not linked to the procurement plan vote, kindly contact supply chain department for more assistance. " + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void requisitionProductGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadPlanCategoryItems();
        }
        private void LoadPlanCategoryItems()
        {
            var nav = new Config().ReturnNav();
            string nrq = requisitionProductGroup.SelectedValue;
            //var cat = nav.ProcurementPlanLines.Where(X => X.Requisition_Product_Group == nrq).ToList();
            //itemCategory.DataSource = cat;
            //itemCategory.DataTextField = "Description";
            //itemCategory.DataValueField = "Planning_Category";
            //itemCategory.DataBind();
            //itemCategory.Items.Insert(0, new ListItem("--Select--", "--Select--"));
        }
        protected void job_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadJobTasks();
        }
        private void LoadJobTasks()
        {
            var nav = new Config().ReturnNav();
            string mm = job.SelectedValue;
            var jobt = nav.JobTask.Where(x=> x.Job_No == mm).ToList();
            jobtask.DataSource = jobt;
            jobtask.DataValueField = "Job_Task_No";
            jobtask.DataTextField = "Description";
            jobtask.DataBind();
            jobtask.Items.Insert(0, new ListItem("--Select--", "--Select--"));
        }
    }
}