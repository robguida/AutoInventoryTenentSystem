<%@ Page Title="" Language="C#" MasterPageFile="~/Auth.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NomadEcommerce.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Default Page</h1>
    <asp:Panel ID="AutoResultsPanel" runat="server" Visible="false">
        <asp:Repeater ID="AutoResultsRepeater" runat="server" OnItemDataBound="LoadAutoResults">

        </asp:Repeater>
    </asp:Panel>
    <asp:Panel ID="AutoNoResultPanel" runat="server" Visible="false">
        <h2>No Autos Found</h2>
        <div>
            <input type="button" id="AddAutoBtn" value="Add Auto" />
        </div>
    </asp:Panel>
    <script type="text/javascript">
        $(function () {
            $('#AddAutoBtn').click(function () {
                console.log('here');
                location.assign('/Auto/AutoCreate.aspx');
            });
        });
    </script>
</asp:Content>
