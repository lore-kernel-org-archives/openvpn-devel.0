From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 2 Jun 2025 15:38:46 +0000
In-Reply-To: <gerrit.1748860734000.I15c730c9eb3f1338019577e7c665c0ca5b1edcd4@...2715...>
References: <gerrit.1748860734000.I15c730c9eb3f1338019577e7c665c0ca5b1edcd4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fd94449c87c17852e7ebd887d1f66d63cffb8a81-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6MrYTAM7CQY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Delete old
 sample-windows file and obsolete Windows sample handling
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

--6MrYTAM7CQY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1036?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: Delete old sample-windows file and obsolete Windows sample =
handling
......................................................................

Delete old sample-windows file and obsolete Windows sample handling

This file is apparently over 20 years old and
was never updated besides fixing some obvious
syntax errors with new versions.

So let's just get rid of it. AFAICT the Windows
installer does not use it. Only the
{server,client}.ovpn. And even there, it just uses
the files directly from the build directory and
does not depend on us renaming them (which is
obvious since we do not use the Makefile at all
in the Windows build, only CMake).

Github: Closes OpenVPN/openvpn#758
Change-Id: I15c730c9eb3f1338019577e7c665c0ca5b1edcd4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M sample/Makefile.am
D sample/sample-windows/sample.ovpn
2 files changed, 0 insertions(+), 117 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1036/3

diff --git a/sample/Makefile.am b/sample/Makefile.am
index 9443cf3..4ed78a6e 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -18,20 +18,5 @@
 EXTRA_DIST =3D \
 	sample-plugins \
 	sample-config-files \
-	sample-windows \
 	sample-keys \
 	sample-scripts
-
-if WIN32
-sample_DATA =3D \
-	client.ovpn \
-	server.ovpn \
-	sample-windows/sample.ovpn
-
-client.ovpn: sample-config-files/client.conf
-	-rm -f client.ovpn
-	cp "$(srcdir)/sample-config-files/client.conf" client.ovpn
-server.ovpn: sample-config-files/server.conf
-	-rm -f server.ovpn
-	cp "$(srcdir)/sample-config-files/server.conf" server.ovpn
-endif
diff --git a/sample/sample-windows/sample.ovpn b/sample/sample-windows/samp=
le.ovpn
deleted file mode 100755
index be24faa..0000000
--- a/sample/sample-windows/sample.ovpn
+++ /dev/null
@@ -1,102 +0,0 @@
-# Edit this file, and save to a .ovpn extension
-# so that OpenVPN will activate it when run
-# as a service.
-
-# Change 'myremote' to be your remote host,
-# or comment out to enter a listening
-# server mode.
-remote myremote
-
-# Uncomment this line to use a different
-# port number than the default of 1194.
-; port 1194
-
-# Choose one of three protocols supported by
-# OpenVPN.  If left commented out, defaults
-# to udp.
-; proto [tcp-server | tcp-client | udp]
-
-# You must specify one of two possible network
-# protocols, 'dev tap' or 'dev tun' to be used
-# on both sides of the connection.  'tap' creates
-# a VPN using the ethernet protocol while 'tun'
-# uses the IP protocol.  You must use 'tap'
-# if you are ethernet bridging or want to route
-# broadcasts.  'tun' is somewhat more efficient
-# but requires configuration of client software
-# to not depend on broadcasts.  Some platforms
-# such as Solaris, OpenBSD, and Mac OS X only
-# support 'tun' interfaces, so if you are
-# connecting to such a platform, you must also
-# use a 'tun' interface on the Windows side.
-
-# Enable 'dev tap' or 'dev tun' but not both!
-dev tap
-
-# This is a 'dev tap' ifconfig that creates
-# a virtual ethernet subnet.
-# 10.3.0.1 is the local VPN IP address
-# and 255.255.255.0 is the VPN subnet.
-# Only define this option for 'dev tap'.
-ifconfig 10.3.0.1 255.255.255.0
-
-# This is a 'dev tun' ifconfig that creates
-# a point-to-point IP link.
-# 10.3.0.1 is the local VPN IP address and
-# 10.3.0.2 is the remote VPN IP address.
-# Only define this option for 'dev tun'.
-# Make sure to include the "tun-mtu" option
-# on the remote machine, but swap the order
-# of the ifconfig addresses.
-;tun-mtu 1500
-;ifconfig 10.3.0.1 10.3.0.2
-
-# If you have fragmentation issues or misconfigured
-# routers in the path which block Path MTU discovery,
-# lower the TCP MSS and internally fragment non-TCP
-# protocols.
-;fragment 1300
-;mssfix
-
-# If you have set up more than one TAP-Win32 adapter
-# on your system, you must refer to it by name.
-;dev-node my-tap
-
-# You can generate a static OpenVPN key
-# by selecting the Generate Key option
-# in the start menu.
-#
-# You can also generate key.txt manually
-# with the following command:
-#   openvpn --genkey secret key.txt
-#
-# key must match on both ends of the connection,
-# so you should generate it on one machine and
-# copy it to the other over a secure medium.
-# Place key.txt in the same directory as this
-# config file.
-secret key.txt
-
-# Uncomment this section for a more reliable
-# detection when a system loses its connection.
-# For example, dial-ups or laptops that travel
-# to other locations.
-#
-# If this section is enabled and "myremote"
-# above is a dynamic DNS name (i.e. dyndns.org),
-# OpenVPN will dynamically "follow" the IP
-# address of "myremote" if it changes.
-; ping-restart 60
-; ping-timer-rem
-; persist-tun
-; resolv-retry 86400
-
-# keep-alive ping
-ping 10
-
-# enable LZO compression
-comp-lzo
-
-# moderate verbosity
-verb 4
-mute 10

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1036?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I15c730c9eb3f1338019577e7c665c0ca5b1edcd4
Gerrit-Change-Number: 1036
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--6MrYTAM7CQY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1036?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">Delete old sample-windo=
ws file and obsolete Windows sample handling<br><br>This file is apparently=
 over 20 years old and<br>was never updated besides fixing some obvious<br>=
