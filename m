MIME-Version: 1.0
In-Reply-To: <1447807884-3734-1-git-send-email-fukawi2@...277...>
References: <1447807884-3734-1-git-send-email-fukawi2@...277...>
From: Phillip Smith <fukawi2@...277...>
Date: Tue, 24 Nov 2015 09:53:21 +1100
Message-ID: <CAKAE9iRth_T67hYed=a9feNz2zZ-bwaqJfhMavM_aTyiRfEvUQ@...278...>
Content-Type: multipart/alternative; boundary=001a113ef6bca8584e05253d1826
Subject: [Openvpn-devel] Fwd: [PATCH] Use example.com to improve clarity of
	documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a113ef6bca8584e05253d1826
Content-Type: text/plain; charset=UTF-8

Hi all,

I sent the below patch last week, but it doesn't seem to have made it to
the mail list for some reason, despite being delivered to SourceForge:
18 Nov 2015 12:07:31    openvpn-devel@lists.sourceforge.net
 216.34.181.68 accepted message./Remote host said: 250 OK
id=1ZyrDo-0007pR-Cm/

Cheers,
~p

---------- Forwarded message ----------
From: Phillip Smith <fukawi2@...277...>
Date: 18 November 2015 at 11:51
Subject: [PATCH] Use example.com to improve clarity of documentation
To: openvpn-devel@lists.sourceforge.net
Cc: Phillip Smith <fukawi2@...277...>


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

@@ -6590,8 +6590,8 @@ Now we will choose the tunnel endpoints.  Tunnel
endpoints are
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
 (a) over the VPN or (b) independently of the VPN, by choosing whether to
use
 (a) the VPN endpoint address or (b) the public internet address,
-to access the remote host. For example if you are on may.kg and you wish
to connect to june.kg
+to access the remote host. For example if you are on host1.example.com and
you wish to connect to host2.example.com
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
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2
\-\-verb 9
+.B openvpn \-\-remote host2.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1
10.4.0.2 \-\-verb 9
 .LP
 On june:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1
\-\-verb 9
+.B openvpn \-\-remote host1.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2
10.4.0.1 \-\-verb 9
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
@@ -6667,11 +6667,11 @@ program.
 .LP
 On may:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2
\-\-verb 5 \-\-secret key
+.B openvpn \-\-remote host2.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1
10.4.0.2 \-\-verb 5 \-\-secret key
 .LP
 On june:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1
\-\-verb 5 \-\-secret key
+.B openvpn \-\-remote host1.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2
10.4.0.1 \-\-verb 5 \-\-secret key
 .LP
 Now verify the tunnel is working by pinging across the tunnel.
 .LP
@@ -6709,11 +6709,11 @@ parameters you can use the included file dh1024.pem.
 .LP
 On may:
 .IP
-.B openvpn \-\-remote june.kg \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2
\-\-tls\-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key
\-\-reneg\-sec 60 \-\-verb 5
+.B openvpn \-\-remote host2.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.1
10.4.0.2 \-\-tls\-client \-\-ca ca.crt \-\-cert client.crt \-\-key
client.key \-\-reneg\-sec 60 \-\-verb 5
 .LP
 On june:
 .IP
-.B openvpn \-\-remote may.kg \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1
\-\-tls\-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key
server.key \-\-reneg\-sec 60 \-\-verb 5
+.B openvpn \-\-remote host1.example.com \-\-dev tun1 \-\-ifconfig 10.4.0.2
10.4.0.1 \-\-tls\-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert
server.crt \-\-key server.key \-\-reneg\-sec 60 \-\-verb 5
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

