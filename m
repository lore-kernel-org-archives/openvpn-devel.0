From: Phillip Smith <fukawi2@...277...>
Date: Mon, 30 Nov 2015 14:03:58 +1100
Message-Id: <1448852638-2644-1-git-send-email-fukawi2@...277...>
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

This patch uses the generic "host1.example.com" and "host2.example.com" to
replace the current "may" and "june" hostname examples. Generic names chosen
rather than other names like "server"/"client" or "head-office"/"remote-office"
etc which may create other unintended or implicit meanings to the reader.
The example.com domain is set aside defined by IANA for use as documentation
examples. Refer to: http://www.iana.org/domains/reserved
Using this well-known domain makes comprehension of documentation easier.

Signed-off-by: Phillip Smith <fukawi2@...277...>
---
 doc/openvpn.8 | 84 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2978b7f..235bc26 100644
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
@@ -6600,16 +6600,17 @@ control which network
 traffic passes between the hosts 
 (a) over the VPN or (b) independently of the VPN, by choosing whether to use
 (a) the VPN endpoint address or (b) the public internet address,
-to access the remote host. For example if you are on may.kg and you wish to connect to june.kg
+to access the remote host. For example if you are on host1.example.com and you
+wish to connect to host2.example.com
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
 
@@ -6624,21 +6625,21 @@ you will get a weird feedback loop.
 .\"*********************************************************
 .SS Example 1: A simple tunnel without security
 .LP
-On may:
+On host1.example.com:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 9
+.B openvpn \-\-remote host2.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 9
 .LP
-On june:
+On host2.example.com:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 9
+.B openvpn \-\-remote host1.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 9
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
-On may:
+On host1.example.com:
 .IP
 .B ping 10.4.0.2
 .LP
-On june:
+On host2.example.com:
 .IP
 .B ping 10.4.0.1
 .LP
@@ -6651,7 +6652,7 @@ program.  Omit the
 option to have OpenVPN run quietly.
 .\"*********************************************************
 .SS Example 2: A tunnel with static-key security (i.e. using a pre-shared secret)
-First build a static key on may.
+First build a static key on host1.example.com.
 .IP
 .B openvpn \-\-genkey \-\-secret key
 .LP
@@ -6660,39 +6661,39 @@ This command will build a random key file called
 (in ascii format).
 Now copy
 .B key
-to june over a secure medium such as by
+to host2.example.com over a secure medium such as by
 using the
 .BR scp (1)
 program.
 .LP
-On may:
+On host1.example.com:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 5 \-\-secret key
+.B openvpn \-\-remote host2.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-verb 5 \-\-secret key
 .LP
-On june:
+On host2.example.com:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 5 \-\-secret key
+.B openvpn \-\-remote host1.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb 5 \-\-secret key
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
-On may:
+On host1.example.com:
 .IP
 .B ping 10.4.0.2
 .LP
-On june:
+On host2.example.com:
 .IP
 .B ping 10.4.0.1
 .\"*********************************************************
 .SS Example 3: A tunnel with full TLS-based security
 For this test, we will designate
-.B may
+.B host1.example.com
 as the TLS client and
-.B june
+.B host2.example.com
 as the TLS server.
 .I Note that client or server designation only has meaning for the TLS subsystem.  It has no bearing on OpenVPN's peer-to-peer, UDP-based communication model.
 
 First, build a separate certificate/key pair
-for both may and june (see above where
+for both host1.example.com and host2.example.com (see above where
 .B \-\-cert
 is discussed for more info).  Then construct
 Diffie Hellman parameters (see above where
@@ -6707,21 +6708,21 @@ client.crt and server.crt.  For Diffie Hellman
 parameters you can use the included file dh1024.pem.
 .I Note that all client, server, and certificate authority certificates and keys included in the OpenVPN distribution are totally insecure and should be used for testing only.
 .LP
-On may:
+On host1.example.com:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-tls\-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key \-\-reneg\-sec 60 \-\-verb 5
+.B openvpn \-\-remote host2.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-tls\-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key \-\-reneg\-sec 60 \-\-verb 5
 .LP
-On june:
+On host2.example.com:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-tls\-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key server.key \-\-reneg\-sec 60 \-\-verb 5
+.B openvpn \-\-remote host1.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-tls\-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key server.key \-\-reneg\-sec 60 \-\-verb 5
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
-On may:
+On host1.example.com:
 .IP
 .B ping 10.4.0.2
 .LP
-On june:
+On host2.example.com:
 .IP
 .B ping 10.4.0.1
 .LP
@@ -6741,12 +6742,11 @@ option to use OpenVPN's default key renegotiation interval of one hour.
 .SS Routing:
 Assuming you can ping across the tunnel,
 the next step is to route a real subnet over
-the secure tunnel.  Suppose that may and june have two network
-interfaces each, one connected
-to the internet, and the other to a private
-network.  Our goal is to securely connect
-both private networks.  We will assume that may's private subnet
-is 10.0.0.0/24 and june's is 10.0.1.0/24.
+the secure tunnel.  Suppose that On host1.example.com and host2.example.com
+have two network interfaces each, one connected to the internet, and the other
+to a private network.  Our goal is to securely connect both private networks.
+We will assume that host1.example.com's private subnet is 10.0.0.0/24 and
+host2.example.com's is 10.0.1.0/24.
 .LP
 First, ensure that IP forwarding is enabled on both peers.
 On Linux, enable routing:
@@ -6757,11 +6757,11 @@ and enable TUN packet forwarding through the firewall:
 .IP
 .B iptables \-A FORWARD \-i tun+ \-j ACCEPT
 .LP
-On may:
+On host1.example.com:
 .IP
 .B route add \-net 10.0.1.0 netmask 255.255.255.0 gw 10.4.0.2
 .LP
-On june:
+On host2.example.com:
 .IP
 .B route add \-net 10.0.0.0 netmask 255.255.255.0 gw 10.4.0.1
 .LP
-- 
2.6.2



