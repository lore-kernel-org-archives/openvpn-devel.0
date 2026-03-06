From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 13:37:46 +0000
In-Reply-To: <gerrit.1772721382000.If797f3fe178fba3f43fb12898e5484bfb38f05c3@...2715...>
References: <gerrit.1772721382000.If797f3fe178fba3f43fb12898e5484bfb38f05c3@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <9ce000579d4707c1942bfa16d3874ce81326ca3c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7FCdtBOr6hM="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7FCdtBOr6hM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1557?usp=3Demail

to look at the new patch set (#3).


Change subject: Optimise iterating over all clients by remembering highest =
peer id
......................................................................

Optimise iterating over all clients by remembering highest peer id

This keeps track of the highest peer id that is currently allocated to avoid
iterating over the empty tail of the m->instances array.

Change-Id: If797f3fe178fba3f43fb12898e5484bfb38f05c3
---
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/push_util.c
3 files changed, 26 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/1557/3

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9d4ea49..c03e821 100644
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
index 498409d..17d850b 100644
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
+    uint32_t max_peerid;               /**< currently highest allocated pe=
erid and
+                                        * maximum allocated/valid index in
+                                        * instances */
     struct hash *hash;                 /**< VPN tunnel instances indexed b=
y real
                                         *   address of the remote peer. */
     struct hash *vhash;                /**< VPN tunnel instances indexed by
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 6456554..529cc39 100644
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--7FCdtBOr6hM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1557?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Optimise iterating over all clients by remembering =
highest peer id<br><br>This keeps track of the highest peer id that is curr=
ently allocated to avoid<br>iterating over the empty tail of the m-&gt;inst=
ances array.<br><br>Change-Id: If797f3fe178fba3f43fb12898e5484bfb38f05c3<br=
>---<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/pus=
h_util.c<br>3 files changed, 26 insertions(+), 10 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/57/1557/3</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</=
span><br><span>index 9d4ea49..c03e821 100644</span><br><span>--- a/src/open=
vpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -6=
01,6 +601,13 @@</span><br><span>         if (mi-&gt;context.c2.tls_multi-&g=
t;peer_id !=3D MAX_PEER_ID)</span><br><span>         {</span><br><span>    =
         m-&gt;instances[mi-&gt;context.c2.tls_multi-&gt;peer_id] =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* Adjust the max_peerid a=
s this might have been the highest</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+             * peer id instance */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            while (m-&gt;max_peerid &gt; 0 &a=
mp;&amp; m-&gt;instances[m-&gt;max_peerid] =3D=3D NULL)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                m-&gt;max_peerid--;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
>         }</span><br><span> </span><br><span>         schedule_remove_entr=
y(m-&gt;schedule, (struct schedule_entry *)mi);</span><br><span>@@ -652,7 +=
659,7 @@</span><br><span> {</span><br><span>     if (m-&gt;hash)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        f=
or (int i =3D 0; i &lt; m-&gt;max_clients; i++)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        for (uint32_t i =3D 0; i &lt;=3D m-&gt;=
max_peerid; i++)</span><br><span>         {</span><br><span>             st=
ruct multi_instance *mi =3D m-&gt;instances[i];</span><br><span>           =
  if (mi)</span><br><span>@@ -1326,7 +1333,7 @@</span><br><span>         {<=
/span><br><span>             int count =3D 0;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            for (int i =3D 0; i &=
lt; m-&gt;max_clients; i++)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            for (uint32_t i =3D 0; i &lt;=3D m-&gt;max_peerid; i++)=
</span><br><span>             {</span><br><span>                 struct mul=
ti_instance *mi =3D m-&gt;instances[i];</span><br><span>                 if=
 (mi &amp;&amp; mi !=3D new_mi &amp;&amp; !mi-&gt;halt)</span><br><span>@@ =
-2885,7 +2892,7 @@</span><br><span> #endif</span><br><span>         mb =3D =
mbuf_alloc_buf(buf);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        for (int i =3D 0; i &lt; m-&gt;max_clients; i++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (uint32_t=
 i =3D 0; i &lt;=3D m-&gt;max_peerid; i++)</span><br><span>         {</span=
><br><span>             struct multi_instance *mi =3D m-&gt;instances[i];</=
span><br><span> </span><br><span>@@ -3794,7 +3801,7 @@</span><br><span> mul=
ti_push_restart_schedule_exit(struct multi_context *m, bool next_server)</s=
pan><br><span> {</span><br><span>     /* tell all clients to restart */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &=
lt; m-&gt;max_clients; i++)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (uint32_t i =3D 0; i &lt;=3D m-&gt;max_peerid; i++)</span><=
br><span>     {</span><br><span>         struct multi_instance *mi =3D m-&g=
t;instances[i];</span><br><span>         if (mi &amp;&amp; !mi-&gt;halt &am=
p;&amp; proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto))</=
span><br><span>@@ -3876,7 +3883,7 @@</span><br><span>     struct multi_cont=
ext *m =3D (struct multi_context *)arg;</span><br><span>     int count =3D =
0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   for (int i =3D 0; i &lt; m-&gt;max_clients; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (uint32_t i =3D 0; i &lt;=3D m-&g=
t;max_peerid; i++)</span><br><span>     {</span><br><span>         struct m=
ulti_instance *mi =3D m-&gt;instances[i];</span><br><span>         if (mi &=
amp;&amp; !mi-&gt;halt)</span><br><span>@@ -3907,7 +3914,7 @@</span><br><sp=
an>     maddr.proto =3D proto;</span><br><span>     if (mroute_extract_open=
vpn_sockaddr(&amp;maddr, &amp;saddr, true))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 0; i &l=
t; m-&gt;max_clients; i++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        for (uint32_t i =3D 0; i &lt;=3D m-&gt;max_peerid; i++)</spa=
n><br><span>         {</span><br><span>             struct multi_instance *=
mi =3D m-&gt;instances[i];</span><br><span>             if (mi &amp;&amp; !=
mi-&gt;halt &amp;&amp; mroute_addr_equal(&amp;maddr, &amp;mi-&gt;real))</sp=
an><br><span>@@ -4100,8 +4107,14 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     /* should not really end up here, since multi_create=
_instance returns null</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * if amount of clients exceeds max_clients */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * if amount of clients exceeds max_c=
lients and this method would then</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * also not have been called */</span><br><span>     ASSE=
RT(mi-&gt;context.c2.tls_multi-&gt;peer_id &lt; m-&gt;max_clients);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (mi-&gt;context.c2.tls_multi-&gt;peer_i=
d &gt; m-&gt;max_peerid)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
-&gt;max_peerid =3D mi-&gt;context.c2.tls_multi-&gt;peer_id;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br=
><span> </span><br><span> #if defined(__GNUC__) || defined(__clang__)</span=
><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br=
><span>index 498409d..17d850b 100644</span><br><span>--- a/src/openvpn/mult=
i.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -160,9 +16=
0,12 @@</span><br><span>  */</span><br><span> struct multi_context</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
multi_instance **instances; /**&lt; Array of multi_instances. An instance c=
an be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mul=
ti_instance **instances; /**&lt; Array of multi_instances with the size of<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                    *  max_clients.  An instance can be</span><br><span>   =
                                      * accessed using peer-id as an index.=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint32_t max_peerid;             =
  /**&lt; currently highest allocated peerid and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                        * maxi=
mum allocated/valid index in</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                        * instances */</span><br><=
span>     struct hash *hash;                 /**&lt; VPN tunnel instances i=
ndexed by real</span><br><span>                                         *  =
 address of the remote peer. */</span><br><span>     struct hash *vhash;   =
             /**&lt; VPN tunnel instances indexed by</span><br><span>diff -=
-git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><span>in=
dex 6456554..529cc39 100644</span><br><span>--- a/src/openvpn/push_util.c</=
span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -317,7 +317=
,7 @@</span><br><span> </span><br><span>     int count =3D 0;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =
=3D 0; i &lt; m-&gt;max_clients; i++)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (uint32_t i =3D 0; i &lt;=3D m-&gt;max_peerid; i+=
+)</span><br><span>     {</span><br><span>         struct multi_instance *c=
urr_mi =3D m-&gt;instances[i];</span><br><span> </span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
557?usp=3Demail">change 1557</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1557=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If797f3fe178fba3f43fb12898e5=
484bfb38f05c3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1557 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--7FCdtBOr6hM=--

