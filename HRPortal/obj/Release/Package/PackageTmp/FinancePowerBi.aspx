<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FinancePowerBi.aspx.cs" Inherits="HRPortal.FinancePowerBi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

          <section class="content-header">
        <h1>Finance PowerBi Report
        </h1>
        <ol class="breadcrumb" style="background-color: antiquewhite">
            <li><a href="Dashboard.aspx"><i class="fa fa-dashboard"></i>Home</a></li>
            <li><a href="PowerBi Reports.aspx">Finance PowerBi Report </a></li>
        </ol>
    </section> 
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Finance Report
                </div>
             <div class="panel-body">
          <iframe runat="server" width="100%" height="541.45" src="http://10.111.108.74/Reports/powerbi/FInance%20Reports?rs:embed=true" frameborder="0" allowFullScreen="true"></iframe>

</div>
            </div>
        </section>

</asp:Content>
