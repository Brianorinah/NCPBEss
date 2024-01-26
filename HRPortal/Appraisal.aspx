<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Appraisal.aspx.cs" Inherits="HRPortal.Appraisal" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="HRPortal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="row">
        <div class="col-sm-12">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard</a></li>
                <li class="breadcrumb-item active">Staff Claim</li>
            </ol>
        </div>
    </div>
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
        {
            %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Appraisal General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>

             <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee No.<span style="color: red">*</span></label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["employeeNo"] %></asp:Label>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Employee Name<span style="color: red">*</span></label>
                        <asp:Label runat="server" class="form-control" readonly="true"> <%=Session["name"] %></asp:Label>
                    </div>
                </div>
            </div>
             <div class="row">
                <div class="col-md-6 col-lg-6">
                     <div class="form-group">
                    <strong>Job title:</strong>
                    <asp:TextBox runat="server" ID="jobtitle" CssClass="form-control" />
                </div>
                </div>
                <div class="col-md-6 col-lg-6">
                     <div class="form-group">
                    <strong>Appraisal Period:</strong>
                    <asp:TextBox runat="server" ID="appraisalperiod" CssClass="form-control" />
                </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Appraisal Start Date</label>
                        <asp:TextBox runat="server" ID="appraisalstartdate" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Goal Setting Start Date<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="goalsettingstartdate" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">Goal Setting End Date</label>
                        <asp:TextBox runat="server" ID="goalsettingenddate" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">MY Start Date<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="mystartdate" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">MY End Date</label>
                        <asp:TextBox runat="server" ID="myenddate" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">EY Start Date<span style="color: red">*</span></label>
                        <asp:TextBox runat="server" ID="eystartdate" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label class="control-label">EY End Date</label>
                        <asp:TextBox runat="server" ID="eyenddate" CssClass="form-control" TextMode="Date" />
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                         <div class="form-group">
                    <strong>Supervisor name:</strong>
                    <asp:TextBox runat="server" ID="supervisor" CssClass="form-control" />
                </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                         <div class="form-group">
                    <strong>Overview manager name:</strong>
                    <asp:TextBox runat="server" ID="overviewmanager" CssClass="form-control" />
                </div>
                </div>
            </div>
              
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
        </div>
    </div>
    <%
        }
         %>
</asp:Content>
