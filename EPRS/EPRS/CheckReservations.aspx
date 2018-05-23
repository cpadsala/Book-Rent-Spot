<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="CheckReservations.aspx.cs" Inherits="EPRS.CheckReservations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Existing Reservations</h3>
                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                    <ul class="panel-controls">
                        <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span></a>
                        </li>
                    </ul>
                </div>
                <div class="panel-body panel-body-table">
                    <div class="table-responsive">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <div class="table table-bordered table-striped table-actions">
                                    <asp:GridView ID="gvReservations" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin" AllowSorting="True" Width="100%" CellPadding="5" BorderStyle="None" BorderColor="White" CellSpacing="5" GridLines="None" Font-Size="Small"  EmptyDataText="No Existing Reservations." EnableViewState="false">
                                        <RowStyle CssClass="RowStyle" />
                                        <HeaderStyle CssClass="HeaderStyle" />
                                        <AlternatingRowStyle CssClass="AltRowStyle" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Booking Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvBookingDate" runat="server" Text='<%#Eval("Booking_Date")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Street Name & Apt No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvStreet" runat="server" Text='<%#Eval("Street_Name")+ ", " + Eval("Apt_No") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="City & State">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvCity" runat="server" Text='<%#Eval("City") + ", " + Eval("State") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Zip Code">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvZip" runat="server" Text='<%#Eval("ZipCode") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="From">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvOpenTime" runat="server" Text='<%#Eval("OpenTime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="To">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvCloseTime" runat="server" Text='<%#Eval("CloseTime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Price Paid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgvPrice" runat="server" Text='<%# "$ " +  Eval("Price") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
