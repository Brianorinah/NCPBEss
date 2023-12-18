<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="hrPowerBi.aspx.cs" Inherits="HRPortal.hrPowerBi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


     <section class="content-header">
        <h1>Human Resource Reports
        </h1>
        <ol class="breadcrumb" style="background-color: antiquewhite">
            <li><a href="Dashboard.aspx"><i class="fa fa-dashboard"></i>Home</a></li>
            <li><a href="HumanResource.aspx">Human Resource Reports </a></li>
        </ol>
    </section>
    <section class="content">
        <div class="panel panel-primary">
            <div class="panel-heading">
                Human Resource Report
                </div>
             <div class="panel-body">
        <iframe runat="server" width=100% height="541.45" src="http://10.111.108.74/Reports/powerbi/Human%20Resources?rs:embed=true" frameborder="0" allowFullScreen="true"></iframe>
</div>
            </div>
        </section>

</asp:Content>
