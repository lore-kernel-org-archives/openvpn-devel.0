From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 20 Aug 2025 21:13:11 +0000
In-Reply-To: <gerrit.1755702161000.If66438662bd862a195b2a69c4fa45f63838982b7@...2715...>
References: <gerrit.1755702161000.If66438662bd862a195b2a69c4fa45f63838982b7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e431de9d76afb2a3162005afb6f340ec905fb1f0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rYDFNqnGC48="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove use of 'dh
 dh2048.pem' from sample configs, remove 'dh2048.pem...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rYDFNqnGC48=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1145?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Remove use of 'dh dh2048.pem' from sample configs, remove '=
dh2048.pem' file
......................................................................

Remove use of 'dh dh2048.pem' from sample configs, remove 'dh2048.pem' file

Since commit bd9aa06feb41 (Jan 2015) OpenVPN has allowed to use
'--dh none' to disable traditional Diffie Hellman, since more secure
ECDH algorithms are available that do not use explicit DH parameters.

If configured with a suffiently high securelevel (3+), or if running in
FIPS mode, OpenSSL 3.5 will refuse 2048 bit DH files, making our tests
fail.

Thus, remove all the DH2048 stuff from our sample configs.

Github: triggered by OpenVPN/openvpn#819

Change-Id: If66438662bd862a195b2a69c4fa45f63838982b7
Signed-off-by: Gert Doering <gert@...1296...>
Message-Id: <20250820175459.11227-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
632.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/tests/authentication-plugins.md
M sample/sample-config-files/loopback-server
M sample/sample-config-files/server.conf
D sample/sample-keys/dh2048.pem
M sample/sample-plugins/keying-material-exporter-demo/server.ovpn
5 files changed, 4 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1145/4

diff --git a/doc/tests/authentication-plugins.md b/doc/tests/authentication=
-plugins.md
index b47c544..45fa381 100644
--- a/doc/tests/authentication-plugins.md
+++ b/doc/tests/authentication-plugins.md
@@ -36,7 +36,7 @@
       verb 4
       dev tun
       server 10.8.0.0 255.255.255.0
-      dh sample/sample-keys/dh2048.pem
+      dh none
       ca sample/sample-keys/ca.crt
       cert sample/sample-keys/server.crt
       key sample/sample-keys/server.key
diff --git a/sample/sample-config-files/loopback-server b/sample/sample-con=
fig-files/loopback-server
index 58daeb56..1980218 100644
--- a/sample/sample-config-files/loopback-server
+++ b/sample/sample-config-files/loopback-server
@@ -17,7 +17,7 @@
 verb 3
 reneg-sec 10
 tls-server
-dh sample-keys/dh2048.pem
+dh none
 ca sample-keys/ca.crt
 key sample-keys/server.key
 cert sample-keys/server.crt
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-=
files/server.conf
index f6d9e65..8943c34 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -87,11 +87,6 @@
 cert server.crt
 key server.key  # This file should be kept secret

-# Diffie hellman parameters.
-# Generate your own with:
-#   openssl dhparam -out dh2048.pem 2048
-dh dh2048.pem
-
 # Allow to connect to really old OpenVPN versions
 # without AEAD support (OpenVPN 2.3.x or older)
 # This adds AES-256-CBC as fallback cipher and
@@ -306,4 +301,4 @@

 # Notify the client that when the server restarts so it
 # can automatically reconnect.
