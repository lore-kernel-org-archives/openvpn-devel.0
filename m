From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 20 Aug 2025 15:02:43 +0000
References: <gerrit.1755702161000.If66438662bd862a195b2a69c4fa45f63838982b7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <eae3ae72d8e85b269783d6d413aa709d7066afbc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HE2A0XJUx58="; charset=UTF-8
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

--HE2A0XJUx58=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1145?usp=3Demail

to review the following change.


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

Change-Id: If66438662bd862a195b2a69c4fa45f63838982b7
Signed-off-by: Gert Doering <gert@...1296...>
---
M sample/sample-config-files/loopback-server
M sample/sample-config-files/server.conf
D sample/sample-keys/dh2048.pem
M sample/sample-plugins/keying-material-exporter-demo/server.ovpn
4 files changed, 3 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1145/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--HE2A0XJUx58=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1145?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Remove use of &#39;dh dh2048.pem&#39; from sample configs, r=
emove &#39;dh2048.pem&#39; file<br><br>Since commit bd9aa06feb41 (Jan 2015)=
 OpenVPN has allowed to use<br>&#39;--dh none&#39; to disable traditional D=
iffie Hellman, since more secure<br>ECDH algorithms are available that do n=
ot use explicit DH parameters.<br><br>If configured with a suffiently high =
securelevel (3+), or if running in<br>FIPS mode, OpenSSL 3.5 will refuse 20=
48 bit DH files, making our tests<br>fail.<br><br>Thus, remove all the DH20=
48 stuff from our sample configs.<br><br>Change-Id: If66438662bd862a195b2a6=
9c4fa45f63838982b7<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M sample/sample-config-files/loopback-server<br>M sample/sample-co=
nfig-files/server.conf<br>D sample/sample-keys/dh2048.pem<br>M sample/sampl=
e-plugins/keying-material-exporter-demo/server.ovpn<br>4 files changed, 3 i=
nsertions(+), 16 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/45/1145/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/sample/sample-conf=
ig-files/loopback-server b/sample/sample-config-files/loopback-server</span=
><br><span>index 58daeb56..1980218 100644</span><br><span>--- a/sample/samp=
le-config-files/loopback-server</span><br><span>+++ b/sample/sample-config-=
files/loopback-server</span><br><span>@@ -17,7 +17,7 @@</span><br><span> ve=
rb 3</span><br><span> reneg-sec 10</span><br><span> tls-server</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-dh sample-keys/dh2048.pem</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+dh none</span><br><span> ca =
sample-keys/ca.crt</span><br><span> key sample-keys/server.key</span><br><s=
pan> cert sample-keys/server.crt</span><br><span>diff --git a/sample/sample=
-config-files/server.conf b/sample/sample-config-files/server.conf</span><b=
r><span>index f6d9e65..8943c34 100644</span><br><span>--- a/sample/sample-c=
onfig-files/server.conf</span><br><span>+++ b/sample/sample-config-files/se=
rver.conf</span><br><span>@@ -87,11 +87,6 @@</span><br><span> cert server.c=
rt</span><br><span> key server.key  # This file should be kept secret</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Diffie =
hellman parameters.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
Generate your own with:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#   openssl dhparam -out dh2048.pem 2048</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-dh dh2048.pem</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> # Allow to connect to really old OpenVPN ver=
sions</span><br><span> # without AEAD support (OpenVPN 2.3.x or older)</spa=
n><br><span> # This adds AES-256-CBC as fallback cipher and</span><br><span=
>@@ -306,4 +301,4 @@</span><br><span> </span><br><span> # Notify the client=
 that when the server restarts so it</span><br><span> # can automatically r=
econnect.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-explicit-exi=
t-notify 1</span><br><span>\ No newline at end of file</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+explicit-exit-notify 1</span><br><span>d=
iff --git a/sample/sample-keys/dh2048.pem b/sample/sample-keys/dh2048.pem</=
span><br><span>deleted file mode 100644</span><br><span>index d393581..0000=
000</span><br><span>--- a/sample/sample-keys/dh2048.pem</span><br><span>+++=
 /dev/null</span><br><span>@@ -1,8 +0,0 @@</span><br><span>------BEGIN DH P=
ARAMETERS-----</span><br><span style=3D"color: hsl(0, 100%, 40%);">-MIIBCAK=
CAQEAgGOVdT2c3GUITi1pF9u+yo72PRBW7I7SnNIsHmXCRYibpyPMGxKM</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-ROK6rduMllC0CjiXQZhMfqCg+GIca9xxBPKtTnw=
tKWD3eH5wgs24kw86mODITjJk</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-6lTNM8it2HY4UuIQoFCqCdt5f5Gwgh2nwU5+dy731md6pmw9x9jUEXoyh67CeZfb</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-C45x5ttzjpSBvYe5ZIiUypYKumYh=
diZhk0RLefEtlUYF9oXrUExDqfYDpSO/1/X3</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-oHC0O0EV3Lh1boZTG7+FjcvMYLIKYUDTmxHpII6/OAHhprg7U9ui1i7GyQRv=
1lze</span><br><span style=3D"color: hsl(0, 100%, 40%);">-QV3FGO4UwLntnv352=
iYy91b0ls2mwD+zTwIBAg=3D=3D</span><br><span>------END DH PARAMETERS-----</s=
pan><br><span>diff --git a/sample/sample-plugins/keying-material-exporter-d=
emo/server.ovpn b/sample/sample-plugins/keying-material-exporter-demo/serve=
r.ovpn</span><br><span>index 5c670b1..1aabcb9 100644</span><br><span>--- a/=
sample/sample-plugins/keying-material-exporter-demo/server.ovpn</span><br><=
span>+++ b/sample/sample-plugins/keying-material-exporter-demo/server.ovpn<=
/span><br><span>@@ -8,7 +8,7 @@</span><br><span> ca     ../../sample-keys/c=
a.crt</span><br><span> cert   ../../sample-keys/server.crt</span><br><span>=
 key    ../../sample-keys/server.key</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-dh     ../../sample-keys/dh2048.pem</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dh     none</span><br><span> </span><br><spa=
n> server 10.8.0.0 255.255.255.0</span><br><span> port 1194</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1145?usp=3Demail">change 1145</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1145?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If66438662bd862a195b2a69c4fa=
45f63838982b7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1145 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--HE2A0XJUx58=--

