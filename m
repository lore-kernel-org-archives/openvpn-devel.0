From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 18 Oct 2025 16:48:49 +0000
In-Reply-To: <gerrit.1760700482000.I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4@...2715...>
References: <gerrit.1760700482000.I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0b27fc887e1fcf557108f6fa8e8eb3de072ea51e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nZOOtij+pEY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nZOOtij+pEY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
84?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I46d0e4be82a5cc7e466d6e8f658e5b131b5401c4
Gerrit-Change-Number: 1284
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nZOOtij+pEY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1284?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">route: Add #endif comment for uncrustify complia=
nce<br><br>Cherry-pick dca6b03098ab0f3ef808c891673305651dc6704a<br>broke un=
crustify compliance. Apparently this one added<br>line pushed it over the l=
imit to require the #endif<br>comment.<br><br>Change-Id: I46d0e4be82a5cc7e4=
66d6e8f658e5b131b5401c4<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: =
https://gerrit.openvpn.net/c/openvpn/+/1284<br>Message-Id: &lt;202510172057=
30.8450-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-=
devel@lists.sourceforge.net/msg33428.html<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>1 file changed, 1 =
insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>i=
ndex 3ff9717..75e94c2 100644</span><br><span>--- a/src/openvpn/route.c</spa=
n><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -2368,7 +2368,7 @@=
</span><br><span>     {</span><br><span>         gateway_needed =3D true;</=
span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifn=
def _WIN32 */</span><br><span> </span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1284?usp=3Demail">change 1284</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1284?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--nZOOtij+pEY=--

