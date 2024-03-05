From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 5 Mar 2024 21:02:08 +0000
In-Reply-To: <gerrit.1709557301000.I199541fea5a76c8edef7f67d2dbfc476987dc2f7@...2715...>
References: <gerrit.1709557301000.I199541fea5a76c8edef7f67d2dbfc476987dc2f7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <55397767fd6918579f9a99819d46ca1d406b7c9a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9FbXkiuyd5o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: samples: Remove
 tls-*.conf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9FbXkiuyd5o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/53=
1?usp=3Demail )

Change subject: samples: Remove tls-*.conf
......................................................................

samples: Remove tls-*.conf

These are mostly redundant with client/server.conf
Let's try to manage to maintain one set of sample
configurations before we branch out further.

Change-Id: I199541fea5a76c8edef7f67d2dbfc476987dc2f7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Antonio Quartulli <a@...2181...>
Message-Id: <20240304161556.2036270-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
316.html
Signed-off-by: Gert Doering <gert@...1296...>
---
D sample/sample-config-files/home.up
D sample/sample-config-files/office.up
D sample/sample-config-files/tls-home.conf
D sample/sample-config-files/tls-office.conf
4 files changed, 0 insertions(+), 173 deletions(-)




diff --git a/sample/sample-config-files/home.up b/sample/sample-config-file=
s/home.up
deleted file mode 100755
index 9c347cc..0000000
--- a/sample/sample-config-files/home.up
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/sh
-route add -net 10.0.0.0 netmask 255.255.255.0 gw $5
diff --git a/sample/sample-config-files/office.up b/sample/sample-config-fi=
les/office.up
deleted file mode 100755
index 74a71a3..0000000
--- a/sample/sample-config-files/office.up
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/sh
-route add -net 10.0.1.0 netmask 255.255.255.0 gw $5
diff --git a/sample/sample-config-files/tls-home.conf b/sample/sample-confi=
g-files/tls-home.conf
deleted file mode 100644
index ff19d50..0000000
--- a/sample/sample-config-files/tls-home.conf
+++ /dev/null
@@ -1,83 +0,0 @@
-#
-# Sample OpenVPN configuration file for
-# home using SSL/TLS mode and RSA certificates/keys.
-#
-# '#' or ';' may be used to delimit comments.
-
-# Use a dynamic tun device.  For non-Linux OSes, you may want to use an
-# explicit unit number such as "tun1".
-# OpenVPN also supports virtual ethernet "tap" devices.
-dev tun
-
-# Our OpenVPN peer is the office gateway.
-remote 1.2.3.4
-
-# 10.1.0.2 is our local VPN endpoint (home).
-# 10.1.0.1 is our remote VPN endpoint (office).
-ifconfig 10.1.0.2 10.1.0.1
-
-# Our up script will establish routes
-# once the VPN is alive.
-up ./home.up
-
-# In SSL/TLS key exchange, Office will
-# assume server role and Home
-# will assume client role.
-tls-client
-
-# Certificate Authority file
-ca my-ca.crt
-
-# Our certificate/public key
-cert home.crt
-
-# Our private key
-key home.key
-
-# Our data channel cipher (must match peer config)
-cipher AES-256-GCM
-
-# OpenVPN 2.0 uses UDP port 1194 by default
-# (official port assignment by iana.org 11/04).
-# OpenVPN 1.x uses UDP port 5000 by default.
-# Each OpenVPN tunnel must use
-# a different port number.
-# lport or rport can be used
-# to denote different ports
-# for local and remote.
-; port 1194
-
-# Downgrade UID and GID to an
-# unpriviledged user after initialization
-# for extra security.
-; user openvpn
-; group openvpn
-
-# If you built OpenVPN with
-# LZO compression, uncomment
-# out the following line.
-; comp-lzo
-
-# Send a UDP ping to remote once
-# every 15 seconds to keep
-# stateful firewall connection
-# alive.  Uncomment this
-# out if you are using a stateful
-# firewall.
-; ping 15
-
-# Uncomment this section for a more reliable detection when a system
-# loses its connection.  For example, dial-ups or laptops that
-# travel to other locations.
-; ping 15
-; ping-restart 45
-; ping-timer-rem
-; persist-tun
-; persist-key
-
-# Verbosity level.
-# 0 -- quiet except for fatal errors.
-# 1 -- mostly quiet, but display non-fatal network errors.
-# 3 -- medium output, good for normal operation.
-# 9 -- verbose, good for troubleshooting
-verb 3
diff --git a/sample/sample-config-files/tls-office.conf b/sample/sample-con=
fig-files/tls-office.conf
deleted file mode 100644
index 152e58a..0000000
--- a/sample/sample-config-files/tls-office.conf
+++ /dev/null
@@ -1,86 +0,0 @@
-#
-# Sample OpenVPN configuration file for
-# office using SSL/TLS mode and RSA certificates/keys.
-#
-# '#' or ';' may be used to delimit comments.
-
-# Use a dynamic tun device.
-# For Linux 2.2 or non-Linux OSes,
-# you may want to use an explicit
-# unit number such as "tun1".
-# OpenVPN also supports virtual
-# ethernet "tap" devices.
-dev tun
-
-# 10.1.0.1 is our local VPN endpoint (office).
-# 10.1.0.2 is our remote VPN endpoint (home).
-ifconfig 10.1.0.1 10.1.0.2
-
-# Our up script will establish routes
-# once the VPN is alive.
-up ./office.up
-
-# In SSL/TLS key exchange, Office will
-# assume server role and Home
-# will assume client role.
-tls-server
-
-# Diffie-Hellman Parameters (tls-server only)
-dh dh2048.pem
-
-# Certificate Authority file
-ca my-ca.crt
-
-# Our certificate/public key
-cert office.crt
-
-# Our private key
-key office.key
-
-# Our data channel cipher (must match peer config)
-cipher AES-256-GCM
-
-# OpenVPN 2.0 uses UDP port 1194 by default
-# (official port assignment by iana.org 11/04).
-# OpenVPN 1.x uses UDP port 5000 by default.
-# Each OpenVPN tunnel must use
-# a different port number.
-# lport or rport can be used
-# to denote different ports
-# for local and remote.
-; port 1194
-
-# Downgrade UID and GID to an
-# unpriviledged user after initialization
-# for extra security.
-; user openvpn
-; group openvpn
-
-# If you built OpenVPN with
-# LZO compression, uncomment
-# out the following line.
-; comp-lzo
-
-# Send a UDP ping to remote once
-# every 15 seconds to keep
-# stateful firewall connection
-# alive.  Uncomment this
-# out if you are using a stateful
-# firewall.
-; ping 15
-
-# Uncomment this section for a more reliable detection when a system
-# loses its connection.  For example, dial-ups or laptops that
-# travel to other locations.
-; ping 15
-; ping-restart 45
-; ping-timer-rem
-; persist-tun
-; persist-key
-
-# Verbosity level.
-# 0 -- quiet except for fatal errors.
-# 1 -- mostly quiet, but display non-fatal network errors.
-# 3 -- medium output, good for normal operation.
-# 9 -- verbose, good for troubleshooting
-verb 3

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/531?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I199541fea5a76c8edef7f67d2dbfc476987dc2f7
Gerrit-Change-Number: 531
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--9FbXkiuyd5o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/531?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">samples: Remove tls-*.conf<br><br>These are mo=
stly redundant with client/server.conf<br>Let&#39;s try to manage to mainta=
in one set of sample<br>configurations before we branch out further.<br><br=
>Change-Id: I199541fea5a76c8edef7f67d2dbfc476987dc2f7<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-=
openvpn@...1227...&gt;<br>Acked-by: Antonio Quartulli &lt;a@...2181...&gt;<=
br>Message-Id: &lt;20240304161556.2036270-1-frank@...2641...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28316.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>D sample=
/sample-config-files/home.up<br>D sample/sample-config-files/office.up<br>D=
 sample/sample-config-files/tls-home.conf<br>D sample/sample-config-files/t=
