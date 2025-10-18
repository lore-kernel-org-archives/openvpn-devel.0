From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 18 Oct 2025 16:48:47 +0000
In-Reply-To: <gerrit.1760700482000.I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4@...2715...>
References: <gerrit.1760700482000.I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0b27fc887e1fcf557108f6fa8e8eb3de072ea51e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HcfOWBrhgUE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: route: Add
 #endif comment for uncrustify compliance
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

--HcfOWBrhgUE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1284?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: route: Add #endif comment for uncrustify compliance
......................................................................

route: Add #endif comment for uncrustify compliance

Cherry-pick dca6b03098ab0f3ef808c891673305651dc6704a
broke uncrustify compliance. Apparently this one added
line pushed it over the limit to require the #endif
comment.

Change-Id: I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1284
Message-Id: <20251017205730.8450-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
428.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1284/2

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3ff9717..75e94c2 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2368,7 +2368,7 @@
     {
         gateway_needed =3D true;
     }
-#endif
+#endif /* ifndef _WIN32 */

     struct gc_arena gc =3D gc_new();
     struct argv argv =3D argv_new();

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1284?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4
Gerrit-Change-Number: 1284
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HcfOWBrhgUE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1284?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">route: Add #endif comment for uncru=
stify compliance<br><br>Cherry-pick dca6b03098ab0f3ef808c891673305651dc6704=
a<br>broke uncrustify compliance. Apparently this one added<br>line pushed =
it over the limit to require the #endif<br>comment.<br><br>Change-Id: I46d0=
e4be82a5cc7e466d6e8f658e5b131b5401c4<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br=
>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1284<br>Message-Id: &lt=
;20251017205730.8450-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg33428.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>1 fil=
e changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1284/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 3=
ff9717..75e94c2 100644</span><br><span>--- a/src/openvpn/route.c</span><br>=
<span>+++ b/src/openvpn/route.c</span><br><span>@@ -2368,7 +2368,7 @@</span=
><br><span>     {</span><br><span>         gateway_needed =3D true;</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef _W=
IN32 */</span><br><span> </span><br><span>     struct gc_arena gc =3D gc_ne=
w();</span><br><span>     struct argv argv =3D argv_new();</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1284?usp=3Demail">change 1284</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1284?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I46d0e4be82a5cc7e466d6e8f658=
e5b131b5401c4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1284 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--HcfOWBrhgUE=--

