From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 17 Mar 2025 15:14:01 +0000
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@...2715...>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <f826a03e5d24d9cdb5b1fb05f6b7ec1f3a58a080-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fTVDZa0TLAc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fTVDZa0TLAc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/890?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: Always use a 0.0.0.0/0 default on Android instead of def1
......................................................................

Always use a 0.0.0.0/0 default on Android instead of def1

Certain handset manufactures (like Samsung iirc)  are handling
0.0.0.0/0 different from the split /1 routes, so push the 0.0.0.0/0
route to the OS.

Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/options.c
1 file changed, 3 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/890/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 31000e9..19cf455 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7320,7 +7320,10 @@
             }
             else if (streq(p[j], "def1"))
             {
+#ifndef TARGET_ANDROID
+                /* Android always uses 0.0.0.0/0, so silently ignore the f=
lag */
                 options->routes->flags |=3D RG_DEF1;
+#endif
             }
             else if (streq(p[j], "bypass-dhcp"))
             {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/890?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
Gerrit-Change-Number: 890
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--fTVDZa0TLAc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/890?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Always use a 0.0.0.0/0 default on Android instead of=
 def1<br><br>Certain handset manufactures (like Samsung iirc)  are handling=
<br>0.0.0.0/0 different from the split /1 routes, so push the 0.0.0.0/0<br>=
route to the OS.<br><br>Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea75=
7<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/op=
envpn/options.c<br>1 file changed, 3 insertions(+), 0 deletions(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/890/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><=
span>index 31000e9..19cf455 100644</span><br><span>--- a/src/openvpn/option=
s.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -7320,7 =
+7320,10 @@</span><br><span>             }</span><br><span>             els=
e if (streq(p[j], &quot;def1&quot;))</span><br><span>             {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TARGET_ANDROID</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Andro=
id always uses 0.0.0.0/0, so silently ignore the flag */</span><br><span>  =
               options-&gt;routes-&gt;flags |=3D RG_DEF1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>             }=
</span><br><span>             else if (streq(p[j], &quot;bypass-dhcp&quot;)=
)</span><br><span>             {</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/890?usp=3Demail">=
change 890</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/890?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e1=
8813d103ea757 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 890 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--fTVDZa0TLAc=--

