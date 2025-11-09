From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 9 Nov 2025 11:11:18 +0000
In-Reply-To: <gerrit.1762536182000.Ief19ba87b0832baa6530ea8bf039d85115434e3e@...2715...>
References: <gerrit.1762536182000.Ief19ba87b0832baa6530ea8bf039d85115434e3e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <710fb66e693512303995c547ec13f18228c0f2d6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0VBA7eg7zJc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_freebsd.c: fix
 integer warnings
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

--0VBA7eg7zJc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1361?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: dco_freebsd.c: fix integer warnings
......................................................................

dco_freebsd.c: fix integer warnings

Fix all nvlist_get_number() related warnings by explicitly casting - these
are all messages coming from DCO, which we trust in this (nothing will
crash if a number is truncated, just "things will not work correctly").

Remove #pragmas.

Change-Id: Ief19ba87b0832baa6530ea8bf039d85115434e3e
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1361
Message-Id: <20251107174810.31851-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
256.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 11 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1361/2

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 21f0ac0..f2a89ac 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -72,11 +72,6 @@
     return (nvl);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static bool
 nvlist_to_sockaddr(const nvlist_t *nvl, struct sockaddr_storage *ss)
 {
@@ -93,7 +88,7 @@
         return (false);
     }

-    ss->ss_family =3D nvlist_get_number(nvl, "af");
+    ss->ss_family =3D (unsigned char)nvlist_get_number(nvl, "af");
=20
     switch (ss->ss_family)
     {
@@ -107,7 +102,7 @@
             data =3D nvlist_get_binary(nvl, "address", &len);
             ASSERT(len =3D=3D sizeof(in->sin_addr));
             memcpy(&in->sin_addr, data, sizeof(in->sin_addr));
-            in->sin_port =3D nvlist_get_number(nvl, "port");
+            in->sin_port =3D (in_port_t)nvlist_get_number(nvl, "port");
             break;
         }

@@ -121,11 +116,11 @@
             data =3D nvlist_get_binary(nvl, "address", &len);
             ASSERT(len =3D=3D sizeof(in6->sin6_addr));
             memcpy(&in6->sin6_addr, data, sizeof(in6->sin6_addr));
-            in6->sin6_port =3D nvlist_get_number(nvl, "port");
+            in6->sin6_port =3D (in_port_t)nvlist_get_number(nvl, "port");

             if (nvlist_exists_number(nvl, "scopeid"))
             {
-                in6->sin6_scope_id =3D nvlist_get_number(nvl, "scopeid");
+                in6->sin6_scope_id =3D (uint32_t)nvlist_get_number(nvl, "s=
copeid");
             }
             break;
         }
@@ -614,9 +609,12 @@
         return -EINVAL;
     }

-    dco->dco_message_peer_id =3D nvlist_get_number(nvl, "peerid");
+    /* dco_message_peer_id is signed int, because other parts of the
+     * code treat "-1" as "this is a message not specific to one peer"
+     */
+    dco->dco_message_peer_id =3D (int)nvlist_get_number(nvl, "peerid");

