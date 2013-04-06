<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="demo.About" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <script src="Scripts/jquery-1.7.1.min.js"></script>
    <script src="Scripts/jquery.signalR-1.0.0.min.js"></script>
    <script type="text/javascript" src="SignalR/hubs"></script>
    <style type="text/css">
                #chat-box {
            border: 2px solid black;
            height: 400px;
            width: 700px;
        }

        .msg-box {
            border: 1px solid;
            height: 20px;
            width: 700px;
            min-height: 20px;
        }
    </style>
    <div class="wrap-chat">
        <input type="text" id="username" /><input type="button" value="Connect" id="connect" />
        <div id="chat-box">
        </div>
        <div contenteditable="true" class="msg-box"></div>
        <div>
            <input type="button" id="btnSend" value="send" />
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            var chat = $.connection.demoChat;
            var UserName;
            $('#connect').bind('click', function () {
                UserName = $('#username').val();
                $.connection.hub.start().done(function () {
                    alert("connected");
                });
            });
            $('#btnSend').click(function () {
                var message = $('.msg-box').text();
                SendMessage(message);
            });
            //calling the server method
            SendMessage = function (msg) {
                $('.msg-box').text("");
                chat.server.broadCast(msg, UserName);
            },
            //function invoked from the server
           chat.client.recieveMessage = function (msg, name) {
               BindMessage(msg, name);
           }
            BindMessage = function (msg, name) {
                $('#chat-box').append('<div>' + name + ' -' + msg);
            }
        });

    </script>
</asp:Content>
