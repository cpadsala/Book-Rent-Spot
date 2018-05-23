<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ConfirmAndPay.aspx.cs" Inherits="EPRS.Confirm_Pay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .text-box-size-3 {
            max-width: 50px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <div class="col-lg-6 col-lg-offset-3 col-lg-offset-right-3 ">
                <div class="well" style="width: 100%">
                    <h3 class=" h2 text-center">Review Booking and Pay
                    </h3>
                    <br />
                    <p class="headtags2 text-center form-inline">
                        <asp:Label ID="Label14" runat="server" Text="Booking Date:&nbsp;"></asp:Label>
                        <asp:Label ID="lblBookingDate" runat="server" Text="" Visible="true"></asp:Label><br />
                        <asp:Label ID="Label16" runat="server" Text="Open - Close Time:&nbsp;"></asp:Label>
                        <asp:Label ID="lblOpenCloseTime" runat="server" Text="" Visible="true"></asp:Label><br />
                        <br />
                        <asp:Label ID="Label2" runat="server" CssClass="text-primary" Text="Owner Name:&nbsp;"></asp:Label>
                        <asp:Label ID="lblOwnerName" runat="server" Text="" Visible="true"></asp:Label><br />
                        <asp:Label ID="Label3" runat="server" Text="Street Name:&nbsp;"></asp:Label>
                        <asp:Label ID="lblStreet" runat="server" Text="" Visible="true"></asp:Label><br />
                        <asp:Label ID="Label4" runat="server" Text="Apt No:&nbsp;"></asp:Label>
                        <asp:Label ID="lblApt" runat="server" Text="" Visible="true"></asp:Label><br />
                        <asp:Label ID="Label5" runat="server" Text="City, State:&nbsp;"></asp:Label>
                        <asp:Label ID="lblCityState" runat="server" Text="" Visible="true"></asp:Label><br />
                        <asp:Label ID="Label10" runat="server" Text="Owner Email:&nbsp;"></asp:Label>
                        <asp:Label ID="lblEmail" runat="server" Text="" Visible="true"></asp:Label><br />
                        <asp:Label ID="Label12" runat="server" Text="Phone Number:&nbsp;"></asp:Label>
                        <asp:Label ID="lblPhone" runat="server" Text="" Visible="true"></asp:Label><br />
                        <br />
                        <br />
                        <asp:Label ID="Label1" runat="server" Text="Card Info:&nbsp;&nbsp;&nbsp;"></asp:Label>
                        <asp:TextBox ID="txtCCNo" runat="server" CssClass="form-control onlyNumbers" MaxLength="16" placeholder="Enter 16 digit  number" ValidationGroup="r"></asp:TextBox><br />
                        <br />
                        <asp:Label ID="Label6" runat="server" Text="Exp Month - Year:&nbsp;"></asp:Label>
                        <asp:TextBox ID="txtMonth" runat="server" MaxLength="2" CssClass=" form-control text-box-size-3 onlyNumbers" placeholder="MM" ValidationGroup="r"></asp:TextBox>
                        <asp:TextBox ID="txtYear" runat="server" MaxLength="2" CssClass="form-control text-box-size-3 onlyNumbers" placeholder=" YY" ValidationGroup="r"></asp:TextBox>
                        &nbsp;&nbsp;<asp:Label ID="Label7" runat="server" Text="CVV:&nbsp;"></asp:Label>
                        <asp:TextBox ID="txtCVV" runat="server" MaxLength="3" CssClass="form-control text-box-size-3 onlyNumbers" placeholder="CVV" ValidationGroup="r"></asp:TextBox><br />
                        <br />
                        <br />
                        <asp:Label ID="Label8" runat="server" Text="Full Name:&nbsp;&nbsp;&nbsp;"></asp:Label>
                        <asp:TextBox ID="txtNameonCard" runat="server" ValidationGroup="r" CssClass="form-control" placeholder="Enter Name as on Card"></asp:TextBox><br />
                        <br />
                        <asp:Label ID="Label9" runat="server" Text="Contact Info:&nbsp;"></asp:Label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control onlyNumbers" MaxLength="10" ValidationGroup="r" placeholder="Enter Phone Number"></asp:TextBox>
                        <br />
                    </p>
                    <p class=" text-center">
                        <asp:Button ID="btnPay" ValidationGroup="r" runat="server" Text="Pay" OnClientClick="return validateText();" CssClass="btn btn-log btn-primary" OnClick="btnPay_Click" />
                        &nbsp;
                    </p>
                    <p class=" text-center">
                        <asp:Label ID="lblError" runat="server" CssClass="text-warning alert-dismissable" EnableViewState="true" Style="display: none;" Text=""></asp:Label>
                        <asp:HyperLink ID="hlExistingReservations" NavigateUrl="ExistingReservations.aspx" runat="server"></asp:HyperLink>
                    </p>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function validateText() {
            var allText = 0;
            $(".onlyNumbers").each(function () {
                if (!/^[0-9]*$/.test(this.value)) {
                    allText += 1;
                }
            });
            if (allText > 0) {
                alert("Please enter valid numeric values.");
                return false;
            }
            var ccno = document.getElementById('<%=txtCCNo.ClientID%>').value;
            var mnth = document.getElementById('<%=txtMonth.ClientID%>').value;
            var year = document.getElementById('<%=txtYear.ClientID%>').value;
            var cvv = document.getElementById('<%=txtCVV.ClientID%>').value;
            if (ccno.length < 16 || mnth > 12 || mnth.length < 2 || year < 18 || year.length < 2 || cvv.length < 3) {
                alert("Please enter correct card details");
                return false;
            }
            return true;
        }

    </script>
</asp:Content>