-explicit-exit-notify 1
\ No newline at end of file
+explicit-exit-notify 1
diff --git a/sample/sample-keys/dh2048.pem b/sample/sample-keys/dh2048.pem
deleted file mode 100644
index d393581..0000000
--- a/sample/sample-keys/dh2048.pem
+++ /dev/null
@@ -1,8 +0,0 @@
------BEGIN DH PARAMETERS-----
-MIIBCAKCAQEAgGOVdT2c3GUITi1pF9u+yo72PRBW7I7SnNIsHmXCRYibpyPMGxKM
-ROK6rduMllC0CjiXQZhMfqCg+GIca9xxBPKtTnwtKWD3eH5wgs24kw86mODITjJk
-6lTNM8it2HY4UuIQoFCqCdt5f5Gwgh2nwU5+dy731md6pmw9x9jUEXoyh67CeZfb
-C45x5ttzjpSBvYe5ZIiUypYKumYhdiZhk0RLefEtlUYF9oXrUExDqfYDpSO/1/X3
-oHC0O0EV3Lh1boZTG7+FjcvMYLIKYUDTmxHpII6/OAHhprg7U9ui1i7GyQRv1lze
-QV3FGO4UwLntnv352iYy91b0ls2mwD+zTwIBAg=3D=3D
------END DH PARAMETERS-----
diff --git a/sample/sample-plugins/keying-material-exporter-demo/server.ovp=
n b/sample/sample-plugins/keying-material-exporter-demo/server.ovpn
index 5c670b1..1aabcb9 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/server.ovpn
+++ b/sample/sample-plugins/keying-material-exporter-demo/server.ovpn
@@ -8,7 +8,7 @@
 ca     ../../sample-keys/ca.crt
 cert   ../../sample-keys/server.crt
 key    ../../sample-keys/server.key
-dh     ../../sample-keys/dh2048.pem
+dh     none

 server 10.8.0.0 255.255.255.0
 port 1194

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1145?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If66438662bd862a195b2a69c4fa45f63838982b7
Gerrit-Change-Number: 1145
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--rYDFNqnGC48=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1145?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Remove use of &#39;dh dh2048.pem&#39; from sampl=
e configs, remove &#39;dh2048.pem&#39; file<br><br>Since commit bd9aa06feb4=
1 (Jan 2015) OpenVPN has allowed to use<br>&#39;--dh none&#39; to disable t=
raditional Diffie Hellman, since more secure<br>ECDH algorithms are availab=
le that do not use explicit DH parameters.<br><br>If configured with a suff=
iently high securelevel (3+), or if running in<br>FIPS mode, OpenSSL 3.5 wi=
ll refuse 2048 bit DH files, making our tests<br>fail.<br><br>Thus, remove =
all the DH2048 stuff from our sample configs.<br><br>Github: triggered by O=
penVPN/openvpn#819<br><br>Change-Id: If66438662bd862a195b2a69c4fa45f6383898=
2b7<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &=
lt;20250820175459.11227-1-gert@...1296...&gt;<br>URL: https://www.mail-arch=
ive.com/openvpn-devel@lists.sourceforge.net/msg32632.html<br>Signed-off-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/tests/authentication-=
plugins.md<br>M sample/sample-config-files/loopback-server<br>M sample/samp=
le-config-files/server.conf<br>D sample/sample-keys/dh2048.pem<br>M sample/=
sample-plugins/keying-material-exporter-demo/server.ovpn<br>5 files changed=
, 4 insertions(+), 17 deletions(-)<br><br></pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/45/1145/4</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/tests/aut=
hentication-plugins.md b/doc/tests/authentication-plugins.md</span><br><spa=
n>index b47c544..45fa381 100644</span><br><span>--- a/doc/tests/authenticat=
ion-plugins.md</span><br><span>+++ b/doc/tests/authentication-plugins.md</s=
pan><br><span>@@ -36,7 +36,7 @@</span><br><span>       verb 4</span><br><sp=
an>       dev tun</span><br><span>       server 10.8.0.0 255.255.255.0</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      dh sample/sample-key=
s/dh2048.pem</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      d=
h none</span><br><span>       ca sample/sample-keys/ca.crt</span><br><span>=
       cert sample/sample-keys/server.crt</span><br><span>       key sample=
/sample-keys/server.key</span><br><span>diff --git a/sample/sample-config-f=
iles/loopback-server b/sample/sample-config-files/loopback-server</span><br=
><span>index 58daeb56..1980218 100644</span><br><span>--- a/sample/sample-c=
onfig-files/loopback-server</span><br><span>+++ b/sample/sample-config-file=
s/loopback-server</span><br><span>@@ -17,7 +17,7 @@</span><br><span> verb 3=
</span><br><span> reneg-sec 10</span><br><span> tls-server</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-dh sample-keys/dh2048.pem</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+dh none</span><br><span> ca samp=
le-keys/ca.crt</span><br><span> key sample-keys/server.key</span><br><span>=
 cert sample-keys/server.crt</span><br><span>diff --git a/sample/sample-con=
