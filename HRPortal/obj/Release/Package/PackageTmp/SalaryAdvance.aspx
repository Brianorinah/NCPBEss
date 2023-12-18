<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalaryAdvance.aspx.cs" Inherits="HRPortal.SalaryAdvance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-primary">
        <div class="panel-heading">
            New Salary Advance Request
        </div>
        <div class="panel-body">
            <div id="salaryFeedback" runat="server"></div>

            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Salary Advance:</strong>
                        <asp:TextBox runat="server" ID="salaryadvance" type="number" CssClass="form-control" Placeholder="Enter Salary Advance Amount"/>
                    </div>
                </div>
                 <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Purpose:</strong>
                        <asp:TextBox runat="server" ID="purpose" cssClass="form-control" TextMode="MultiLine" Placeholder="Enter The Purpose"/>
                    </div>
                </div>  
           </div>         
           <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Number Of Months Deducted:</strong>
                        <asp:TextBox ID="numberofmonths" runat="server" CssClass="form-control" type="number" Placeholder="Enter Number Of Months Deducted"/>
                    </div>
                </div>
               <div class="col-md-6 col-lg-6">
                <div class="form-group">
                    <strong>Recovery Start Month:</strong>
                    <asp:TextBox ID="recoverymonth" runat="server" CssClass="form-control" Placeholder="Enter Recovery Start Month"/>
                </div>
            </div>
            </div>
<%--            <div class="row">
             <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Request Date:</strong>
                        <asp:TextBox runat="server" ID="travelDate" CssClass="form-control" placeholder="Salary Advance Date"/>
                    </div>
                </div>
           </div>--%>
            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Request Salary Advance" ID="SendApproval" Onclick="RequestSalaryAdvance_Click" />
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</asp:Content>
