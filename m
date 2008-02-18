Message-ID: <47B9AB97.5040407@...1030...>
Date: Mon, 18 Feb 2008 17:00:23 +0100
From: Marcus <adesperateuser@...1030...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Needing help with writing an easy-to-use
	Radius-Plugin for authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Folks,

since pam doesn't work for me on ubuntu, as already stated on the 
user-list, I decided to take a different approach towards 
authentication. There is a python module called pyrad 
(http://www.wiggy.net/code/pyrad/), which is able to authenticate a user 
with a username and a password against a radius-server.

The goal is to put a line like
plugin /path/to/my-auth-script.py
in openvpn-server.conf and take the user + pass which the client 
provides via the "auth-user-pass"-Directive in it's client.conf.

I already read the README file in the plugin folder of the OpenVPN 
source distribution, and also browsed through the plugin.h-file but I'm 
not that good in reading header-files.

An authentication-script could look something like this:


#!/usr/bin/python

import sys
import socket
import pyrad.packet
from pyrad.client import Client
from pyrad.dictionary import Dictionary

args = sys.argv[1:] # drop first entry (progpath)
if len(args) != 2:
         raise SystemExit("expected two parameters (username and password)")

srv=Client(server="server_ip",
         secret="some_s3cret",
         dict=Dictionary("dictionary"))

req=srv.CreateAuthPacket(code=pyrad.packet.AccessRequest,User_Name=sys.argv[1])

req["User-Password"]=req.PwCrypt(sys.argv[2])


req["NAS-IP-Address"] = "The_Nas_IP"
req["NAS-Port"] = 0
req["Service-Type"] = "Login-User"
req["NAS-Identifier"] = "openvpn"

try:
#       print "Sending authentication request"
         reply=srv.SendPacket(req)
except pyrad.client.Timeout:
         print "RADIUS server does not reply"
         sys.exit(1)
except socket.error, error:
         print "Network error: " + error[1]
         sys.exit(1)

if reply.code==pyrad.packet.AccessAccept:
         sys.exit(0)
else:
         sys.exit(1)


Can anyone tell me (pretty please with sugar on top) how to put this 
together?
What I don't know yet is:
1. What is the script supposed to return? 0 for authenticated and 1 for 
not authenticated?
2. How are arguments (username/password) passed to the plugin?
3. How can I use a python-script instead of a *.so-File or a perl-Script?

I hope it's not a big deal to get this set-up running.

I recognized, that easy authentication via a MS-IAS-Radius server IS an 
issue in the openvpn-community. This solution would be very simple to 
set up and I'd document it in the official wiki to share with the world, 
in return.

Best regards, Marcus

My client.conf looks like this:

client
dev tun
proto udp
remote SOME_IP 1194
route-method exe
route-delay 2
resolv-retry infinite
nobind
persist-key
persist-tun

auth-user-pass
ca keys/ca.crt

comp-lzo
verb 3

