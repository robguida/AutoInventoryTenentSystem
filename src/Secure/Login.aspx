<%@ Page Title="" Language="C#" MasterPageFile="~/Guest.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="NomadEcommerce.Secure.Login" %>
<%@ MasterType VirtualPath="~/Guest.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div>
            <h1 class="">Login</h1>
        </div>
        <div>
            <asp:TextBox ID="EmailText" runat="server" TextMode="Email" placeholder="Email" CssClass=""></asp:TextBox>
        </div>
        <div id="PasswordContainer">
            <asp:TextBox ID="PasswordText" runat="server" CssClass="" TextMode="Password" placeholder="Password"></asp:TextBox><br />
            <asp:CheckBox ID="PasswordVisibilityCheckBox" runat="server"></asp:CheckBox>
            <asp:Label ID="PasswordVisibilityLabel" runat="server">Show Password</asp:Label>
        </div>
        <div class="">
            <asp:Button ID="login" runat="server" CssClass="" Text="LOG IN" OnClick="Authenticate" />
        </div>
        <div class="">
            <asp:HyperLink runat="server" CssClass="" Text="Register" NavigateUrl="~/Secure/Register.aspx" />
        </div>
    </div>
    <script type="text/javascript">
       $(function () {
           $("#MainContent_EmailText").focus();
           $('#PasswordContainer').NomadPasswordVisibility();
       });
    </script>
</asp:Content>
