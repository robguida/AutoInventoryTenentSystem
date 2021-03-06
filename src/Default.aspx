﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Auth.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NomadEcommerce.Default" %>
<%@ MasterType VirtualPath="~/Auth.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="/Scripts/NomadEcommerceManageInentory.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Default Page</h1>
    <asp:Panel ID="AutoResultsPanel" runat="server" Visible="false">

        <div>
            <div>
                <input type="button" ID="AddAutoBtnTop" data-type="AddAutoBtn" value="Add Auto" />
            </div>
            <div>
                <asp:Label ID="SearchLabel" runat="server">Search</asp:Label>
                <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                <asp:Button ID="SearchBtn" runat="server" Text="Search" OnClick="FilterResults"></asp:Button>
                <asp:Button ID="ClearButton" runat="server" Text="Clear" OnClick="ClearResults"></asp:Button>
            </div>
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

        <asp:HiddenField ID="AuthTokenHidden" runat="server" />

    </asp:Panel>

    <asp:Panel ID="AutoNoResultPanel" runat="server" Visible="false">
        <h2>No Autos Found</h2>
        <div>
            <input type="button" id="AddAutoBtnBottom" data-type="AddAutoBtn" value="Add Auto" />
        </div>
    </asp:Panel>
    <div id="NomadModalDelete">
        <h2>Confirmation Delete</h2>
        <p>Delete this record?</p>
        <div>
            <input type="button" value="No" />
            <input type="button" value="Yes" />
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $('input[type="button"][data-type="AddAutoBtn"]').click(function () {
                console.log('here');
                location.assign('/Auto/AutoCreate.aspx');
            });

            $('#NomadModalEdit').dialog({ modal: true, autoOpen: false });
            $('#NomadModalDelete').dialog({ modal: true, autoOpen: false });

            $('input[type="button"][value="Edit"]').NomadManageInventoryEdit();
            $('input[type="button"][value="Delete"]').NomadManageInventoryDelete(
                {
                    modal: $('#NomadModalDelete'),
                    authToken: $('#MainContent_AuthTokenHidden').val()
                }
            );
        });
    </script>
</asp:Content>