--001a113ef6bca8584e05253d1826
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Hi all,</div><div class=3D"gmail_default" style=3D"font-family:=
verdana,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fa=
mily:verdana,sans-serif">I sent the below patch last week, but it doesn&#39=
;t seem to have made it to the mail list for some reason, despite being del=
ivered to SourceForge:</div><div class=3D"gmail_default"><font face=3D"verd=
ana, sans-serif">18 Nov 2015 12:07:31 =C2=A0<span style=3D"white-space:pre"=
>=C2=A0    </span><a href=3D"mailto:openvpn-devel@lists.sourceforge.net">op=
envpn-devel@lists.sourceforge.net</a> =C2=A0 =C2=A0 =C2=A0216.34.181.68 acc=
epted message./Remote host said: 250 OK id=3D1ZyrDo-0007pR-Cm/</font><br></=
div><div class=3D"gmail_default"><font face=3D"verdana, sans-serif"><br></f=
ont></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-se=
rif">Cheers,</div><div class=3D"gmail_default" style=3D"font-family:verdana=
,sans-serif">~p</div>
<br><div class=3D"gmail_quote">---------- Forwarded message ----------<br>F=
rom: <b class=3D"gmail_sendername">Phillip Smith</b> <span dir=3D"ltr">&lt;=
<a href=3D"mailto:fukawi2@...277...">fukawi2@...277...</a>&gt;</span><br>Da=
te: 18 November 2015 at 11:51<br>Subject: [PATCH] Use <a href=3D"http://exa=
mple.com">example.com</a> to improve clarity of documentation<br>To: <a hre=
f=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1659...=
forge.net</a><br>Cc: Phillip Smith &lt;<a href=3D"mailto:fukawi2@...277..."=
>fukawi2@...277...</a>&gt;<br><br><br>The <a href=3D"http://example.com" re=
l=3D"noreferrer" target=3D"_blank">example.com</a> domain is set aside defi=
ned by IANA for use as documentation<br>
examples. Refer to: <a href=3D"http://www.iana.org/domains/reserved" rel=3D=
"noreferrer" target=3D"_blank">http://www.iana.org/domains/reserved</a><br>
Using this well-known domain makes comprehension of documentation easier.<b=
r>
<br>
Signed-off-by: Phillip Smith &lt;<a href=3D"mailto:fukawi2@...277...">fukaw=
i2@...277...</a>&gt;<br>
---<br>
=C2=A0doc/openvpn.8 | 35 ++++++++++++++++++-----------------<br>
=C2=A01 file changed, 18 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/doc/openvpn.8 b/doc/openvpn.8<br>
index 2978b7f..295e9a5 100644<br>
--- a/doc/openvpn.8<br>
+++ b/doc/openvpn.8<br>
@@ -6427,12 +6427,12 @@ and 1 for the CA certificate.<br>
=C2=A0.nf<br>
=C2=A0.ft 3<br>
=C2=A0.in +4<br>
-X509_0_emailAddress=3Dme@...430...<br>
+X509_0_emailAddress=3D<a href=3D"mailto:me@...1113...">me@...1113...</a><b=
r>
=C2=A0X509_0_CN=3DTest-Client<br>
=C2=A0X509_0_O=3DOpenVPN-TEST<br>
=C2=A0X509_0_ST=3DNA<br>
=C2=A0X509_0_C=3DKG<br>
-X509_1_emailAddress=3Dme@...430...<br>
+X509_1_emailAddress=3D<a href=3D"mailto:me@...1113...">me@...1113...</a><b=
r>
=C2=A0X509_1_O=3DOpenVPN-TEST<br>
=C2=A0X509_1_L=3DBISHKEK<br>
=C2=A0X509_1_ST=3DNA<br>
@@ -6576,13 +6576,13 @@ for use with OpenVPN.<br>
=C2=A0.SS VPN Address Setup:<br>
=C2=A0For purposes<br>
=C2=A0of our example, our two machines will be called<br>
-.B <a href=3D"http://may.kg" rel=3D"noreferrer" target=3D"_blank">may.kg</=
a><br>
+.B <a href=3D"http://host1.example.com" rel=3D"noreferrer" target=3D"_blan=
k">host1.example.com</a><br>
=C2=A0and<br>
-.B <a href=3D"http://june.kg" rel=3D"noreferrer" target=3D"_blank">june.kg=
</a>.<br>
+.B <a href=3D"http://host2.example.com" rel=3D"noreferrer" target=3D"_blan=
k">host2.example.com</a>.<br>
=C2=A0If you are constructing a VPN over the internet, then replace<br>
-.B <a href=3D"http://may.kg" rel=3D"noreferrer" target=3D"_blank">may.kg</=
a><br>
+.B <a href=3D"http://host1.example.com" rel=3D"noreferrer" target=3D"_blan=
k">host1.example.com</a><br>
=C2=A0and<br>
-.B <a href=3D"http://june.kg" rel=3D"noreferrer" target=3D"_blank">june.kg=
</a><br>
+.B <a href=3D"http://host2.example.com" rel=3D"noreferrer" target=3D"_blan=
k">host2.example.com</a><br>
=C2=A0with the internet hostname or IP address that each machine will use<b=
r>
=C2=A0to contact the other over the internet.<br>
<br>
@@ -6590,8 +6590,8 @@ Now we will choose the tunnel endpoints.=C2=A0 Tunnel=
 endpoints are<br>
