From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 16 Jul 2025 14:18:10 +0000
In-Reply-To: <gerrit.1752669697000.I22af9957b27785514d8c6d58fe4f2100d007fa5c@...2715...>
References: <gerrit.1752669697000.I22af9957b27785514d8c6d58fe4f2100d007fa5c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <2cfe7e0208e8b5979437f2e72f3a44df2a116ad8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HOFyjQbC+d4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: README.dco: update
 Linux instructions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HOFyjQbC+d4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
87?usp=3Demail )

Change subject: README.dco: update Linux instructions
......................................................................

README.dco: update Linux instructions

Update the README.dco file by including instructions related
to the new 'ovpn' linux kernel module.

Change-Id: I22af9957b27785514d8c6d58fe4f2100d007fa5c
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250716135430.23484-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
180.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M README.dco.md
1 file changed, 14 insertions(+), 19 deletions(-)




diff --git a/README.dco.md b/README.dco.md
index 3f7e00c..a93dc94 100644
--- a/README.dco.md
+++ b/README.dco.md
@@ -14,26 +14,22 @@

 Getting started (Linux)
 -----------------------
-- Use a recent Linux kernel. Linux 5.4.0 and newer are known to work with
-  ovpn-dco.
+The new DCO linux kernel module (namely `ovpn`) has been merged upstream
+as of linux-6.16. From this kernel version onwards you directly get
+the DCO module as shipped by your kernel.
+NOTE: the new `ovpn` Linux kernel module is compatible only with OpenVPN
+2.7 and greater.

-Get the ovpn-dco module from one these urls and build it:
+Alternatively, if you run an older kernel or if you want to use a more
+recent DCO module than the one shipped by your kernel, you need to use
+the ovpn-backports project.

-* https://gitlab.com/openvpn/ovpn-dco
-* https://github.com/OpenVPN/ovpn-dco
+To learn how to use the ovpn-backports project and build your own DCO
+kernel module, please refer to the README file available at:

-e.g.
+  https://github.com/OpenVPN/ovpn-backports/blob/main/README.md

-    git clone https://github.com/OpenVPN/ovpn-dco
-    cd ovpn-dco
-    make
-    sudo make install
-
-If you want to report bugs please ensure to compile ovpn-dco with
-`make DEBUG=3D1` and include any debug message being printed by the
-kernel (you can view those messages with `dmesg`).
-
-Clone and build OpenVPN (or use OpenVPN 2.6+). For example:
+Then clone and build OpenVPN (or use OpenVPN 2.7+). For example:

     git clone https://github.com/openvpn/openvpn.git
     cd openvpn
@@ -48,8 +44,8 @@
 data channel offloading, OpenVPN will automatically disable DCO support and
 warn the user.

-Should OpenVPN be configured to use a feature that is not supported by ovp=
n-dco
-or should the ovpn-dco kernel module not be available on the system, you w=
ill
+Should OpenVPN be configured to use a feature that is not supported by ovpn
+or should the ovpn kernel module not be available on the system, you will
 see a message like

     Note: Kernel support for ovpn-dco missing, disabling data channel offl=
oad.
@@ -131,4 +127,3 @@
 - `--persist-tun` not tested;
 - IPv6 mapped IPv4 addresses need Linux 5.4.189+/5.10.110+/5.12+ to work;
 - some incompatible options may not properly fallback to non-dco;
-- no per client statistics. Only total statistics available on the interfa=
ce.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1087?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I22af9957b27785514d8c6d58fe4f2100d007fa5c
Gerrit-Change-Number: 1087
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--HOFyjQbC+d4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1087?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">README.dco: update Linux instructions<br><br>=
Update the README.dco file by including instructions related<br>to the new =
&#39;ovpn&#39; linux kernel module.<br><br>Change-Id: I22af9957b27785514d8c=
6d58fe4f2100d007fa5c<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2788...=
6...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message=
-Id: &lt;20250716135430.23484-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg32180.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M README.dco.md<br>1 =
file changed, 14 insertions(+), 19 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/README.dco.md b/README.dco.md</span><br><span>index 3f7e00c=
..a93dc94 100644</span><br><span>--- a/README.dco.md</span><br><span>+++ b/=
README.dco.md</span><br><span>@@ -14,26 +14,22 @@</span><br><span> </span><=
br><span> Getting started (Linux)</span><br><span> -----------------------<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Use a recent Linux k=
ernel. Linux 5.4.0 and newer are known to work with</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  ovpn-dco.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+The new DCO linux kernel module (namely `ovpn`) has=
 been merged upstream</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+as of linux-6.16. From this kernel version onwards you directly get</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+the DCO module as shipped=
 by your kernel.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+NOT=
E: the new `ovpn` Linux kernel module is compatible only with OpenVPN</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+2.7 and greater.</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-Get the ovpn=
-dco module from one these urls and build it:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+Alternatively, if you run an older kernel or if y=
ou want to use a more</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+recent DCO module than the one shipped by your kernel, you need to use</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+the ovpn-backports pro=
ject.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-* https://gitlab.com/openvpn/ovpn-dco</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-* https://github.com/OpenVPN/ovpn-dco</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+To learn how to use the ovpn-backports =
project and build your own DCO</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+kernel module, please refer to the README file available at:</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-e.g.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  https://github.com/O=
penVPN/ovpn-backports/blob/main/README.md</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    git clone https://github.com/Open=
VPN/ovpn-dco</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cd ov=
pn-dco</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    make</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    sudo make install</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-If you want to report bugs please ensure to compi=
le ovpn-dco with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-`make=
 DEBUG=3D1` and include any debug message being printed by the</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-kernel (you can view those message=
s with `dmesg`).</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-Clone and build OpenVPN (o=
r use OpenVPN 2.6+). For example:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+Then clone and build OpenVPN (or use OpenVPN 2.7+). For examp=
le:</span><br><span> </span><br><span>     git clone https://github.com/ope=
nvpn/openvpn.git</span><br><span>     cd openvpn</span><br><span>@@ -48,8 +=
44,8 @@</span><br><span> data channel offloading, OpenVPN will automaticall=
y disable DCO support and</span><br><span> warn the user.</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Should OpenVPN be con=
figured to use a feature that is not supported by ovpn-dco</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-or should the ovpn-dco kernel module n=
ot be available on the system, you will</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Should OpenVPN be configured to use a feature that is n=
ot supported by ovpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+or should the ovpn kernel module not be available on the system, you will<=
/span><br><span> see a message like</span><br><span> </span><br><span>     =
Note: Kernel support for ovpn-dco missing, disabling data channel offload.<=
/span><br><span>@@ -131,4 +127,3 @@</span><br><span> - `--persist-tun` not =
tested;</span><br><span> - IPv6 mapped IPv4 addresses need Linux 5.4.189+/5=
.10.110+/5.12+ to work;</span><br><span> - some incompatible options may no=
t properly fallback to non-dco;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-- no per client statistics. Only total statistics available on th=
e interface.</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1087?usp=3Demail">change 1087</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1087?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I22af9957b27785514d8c6d58fe4=
f2100d007fa5c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1087 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--HOFyjQbC+d4=--

