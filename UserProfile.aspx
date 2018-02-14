<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UserProfile.aspx.cs" Inherits="UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div style="padding: 30px; background: #fffffff5; margin-top: 50px;">
        <h3 style="text-align: center;">Update your Profile</h3>
        <br />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="userName" CssClass="col-md-2 control-label">Name: </asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="userName" CssClass="form-control" />
            </div>
        </div>
        <br />
        <br />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="email" CssClass="col-md-2 control-label">Email: </asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="email" CssClass="form-control" />
            </div>
        </div>
        <br />
        <br />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="addressLine1" CssClass="col-md-2 control-label">Address Line 1: </asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="addressLine1" CssClass="form-control" />
            </div>
        </div>
        <br />
        <br />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="phone" CssClass="col-md-2 control-label">Phone: </asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="phone" CssClass="form-control" />
            </div>
        </div>
        <br />
        <br />
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" ID="updateProfile" OnClick="updateProfile_Click"
                    Text="Update Profile" CssClass="btn btn-success" />
            </div>
        </div>
    </div>
</asp:Content>