syntax errors with new versions.<br><br>So let&#39;s just get rid of it. AF=
AICT the Windows<br>installer does not use it. Only the<br>{server,client}.=
ovpn. And even there, it just uses<br>the files directly from the build dir=
ectory and<br>does not depend on us renaming them (which is<br>obvious sinc=
e we do not use the Makefile at all<br>in the Windows build, only CMake).<b=
r><br>Github: Closes OpenVPN/openvpn#758<br>Change-Id: I15c730c9eb3f1338019=
577e7c665c0ca5b1edcd4<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2746...=
...&gt;<br>---<br>M sample/Makefile.am<br>D sample/sample-windows/sample.ov=
pn<br>2 files changed, 0 insertions(+), 117 deletions(-)<br><br></pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1036/3</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/sample/Makefile.am b/sample/Makefile.am</span><br><span>index 9443=
cf3..4ed78a6e 100644</span><br><span>--- a/sample/Makefile.am</span><br><sp=
an>+++ b/sample/Makefile.am</span><br><span>@@ -18,20 +18,5 @@</span><br><s=
pan> EXTRA_DIST =3D \</span><br><span> 	sample-plugins \</span><br><span> 	=
sample-config-files \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	sample-windows \</span><br><span> 	sample-keys \</span><br><span> 	sample-=
scripts</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-if WIN32</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-sample_DATA =3D \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	client.ovpn \</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	server.ovpn \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	sample-windows/sample.ovpn</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-client=
.ovpn: sample-config-files/client.conf</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	-rm -f client.ovpn</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	cp &quot;$(srcdir)/sample-config-files/client.conf&quot; cl=
ient.ovpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-server.ovpn:=
 sample-config-files/server.conf</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	-rm -f server.ovpn</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	cp &quot;$(srcdir)/sample-config-files/server.conf&quot; server.o=
vpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">-endif</span><br><s=
pan>diff --git a/sample/sample-windows/sample.ovpn b/sample/sample-windows/=
sample.ovpn</span><br><span>deleted file mode 100755</span><br><span>index =
be24faa..0000000</span><br><span>--- a/sample/sample-windows/sample.ovpn</s=
pan><br><span>+++ /dev/null</span><br><span>@@ -1,102 +0,0 @@</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# Edit this file, and save to a .ov=
pn extension</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# so that=
 OpenVPN will activate it when run</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# as a service.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Change &#39;=
