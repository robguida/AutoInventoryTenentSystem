<%@ Page Title="" Language="C#" MasterPageFile="~/Auth.Master" AutoEventWireup="true" CodeBehind="AutoUpdate.aspx.cs" Inherits="NomadEcommerce.AutoUpdate" %>
<%@ MasterType VirtualPath="~/Auth.Master" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
        <script src="/Scripts/NomadEcommerceNumericLimit.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Auto</h1>
    <h2>Update</h2>
    <div>
        <div>
            <asp:Label ID="ModelNumberLabel" runat="server">Model:</asp:Label>
            <asp:DropDownList ID="ModelNumberDdl" runat="server"></asp:DropDownList>
        </div>
        <div>
            <asp:Label ID="ClassificationLabel" runat="server">Classification:</asp:Label>
            <asp:DropDownList ID="ClassificationDdl" runat="server"></asp:DropDownList>
        </div>
        <div>
            <asp:Label ID="ColorLabel" runat="server">Color:</asp:Label>
            <asp:DropDownList ID="ColorDdl" runat="server"></asp:DropDownList>
        </div>
       <div>
            <asp:Label ID="TrimLevelLabel" runat="server">Trim Level:</asp:Label>
            <asp:DropDownList ID="TrimLevelDdl" runat="server"></asp:DropDownList>
        </div>
         <div>
            <asp:Label ID="DoorsLabel" runat="server">Doors:</asp:Label>
            <asp:TextBox ID="DoorsTextBox" runat="server" TextMode="Number" Text="4"></asp:TextBox>
        </div>
        <div>
            <asp:Label ID="VinLabel" runat="server">VIN:</asp:Label>
            <asp:TextBox ID="VinText" runat="server"></asp:TextBox>
        </div>
         <div>
             <asp:HiddenField ID="AutoInventoryIdHidden" runat="server" />
            <asp:Button ID="SaveBtn" runat="server" Text="Save" OnClick="UpdateAuto"></asp:Button>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $("#MainContent_DoorsTextBox").NomadNumericLimit({ min: 2, max: 5 });
        });
    </script>
</asp:Content>