ls-office.conf<br>4 files changed, 0 insertions(+), 173 deletions(-)<br><br=
></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/sample/sample-config-files/home.up b/sample/sample-config-f=
iles/home.up</span><br><span>deleted file mode 100755</span><br><span>index=
 9c347cc..0000000</span><br><span>--- a/sample/sample-config-files/home.up<=
/span><br><span>+++ /dev/null</span><br><span>@@ -1,2 +0,0 @@</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-route add -net 10.0.0.0 netmask 255.255.255.0 g=
w $5</span><br><span>diff --git a/sample/sample-config-files/office.up b/sa=
mple/sample-config-files/office.up</span><br><span>deleted file mode 100755=
</span><br><span>index 74a71a3..0000000</span><br><span>--- a/sample/sample=
-config-files/office.up</span><br><span>+++ /dev/null</span><br><span>@@ -1=
,2 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-route add -net 10.0.1.0=
 netmask 255.255.255.0 gw $5</span><br><span>diff --git a/sample/sample-con=
fig-files/tls-home.conf b/sample/sample-config-files/tls-home.conf</span><b=
r><span>deleted file mode 100644</span><br><span>index ff19d50..0000000</sp=
an><br><span>--- a/sample/sample-config-files/tls-home.conf</span><br><span=
>+++ /dev/null</span><br><span>@@ -1,83 +0,0 @@</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# Sample OpenVPN configuration file for</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-# home using SSL/TLS mode and RSA certificates/keys=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# &#39;#&#39; or &#39;;&#39; may be used=
 to delimit comments.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Use a dynamic tun d=
