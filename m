From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 25 Mar 2024 12:55:10 +0000
In-Reply-To: <gerrit.1709557301000.I1a36651c0dea52259533ffc00bccb9b03bf82e26@...2715...>
References: <gerrit.1709557301000.I1a36651c0dea52259533ffc00bccb9b03bf82e26@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <08d6a48552d200ae8c11033b591d9efb276c7fca-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EPQ0RlosxcA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: samples: Update
 sample configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EPQ0RlosxcA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/532?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: samples: Update sample configurations
......................................................................

samples: Update sample configurations

- Remove compression settings. Not recommended anymore.
- Remove old cipher setting. Replaced by data-ciphers negotiation.
- Add comment how to set data-ciphers for very old clients.
- Remove/reword some old comments. e.g. no need to reference
  OpenVPN 1.x anymore.
- Mention peer-fingerprint alternative.
- comment out "tls-auth" as that is not needed for a bare-bones VPN config
  and needs additional setup.

Github: #511
Change-Id: I1a36651c0dea52259533ffc00bccb9b03bf82e26
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240325071320.11348-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
451.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M sample/sample-config-files/README
M sample/sample-config-files/client.conf
M sample/sample-config-files/server.conf
3 files changed, 33 insertions(+), 43 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/532/5

diff --git a/sample/sample-config-files/README b/sample/sample-config-files=
/README
index d53ac79..1493dab 100644
--- a/sample/sample-config-files/README
+++ b/sample/sample-config-files/README
@@ -4,3 +4,5 @@
 which is located at:

 http://openvpn.net/howto.html
+
+See also the openvpn-examples man page.
diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-=
files/client.conf
index f51e017..53b8027 100644
--- a/sample/sample-config-files/client.conf
+++ b/sample/sample-config-files/client.conf
@@ -1,5 +1,5 @@
 ##############################################
-# Sample client-side OpenVPN 2.0 config file #
+# Sample client-side OpenVPN 2.6 config file #
 # for connecting to multi-client server.     #
 #                                            #
 # This configuration can be used by multiple #
@@ -102,22 +102,15 @@
 # EasyRSA can do this for you.
 remote-cert-tls server

+# Allow to connect to really old OpenVPN versions
+# without AEAD support (OpenVPN 2.3.x or older)
+# This adds AES-256-CBC as fallback cipher and
+# keeps the modern ciphers as well.
+;data-ciphers AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305:AES-256-CBC
+
 # If a tls-auth key is used on the server
 # then every client must also have the key.
-tls-auth ta.key 1
-
-# Select a cryptographic cipher.
-# If the cipher option is used on the server
-# then you must also specify it here.
-# Note that v2.4 client/server will automatically
-# negotiate AES-256-GCM in TLS mode.
-# See also the data-ciphers option in the manpage
-cipher AES-256-CBC
-
-# Enable compression on the VPN link.
-# Don't enable this unless it is also
-# enabled in the server config file.
-#comp-lzo
+;tls-auth ta.key 1

 # Set log file verbosity.
 verb 3
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-=
files/server.conf
index 97732c6..48716a0 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -1,5 +1,5 @@
 #################################################
-# Sample OpenVPN 2.0 config file for            #
+# Sample OpenVPN 2.6 config file for            #
 # multi-client server.                          #
 #                                               #
 # This file is for the server side              #
@@ -47,15 +47,15 @@
 # an explicit unit number, such as tun0.
 # On Windows, use "dev-node" for this.
 # On most systems, the VPN will not function
-# unless you partially or fully disable
+# unless you partially or fully disable/open
 # the firewall for the TUN/TAP interface.
 ;dev tap
 dev tun

 # Windows needs the TAP-Win32 adapter name
 # from the Network Connections panel if you
-# have more than one.  On XP SP2 or higher,
-# you may need to selectively disable the
+# have more than one.
+# You may need to selectively disable the
 # Windows firewall for the TAP adapter.
 # Non-Windows systems usually don't need this.
 ;dev-node MyTap
