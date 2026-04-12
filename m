From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 12 Apr 2026 14:44:05 +0000
In-Reply-To: <gerrit.1772721382000.If797f3fe178fba3f43fb12898e5484bfb38f05c3@...2715...>
References: <gerrit.1772721382000.If797f3fe178fba3f43fb12898e5484bfb38f05c3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fc2b49f2e2496a462fef572e58e1e010c5e2c1d2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lxzPNz4Y4ZA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Optimise iterating
 over all clients by remembering highest peer id
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

--lxzPNz4Y4ZA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1557?usp=3Demail )


Change subject: Optimise iterating over all clients by remembering highest =
peer id
......................................................................

Optimise iterating over all clients by remembering highest peer id

This keeps track of the highest peer id that is currently allocated to avoid
iterating over the empty tail of the m->instances array.

Change-Id: If797f3fe178fba3f43fb12898e5484bfb38f05c3
Signed-off-by: Arne Schwabe <arne@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1557
Message-Id: <20260412125356.32261-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
577.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/push_util.c
3 files changed, 26 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/1557/8

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0b03ff1..c7a91ab 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -601,6 +601,13 @@
         if (mi->context.c2.tls_multi->peer_id !=3D MAX_PEER_ID)
         {
             m->instances[mi->context.c2.tls_multi->peer_id] =3D NULL;
+
+            /* Adjust the max_peerid as this might have been the highest
+             * peer id instance */
+            while (m->max_peerid > 0 && m->instances[m->max_peerid] =3D=3D=
 NULL)
+            {
+                m->max_peerid--;
+            }
         }

         schedule_remove_entry(m->schedule, (struct schedule_entry *)mi);