=C2=A0private IP addresses that only have meaning in the context of<br>
=C2=A0the VPN.=C2=A0 Each machine will use the tunnel endpoint of the other=
<br>
=C2=A0machine to access it over the VPN.=C2=A0 In our example,<br>
-the tunnel endpoint for <a href=3D"http://may.kg" rel=3D"noreferrer" targe=
t=3D"_blank">may.kg</a><br>
-will be 10.4.0.1 and for <a href=3D"http://june.kg" rel=3D"noreferrer" tar=
get=3D"_blank">june.kg</a>, 10.4.0.2.<br>
+the tunnel endpoint for <a href=3D"http://host1.example.com" rel=3D"norefe=
rrer" target=3D"_blank">host1.example.com</a><br>
+will be 10.4.0.1 and for <a href=3D"http://host2.example.com" rel=3D"noref=
errer" target=3D"_blank">host2.example.com</a>, 10.4.0.2.<br>
<br>
=C2=A0Once the VPN is established, you have essentially<br>
=C2=A0created a secure alternate path between the two hosts<br>
@@ -6600,16 +6600,16 @@ control which network<br>
=C2=A0traffic passes between the hosts<br>
=C2=A0(a) over the VPN or (b) independently of the VPN, by choosing whether=
 to use<br>
=C2=A0(a) the VPN endpoint address or (b) the public internet address,<br>
-to access the remote host. For example if you are on <a href=3D"http://may=
.kg" rel=3D"noreferrer" target=3D"_blank">may.kg</a> and you wish to connec=
t to <a href=3D"http://june.kg" rel=3D"noreferrer" target=3D"_blank">june.k=
g</a><br>
+to access the remote host. For example if you are on <a href=3D"http://hos=
t1.example.com" rel=3D"noreferrer" target=3D"_blank">host1.example.com</a> =
and you wish to connect to <a href=3D"http://host2.example.com" rel=3D"nore=
ferrer" target=3D"_blank">host2.example.com</a><br>
=C2=A0via<br>
=C2=A0.B ssh<br>
=C2=A0without using the VPN (since<br>
=C2=A0.B ssh<br>
=C2=A0has its own built-in security) you would use the command<br>
-.B ssh <a href=3D"http://june.kg" rel=3D"noreferrer" target=3D"_blank">jun=
e.kg</a>.<br>
+.B ssh <a href=3D"http://host2.example.com" rel=3D"noreferrer" target=3D"_=
blank">host2.example.com</a>.<br>
=C2=A0However in the same scenario, you could also use the command<br>
=C2=A0.B telnet 10.4.0.2<br>
-to create a telnet session with <a href=3D"http://june.kg" rel=3D"noreferr=
er" target=3D"_blank">june.kg</a> over the VPN, that would<br>
+to create a telnet session with <a href=3D"http://host2.example.com" rel=
=3D"noreferrer" target=3D"_blank">host2.example.com</a> over the VPN, that =
would<br>
=C2=A0use the VPN to secure the session rather than<br>
=C2=A0.B ssh.<br>
<br>
@@ -6626,11 +6626,11 @@ you will get a weird feedback loop.<br>
=C2=A0.LP<br>
=C2=A0On may:<br>
=C2=A0.IP<br>
-.B openvpn \-\-remote <a href=3D"http://june.kg" rel=3D"noreferrer" target=
=3D"_blank">june.kg</a> \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-ver=
b 9<br>
+.B openvpn \-\-remote <a href=3D"http://host2.example.com" rel=3D"noreferr=
er" target=3D"_blank">host2.example.com</a> \-\-dev tun1 \-\-ifconfig 10.4.=
0.1 10.4.0.2 \-\-verb 9<br>
=C2=A0.LP<br>
=C2=A0On june:<br>
=C2=A0.IP<br>
-.B openvpn \-\-remote <a href=3D"http://may.kg" rel=3D"noreferrer" target=
=3D"_blank">may.kg</a> \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb=
 9<br>