@@ -66,8 +66,9 @@
 # key file.  The server and all clients will
 # use the same ca file.
 #
-# See the "easy-rsa" directory for a series
-# of scripts for generating RSA certificates
+# See the "easy-rsa" project at
+# https://github.com/OpenVPN/easy-rsa
+# for generating RSA certificates
 # and private keys.  Remember to use
 # a unique Common Name for the server
 # and each of the client certificates.
@@ -75,6 +76,13 @@
 # Any X509 key management system can be used.
 # OpenVPN can also use a PKCS #12 formatted key file
 # (see "pkcs12" directive in man page).
+#
+# If you do not want to maintain a CA
+# and have a small number of clients
+# you can also use self-signed certificates
+# and use the peer-fingerprint option.
+# See openvpn-examples man page for a
+# configuration example.
 ca ca.crt
 cert server.crt
 key server.key  # This file should be kept secret
@@ -84,12 +92,18 @@
 #   openssl dhparam -out dh2048.pem 2048
 dh dh2048.pem

+# Allow to connect to really old OpenVPN versions
+# without AEAD support (OpenVPN 2.3.x or older)
+# This adds AES-256-CBC as fallback cipher and
+# keeps the modern ciphers as well.
+;data-ciphers AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305:AES-256-CBC
+
 # Network topology
 # Should be subnet (addressing via IP)
 # unless Windows clients v2.0.9 and lower have to
 # be supported (then net30, i.e. a /30 per client)
 # Defaults to net30 (not recommended)
-;topology subnet
+topology subnet

 # Configure server mode and supply a VPN subnet
 # for OpenVPN to draw client addresses from.
@@ -218,7 +232,7 @@
 # IF YOU HAVE NOT GENERATED INDIVIDUAL
 # CERTIFICATE/KEY PAIRS FOR EACH CLIENT,
 # EACH HAVING ITS OWN UNIQUE "COMMON NAME",
-# UNCOMMENT THIS LINE OUT.
+# UNCOMMENT THIS LINE.
 ;duplicate-cn

 # The keepalive directive causes ping-like
@@ -241,26 +255,7 @@
 # a copy of this key.
 # The second parameter should be '0'
 # on the server and '1' on the clients.
-tls-auth ta.key 0 # This file is secret
-
-# Select a cryptographic cipher.
-# This config item must be copied to
-# the client config file as well.
-# Note that v2.4 client/server will automatically
-# negotiate AES-256-GCM in TLS mode.
-# See also the ncp-cipher option in the manpage
-cipher AES-256-CBC
-
-# Enable compression on the VPN link and push the
-# option to the client (v2.4+ only, for earlier
-# versions see below)
-;compress lz4-v2
-;push "compress lz4-v2"
-
-# For compression compatible with older clients use comp-lzo
-# If you enable it here, you must also
-# enable it in the client config file.
-;comp-lzo
+;tls-auth ta.key 0 # This file is secret

 # The maximum number of concurrently connected
 # clients we want to allow.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/532?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a36651c0dea52259533ffc00bccb9b03bf82e26
Gerrit-Change-Number: 532
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--EPQ0RlosxcA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/532?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">samples: Update sample configurations<br><br>- R=
emove compression settings. Not recommended anymore.<br>- Remove old cipher=
 setting. Replaced by data-ciphers negotiation.<br>- Add comment how to set=
 data-ciphers for very old clients.<br>- Remove/reword some old comments. e=
