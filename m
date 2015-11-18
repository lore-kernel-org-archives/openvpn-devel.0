From: Phillip Smith <fukawi2@...277...>
Date: Wed, 18 Nov 2015 11:51:24 +1100
Message-Id: <1447807884-3734-1-git-send-email-fukawi2@...277...>
Subject: [Openvpn-devel] [PATCH] Use example.com to improve clarity of
	documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The example.com domain is set aside defined by IANA for use as documentation
examples. Refer to: http://www.iana.org/domains/reserved
Using this well-known domain makes comprehension of documentation easier.

Signed-off-by: Phillip Smith <fukawi2@...277...>
---
 doc/openvpn.8 | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2978b7f..295e9a5 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -6427,12 +6427,12 @@ and 1 for the CA certificate.
 .nf
 .ft 3
 .in +4
-X509_0_emailAddress=me@...430...
+X509_0_emailAddress=me@...1113...
 X509_0_CN=Test-Client
 X509_0_O=OpenVPN-TEST
 X509_0_ST=NA
 X509_0_C=KG
-X509_1_emailAddress=me@...430...
+X509_1_emailAddress=me@...1113...
 X509_1_O=OpenVPN-TEST
 X509_1_L=BISHKEK
 X509_1_ST=NA
@@ -6576,13 +6576,13 @@ for use with OpenVPN.
 .SS VPN Address Setup:
 For purposes
 of our example, our two machines will be called
-.B may.kg
+.B host1.example.com
 and
-.B june.kg.
+.B host2.example.com.
 If you are constructing a VPN over the internet, then replace
-.B may.kg
+.B host1.example.com
 and
-.B june.kg
+.B host2.example.com
 with the internet hostname or IP address that each machine will use
 to contact the other over the internet.
 
@@ -6590,8 +6590,8 @@ Now we will choose the tunnel endpoints.  Tunnel endpoints are
 private IP addresses that only have meaning in the context of
 the VPN.  Each machine will use the tunnel endpoint of the other
 machine to access it over the VPN.  In our example,
-the tunnel endpoint for may.kg
-will be 10.4.0.1 and for june.kg, 10.4.0.2.
+the tunnel endpoint for host1.example.com
+will be 10.4.0.1 and for host2.example.com, 10.4.0.2.
 
 Once the VPN is established, you have essentially
 created a secure alternate path between the two hosts
@@ -6600,16 +6600,16 @@ control which network
 traffic passes between the hosts 
 (a) over the VPN or (b) independently of the VPN, by choosing whether to use
 (a) the VPN endpoint address or (b) the public internet address,
-to access the remote host. For example if you are on may.kg and you wish to connect to june.kg
+to access the remote host. For example if you are on host1.example.com and you wish to connect to host2.example.com
 via
 .B ssh
 without using the VPN (since
 .B ssh
 has its own built-in security) you would use the command
-.B ssh june.kg.
+.B ssh host2.example.com.
 However in the same scenario, you could also use the command
 .B telnet 10.4.0.2
-to create a telnet session with june.kg over the VPN, that would
+to create a telnet session with host2.example.com over the VPN, that would
 use the VPN to secure the session rather than
 .B ssh.
 
@@ -6626,11 +6626,11 @@ you will get a weird feedback loop.
 .LP
 On may:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 9
+.B openvpn \-\-remote host2.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 9
 .LP
 On june:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 9
+.B openvpn \-\-remote host1.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 9
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
@@ -6667,11 +6667,11 @@ program.
 .LP
 On may:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 5 \-\-secret key
+.B openvpn \-\-remote host2.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 5 \-\-secret key
 .LP
 On june:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 5 \-\-secret key
+.B openvpn \-\-remote host1.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 5 \-\-secret key
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
@@ -6709,11 +6709,11 @@ parameters you can use the included file dh1024.pem.
 .LP
 On may:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-tls\-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key \-\-reneg\-sec 60 \-\-verb 5
+.B openvpn \-\-remote host2.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-tls\-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key \-\-reneg\-sec 60 \-\-verb 5
 .LP
 On june:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-tls\-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key server.key \-\-reneg\-sec 60 \-\-verb 5
+.B openvpn \-\-remote host1.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-tls\-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key server.key \-\-reneg\-sec 60 \-\-verb 5
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
@@ -6888,3 +6888,4 @@ as published by the Free Software Foundation.
 .\"*********************************************************
 .SH AUTHORS
 James Yonan <jim@...41...>
+Phillip Smith <fukawi2@...277...>
-- 
2.6.2



