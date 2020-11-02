<%@ Page Title="" Language="C#" MasterPageFile="~/Auth.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NomadEcommerce.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Default Page</h1>
    <asp:Panel ID="AutoResultsPanel" runat="server" Visible="false">
        <div>
            <input type="button" id="AddAutoBtn" value="Add Auto" />
        </div>
        <asp:Repeater ID="AutoResultsRepeater" runat="server" OnItemDataBound="LoadAutoResults">
            <HeaderTemplate>
                <table class="table" cellspacing="0" rules="all" mode="Numeric" border="1" style="border-collapse:collapse;">                   
                    <thead>
                        <tr>               
                            <th scope="col">Model</th>
                            <th scope="col">Class</th>  
                            <th scope="col">Color</th> 
                            <th scope="col">Trim</th>
                            <th scope="col">Doors</th>                       
                            <th scope="col">VIN</th>
                            <th scope="col" colspan="2">Actions</th>                       
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>
            <ItemTemplate>               
                <tr>
                    <td style="vertical-align:top"><%#DataBinder.Eval(Container.DataItem, "ModelNumber")%></td>
                    <td style="vertical-align:top"><%#DataBinder.Eval(Container.DataItem, "Classification")%></td>
                    <td style="vertical-align:top"><%#DataBinder.Eval(Container.DataItem, "Color")%></td>
                    <td style="vertical-align:top"><%#DataBinder.Eval(Container.DataItem, "Trim")%></td>
                    <td style="vertical-align:top"><%#DataBinder.Eval(Container.DataItem, "Doors")%></td>
                    <td style="vertical-align:top"><%#DataBinder.Eval(Container.DataItem, "VIN")%></td>                      
                    <td style="vertical-align:top">
                        <input type="button" data-auto-inventory-id="<%#DataBinder.Eval(Container.DataItem, "AutoInventoryId")%>" value="Edit"
                            data-auto-id="<%#DataBinder.Eval(Container.DataItem, "AutoId")%>" />
                        <input type="button" data-auto-inventory-id="<%#DataBinder.Eval(Container.DataItem, "AutoInventoryId")%>" value="Delete"
                            data-auto-id="<%#DataBinder.Eval(Container.DataItem, "AutoId")%>" />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
                </table>
            </FooterTemplate> 
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
