From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 16 Jul 2025 13:42:52 +0000
In-Reply-To: <gerrit.1752669697000.I22af9957b27785514d8c6d58fe4f2100d007fa5c@...2715...>
References: <gerrit.1752669697000.I22af9957b27785514d8c6d58fe4f2100d007fa5c@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4a273fadba18535a50f05662e45b31d420b2efc7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6z0xsIgziTY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6z0xsIgziTY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1087?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: README.dco: update Linux instructions
......................................................................

README.dco: update Linux instructions

Update the README.dco file by including instructions related
to the new 'ovpn' linux kernel module.

Change-Id: I22af9957b27785514d8c6d58fe4f2100d007fa5c
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M README.dco.md
1 file changed, 14 insertions(+), 19 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1087/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-MessageType: newpatchset

--6z0xsIgziTY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>ordex <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1087?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">README.dco: upda=
te Linux instructions<br><br>Update the README.dco file by including instru=
ctions related<br>to the new &#39;ovpn&#39; linux kernel module.<br><br>Cha=
nge-Id: I22af9957b27785514d8c6d58fe4f2100d007fa5c<br>Signed-off-by: Antonio=
 Quartulli &lt;antonio@...2726...&gt;<br>---<br>M README.dco.md<br>1 file c=
hanged, 14 insertions(+), 19 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/87/1087/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/README=
.dco.md b/README.dco.md</span><br><span>index 3f7e00c..a93dc94 100644</span=
><br><span>--- a/README.dco.md</span><br><span>+++ b/README.dco.md</span><b=
r><span>@@ -14,26 +14,22 @@</span><br><span> </span><br><span> Getting star=
ted (Linux)</span><br><span> -----------------------</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- Use a recent Linux kernel. Linux 5.4.0 an=
d newer are known to work with</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  ovpn-dco.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+The new DCO linux kernel module (namely `ovpn`) has been merged upstream</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+as of linux-6.16. Fro=
m this kernel version onwards you directly get</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+the DCO module as shipped by your kernel.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+NOTE: the new `ovpn` Linux=
 kernel module is compatible only with OpenVPN</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+2.7 and greater.</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-Get the ovpn-dco module from one th=
ese urls and build it:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+Alternatively, if you run an older kernel or if you want to use a more</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+recent DCO module tha=
n the one shipped by your kernel, you need to use</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+the ovpn-backports project.</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-* https://gitlab.com/=
openvpn/ovpn-dco</span><br><span style=3D"color: hsl(0, 100%, 40%);">-* htt=
ps://github.com/OpenVPN/ovpn-dco</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+To learn how to use the ovpn-backports project and build your =
own DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+kernel modul=
e, please refer to the README file available at:</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-e.g.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  https://github.com/OpenVPN/ovpn-backports/b=
lob/main/README.md</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    git clone https://github.com/OpenVPN/ovpn-dco</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    cd ovpn-dco</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    make</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    sudo make install</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-If you want to report bugs please ensure to compile ovpn-dco with</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-`make DEBUG=3D1` and include=
 any debug message being printed by the</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-kernel (you can view those messages with `dmesg`).</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-Clone and build OpenVPN (or use OpenVPN 2.6+). Fo=
r example:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Then clon=
e and build OpenVPN (or use OpenVPN 2.7+). For example:</span><br><span> </=
span><br><span>     git clone https://github.com/openvpn/openvpn.git</span>=
<br><span>     cd openvpn</span><br><span>@@ -48,8 +44,8 @@</span><br><span=
> data channel offloading, OpenVPN will automatically disable DCO support a=
nd</span><br><span> warn the user.</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-Should OpenVPN be configured to use a featu=
re that is not supported by ovpn-dco</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-or should the ovpn-dco kernel module not be available on the=
 system, you will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Sh=
ould OpenVPN be configured to use a feature that is not supported by ovpn</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+or should the ovpn ke=
rnel module not be available on the system, you will</span><br><span> see a=
 message like</span><br><span> </span><br><span>     Note: Kernel support f=
or ovpn-dco missing, disabling data channel offload.</span><br><span>@@ -13=
1,4 +127,3 @@</span><br><span> - `--persist-tun` not tested;</span><br><spa=
n> - IPv6 mapped IPv4 addresses need Linux 5.4.189+/5.10.110+/5.12+ to work=
;</span><br><span> - some incompatible options may not properly fallback to=
 non-dco;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- no per cli=
ent statistics. Only total statistics available on the interface.</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1087?usp=3Demail">change 1087</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1087?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I22af9957b27785514d8c6d58fe4=
f2100d007fa5c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1087 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--6z0xsIgziTY=--

