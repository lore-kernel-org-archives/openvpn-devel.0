From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 17:23:06 +0000
References: <gerrit.1762536182000.Ief19ba87b0832baa6530ea8bf039d85115434e3e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <00d16a365209c21cfb10298636ed59be45af26b5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ofrxxIgZ59I="; charset=UTF-8
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

--ofrxxIgZ59I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1361?usp=3Demail

to review the following change.


Change subject: dco_freebsd.c: fix integer warnings
......................................................................

dco_freebsd.c: fix integer warnings

Fix all nvlist_get_number() related warnings by explicitly casting - these
are all messages coming from DCO, which we trust in this (nothing will
crash if a number is truncated, just "things will not work correctly").

Remove #pragmas.

Change-Id: Ief19ba87b0832baa6530ea8bf039d85115434e3e
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.c
1 file changed, 11 insertions(+), 17 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1361/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ief19ba87b0832baa6530ea8bf039d85115434e3e
Gerrit-Change-Number: 1361
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--ofrxxIgZ59I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1361?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco_freebsd.c: fix integer warnings<br><br>=
Fix all nvlist_get_number() related warnings by explicitly casting - these<=
br>are all messages coming from DCO, which we trust in this (nothing will<b=
r>crash if a number is truncated, just &quot;things will not work correctly=
&quot;).<br><br>Remove #pragmas.<br><br>Change-Id: Ief19ba87b0832baa6530ea8=
bf039d85115434e3e<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M src/openvpn/dco_freebsd.c<br>1 file changed, 11 insertions(+), 17=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/61/1361/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_f=
reebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index 21f0ac0..f2a89ac=
 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++=
 b/src/openvpn/dco_freebsd.c</span><br><span>@@ -72,11 +72,6 @@</span><br><=
span>     return (nvl);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC di=
agnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> static bool</span><br><span> nvlist_to_sockadd=
r(const nvlist_t *nvl, struct sockaddr_storage *ss)</span><br><span> {</spa=
n><br><span>@@ -93,7 +88,7 @@</span><br><span>         return (false);</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ss-&gt;ss_family =3D nvlist_get_number(nvl, &quot;af&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ss-&gt;ss_f=
amily =3D (unsigned char)nvlist_get_number(nvl, &quot;af&quot;);</span><br>=
<span> </span><br><span>     switch (ss-&gt;ss_family)</span><br><span>    =
 {</span><br><span>@@ -107,7 +102,7 @@</span><br><span>             data =
=3D nvlist_get_binary(nvl, &quot;address&quot;, &amp;len);</span><br><span>=
             ASSERT(len =3D=3D sizeof(in-&gt;sin_addr));</span><br><span>  =
           memcpy(&amp;in-&gt;sin_addr, data, sizeof(in-&gt;sin_addr));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            in-&gt;sin_po=
rt =3D nvlist_get_number(nvl, &quot;port&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            in-&gt;sin_port =3D (in_port_t)nvl=
ist_get_number(nvl, &quot;port&quot;);</span><br><span>             break;<=
/span><br><span>         }</span><br><span> </span><br><span>@@ -121,11 +11=
6,11 @@</span><br><span>             data =3D nvlist_get_binary(nvl, &quot;=
address&quot;, &amp;len);</span><br><span>             ASSERT(len =3D=3D si=
zeof(in6-&gt;sin6_addr));</span><br><span>             memcpy(&amp;in6-&gt;=
sin6_addr, data, sizeof(in6-&gt;sin6_addr));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            in6-&gt;sin6_port =3D nvlist_get_number(=
nvl, &quot;port&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            in6-&gt;sin6_port =3D (in_port_t)nvlist_get_number(nvl, &qu=
ot;port&quot;);</span><br><span> </span><br><span>             if (nvlist_e=
xists_number(nvl, &quot;scopeid&quot;))</span><br><span>             {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                in6-&gt;si=
n6_scope_id =3D nvlist_get_number(nvl, &quot;scopeid&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                in6-&gt;sin6_scope=
_id =3D (uint32_t)nvlist_get_number(nvl, &quot;scopeid&quot;);</span><br><s=
pan>             }</span><br><span>             break;</span><br><span>    =
     }</span><br><span>@@ -614,9 +609,12 @@</span><br><span>         return=
 -EINVAL;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    dco-&gt;dco_message_peer_id =3D nvlist_get=
_number(nvl, &quot;peerid&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* dco_message_peer_id is signed int, because other parts=
 of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * code =
treat &quot;-1&quot; as &quot;this is a message not specific to one peer&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_peer=
_id =3D (int)nvlist_get_number(nvl, &quot;peerid&quot;);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    type =3D nvlist_ge=
t_number(nvl, &quot;notification&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    type =3D (enum ovpn_notif_type)nvlist_get_number(n=
vl, &quot;notification&quot;);</span><br><span> </span><br><span>     switc=
h (type)</span><br><span>     {</span><br><span>@@ -625,7 +623,7 @@</span><=
br><span> </span><br><span>             if (nvlist_exists_number(nvl, &quot=
;del_reason&quot;))</span><br><span>             {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                uint32_t reason =3D nvlist_get=
_number(nvl, &quot;del_reason&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                uint32_t reason =3D (uint32_t)nvlist_get_=
number(nvl, &quot;del_reason&quot;);</span><br><span>                 if (r=
eason =3D=3D OVPN_DEL_REASON_TIMEOUT)</span><br><span>                 {</s=
pan><br><span>                     dco-&gt;dco_del_peer_reason =3D OVPN_DEL=
_PEER_REASON_EXPIRED;</span><br><span>@@ -869,7 +867,7 @@</span><br><span> =
    for (size_t i =3D 0; i &lt; npeers; i++)</span><br><span>     {</span><=
br><span>         const nvlist_t *peer =3D nvpeers[i];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        uint32_t peerid =3D nvlist_get_num=
ber(peer, &quot;peerid&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uint32_t peerid =3D (uint32_t)nvlist_get_number(peer, &q=
uot;peerid&quot;);</span><br><span>         const nvlist_t *bytes =3D nvlis=
t_get_nvlist(peer, &quot;bytes&quot;);</span><br><span> </span><br><span>  =
       /* we can end here in p2mp mode, or in p2p mode via</span><br><span>=
@@ -890,10 +888,6 @@</span><br><span>     return 0;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> /* get stats for a single peer</span><br><span>  * we=
 can get here for &quot;the peer stats&quot; in p2p client mode, or by</spa=
n><br><span>  * being queried for a particular peer in p2mp mode, for --ina=
ctive</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1361?usp=3Demail">change 1361</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1361?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief19ba87b0832baa6530ea8bf03=
9d85115434e3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1361 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
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

</body></html>=

--ofrxxIgZ59I=--

