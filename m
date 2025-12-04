From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 4 Dec 2025 15:01:50 +0000
In-Reply-To: <gerrit.1762945572000.I1104044701145fa37cea857e2e0e0fcac7a2bee3@...2715...>
References: <gerrit.1762945572000.I1104044701145fa37cea857e2e0e0fcac7a2bee3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <f47bb7885d4c2ffdd04c4119d77da41b41479fbe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DkC8vJo/6Yg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix dco with null
 cipher being enabled without auth none
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DkC8vJo/6Yg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
69?usp=3Demail )

Change subject: Fix dco with null cipher being enabled without auth none
......................................................................

Fix dco with null cipher being enabled without auth none

This is a corner case and only the FreeBSD DCO module support the
none encryption but as long as it supports it, we should only
enable it when the configuration actually allows to enable it.

Change-Id: I1104044701145fa37cea857e2e0e0fcac7a2bee3
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1369
Message-Id: <20251204134521.20025-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
847.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco.c
1 file changed, 12 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7abdad3..6a1a5c9 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -474,6 +474,18 @@
             gc_free(&gc);
             return false;
         }
+        /* FreeBSD supports none as cipher type but requires auth none to =
be
+         * be also enabled */
+        if (strcmp(token, "none") =3D=3D 0 && strcmp(o->authname, "none") =
!=3D 0)
+        {
+            msg(msglevel,
+                "Note: cipher '%s' in --data-ciphers is only supported "
+                "with --auth=3Dnone by ovpn-dco, disabling data channel "
+                "offload.",
+                token);
+            gc_free(&gc);
+            return false;
+        }
     }
     gc_free(&gc);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1369?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1104044701145fa37cea857e2e0e0fcac7a2bee3
Gerrit-Change-Number: 1369
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DkC8vJo/6Yg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1369?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Fix dco with null cipher being enabled without a=
uth none<br><br>This is a corner case and only the FreeBSD DCO module suppo=
rt the<br>none encryption but as long as it supports it, we should only<br>=
enable it when the configuration actually allows to enable it.<br><br>Chang=
e-Id: I1104044701145fa37cea857e2e0e0fcac7a2bee3<br>Signed-off-by: Arne Schw=
abe &lt;arne@...1227...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...1665...=
726...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1369<br>Me=
ssage-Id: &lt;20251204134521.20025-1-gert@...1296...&gt;<br>URL: https://ww=
w.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34847.html<br>Sig=
ned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dc=
o.c<br>1 file changed, 12 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index=
 7abdad3..6a1a5c9 100644</span><br><span>--- a/src/openvpn/dco.c</span><br>=
<span>+++ b/src/openvpn/dco.c</span><br><span>@@ -474,6 +474,18 @@</span><b=
r><span>             gc_free(&amp;gc);</span><br><span>             return =
false;</span><br><span>         }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* FreeBSD supports none as cipher type but requires =
auth none to be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * be also enabled */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (strcmp(token, &quot;none&quot;) =3D=3D 0 &amp;&amp; strcm=
p(o-&gt;authname, &quot;none&quot;) !=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(msglevel,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                &quot;Note: cipher &#39;%s&#39; in --da=
ta-ciphers is only supported &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                &quot;with --auth=3Dnone by ovpn-dco, disab=
ling data channel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot;offload.&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                token);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }=
</span><br><span>     gc_free(&amp;gc);</span><br><span> </span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1369?usp=3Demail">change 1369</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1369?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1104044701145fa37cea857e2e0=
e0fcac7a2bee3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1369 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--DkC8vJo/6Yg=--

