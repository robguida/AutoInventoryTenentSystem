<%@ Page Title="" Language="C#" MasterPageFile="~/Auth.Master" AutoEventWireup="true" CodeBehind="TenentCreate.aspx.cs" Inherits="NomadEcommerce.TenentCreate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel runat="server">
        <div>
            <asp:Label runat="server" ID="TenentNameLabel">Comany Name</asp:Label>
            <asp:TextBox runat="server" ID="TenentNameTextBox"></asp:TextBox>
        </div>
        <div>
            <asp:Label runat="server" ID="TenentDomainLabel">Domain Name Associated with Company</asp:Label>
            <asp:TextBox runat="server" ID="TenentDomainTextBox"></asp:TextBox>
        </div>
        <div>
            <asp:Button runat="server" ID="Submit" Text="Create Customer" OnClick="ActionSubmitClick" />
        </div>
    </asp:Panel>
</asp:Content>
