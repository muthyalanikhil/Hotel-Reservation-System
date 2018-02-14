<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
             <div class="jumbotron">
        <div style="align-content: center;">
            <h3><span style="color: green;"></span></h3>
            <h3><span style="color: green;"></span></h3>
            <fieldset>
                <legend>Hotel Reservation Login</legend>
                <div class="form-group">
                    <label for="inputEmail" class="control-label">Email</label>
                    <div>
                        <asp:TextBox runat="server" ID="UserName" CssClass="form-control" type="email" class="form-control" placeholder="Email" name="email" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="control-label">Password</label>
                    <div>
                        <asp:TextBox runat="server" ID="Password" CssClass="form-control" type="password" class="form-control" placeholder="Password" name="password" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                        <asp:Button ID="loginButton" runat="server" Text="submit" type="submit" class="btn btn-primary" name="submit" OnClick="loginButton_Click" />
                    </div>
                </div>
            </fieldset>
            <h3><span style="color: red;"></span></h3>
        </div>
    </div>
        </div>
        <div class="col-md-4">
        </div>
    </div>
</asp:Content>

