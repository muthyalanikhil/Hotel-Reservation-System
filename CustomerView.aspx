<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="CustomerView.aspx.cs" Inherits="CustomerView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <br />
    <br />
    <div class="panel panel-default">
        <div class="panel-heading" style="align-content: center; font-weight: bold">Reserve a room</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="roomTypeDD" CssClass="control-label">Room Type:</asp:Label>
                        <div>
                            <asp:DropDownList ID="roomTypeDD" runat="server">
                                <asp:ListItem>Single</asp:ListItem>
                                <asp:ListItem>Double</asp:ListItem>
                                <asp:ListItem>Triple</asp:ListItem>
                                <asp:ListItem>Suite</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="totalNumber" CssClass="control-label">Number of People:</asp:Label>
                        <div>
                            <asp:TextBox TextMode="Number" ID="totalNumber" runat="server" Text="0" min="0" max="20" step="1" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="fromDate" CssClass="control-label">From: </asp:Label>
                        <div>
                            <asp:TextBox type="date" ID="fromDate" runat="server" class="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <asp:Label runat="server" AssociatedControlID="toDate" CssClass="control-label">To: </asp:Label>
                    <div>
                        <asp:TextBox type="date" ID="toDate" runat="server" class="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                   <div>
                        <asp:CheckBox Text="&nbsp;&nbsp;&nbsp;Please check the box if you need Airport Pickup" ID="airportPickup" runat="server"></asp:CheckBox>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-4">
            <asp:Button runat="server" ID="bookRoom" OnClick="bookRoom_Click"
                Text="Book Room" CssClass="btn btn-success" />
        </div>
    </div>
    <br />
    <br />
    <asp:PlaceHolder runat="server" ID="allBookinigsPH">
        <hr />
        <h3 style="text-align:center;"><asp:Label runat="server" Text="" ID="previousBookingsLBL"></asp:Label></h3>
    </asp:PlaceHolder>

</asp:Content>

