<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
      <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
             <div class="jumbotron">
        <div style="align-content: center;">
            <h3><span style="color: green;"></span></h3>
            <h3><span style="color: green;"></span></h3>
            <fieldset>
                <legend>Registration</legend>
                <div class="form-group">
                    <label for="inputEmail" class="control-label">User Name</label>
                    <div>
                        <asp:TextBox runat="server" ID="UserName" CssClass="form-control" type="text" class="form-control" placeholder="User Name" name="username" required="required" />
                    </div>
                </div>
                  <div class="form-group">
                    <label for="inputEmail" class="control-label">Email</label>
                    <div>
                        <asp:TextBox runat="server" ID="Email" CssClass="form-control" type="email" class="form-control" placeholder="Email" name="email" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="control-label">Password</label>
                    <div>
                        <asp:TextBox runat="server" ID="Password" CssClass="form-control" type="password" class="form-control" placeholder="Password" name="password" required="required" />
                    </div>
                </div>
                  <div class="form-group">
                    <label for="password" class="control-label">Confirm Password</label>
                    <div>
                        <asp:TextBox runat="server" ID="confirmPassword" CssClass="form-control" type="password" class="form-control" placeholder="Confirm Password" name="confirmPassword" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                        <asp:Button ID="register" runat="server" Text="submit" type="submit" class="btn btn-primary" name="Register" OnClick="register_Click" />
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