.g. no need to reference<br>  OpenVPN 1.x anymore.<br>- Mention peer-finger=
print alternative.<br>- comment out &quot;tls-auth&quot; as that is not nee=
ded for a bare-bones VPN config<br>  and needs additional setup.<br><br>Git=
hub: #511<br>Change-Id: I1a36651c0dea52259533ffc00bccb9b03bf82e26<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwa=
be &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20240325071320.11348-=
1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg28451.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M sample/sample-config-files/README<br>M sample/sam=
ple-config-files/client.conf<br>M sample/sample-config-files/server.conf<br=
>3 files changed, 33 insertions(+), 43 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/32/532/5</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/sample/sample-config-files/README b/sample/sample-config-files/README</s=
pan><br><span>index d53ac79..1493dab 100644</span><br><span>--- a/sample/sa=
mple-config-files/README</span><br><span>+++ b/sample/sample-config-files/R=
EADME</span><br><span>@@ -4,3 +4,5 @@</span><br><span> which is located at:=
</span><br><span> </span><br><span> http://openvpn.net/howto.html</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+See also the openvpn-examples man page.</span><b=
r><span>diff --git a/sample/sample-config-files/client.conf b/sample/sample=
-config-files/client.conf</span><br><span>index f51e017..53b8027 100644</sp=
an><br><span>--- a/sample/sample-config-files/client.conf</span><br><span>+=
++ b/sample/sample-config-files/client.conf</span><br><span>@@ -1,5 +1,5 @@=
</span><br><span> ##############################################</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# Sample client-side OpenVPN 2.0=
 config file #</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Sam=
ple client-side OpenVPN 2.6 config file #</span><br><span> # for connecting=
 to multi-client server.     #</span><br><span> #                          =
                  #</span><br><span> # This configuration can be used by mu=
ltiple #</span><br><span>@@ -102,22 +102,15 @@</span><br><span> # EasyRSA c=
an do this for you.</span><br><span> remote-cert-tls server</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Allow to connec=
t to really old OpenVPN versions</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# without AEAD support (OpenVPN 2.3.x or older)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# This adds AES-256-CBC as fallbac=
k cipher and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# keeps=
 the modern ciphers as well.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+;data-ciphers AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305:AES-256-C=
BC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 # If a tls-auth key is used on the server</span><br><span> # then every cl=
ient must also have the key.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-tls-auth ta.key 1</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Select a cryptog=
raphic cipher.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# If th=
e cipher option is used on the server</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# then you must also specify it here.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# Note that v2.4 client/server will automat=
ically</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# negotiate AES=
-256-GCM in TLS mode.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# See also the data-ciphers option in the manpage</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-cipher AES-256-CBC</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-# Enable compression on the VPN link.</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-# Don&#39;t enable this unless it is also</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# enabled in the server config file=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#comp-lzo</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+;tls-auth ta.key 1</span><br><=
span> </span><br><span> # Set log file verbosity.</span><br><span> verb 3</=
span><br><span>diff --git a/sample/sample-config-files/server.conf b/sample=
/sample-config-files/server.conf</span><br><span>index 97732c6..48716a0 100=
644</span><br><span>--- a/sample/sample-config-files/server.conf</span><br>=
<span>+++ b/sample/sample-config-files/server.conf</span><br><span>@@ -1,5 =
+1,5 @@</span><br><span> #################################################<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Sample OpenVPN 2.0 c=
onfig file for            #</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# Sample OpenVPN 2.6 config file for            #</span><br><span> =
# multi-client server.                          #</span><br><span> #       =
                                        #</span><br><span> # This file is f=
or the server side              #</span><br><span>@@ -47,15 +47,15 @@</span=
><br><span> # an explicit unit number, such as tun0.</span><br><span> # On =
Windows, use &quot;dev-node&quot; for this.</span><br><span> # On most syst=
ems, the VPN will not function</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# unless you partially or fully disable</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# unless you partially or fully disable/open</=
span><br><span> # the firewall for the TUN/TAP interface.</span><br><span> =
;dev tap</span><br><span> dev tun</span><br><span> </span><br><span> # Wind=
ows needs the TAP-Win32 adapter name</span><br><span> # from the Network Co=
nnections panel if you</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# have more than one.  On XP SP2 or higher,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# you may need to selectively disable the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# have more than one.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# You may need to selectivel=
y disable the</span><br><span> # Windows firewall for the TAP adapter.</spa=
n><br><span> # Non-Windows systems usually don&#39;t need this.</span><br><=
span> ;dev-node MyTap</span><br><span>@@ -66,8 +66,9 @@</span><br><span> # =
key file.  The server and all clients will</span><br><span> # use the same =
ca file.</span><br><span> #</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# See the &quot;easy-rsa&quot; directory for a series</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-# of scripts for generating RSA certi=
ficates</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# See the &q=
uot;easy-rsa&quot; project at</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# https://github.com/OpenVPN/easy-rsa</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# for generating RSA certificates</span><br><sp=
an> # and private keys.  Remember to use</span><br><span> # a unique Common=
 Name for the server</span><br><span> # and each of the client certificates=
