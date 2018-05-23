<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="BookSpot.aspx.cs" Inherits="EPRS.BookSpot" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/tcss/StyleSheet.css" rel="Stylesheet" type="text/css" />
    <br />
    <br />
    <br />
    <br />
    <div class="row">
        <center><asp:Label ID="lblMessage" Text="" Visible="false" CssClass="h1 popup-msg dismis-alert" runat="server"></asp:Label></center>
        <br />
        <center><asp:Label ID="lblHd" Text="Book a Spot" CssClass="h1" runat="server"></asp:Label></center>
        <br />
        <center><asp:Label ID="lblHead" Text="Select a date to check available parking spots." CssClass="h3" runat="server"></asp:Label></center>
        <br />
        <br />

        <div class="col-lg-1">
        </div>
        <div class="col-lg-4">
            <div class="rescalender">
                <asp:Calendar ID="clBook" CellPadding="0" BorderWidth="0px" Width="75%" Height="240px" TitleStyle-CssClass="Title" DayHeaderStyle-CssClass="DayHeader" DayStyle-CssClass="Day" DayStyle-Width="90px" OtherMonthDayStyle-CssClass="Day OtherMonthDay" OnSelectionChanged="clBook_SelectionChanged" OnDayRender="clBook_DayRender" runat="server"></asp:Calendar>
            </div>
            <br />
            <div class="form-group form-inline" runat="server" id="divCity" visible="false">
                <asp:TextBox ID="txtSearchCity" runat="server" placeholder="Search by City Name" CssClass=" form-control" ValidationGroup="rr"></asp:TextBox>
                &nbsp;<asp:Button ID="btnSearchCity" runat="server" Text="Search" CssClass="btngrid btngridsizebtngrid btngridsize " ValidationGroup="rr" OnClick="btnSearchCity_Click" />
                <asp:Button ID="btnNearMe" runat="server" Text="Near Me" CssClass="btngrid btngridsizebtngrid btngridsize "  OnClick="btnNearMe_Click" />
            </div>
        </div>
        <div class="col-lg-7">
            <div class="rounded-corners">
                <asp:GridView ID="gvAvailableSpot" runat="server" DataKeyNames="Rent_Id" Width="100%" AllowSorting="True" AutoGenerateColumns="False" EnableModelValidation="True" CssClass="Grid" HeaderStyle-BackColor="#265990" HeaderStyle-ForeColor="White" RowStyle-BackColor="White" EmptyDataText="There are no available parkings on this day" OnRowCommand="gvAvailableSpot_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Parking Details">
                            <ItemTemplate>
                                <span style="color: #808080;">Street:</span>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Street_Name") %>'></asp:Label><br />
                                <span style="color: #808080;">Apt No:</span>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Apt_No") %>'></asp:Label><br />
                                <span style="color: #808080;">City:</span>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("City") %>'></asp:Label><br />
                                <span style="color: #808080;">State:</span>
                                <asp:Label ID="Label4" runat="server" Text='<%# Eval("State") %>'></asp:Label><br />
                                <span style="color: #808080;">Zip:</span>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("ZipCode") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="OpenTime" HeaderText="From" />
                        <asp:BoundField DataField="CloseTime" HeaderText="Till" />
                        <asp:TemplateField HeaderText="Price">
                            <ItemTemplate>
                                <span style="color: #808080;">$</span>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:ButtonField ButtonType="Button" ControlStyle-CssClass=" btngrid btngridsize" Text="Book" HeaderText="Book & Pay" CommandName="BookSpot" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdnCity" Value="" runat="server" ClientIDMode="Static"/>
    <script>
        $.ajax({
            url: "https://geoip-db.com/jsonp",
            jsonpCallback: "callback",
            dataType: "jsonp",
            success: function (location) {
                $('#<%=hdnCity.ClientID%>').val(location.city);
            }
        });
    </script>
</asp:Content>
