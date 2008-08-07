Message-ID: <COL102-W7821B9DCAE8DDE79D1D9C0DC750@...512...>
Content-Type: multipart/alternative;
	boundary="_9baadd92-7fa3-4c9b-bf09-5ecd24f6b9a1_"
From: Adrian Chng <adrianchng@...160...>
Date: Thu, 7 Aug 2008 11:06:26 +0800
MIME-Version: 1.0
Subject: [Openvpn-devel] Problem connecting OpenVPN connection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--_9baadd92-7fa3-4c9b-bf09-5ecd24f6b9a1_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit

Hi,
 
   I've set up openvpn on my fedora as the server using the configuration from http://blog.fourthirty.org/?p=135. 
 
   Scenario: server fedora, client windows xp
 
 
    When I start openvpn on my server, I get:
 
Fri Aug 1 19:41:55 2008 OpenVPN 2.0.9 i686-pc-linux [SSL] [LZO] [EPOLL] built on Jul 24 2008 Fri Aug 1 19:41:55 2008 IMPORTANT: OpenVPN's default port number is now 1194 based on an official port number assignment by IANA. OpenVPN 2.0-beta16 and earlier used 5000 as the default port. Fri Aug 1 19:41:55 2008 TUN/TAP device tap0 opened  Fri Aug 1 19:41:55 2008 UDPv4 link local (bound) : [undef] : 114  Fri Aug 1 19:41:55 2008 UDPv4 link remote: [undef] 
 
But after this, when i typed "service openvpn status", I get "openvpn: service not started". (when I press "service openvpn start", it states "ok")
   
 
    When I try to start openvpn on my client, I will get an error: 
 
<date details>     OpenVPN 2.0.9 Win32-MiniGW [SSL] [LZO] built on Oct 1 2006
 
<date details>      IMPORTANT: OpenVPN's default port number is now 1194 based on an official port number assignment by IANA. OpenVPN 2.0-beta16 and earlier used 5000 as the default port. 
 
<date details>     Cannot load certificate file <directory of cert file>: error:0906D06C: PEM routines: PEM_read_bio: no start line: error: 140AD009: SSL routines: SSL_CTX_use_certificate_file: PEM lib
 
 
I've transferred ca.crt, ca.key, client1.crt, client1.csr, client1.key over to my client. Both the certificates contain "begin certificate, base 64 stuff, end certificate"
I've wrote down the full path to the certificates and keys in both the server and client configuration file and double checked.
 
Anybody can help me with this? I'm stuck with it for quite a few days already. Help greatly appreciated.
_________________________________________________________________
Manage multiple email accounts with Windows Live Mail effortlessly.
http://www.get.live.com/wl/all
--_9baadd92-7fa3-4c9b-bf09-5ecd24f6b9a1_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class='hmmessage'>Hi,<BR>
&nbsp;<BR>
&nbsp;&nbsp; I've set up openvpn on my fedora as the server using the configuration from <A href="http://blog.fourthirty.org/?p=135." target=_blank><FONT face="" color=#0033cc>http://blog.fourthirty.org/?p=135.</FONT></A> <BR>
&nbsp;<BR>
&nbsp;&nbsp; Scenario: server fedora, client windows xp<BR>
&nbsp;<BR>
&nbsp;<BR>
&nbsp;&nbsp;&nbsp; When&nbsp;I start openvpn on my server, I get:<BR>
&nbsp;<BR>
Fri Aug 1 19:41:55 2008 OpenVPN 2.0.9 i686-pc-linux [SSL] [LZO] [EPOLL] built on Jul 24 2008&nbsp;<BR>Fri Aug 1 19:41:55 2008 IMPORTANT: OpenVPN's default port number is now 1194 based on an official port number assignment by IANA. OpenVPN 2.0-beta16 and earlier used 5000 as the default port.&nbsp;<BR>Fri Aug 1 19:41:55 2008 TUN/TAP device tap0 opened &nbsp;<BR>Fri Aug 1 19:41:55 2008 UDPv4 link local (bound) : [undef] : 114 &nbsp;<BR>Fri Aug 1 19:41:55 2008 UDPv4 link remote: [undef]&nbsp;<BR>
&nbsp;<BR>
But after this, when i typed "service openvpn status", I get "openvpn: service not started". (when I press "service openvpn start", it states "ok")<BR>
&nbsp;&nbsp; <BR>
&nbsp;<BR>
&nbsp;&nbsp;&nbsp; When I try to start openvpn on my client, I will get an error: <BR>
&nbsp;<BR>
&lt;date details&gt;&nbsp;&nbsp;&nbsp;&nbsp; OpenVPN 2.0.9 Win32-MiniGW [SSL] [LZO] built on Oct 1 2006<BR>
&nbsp;<BR>
&lt;date details&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMPORTANT: OpenVPN's default port number is now 1194 based on an official port number assignment by IANA. OpenVPN 2.0-beta16 and earlier used 5000 as the default port.&nbsp;<BR>
&nbsp;<BR>
&lt;date details&gt;&nbsp;&nbsp;&nbsp;&nbsp; Cannot load certificate file &lt;directory of cert file&gt;: error:0906D06C: PEM routines: <FONT face="">PEM_read_bio</FONT>: no start line: error: 140AD009: SSL routines: <FONT face="">SSL_CTX_use_certificate_file</FONT>: PEM lib<BR>
&nbsp;<BR>
&nbsp;<BR>
I've transferred ca.crt, ca.key, client1.crt, client1.csr, client1.key over to my client. Both the certificates contain "begin certificate, base 64 stuff, end certificate"<BR>
I've wrote down the full&nbsp;path to the certificates and keys in both the server and client configuration file and double checked.<BR>
&nbsp;<BR>
Anybody can help me with this? I'm stuck with it for quite a few days already. Help greatly appreciated.<BR><br /><hr />Share your beautiful moments with Photo Gallery. <a href='http://get.live.com/photogallery/overview' target='_new'>Windows Live Photo Gallery</a></body>
</html>
--_9baadd92-7fa3-4c9b-bf09-5ecd24f6b9a1_--