-    type =3D nvlist_get_number(nvl, "notification");
+    type =3D (enum ovpn_notif_type)nvlist_get_number(nvl, "notification");

     switch (type)
     {
@@ -625,7 +623,7 @@

             if (nvlist_exists_number(nvl, "del_reason"))
             {
-                uint32_t reason =3D nvlist_get_number(nvl, "del_reason");
+                uint32_t reason =3D (uint32_t)nvlist_get_number(nvl, "del_=
reason");
                 if (reason =3D=3D OVPN_DEL_REASON_TIMEOUT)
                 {
                     dco->dco_del_peer_reason =3D OVPN_DEL_PEER_REASON_EXPI=
RED;
@@ -869,7 +867,7 @@
     for (size_t i =3D 0; i < npeers; i++)
     {
         const nvlist_t *peer =3D nvpeers[i];
-        uint32_t peerid =3D nvlist_get_number(peer, "peerid");
+        uint32_t peerid =3D (uint32_t)nvlist_get_number(peer, "peerid");
         const nvlist_t *bytes =3D nvlist_get_nvlist(peer, "bytes");

         /* we can end here in p2mp mode, or in p2p mode via
@@ -890,10 +888,6 @@
     return 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* get stats for a single peer
  * we can get here for "the peer stats" in p2p client mode, or by
  * being queried for a particular peer in p2mp mode, for --inactive

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1361?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ief19ba87b0832baa6530ea8bf039d85115434e3e
Gerrit-Change-Number: 1361
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0VBA7eg7zJc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1361?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">dco_freebsd.c: fix integer w=
arnings<br><br>Fix all nvlist_get_number() related warnings by explicitly c=
asting - these<br>are all messages coming from DCO, which we trust in this =
(nothing will<br>crash if a number is truncated, just &quot;things will not=
 work correctly&quot;).<br><br>Remove #pragmas.<br><br>Change-Id: Ief19ba87=
b0832baa6530ea8bf039d85115434e3e<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ger=
rit URL: https://gerrit.openvpn.net/c/openvpn/+/1361<br>Message-Id: &lt;202=
51107174810.31851-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.co=
m/openvpn-devel@lists.sourceforge.net/msg34256.html<br>Signed-off-by: Gert =
Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_freebsd.c<br>1 =
file changed, 11 insertions(+), 17 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1361/2</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</spa=
n><br><span>index 21f0ac0..f2a89ac 100644</span><br><span>--- a/src/openvpn=
/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><s=
pan>@@ -72,11 +72,6 @@</span><br><span>     return (nvl);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool<=
/span><br><span> nvlist_to_sockaddr(const nvlist_t *nvl, struct sockaddr_st=
orage *ss)</span><br><span> {</span><br><span>@@ -93,7 +88,7 @@</span><br><=
span>         return (false);</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ss-&gt;ss_family =3D n=
vlist_get_number(nvl, &quot;af&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ss-&gt;ss_family =3D (unsigned char)nvlist_get_numbe=
r(nvl, &quot;af&quot;);</span><br><span> </span><br><span>     switch (ss-&=
gt;ss_family)</span><br><span>     {</span><br><span>@@ -107,7 +102,7 @@</s=
pan><br><span>             data =3D nvlist_get_binary(nvl, &quot;address&qu=
ot;, &amp;len);</span><br><span>             ASSERT(len =3D=3D sizeof(in-&g=
t;sin_addr));</span><br><span>             memcpy(&amp;in-&gt;sin_addr, dat=
a, sizeof(in-&gt;sin_addr));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            in-&gt;sin_port =3D nvlist_get_number(nvl, &quot;port&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            in=
-&gt;sin_port =3D (in_port_t)nvlist_get_number(nvl, &quot;port&quot;);</spa=
n><br><span>             break;</span><br><span>         }</span><br><span>=
 </span><br><span>@@ -121,11 +116,11 @@</span><br><span>             data =
=3D nvlist_get_binary(nvl, &quot;address&quot;, &amp;len);</span><br><span>=
             ASSERT(len =3D=3D sizeof(in6-&gt;sin6_addr));</span><br><span>=
             memcpy(&amp;in6-&gt;sin6_addr, data, sizeof(in6-&gt;sin6_addr)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            in6-&gt=
;sin6_port =3D nvlist_get_number(nvl, &quot;port&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            in6-&gt;sin6_port =3D (in_=
port_t)nvlist_get_number(nvl, &quot;port&quot;);</span><br><span> </span><b=
r><span>             if (nvlist_exists_number(nvl, &quot;scopeid&quot;))</s=
pan><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                in6-&gt;sin6_scope_id =3D nvlist_get_number(nvl, &qu=
ot;scopeid&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               in6-&gt;sin6_scope_id =3D (uint32_t)nvlist_get_number(nvl, &=
quot;scopeid&quot;);</span><br><span>             }</span><br><span>       =
      break;</span><br><span>         }</span><br><span>@@ -614,9 +609,12 @=
@</span><br><span>         return -EINVAL;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco-&gt;d=
co_message_peer_id =3D nvlist_get_number(nvl, &quot;peerid&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* dco_message_peer_id i=
s signed int, because other parts of the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * code treat &quot;-1&quot; as &quot;this is a me=
ssage not specific to one peer&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    dco-&gt;dco_message_peer_id =3D (int)nvlist_get_number(nvl, &quot;=
peerid&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    type =3D nvlist_get_number(nvl, &quot;notification&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    type =3D (enum ov=
pn_notif_type)nvlist_get_number(nvl, &quot;notification&quot;);</span><br><=
span> </span><br><span>     switch (type)</span><br><span>     {</span><br>=
<span>@@ -625,7 +623,7 @@</span><br><span> </span><br><span>             if=
 (nvlist_exists_number(nvl, &quot;del_reason&quot;))</span><br><span>      =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   uint32_t reason =3D nvlist_get_number(nvl, &quot;del_reason&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                uint32_t=
 reason =3D (uint32_t)nvlist_get_number(nvl, &quot;del_reason&quot;);</span=
><br><span>                 if (reason =3D=3D OVPN_DEL_REASON_TIMEOUT)</spa=
n><br><span>                 {</span><br><span>                     dco-&gt=
;dco_del_peer_reason =3D OVPN_DEL_PEER_REASON_EXPIRED;</span><br><span>@@ -=
869,7 +867,7 @@</span><br><span>     for (size_t i =3D 0; i &lt; npeers; i+=
+)</span><br><span>     {</span><br><span>         const nvlist_t *peer =3D=
 nvpeers[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
int32_t peerid =3D nvlist_get_number(peer, &quot;peerid&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uint32_t peerid =3D (ui=
nt32_t)nvlist_get_number(peer, &quot;peerid&quot;);</span><br><span>       =
  const nvlist_t *bytes =3D nvlist_get_nvlist(peer, &quot;bytes&quot;);</sp=
an><br><span> </span><br><span>         /* we can end here in p2mp mode, or=
 in p2p mode via</span><br><span>@@ -890,10 +888,6 @@</span><br><span>     =
return 0;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* get stats for a s=
ingle peer</span><br><span>  * we can get here for &quot;the peer stats&quo=
t; in p2p client mode, or by</span><br><span>  * being queried for a partic=
ular peer in p2mp mode, for --inactive</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1361?usp=3D=
email">change 1361</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1361?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief19ba87b0832baa6530ea8bf03=
9d85115434e3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1361 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--0VBA7eg7zJc=--

