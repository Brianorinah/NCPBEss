<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="HRPortal.Dashboard" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row">
    <div class="col-sm-12">
        <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="Dashboard.aspx">National Cerials And Produce Board</a></li>
            <li class="breadcrumb-item"><a href="Dashboard.aspx">Employee Self Service Portal</a></li>
            <li class="breadcrumb-item active">Dashboard</li>
        </ol>
    </div>
</div>  
    <% var nav = new Config().ReturnNav(); 
         String employeeNo = Convert.ToString(Session["employeeNo"]);
        Decimal leaveBalance = 0;
        %>
<div class="main">
  <div class="main-inner">
    <div class="container" style="max-width: 1050px;">
      <div class="row" style="width: 98%;">
        <div class="col-md-6 col-lg-6">
         
         
          <div class="widget">
            <div class="widget-header"> <i class="icon-file"></i>
              <h3> Welcome <%=Session["name"]%></h3>
            </div>
              <div runat="server" id="photosize"></div>
            <!-- /widget-header -->
            <div class="widget-content">
            <center>
                <div style="width: 100%; display: block; margin: auto;">
                <img id="passportimage" runat="server" />
            </div>
            </center>
            <div runat="server" id="documentsfeedback"></div>
            <button type="button" class="btn btn-primary pull-right" data-toggle="modal" data-target="#myModal">Upload Image</button>
            <br />
                 <table class="table table-striped table-bordered">
                
                <tbody>
                    <%                        
                        var nav1 = Config.ObjNav1;
                        var result = nav1.fnGetEmployees(employeeNo);
                        String[] info = result.Split(new string[] { "::::" }, StringSplitOptions.RemoveEmptyEntries);
                        if (info.Count() > 0)
                        {
                            if (info != null)
                            {
                                foreach (var allinfo in info)
                                {
                                    String[] arr = allinfo.Split('*');
                                    leaveBalance = Convert.ToDecimal(arr[4]);


                         %>
                
                  <tr><td> Employee Number:</td><td> <%= arr[0]%></td></tr>
                  <tr><td> Name:</td><td> <%= arr[1] %></td></tr>                 
                  <tr><td> Email:</td><td> <%= arr[2] %> </td></tr>
                  <tr><td> Id Number:</td><td> <%= arr[3] %> </td></tr>
                  <%
                              }
                          }
                      }
                  %>


                
                </tbody>
              </table>
            </div>
            <!-- /widget-content --> 
          </div>
          <!-- /widget --> 
        </div>
        <div class="col-md-6 col-lg-6">          
            
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3>
                   <%    
                        int approvedImprest = 0;                    
                       //var employeesLeaves = nav.Employees.Where(r => r.No == (String) Session["employeeNo"]);
                       //Decimal leaveBalance = 0;
                       //try
                       //{
                       //    foreach (var employee in employeesLeaves)
                       //    {
                       //        leaveBalance = Convert.ToDecimal(employee.Leave_Outstanding_Bal);

                       //        break;
                       //    }
                       //}
                       //catch (Exception)
                       //{
                       //    leaveBalance = 0;
                       //}
                   %>
                  <% = approvedImprest %>
              </h3>

              <p>Approved Leave Applications</p>
            </div>
<%--            <div class="icon">
              <i class="fa fa-sign-out"></i>
            </div>--%>
            <a href="Approvedleave.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-green">
            <div class="inner">
              <h3>
                   <% 
                       int approvedSafariRequest = 0;
                       //var  imprests = nav.HrLeaveApplication.Where(r => r.Status == "Released" && r.Employee_No == employeeNo && r.Posted == false );;
                       //int approvedImprestMemos = 0;
                       //try
                       //{
                       //    foreach (var imprest in imprests)
                       //    {
                       //        approvedImprestMemos ++;

                       //    }
                       //}
                       //catch (Exception)
                       //{
                       //    approvedImprestMemos = 0;
                       //}
                   %>
                  <% = approvedSafariRequest %>
              </h3>

              <p>Approved Safari Request</p>
            </div>
<%--            <div class="icon">
              <i class="fa fa-money"></i>
            </div>--%>
            <a href="ApprovedImprestRequisition.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3>
                  <% 
                      int approvedImprestRequisitions = 0;
                      //var payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Posted == false && r.Payment_Type =="Imprest");
                      //int approvedImprestRequisitions = 0;
                      //try
                      //{
                      //    foreach (var imprest in payments)
                      //    {
                      //        approvedImprestRequisitions ++;

                      //    }
                      //}
                      //catch (Exception)
                      //{
                      //    approvedImprestRequisitions = 0;
                      //}
                   %>
                  <% = approvedImprestRequisitions %>
              </h3>

              <p>Approved Imprest</p>
            </div>
<%--            <div class="icon">
              <i class="fa fa-money"></i>
            </div>--%>
            <a href="ApprovedImprest.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
          <!-- small box -->
          <div class="small-box bg-red">
            <div class="inner">
              <h3>
                    <% 
                        int approvedImprestSurrenders = 0;
                        //payments = nav.Payments.Where(r => r.Status == "Released" && r.Account_No == employeeNo && r.Posted == false && r.Payment_Type == "Surrender");
                        //int approvedImprestSurrenders = 0;
                        //try
                        //{
                        //    foreach (var imprest in payments)
                        //    {
                        //        approvedImprestSurrenders ++;

                        //    }
                        //}
                        //catch (Exception)
                        //{
                        //    approvedImprestSurrenders = 0;
                        //}
                   %>
                  <% = approvedImprestSurrenders %>
              </h3>

              <p>Approved Imprests Surrenders</p>
            </div>
<%--            <div class="icon">
              <i class="fa fa-money"></i>
            </div>--%>
            <a href="ImprestSurrendersApproved1.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
        <!-- ./col -->
        <!-- ./col -->        
        </div>
      </div>
      <!-- /row --> 
    </div>
    <!-- /container --> 
  </div>
  <!-- /main-inner --> 
</div>
    <div id="myModal" class="modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Upload your passport Size Photo</h4>
                </div>
                <div class="modal-body">
                    <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Image" OnClick="UPloadImage_Click" />
                </div>
            </div>

        </div>
    </div>
<!-- /main -->
</asp:Content>