@@ -652,7 +659,7 @@
 {
     if (m->hash)
     {
-        for (int i =3D 0; i < m->max_clients; i++)
+        for (uint32_t i =3D 0; i <=3D m->max_peerid; i++)
         {
             struct multi_instance *mi =3D m->instances[i];
             if (mi)
@@ -1326,7 +1333,7 @@
         {
             int count =3D 0;

-            for (int i =3D 0; i < m->max_clients; i++)
+            for (uint32_t i =3D 0; i <=3D m->max_peerid; i++)
             {
                 struct multi_instance *mi =3D m->instances[i];
                 if (mi && mi !=3D new_mi && !mi->halt)
@@ -2885,7 +2892,7 @@
 #endif
         mb =3D mbuf_alloc_buf(buf);

-        for (int i =3D 0; i < m->max_clients; i++)
+        for (uint32_t i =3D 0; i <=3D m->max_peerid; i++)
         {
             struct multi_instance *mi =3D m->instances[i];

@@ -3794,7 +3801,7 @@
 multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
 {
     /* tell all clients to restart */
-    for (int i =3D 0; i < m->max_clients; i++)
+    for (uint32_t i =3D 0; i <=3D m->max_peerid; i++)
     {
         struct multi_instance *mi =3D m->instances[i];
         if (mi && !mi->halt && proto_is_dgram(mi->context.c2.link_sockets[=
0]->info.proto))
@@ -3876,7 +3883,7 @@
     struct multi_context *m =3D (struct multi_context *)arg;
     int count =3D 0;

-    for (int i =3D 0; i < m->max_clients; i++)
+    for (uint32_t i =3D 0; i <=3D m->max_peerid; i++)
     {
         struct multi_instance *mi =3D m->instances[i];
         if (mi && !mi->halt)
@@ -3907,7 +3914,7 @@
     maddr.proto =3D proto;
     if (mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
     {
-        for (int i =3D 0; i < m->max_clients; i++)
+        for (uint32_t i =3D 0; i <=3D m->max_peerid; i++)
         {
             struct multi_instance *mi =3D m->instances[i];
             if (mi && !mi->halt && mroute_addr_equal(&maddr, &mi->real))
@@ -4100,8 +4107,14 @@
     }

     /* should not really end up here, since multi_create_instance returns =
null
-     * if amount of clients exceeds max_clients */
+     * if amount of clients exceeds max_clients and this method would then
+     * also not have been called */
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
+
+    if (mi->context.c2.tls_multi->peer_id > m->max_peerid)
+    {
+        m->max_peerid =3D mi->context.c2.tls_multi->peer_id;
+    }
 }

 #if defined(__GNUC__) || defined(__clang__)
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3f4eefe..935bda1 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -160,9 +160,12 @@
  */
 struct multi_context
 {
-    struct multi_instance **instances; /**< Array of multi_instances. An i=
nstance can be
+    struct multi_instance **instances; /**< Array of multi_instances with =
the size of
+                                        *  max_clients.  An instance can be
                                         * accessed using peer-id as an ind=
ex. */
-
+    uint32_t max_peerid;               /**< highest currently allocated pe=
er-id
+                                        * and maximum allocated/valid inde=
x in
+                                        * instances */
     struct hash *hash;                 /**< VPN tunnel instances indexed b=
y real
                                         *   address of the remote peer. */
     struct hash *vhash;                /**< VPN tunnel instances indexed by
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index fe48091..f57f54d 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -317,7 +317,7 @@

     int count =3D 0;

-    for (int i =3D 0; i < m->max_clients; i++)
+    for (uint32_t i =3D 0; i <=3D m->max_peerid; i++)
     {
         struct multi_instance *curr_mi =3D m->instances[i];


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1557?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If797f3fe178fba3f43fb12898e5484bfb38f05c3
Gerrit-Change-Number: 1557
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lxzPNz4Y4ZA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1557?usp=3Demail">Vi=
ew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">Optimise iterating over all clients by remem=
bering highest peer id<br><br>This keeps track of the highest peer id that =
is currently allocated to avoid<br>iterating over the empty tail of the m-&=
gt;instances array.<br><br>Change-Id: If797f3fe178fba3f43fb12898e5484bfb38f=
05c3<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Gerrit URL: =
https://gerrit.openvpn.net/c/openvpn/+/1557<br>Message-Id: &lt;202604121253=
56.32261-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg36577.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M src/openvpn/multi.c<br>M src/openvpn/mul=
ti.h<br>M src/openvpn/push_util.c<br>3 files changed, 26 insertions(+), 10 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/57/1557/8</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.=
c b/src/openvpn/multi.c</span><br><span>index 0b03ff1..c7a91ab 100644</span=
><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/mult=
i.c</span><br><span>@@ -601,6 +601,13 @@</span><br><span>         if (mi-&g=
t;context.c2.tls_multi-&gt;peer_id !=3D MAX_PEER_ID)</span><br><span>      =
   {</span><br><span>             m-&gt;instances[mi-&gt;context.c2.tls_mul=
ti-&gt;peer_id] =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* Adjust the max_peerid as this might have been the highest</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             * peer id instance */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            while (m=
-&gt;max_peerid &gt; 0 &amp;&amp; m-&gt;instances[m-&gt;max_peerid] =3D=3D =
NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m-&g=
t;max_peerid--;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span>         }</span><br><span> </span><br><span>    =
     schedule_remove_entry(m-&gt;schedule, (struct schedule_entry *)mi);</s=
pan><br><span>@@ -652,7 +659,7 @@</span><br><span> {</span><br><span>     i=
f (m-&gt;hash)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        for (int i =3D 0; i &lt; m-&gt;max_clients; i++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (uint32_t =
i =3D 0; i &lt;=3D m-&gt;max_peerid; i++)</span><br><span>         {</span>=
<br><span>             struct multi_instance *mi =3D m-&gt;instances[i];</s=
pan><br><span>             if (mi)</span><br><span>@@ -1326,7 +1333,7 @@</s=
pan><br><span>         {</span><br><span>             int count =3D 0;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    for (int i =3D 0; i &lt; m-&gt;max_clients; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            for (uint32_t i =3D 0; i &lt;=
=3D m-&gt;max_peerid; i++)</span><br><span>             {</span><br><span> =
                struct multi_instance *mi =3D m-&gt;instances[i];</span><br=
><span>                 if (mi &amp;&amp; mi !=3D new_mi &amp;&amp; !mi-&gt=
;halt)</span><br><span>@@ -2885,7 +2892,7 @@</span><br><span> #endif</span>=
<br><span>         mb =3D mbuf_alloc_buf(buf);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 0; i &lt;=
 m-&gt;max_clients; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        for (uint32_t i =3D 0; i &lt;=3D m-&gt;max_peerid; i++)</span>=
<br><span>         {</span><br><span>             struct multi_instance *mi=
 =3D m-&gt;instances[i];</span><br><span> </span><br><span>@@ -3794,7 +3801=
,7 @@</span><br><span> multi_push_restart_schedule_exit(struct multi_contex=
t *m, bool next_server)</span><br><span> {</span><br><span>     /* tell all=
 clients to restart */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    for (int i =3D 0; i &lt; m-&gt;max_clients; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (uint32_t i =3D 0; i &lt;=3D m-&g=
t;max_peerid; i++)</span><br><span>     {</span><br><span>         struct m=
ulti_instance *mi =3D m-&gt;instances[i];</span><br><span>         if (mi &=
amp;&amp; !mi-&gt;halt &amp;&amp; proto_is_dgram(mi-&gt;context.c2.link_soc=
kets[0]-&gt;info.proto))</span><br><span>@@ -3876,7 +3883,7 @@</span><br><s=
pan>     struct multi_context *m =3D (struct multi_context *)arg;</span><br=
><span>     int count =3D 0;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; m-&gt;max_clients; i+=
+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (uint32_t=
 i =3D 0; i &lt;=3D m-&gt;max_peerid; i++)</span><br><span>     {</span><br=
><span>         struct multi_instance *mi =3D m-&gt;instances[i];</span><br=
><span>         if (mi &amp;&amp; !mi-&gt;halt)</span><br><span>@@ -3907,7 =
+3914,7 @@</span><br><span>     maddr.proto =3D proto;</span><br><span>    =
 if (mroute_extract_openvpn_sockaddr(&amp;maddr, &amp;saddr, true))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  for (int i =3D 0; i &lt; m-&gt;max_clients; i++)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        for (uint32_t i =3D 0; i &lt;=3D m-&=
gt;max_peerid; i++)</span><br><span>         {</span><br><span>            =
 struct multi_instance *mi =3D m-&gt;instances[i];</span><br><span>        =
     if (mi &amp;&amp; !mi-&gt;halt &amp;&amp; mroute_addr_equal(&amp;maddr=
, &amp;mi-&gt;real))</span><br><span>@@ -4100,8 +4107,14 @@</span><br><span=
>     }</span><br><span> </span><br><span>     /* should not really end up =
here, since multi_create_instance returns null</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     * if amount of clients exceeds max_clients */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * if amount of=
 clients exceeds max_clients and this method would then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * also not have been called */</sp=
an><br><span>     ASSERT(mi-&gt;context.c2.tls_multi-&gt;peer_id &lt; m-&gt=
;max_clients);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context.c=
2.tls_multi-&gt;peer_id &gt; m-&gt;max_peerid)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        m-&gt;max_peerid =3D mi-&gt;context.c2.tls_multi-&gt;p=
eer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span> }</span><br><span> </span><br><span> #if defined(__GNUC__) || de=
fined(__clang__)</span><br><span>diff --git a/src/openvpn/multi.h b/src/ope=
nvpn/multi.h</span><br><span>index 3f4eefe..935bda1 100644</span><br><span>=
--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><=
br><span>@@ -160,9 +160,12 @@</span><br><span>  */</span><br><span> struct =
multi_context</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct multi_instance **instances; /**&lt; Array of multi_in=
stances. An instance can be</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct multi_instance **instances; /**&lt; Array of multi_insta=
nces with the size of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                        *  max_clients.  An instance can =
be</span><br><span>                                         * accessed usin=
g peer-id as an index. */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t ma=
x_peerid;               /**&lt; highest currently allocated peer-id</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
             * and maximum allocated/valid index in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                        *=
 instances */</span><br><span>     struct hash *hash;                 /**&l=
t; VPN tunnel instances indexed by real</span><br><span>                   =
                      *   address of the remote peer. */</span><br><span>  =
   struct hash *vhash;                /**&lt; VPN tunnel instances indexed =
by</span><br><span>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_=
util.c</span><br><span>index fe48091..f57f54d 100644</span><br><span>--- a/=
src/openvpn/push_util.c</span><br><span>+++ b/src/openvpn/push_util.c</span=
><br><span>@@ -317,7 +317,7 @@</span><br><span> </span><br><span>     int c=
ount =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    for (int i =3D 0; i &lt; m-&gt;max_clients; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (uint32_t i =3D 0; i &lt;=
=3D m-&gt;max_peerid; i++)</span><br><span>     {</span><br><span>         =
struct multi_instance *curr_mi =3D m-&gt;instances[i];</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1557?usp=3Demail">change 1557</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1557?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If797f3fe178fba3f43fb12898e5=
484bfb38f05c3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1557 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--lxzPNz4Y4ZA=--

