using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
namespace demo
{
    [HubName("demoChat")]
    public class DemoChat:Hub
    {
        public void BroadCast(string msg,string name) {
            Clients.All.recieveMessage(msg, name);
        }
    }
}