myremote&#39; to be your remote host,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# or comment out to enter a listening</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# server mode.</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-remote myremote</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
Uncomment this line to use a different</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# port number than the default of 1194.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-; port 1194</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-# Choose one of three protocols supported by</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# OpenVPN.  If left commented out, defaults</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# to udp.</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-; proto [tcp-server | tcp-client | udp=
]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-# You must specify one of two possible ne=
twork</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# protocols, &#3=
9;dev tap&#39; or &#39;dev tun&#39; to be used</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-# on both sides of the connection.  &#39;tap&#39; =
creates</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# a VPN using =
the ethernet protocol while &#39;tun&#39;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-# uses the IP protocol.  You must use &#39;tap&#39;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# if you are ethernet bri=
dging or want to route</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# broadcasts.  &#39;tun&#39; is somewhat more efficient</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# but requires configuration of client s=
oftware</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# to not depen=
d on broadcasts.  Some platforms</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# such as Solaris, OpenBSD, and Mac OS X only</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# support &#39;tun&#39; interfaces, so i=
f you are</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# connecting=
 to such a platform, you must also</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# use a &#39;tun&#39; interface on the Windows side.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# Enable &#39;dev tap&#39; or &#39;dev tun&#39; but =
not both!</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dev tap</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-# This is a &#39;dev tap&#39; ifconfig that cre=
ates</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# a virtual ether=
net subnet.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# 10.3.0.1=
 is the local VPN IP address</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# and 255.255.255.0 is the VPN subnet.</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-# Only define this option for &#39;dev tap&#39;.</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig 10.3.0.1 255.25=
5.255.0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# This is a &#39;dev tun&#39; ifcon=
fig that creates</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# a p=
oint-to-point IP link.</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# 10.3.0.1 is the local VPN IP address and</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-# 10.3.0.2 is the remote VPN IP address. </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# Only define this option for &#3=
9;dev tun&#39;.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Make=
 sure to include the &quot;tun-mtu&quot; option</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-# on the remote machine, but swap the order</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# of the ifconfig addresses=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-;tun-mtu 1500</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-;ifconfig 10.3.0.1 10.3.0.2<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# If you have fragmentation issues or misco=
nfigured</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# routers in =
the path which block Path MTU discovery,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# lower the TCP MSS and internally fragment non-TCP</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# protocols.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-;fragment 1300</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-;mssfix</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
If you have set up more than one TAP-Win32 adapter</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# on your system, you must refer to it by name=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-;dev-node my-tap</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# You can generate a static OpenVPN key</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# by selecting the Generate =
Key option</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# in the st=
art menu.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# You can also generate key.txt =
manually</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# with the fo=
llowing command:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   o=
penvpn --genkey secret key.txt</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# key must =
match on both ends of the connection,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# so you should generate it on one machine and</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# copy it to the other over a secu=
re medium.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Place key=
.txt in the same directory as this</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# config file.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-secret key.txt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Uncomment this secti=
on for a more reliable</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# detection when a system loses its connection.</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# For example, dial-ups or laptops that travel</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# to other locations.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# If this section is enabled and &quot;myre=
mote&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# above is =
a dynamic DNS name (i.e. dyndns.org),</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# OpenVPN will dynamically &quot;follow&quot; the IP</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# address of &quot;myremote&=
quot; if it changes.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-;=
 ping-restart 60</span><br><span style=3D"color: hsl(0, 100%, 40%);">-; pin=
g-timer-rem</span><br><span style=3D"color: hsl(0, 100%, 40%);">-; persist-=
tun</span><br><span style=3D"color: hsl(0, 100%, 40%);">-; resolv-retry 864=
00</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# keep-alive ping</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ping 10</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# e=
nable LZO compression</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
comp-lzo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# moderate verbosity</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-verb 4</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-mute 10</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1036?usp=3Demail"=
>change 1036</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1036?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I15c730c9eb3f1338019577e7c66=
5c0ca5b1edcd4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1036 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--6MrYTAM7CQY=--