fig-files/server.conf b/sample/sample-config-files/server.conf</span><br><s=
pan>index f6d9e65..8943c34 100644</span><br><span>--- a/sample/sample-confi=
g-files/server.conf</span><br><span>+++ b/sample/sample-config-files/server=
.conf</span><br><span>@@ -87,11 +87,6 @@</span><br><span> cert server.crt</=
span><br><span> key server.key  # This file should be kept secret</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Diffie hell=
man parameters.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Gene=
rate your own with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
  openssl dhparam -out dh2048.pem 2048</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-dh dh2048.pem</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> # Allow to connect to really old OpenVPN version=
s</span><br><span> # without AEAD support (OpenVPN 2.3.x or older)</span><b=
r><span> # This adds AES-256-CBC as fallback cipher and</span><br><span>@@ =
-306,4 +301,4 @@</span><br><span> </span><br><span> # Notify the client tha=
t when the server restarts so it</span><br><span> # can automatically recon=
nect.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-explicit-exit-no=
tify 1</span><br><span>\ No newline at end of file</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+explicit-exit-notify 1</span><br><span>diff =
--git a/sample/sample-keys/dh2048.pem b/sample/sample-keys/dh2048.pem</span=
><br><span>deleted file mode 100644</span><br><span>index d393581..0000000<=
/span><br><span>--- a/sample/sample-keys/dh2048.pem</span><br><span>+++ /de=
v/null</span><br><span>@@ -1,8 +0,0 @@</span><br><span>------BEGIN DH PARAM=
ETERS-----</span><br><span style=3D"color: hsl(0, 100%, 40%);">-MIIBCAKCAQE=
AgGOVdT2c3GUITi1pF9u+yo72PRBW7I7SnNIsHmXCRYibpyPMGxKM</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ROK6rduMllC0CjiXQZhMfqCg+GIca9xxBPKtTnwtKWD=
3eH5wgs24kw86mODITjJk</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
6lTNM8it2HY4UuIQoFCqCdt5f5Gwgh2nwU5+dy731md6pmw9x9jUEXoyh67CeZfb</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-C45x5ttzjpSBvYe5ZIiUypYKumYhdiZh=
k0RLefEtlUYF9oXrUExDqfYDpSO/1/X3</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-oHC0O0EV3Lh1boZTG7+FjcvMYLIKYUDTmxHpII6/OAHhprg7U9ui1i7GyQRv1lze=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-QV3FGO4UwLntnv352iYy9=
1b0ls2mwD+zTwIBAg=3D=3D</span><br><span>------END DH PARAMETERS-----</span>=
<br><span>diff --git a/sample/sample-plugins/keying-material-exporter-demo/=
server.ovpn b/sample/sample-plugins/keying-material-exporter-demo/server.ov=
pn</span><br><span>index 5c670b1..1aabcb9 100644</span><br><span>--- a/samp=
le/sample-plugins/keying-material-exporter-demo/server.ovpn</span><br><span=
>+++ b/sample/sample-plugins/keying-material-exporter-demo/server.ovpn</spa=
n><br><span>@@ -8,7 +8,7 @@</span><br><span> ca     ../../sample-keys/ca.cr=
t</span><br><span> cert   ../../sample-keys/server.crt</span><br><span> key=
    ../../sample-keys/server.key</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-dh     ../../sample-keys/dh2048.pem</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dh     none</span><br><span> </span><br><span> s=
erver 10.8.0.0 255.255.255.0</span><br><span> port 1194</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1145?usp=3Demail">change 1145</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1145?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If66438662bd862a195b2a69c4fa=
45f63838982b7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1145 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--rYDFNqnGC48=--