+.B openvpn \-\-remote <a href=3D"http://host1.example.com" rel=3D"noreferr=
er" target=3D"_blank">host1.example.com</a> \-\-dev tun1 \-\-ifconfig 10.4.=
0.2 10.4.0.1 \-\-verb 9<br>
=C2=A0.LP<br>
=C2=A0Now verify the tunnel is working by pinging across the tunnel.<br>
=C2=A0.LP<br>
@@ -6667,11 +6667,11 @@ program.<br>
=C2=A0.LP<br>
=C2=A0On may:<br>
=C2=A0.IP<br>
-.B openvpn \-\-remote <a href=3D"http://june.kg" rel=3D"noreferrer" target=
=3D"_blank">june.kg</a> \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-ver=
b 5 \-\-secret key<br>
+.B openvpn \-\-remote <a href=3D"http://host2.example.com" rel=3D"noreferr=
er" target=3D"_blank">host2.example.com</a> \-\-dev tun1 \-\-ifconfig 10.4.=
0.1 10.4.0.2 \-\-verb 5 \-\-secret key<br>
=C2=A0.LP<br>
=C2=A0On june:<br>
=C2=A0.IP<br>
-.B openvpn \-\-remote <a href=3D"http://may.kg" rel=3D"noreferrer" target=
=3D"_blank">may.kg</a> \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-verb=
 5 \-\-secret key<br>
+.B openvpn \-\-remote <a href=3D"http://host1.example.com" rel=3D"noreferr=
er" target=3D"_blank">host1.example.com</a> \-\-dev tun1 \-\-ifconfig 10.4.=
0.2 10.4.0.1 \-\-verb 5 \-\-secret key<br>
=C2=A0.LP<br>
=C2=A0Now verify the tunnel is working by pinging across the tunnel.<br>
=C2=A0.LP<br>
@@ -6709,11 +6709,11 @@ parameters you can use the included file dh1024.pem=
.<br>
=C2=A0.LP<br>
=C2=A0On may:<br>
=C2=A0.IP<br>
-.B openvpn \-\-remote <a href=3D"http://june.kg" rel=3D"noreferrer" target=
=3D"_blank">june.kg</a> \-\-dev tun1 \-\-ifconfig 10.4.0.1 10.4.0.2 \-\-tls=
\-client \-\-ca ca.crt \-\-cert client.crt \-\-key client.key \-\-reneg\-se=
c 60 \-\-verb 5<br>
+.B openvpn \-\-remote <a href=3D"http://host2.example.com" rel=3D"noreferr=
er" target=3D"_blank">host2.example.com</a> \-\-dev tun1 \-\-ifconfig 10.4.=
0.1 10.4.0.2 \-\-tls\-client \-\-ca ca.crt \-\-cert client.crt \-\-key clie=
nt.key \-\-reneg\-sec 60 \-\-verb 5<br>
=C2=A0.LP<br>
=C2=A0On june:<br>
=C2=A0.IP<br>
-.B openvpn \-\-remote <a href=3D"http://may.kg" rel=3D"noreferrer" target=
=3D"_blank">may.kg</a> \-\-dev tun1 \-\-ifconfig 10.4.0.2 10.4.0.1 \-\-tls\=
-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert server.crt \-\-key server.=
key \-\-reneg\-sec 60 \-\-verb 5<br>
+.B openvpn \-\-remote <a href=3D"http://host1.example.com" rel=3D"noreferr=
er" target=3D"_blank">host1.example.com</a> \-\-dev tun1 \-\-ifconfig 10.4.=
0.2 10.4.0.1 \-\-tls\-server \-\-dh dh1024.pem \-\-ca ca.crt \-\-cert serve=
r.crt \-\-key server.key \-\-reneg\-sec 60 \-\-verb 5<br>
=C2=A0.LP<br>
=C2=A0Now verify the tunnel is working by pinging across the tunnel.<br>
=C2=A0.LP<br>
@@ -6888,3 +6888,4 @@ as published by the Free Software Foundation.<br>
=C2=A0.\&quot;*********************************************************<br>
=C2=A0.SH AUTHORS<br>
=C2=A0James Yonan &lt;<a href=3D"mailto:jim@...41...">jim@...41...</a>&gt;<=
br>
+Phillip Smith &lt;<a href=3D"mailto:fukawi2@...277...">fukawi2@...277...</=
a>&gt;<br>
<span class=3D""><font color=3D"#888888">--<br>
2.6.2<br>
<br>
<br>
</font></span></div><br></div>

--001a113ef6bca8584e05253d1826--

