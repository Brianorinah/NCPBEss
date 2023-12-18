<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImprestRequisitionEdit.aspx.cs" Inherits="HRPortal.ImprestRequisitionEdit" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>

<%--<%@ Import Namespace="Microsoft.SharePoint.Client" %>--%>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="HRPortal.Models" %>
<%@ Import Namespace="System.Security" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        int step = 1;
        try
        {
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 3 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step == 1)
        {%>
     <div class="panel panel-primary">
        <div class="panel-heading">
            Imprest Requisition Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Imprest Requisition</a></li>
                        <li class="breadcrumb-item active">Imprest Requisition Detail</li>
                    </ol>
                </div>
            </div>
            <div runat="server" id="generalFeedback"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Document No</strong>
                     <asp:TextBox runat="server" CssClass="form-control" ID="docNo" ReadOnly="true"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Account Type</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="accountType" ReadOnly="true"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Account Number</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="accountNo" ReadOnly="true"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Account Name</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="accountName" ReadOnly="true"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Payment Narration</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="paymentNarration" ReadOnly="true"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Imprest Deadline</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="imprestDeadline" ReadOnly="true"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


    <%} %>

    <% 
        else if (step == 2)
        {%>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Imprest Requisition Lines
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Imprest Requisition Lines</a></li>
                        <li class="breadcrumb-item active">Imprest Requisition  Lines</li>
                    </ol>
                </div>
            </div>
            <div runat="server" id="lineFeedback"></div>
               <hr />
       
        <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Purpose</th>
                        <th>Daily Rate</th>
                        <th>No of Days</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>

                    <% 
                        var nav = new Config().ReturnNav();
                        String tNo = "";
                        if (Request.QueryString["requisitionNo"] != null)
                        {
                            tNo = Request.QueryString["requisitionNo"].ToString();
                        }

                        var query = nav.ImprestLines.Where(x => x.No == tNo).ToList();
                        foreach (var item in query)
                        { %>
                    <tr>
                        <td><%=item.Purpose %></td>
                        <td><%=item.Daily_Rate %></td>
                        <td><%=item.No_of_Days %></td>
                        <td><%=item.Amount %></td>
                       

                    </tr>
                    <%  }%>
                </tbody>


            </table>
            
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Previous" OnClick="Previous_Click"/>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Send For Approval" ID="SendForApproval" OnClick="SendForApproval_Click"/>

        <div class="clearfix"></div>
        </div>
    </div>



      <%} %>
</asp:Content>