.</span><br><span>@@ -75,6 +76,13 @@</span><br><span> # Any X509 key manage=
ment system can be used.</span><br><span> # OpenVPN can also use a PKCS #12=
 formatted key file</span><br><span> # (see &quot;pkcs12&quot; directive in=
 man page).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# If you do not want to ma=
intain a CA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# and ha=
ve a small number of clients</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# you can also use self-signed certificates</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# and use the peer-fingerprint option.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# See openvpn-examples=
 man page for a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# co=
nfiguration example.</span><br><span> ca ca.crt</span><br><span> cert serve=
r.crt</span><br><span> key server.key  # This file should be kept secret</s=
pan><br><span>@@ -84,12 +92,18 @@</span><br><span> #   openssl dhparam -out=
 dh2048.pem 2048</span><br><span> dh dh2048.pem</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# Allow to connect to really =
old OpenVPN versions</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# without AEAD support (OpenVPN 2.3.x or older)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# This adds AES-256-CBC as fallback cipher and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# keeps the modern =
ciphers as well.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+;da=
ta-ciphers AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305:AES-256-CBC</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Network t=
opology</span><br><span> # Should be subnet (addressing via IP)</span><br><=
span> # unless Windows clients v2.0.9 and lower have to</span><br><span> # =
be supported (then net30, i.e. a /30 per client)</span><br><span> # Default=
s to net30 (not recommended)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-;topology subnet</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+topology subnet</span><br><span> </span><br><span> # Configure server m=
ode and supply a VPN subnet</span><br><span> # for OpenVPN to draw client a=
ddresses from.</span><br><span>@@ -218,7 +232,7 @@</span><br><span> # IF YO=
U HAVE NOT GENERATED INDIVIDUAL</span><br><span> # CERTIFICATE/KEY PAIRS FO=
R EACH CLIENT,</span><br><span> # EACH HAVING ITS OWN UNIQUE &quot;COMMON N=
AME&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# UNCOMMENT=
 THIS LINE OUT.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# UN=
COMMENT THIS LINE.</span><br><span> ;duplicate-cn</span><br><span> </span><=
br><span> # The keepalive directive causes ping-like</span><br><span>@@ -24=
1,26 +255,7 @@</span><br><span> # a copy of this key.</span><br><span> # Th=
e second parameter should be &#39;0&#39;</span><br><span> # on the server a=
nd &#39;1&#39; on the clients.</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-tls-auth ta.key 0 # This file is secret</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# Select a cryptographic cipher.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# This config item must be copied to</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# the client config file as well.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-# Note that v2.4 client/server =
will automatically</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# n=
egotiate AES-256-GCM in TLS mode.</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# See also the ncp-cipher option in the manpage</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-cipher AES-256-CBC</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-# Enable compression on the VPN link and push the</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# option to the client (v2.4+ onl=
y, for earlier</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# versi=
ons see below)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-;compre=
ss lz4-v2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-;push &quot;=
compress lz4-v2&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# For compression com=
patible with older clients use comp-lzo</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# If you enable it here, you must also</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# enable it in the client config file.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-;comp-lzo</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+;tls-auth ta.key 0 # This file is=
 secret</span><br><span> </span><br><span> # The maximum number of concurre=
ntly connected</span><br><span> # clients we want to allow.</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/532?usp=3Demail">change 532</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/532?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a36651c0dea52259533ffc00bc=
cb9b03bf82e26 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 532 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--EPQ0RlosxcA=--

