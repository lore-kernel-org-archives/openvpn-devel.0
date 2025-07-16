From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 16 Jul 2025 12:41:39 +0000
References: <gerrit.1752669697000.I22af9957b27785514d8c6d58fe4f2100d007fa5c@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cf15571b47d39c51bb3e4d925e3e9aa526a944ec-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iLej8G6/1Ow="; charset=UTF-8
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

--iLej8G6/1Ow=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1087?usp=3Demail

to review the following change.


Change subject: README.dco: update Linux instructions
......................................................................

README.dco: update Linux instructions

Update the README.dco file by including instructions related
to the new 'ovpn' linux kernel module.

Change-Id: I22af9957b27785514d8c6d58fe4f2100d007fa5c
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M README.dco.md
1 file changed, 12 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1087/1

diff --git a/README.dco.md b/README.dco.md
index 3f7e00c..8c2ff87 100644
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1087?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I22af9957b27785514d8c6d58fe4f2100d007fa5c
Gerrit-Change-Number: 1087
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--iLej8G6/1Ow=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1087?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">README.dco: update Linux instructions<br><br>Update the READ=
ME.dco file by including instructions related<br>to the new &#39;ovpn&#39; =
linux kernel module.<br><br>Change-Id: I22af9957b27785514d8c6d58fe4f2100d00=
7fa5c<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---=
<br>M README.dco.md<br>1 file changed, 12 insertions(+), 16 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/108=
7/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/README.dco.md b/README.dco.md</span><br><span>inde=
x 3f7e00c..8c2ff87 100644</span><br><span>--- a/README.dco.md</span><br><sp=
an>+++ b/README.dco.md</span><br><span>@@ -14,26 +14,22 @@</span><br><span>=
 </span><br><span> Getting started (Linux)</span><br><span> ---------------=
--------</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- Use a recen=
t Linux kernel. Linux 5.4.0 and newer are known to work with</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  ovpn-dco.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+The new DCO linux kernel module (namely `ovp=
n`) has been merged upstream</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+as of linux-6.16. From this kernel version onwards you directly ge=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the DCO module as =
shipped by your kernel.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+NOTE: the new `ovpn` Linux kernel module is compatible only with OpenVP=
N</span><br><span style=3D"color: hsl(120, 100%, 40%);">+2.7 and greater.</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-Get t=
he ovpn-dco module from one these urls and build it:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Alternatively, if you run an older kernel=
 or if you want to use a more</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+recent DCO module than the one shipped by your kernel, you need t=
o use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the ovpn-backp=
orts project.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-* https://gitlab.com/openvpn/ovpn-dco</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-* https://github.com/OpenVPN/ovpn-dco</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+To learn how to use the ovpn-ba=
ckports project and build your own DCO</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+kernel module, please refer to the README file available=
 at:</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-e.g.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  https://gith=
ub.com/OpenVPN/ovpn-backports/blob/main/README.md</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    git clone https://github.=
com/OpenVPN/ovpn-dco</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   cd ovpn-dco</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mak=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sudo make instal=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-If you want to report bugs please ensure =
to compile ovpn-dco with</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-`make DEBUG=3D1` and include any debug message being printed by the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-kernel (you can view those=
 messages with `dmesg`).</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Clone and build Op=
enVPN (or use OpenVPN 2.6+). For example:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+Then clone and build OpenVPN (or use OpenVPN 2.7+). F=
or example:</span><br><span> </span><br><span>     git clone https://github=
.com/openvpn/openvpn.git</span><br><span>     cd openvpn</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1087?usp=3Demail">change 1087</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1087?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I22af9957b27785514d8c6d58fe4=
f2100d007fa5c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1087 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--iLej8G6/1Ow=--

