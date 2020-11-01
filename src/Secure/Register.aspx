<%@ Page Title="" Language="C#" MasterPageFile="~/Guest.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="NomadEcommerce.Register" %>
<%@ MasterType VirtualPath="~/Guest.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div>
    <div>
        <h1 class="">Register</h1>
    </div>
     <div>
        <asp:TextBox ID="FirstNameText" runat="server" placeholder="First Name" CssClass=""></asp:TextBox>
    </div>
    <div>
        <asp:TextBox ID="LastNameText" runat="server" placeholder="Last Name" CssClass=""></asp:TextBox>
    </div>
   <div>
        <asp:TextBox ID="EmailText" runat="server" TextMode="Email" placeholder="Email" CssClass="" ValidateRequestMode="Enabled"></asp:TextBox>
    </div>
    <div id="PasswordContainer">
        <asp:TextBox ID="PasswordText" runat="server" CssClass="" TextMode="Password" placeholder="Password"></asp:TextBox><br />
        <asp:CheckBox ID="PasswordVisibilityCheckBox" runat="server"></asp:CheckBox>
        <asp:Label ID="PasswordVisibilityLabel" runat="server">Show Password</asp:Label>
    </div>
    <div id="PasswordConfirmContainer">
        <asp:TextBox ID="PasswordConfirmText" runat="server" CssClass="" TextMode="Password" placeholder="Type your password again"></asp:TextBox><br />
        <asp:CheckBox ID="PasswordConfirmVisibilityCheckBox" runat="server"></asp:CheckBox>
        <asp:Label ID="PasswordConfirmVisibilityLabel" runat="server">Show Password</asp:Label>
    </div>
    <div class="">
        <asp:Button ID="RegisterBtn" runat="server" CssClass="" Text="Register" OnClick="CreateUser" />
    </div>
</div>
<script type="text/javascript">
$(function () {
    $("#MainContent_FirstNameText").focus();
    $('#PasswordContainer').NomadPasswordVisibility();
    $('#PasswordConfirmContainer').NomadPasswordVisibility();
});
</script>
</asp:Content>