evice.  For non-Linux OSes, you may want to use an</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# explicit unit number such as &quot;tun1&quot=
;.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# OpenVPN also supp=
orts virtual ethernet &quot;tap&quot; devices.</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-dev tun</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Our Open=
VPN peer is the office gateway.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-remote 1.2.3.4</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# 10.1.0.2 is our =
local VPN endpoint (home).</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# 10.1.0.1 is our remote VPN endpoint (office).</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ifconfig 10.1.0.2 10.1.0.1</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# Our up script will establish routes</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# once the VPN is alive.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-up ./home.up</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# In SSL/TLS key exchange, Office will</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-# assume server role and Home</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# will assume client role.</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-tls-client</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# Certificate Authority file</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-ca my-ca.crt</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Our certificate/=
public key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cert home.c=
rt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# Our private key</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-key home.key</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-# Our data channel cipher (must match peer config)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-cipher AES-256-GCM</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# OpenVPN 2.0 uses UDP port 1194 by default</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# (official port assignment by iana.org 11/=
04).</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# OpenVPN 1.x use=
s UDP port 5000 by default.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# Each OpenVPN tunnel must use</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-# a different port number.</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-# lport or rport can be used</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# to denote different ports</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# for local and remote.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-; port 1194</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-# Downgrade UID and GID to an</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# unpriviledged user after initialization</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# for extra security.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-; user openvpn</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-; group openvpn</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
If you built OpenVPN with</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-# LZO compression, uncomment</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# out the following line.</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-; comp-lzo</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Send a UDP ping=
 to remote once</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# ever=
y 15 seconds to keep</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
 stateful firewall connection</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# alive.  Uncomment this</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# out if you are using a stateful</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# firewall.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-; ping 15</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Uncomment this sec=
tion for a more reliable detection when a system</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# loses its connection.  For example, dial-ups o=
r laptops that</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# trave=
l to other locations.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
; ping 15</span><br><span style=3D"color: hsl(0, 100%, 40%);">-; ping-resta=
rt 45</span><br><span style=3D"color: hsl(0, 100%, 40%);">-; ping-timer-rem=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-; persist-tun</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-; persist-key</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# Verbosity level.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-# 0 -- quiet except for fatal errors.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# 1 -- mostly quiet, but display non-fatal =
network errors.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# 3 --=
 medium output, good for normal operation.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-# 9 -- verbose, good for troubleshooting</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-verb 3</span><br><span>diff --git a=
/sample/sample-config-files/tls-office.conf b/sample/sample-config-files/tl=
s-office.conf</span><br><span>deleted file mode 100644</span><br><span>inde=
x 152e58a..0000000</span><br><span>--- a/sample/sample-config-files/tls-off=
ice.conf</span><br><span>+++ /dev/null</span><br><span>@@ -1,86 +0,0 @@</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# Sample OpenVPN configuration file for</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# office using SSL/TLS mo=
de and RSA certificates/keys.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# &#39;#&#39=
; or &#39;;&#39; may be used to delimit comments.</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# Use a dynamic tun device.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# For Linux 2.2 or non-Linux OSes,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-# you may want to use an explicit</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-# unit number such as &quot;tun1&quot=
;.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# OpenVPN also supp=
orts virtual</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# etherne=
t &quot;tap&quot; devices.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-dev tun</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-# 10.1.0.1 is our local VPN en=
dpoint (office).</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# 10.=
1.0.2 is our remote VPN endpoint (home).</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-ifconfig 10.1.0.1 10.1.0.2</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-# Our up script will establish routes</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# once the VPN is alive.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-up ./office.up</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# In S=
SL/TLS key exchange, Office will</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# assume server role and Home</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# will assume client role.</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-tls-server</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Diffie=
-Hellman Parameters (tls-server only)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-dh dh2048.pem</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Certificate=
 Authority file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ca my-=
ca.crt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# Our certificate/public key</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-cert office.crt</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# Our private key</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-key office.key</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Our data ch=
annel cipher (must match peer config)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-cipher AES-256-GCM</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# OpenVP=
N 2.0 uses UDP port 1194 by default</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-# (official port assignment by iana.org 11/04).</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# OpenVPN 1.x uses UDP port 5000 by=
 default.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Each OpenV=
PN tunnel must use</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# a=
 different port number.</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-# lport or rport can be used</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# to denote different ports</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-# for local and remote.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-; port 1194</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Downgrade UI=
D and GID to an</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# unpr=
iviledged user after initialization</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-# for extra security.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-; user openvpn</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-; group openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# If you built OpenV=
PN with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# LZO compress=
ion, uncomment</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# out t=
he following line.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-; c=
omp-lzo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# Send a UDP ping to remote once</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# every 15 seconds to ke=
ep</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# stateful firewall=
 connection</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# alive.  =
Uncomment this</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# out i=
f you are using a stateful</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# firewall.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-; pin=
g 15</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-# Uncomment this section for a more re=
liable detection when a system</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# loses its connection.  For example, dial-ups or laptops that</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# travel to other locatio=
ns.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-; ping 15</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-; ping-restart 45</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-; ping-timer-rem</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-; persist-tun</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-; persist-key</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
 Verbosity level.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# 0 =
-- quiet except for fatal errors.</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# 1 -- mostly quiet, but display non-fatal network errors.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# 3 -- medium output, good=
 for normal operation.</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# 9 -- verbose, good for troubleshooting</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-verb 3</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/531?usp=3Demail">change=
 531</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/531?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I199541fea5a76c8edef7f67d2db=
fc476987dc2f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 531 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--9FbXkiuyd5o=--

