From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 12 Feb 2025 11:53:32 +0000
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7339e232f9d6a9dbd94473d7f647f51061a188b6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M2YB4PnhSQo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Always use a
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

--M2YB4PnhSQo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/890?usp=3Demail

to review the following change.


Change subject: Always use a 0.0.0.0/0 default on Android instead of def1
......................................................................

Always use a 0.0.0.0/0 default on Android instead of def1

Certain handset manufactures (like Samsung iirc)  are handling
0.0.0.0/0 different from the split /1 routes, so push the 0.0.0.0/0
route to the OS.

Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/route.c
1 file changed, 12 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/890/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d895e1c..71a0bbc9 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1078,6 +1078,17 @@

             if (rl->flags & RG_REROUTE_GW)
             {
+#ifdef TARGET_ANDROID
+                add_route3(0,
+                           0,
+                           rl->spec.remote_endpoint,
+                           tt,
+                           flags,
+                           &rl->rgi,
+                           es,
+                           ctx);
+
+#else  /* ifdef TARGET_ANDROID */
                 if (rl->flags & RG_DEF1)
                 {
                     /* add new default route (1st component) */
@@ -1102,6 +1113,7 @@
                     ret =3D add_route3(0, 0, rl->spec.remote_endpoint, tt,
                                      flags, &rl->rgi, es, ctx) && ret;
                 }
+#endif /* ifdef TARGET_ANDROID */
             }

             /* set a flag so we can undo later */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/890?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
Gerrit-Change-Number: 890
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--M2YB4PnhSQo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/890?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Always use a 0.0.0.0/0 default on Android instead of def1<br>=
<br>Certain handset manufactures (like Samsung iirc)  are handling<br>0.0.0=
.0/0 different from the split /1 routes, so push the 0.0.0.0/0<br>route to =
the OS.<br><br>Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757<br>Sign=
ed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/rou=
te.c<br>1 file changed, 12 insertions(+), 0 deletions(-)<br><br></pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/890/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index d89=
5e1c..71a0bbc9 100644</span><br><span>--- a/src/openvpn/route.c</span><br><=
span>+++ b/src/openvpn/route.c</span><br><span>@@ -1078,6 +1078,17 @@</span=
><br><span> </span><br><span>             if (rl-&gt;flags &amp; RG_REROUTE=
_GW)</span><br><span>             {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef TARGET_ANDROID</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                add_route3(0,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                           0,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                           rl-&gt;spe=
c.remote_endpoint,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                          tt,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                           flags,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                           &amp;rl-&gt;rgi,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
           ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* ifdef TARGET=
_ANDROID */</span><br><span>                 if (rl-&gt;flags &amp; RG_DEF1=
)</span><br><span>                 {</span><br><span>                     /=
* add new default route (1st component) */</span><br><span>@@ -1102,6 +1113=
,7 @@</span><br><span>                     ret =3D add_route3(0, 0, rl-&gt;=
spec.remote_endpoint, tt,</span><br><span>                                 =
     flags, &amp;rl-&gt;rgi, es, ctx) &amp;&amp; ret;</span><br><span>     =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
 /* ifdef TARGET_ANDROID */</span><br><span>             }</span><br><span>=
 </span><br><span>             /* set a flag so we can undo later */</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/890?usp=3Demail">change 890</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/890?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e1=
8813d103ea757 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 890 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--M2YB4PnhSQo=--

