From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 17:48:37 +0000
In-Reply-To: <gerrit.1772719451000.Ibf8865e451866e1fffc8dbc8ad5ecf6bc5577ce4@...2715...>
References: <gerrit.1772719451000.Ibf8865e451866e1fffc8dbc8ad5ecf6bc5577ce4@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d455dc3c806c2189d9e656a1ee5f6e77a49d3afa-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XBxdHfUdsxM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove
 multi_context->iter
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

--XBxdHfUdsxM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1556?usp=3Demail

to look at the new patch set (#3).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: Remove multi_context->iter
......................................................................

Remove multi_context->iter

The multi_context->iter is basically a hash with only one bucket. This makes
m->iter a linear list. Instead of maintaining this extra list use
m->instances instead. This is a fixed sized continuous array, so iterating
over it should be very quick. When the number of connected clients
approaches max_clients, iterating over a static array should be faster than
a linked list, especially when considering cache locality.

Of the several places where m->iter is used only one is potentially on a
critical path: the usage of m->iter in multi_bcast.

However this performance difference would be only visible with a lightly
loaded server with very few clients. And even in this scenario I could
not manage to measure a difference.

Change-Id: Ibf8865e451866e1fffc8dbc8ad5ecf6bc5577ce4
---
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/push_util.c
3 files changed, 25 insertions(+), 83 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/1556/3

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 1625fd0..9d4ea49 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -300,14 +300,6 @@
     m->vhash =3D hash_init(t->options.virtual_hash_size, (uint32_t)get_ran=
dom(),
                          mroute_addr_hash_function, mroute_addr_compare_fu=
nction);

-    /*
-     * This hash table is a clone of m->hash but with a
-     * bucket size of one so that it can be used
-     * for fast iteration through the list.
-     */
-    m->iter =3D hash_init(1, (uint32_t)get_random(), mroute_addr_hash_func=
tion,
-                        mroute_addr_compare_function);
-
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash =3D hash_init(t->options.real_hash_size, 0, cid_hash_funct=
ion, cid_compare_function);
 #endif
@@ -591,10 +583,6 @@
         {
             ASSERT(hash_remove(m->hash, &mi->real));
         }
-        if (mi->did_iter)
-        {
-            ASSERT(hash_remove(m->iter, &mi->real));
-        }
 #ifdef ENABLE_MANAGEMENT
         if (mi->did_cid_hash)
         {
@@ -664,23 +652,19 @@
 {
     if (m->hash)
     {
-        struct hash_iterator hi;
-        struct hash_element *he;
-
-        hash_iterator_init(m->iter, &hi);
-        while ((he =3D hash_iterator_next(&hi)))
+        for (int i =3D 0; i < m->max_clients; i++)
         {
-            struct multi_instance *mi =3D (struct multi_instance *)he->val=
ue;
-            mi->did_iter =3D false;
-            multi_close_instance(m, mi, true);
+            struct multi_instance *mi =3D m->instances[i];
+            if (mi)
+            {
+                multi_close_instance(m, mi, true);
+            }
         }
-        hash_iterator_free(&hi);

         multi_reap_all(m);

         hash_free(m->hash);
         hash_free(m->vhash);
-        hash_free(m->iter);
 #ifdef ENABLE_MANAGEMENT
         hash_free(m->cid_hash);
 #endif
@@ -760,14 +744,6 @@
         generate_prefix(mi);
     }

-    if (!hash_add(m->iter, &mi->real, mi, false))
-    {
-        msg(D_MULTI_LOW, "MULTI: unable to add real address [%s] to iterat=
or hash table",
-            mroute_addr_print(&mi->real, &gc));
-        goto err;
-    }
-    mi->did_iter =3D true;
-
 #ifdef ENABLE_MANAGEMENT
     do
     {
@@ -1348,27 +1324,21 @@
         const char *new_cn =3D tls_common_name(new_mi->context.c2.tls_mult=
i, true);
         if (new_cn)
         {
-            struct hash_iterator hi;
-            struct hash_element *he;
             int count =3D 0;

-            hash_iterator_init(m->iter, &hi);
-            while ((he =3D hash_iterator_next(&hi)))
+            for (int i =3D 0; i < m->max_clients; i++)
             {
-                struct multi_instance *mi =3D (struct multi_instance *)he-=
>value;
-                if (mi !=3D new_mi && !mi->halt)
+                struct multi_instance *mi =3D m->instances[i];
+                if (mi && mi !=3D new_mi && !mi->halt)
                 {
                     const char *cn =3D tls_common_name(mi->context.c2.tls_=
multi, true);
                     if (cn && !strcmp(cn, new_cn))
                     {
-                        mi->did_iter =3D false;
                         multi_close_instance(m, mi, false);
-                        hash_iterator_delete_element(&hi);
                         ++count;
                     }
                 }
             }
-            hash_iterator_free(&hi);

             if (count)
             {
@@ -2906,9 +2876,6 @@
 multi_bcast(struct multi_context *m, const struct buffer *buf,
             const struct multi_instance *sender_instance, uint16_t vid)
 {
-    struct hash_iterator hi;
-    struct hash_element *he;
-    struct multi_instance *mi;
     struct mbuf_buffer *mb;

     if (BLEN(buf) > 0)
@@ -2917,12 +2884,12 @@
         printf("BCAST len=3D%d\n", BLEN(buf));
 #endif
         mb =3D mbuf_alloc_buf(buf);
-        hash_iterator_init(m->iter, &hi);

-        while ((he =3D hash_iterator_next(&hi)))
+        for (int i =3D 0; i < m->max_clients; i++)
         {
-            mi =3D (struct multi_instance *)he->value;
-            if (mi !=3D sender_instance && !mi->halt)
+            struct multi_instance *mi =3D m->instances[i];
+
+            if (mi && mi !=3D sender_instance && !mi->halt)
             {
                 if (vid !=3D 0 && vid !=3D mi->context.options.vlan_pvid)
                 {
@@ -2931,8 +2898,6 @@
                 multi_add_mbuf(m, mi, mb);
             }
         }
-
-        hash_iterator_free(&hi);
         mbuf_free_buf(mb);
     }
 }
@@ -3182,7 +3147,6 @@

     /* remove old address from hash table before changing address */
     ASSERT(hash_remove(m->hash, &mi->real));
-    ASSERT(hash_remove(m->iter, &mi->real));

     /* change external network address of the remote peer */
     mi->real =3D real;
@@ -3198,7 +3162,6 @@
     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);

     ASSERT(hash_add(m->hash, &mi->real, mi, false));
-    ASSERT(hash_add(m->iter, &mi->real, mi, false));

 #ifdef ENABLE_MANAGEMENT
     ASSERT(hash_add(m->cid_hash, &mi->context.c2.mda_context.cid, mi, true=
));
@@ -3830,22 +3793,17 @@
 static void
 multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
 {
-    struct hash_iterator hi;
-    struct hash_element *he;
-
     /* tell all clients to restart */
-    hash_iterator_init(m->iter, &hi);
-    while ((he =3D hash_iterator_next(&hi)))
+    for (int i =3D 0; i < m->max_clients; i++)
     {
-        struct multi_instance *mi =3D (struct multi_instance *)he->value;
-        if (!mi->halt && proto_is_dgram(mi->context.c2.link_sockets[0]->in=
fo.proto))
+        struct multi_instance *mi =3D m->instances[i];
+        if (mi && !mi->halt && proto_is_dgram(mi->context.c2.link_sockets[=
0]->info.proto))
         {
             send_control_channel_string(&mi->context, next_server ? "RESTA=
RT,[N]" : "RESTART",
                                         D_PUSH);
             multi_schedule_context_wakeup(m, mi);
         }
     }
-    hash_iterator_free(&hi);

     /* reschedule signal */
     ASSERT(!openvpn_gettimeofday(&m->deferred_shutdown_signal.wakeup, NULL=
));
@@ -3916,15 +3874,12 @@
 management_callback_kill_by_cn(void *arg, const char *del_cn)
 {
     struct multi_context *m =3D (struct multi_context *)arg;
-    struct hash_iterator hi;
-    struct hash_element *he;
     int count =3D 0;

-    hash_iterator_init(m->iter, &hi);
-    while ((he =3D hash_iterator_next(&hi)))
+    for (int i =3D 0; i < m->max_clients; i++)
     {
-        struct multi_instance *mi =3D (struct multi_instance *)he->value;
-        if (!mi->halt)
+        struct multi_instance *mi =3D m->instances[i];
+        if (mi && !mi->halt)
         {
             const char *cn =3D tls_common_name(mi->context.c2.tls_multi, f=
alse);
             if (cn && !strcmp(cn, del_cn))
@@ -3934,7 +3889,6 @@
             }
         }
     }
-    hash_iterator_free(&hi);
     return count;
 }

@@ -3942,8 +3896,6 @@
 management_callback_kill_by_addr(void *arg, const in_addr_t addr, const ui=
nt16_t port, const uint8_t proto)
 {
     struct multi_context *m =3D (struct multi_context *)arg;
-    struct hash_iterator hi;
-    struct hash_element *he;
     struct openvpn_sockaddr saddr;
     struct mroute_addr maddr;
     int count =3D 0;
@@ -3955,17 +3907,15 @@
     maddr.proto =3D proto;
     if (mroute_extract_openvpn_sockaddr(&maddr, &saddr, true))
     {
-        hash_iterator_init(m->iter, &hi);
-        while ((he =3D hash_iterator_next(&hi)))
+        for (int i =3D 0; i < m->max_clients; i++)
         {
-            struct multi_instance *mi =3D (struct multi_instance *)he->val=
ue;
-            if (!mi->halt && mroute_addr_equal(&maddr, &mi->real))
+            struct multi_instance *mi =3D m->instances[i];
+            if (mi && !mi->halt && mroute_addr_equal(&maddr, &mi->real))
             {
                 multi_signal_instance(m, mi, SIGTERM);
                 ++count;
             }
         }
-        hash_iterator_free(&hi);
     }
     return count;
 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index c686e47..498409d 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -132,7 +132,6 @@
     struct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing=
 */

     bool did_real_hash;
-    bool did_iter;
 #ifdef ENABLE_MANAGEMENT
     bool did_cid_hash;
     struct buffer_list *cc_config;
@@ -168,9 +167,6 @@
                                         *   address of the remote peer. */
     struct hash *vhash;                /**< VPN tunnel instances indexed by
                                         *   virtual address of remote host=
s. */
-    struct hash *iter;                 /**< VPN tunnel instances indexed b=
y real
-                                        *   address of the remote peer, op=
timized
-                                        *   for iteration. */
     struct schedule *schedule;
     struct mbuf_set *mbuf;             /**< Set of buffers for passing data
                                         *   channel packets between VPN tu=
nnel
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 51c7b5f..6456554 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -316,15 +316,12 @@
     }

     int count =3D 0;
-    struct hash_iterator hi;
-    const struct hash_element *he;

-    hash_iterator_init(m->iter, &hi);
-    while ((he =3D hash_iterator_next(&hi)))
+    for (int i =3D 0; i < m->max_clients; i++)
     {
-        struct multi_instance *curr_mi =3D he->value;
+        struct multi_instance *curr_mi =3D m->instances[i];

-        if (curr_mi->halt || !support_push_update(curr_mi))
+        if (!curr_mi || curr_mi->halt || !support_push_update(curr_mi))
         {
             continue;
         }
@@ -338,7 +335,6 @@
         count++;
     }

-    hash_iterator_free(&hi);
     buffer_list_free(msgs);
     gc_free(&gc);
     return count;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1556?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibf8865e451866e1fffc8dbc8ad5ecf6bc5577ce4
Gerrit-Change-Number: 1556
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--XBxdHfUdsxM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1556?usp=3Demail">View Chan=
ge</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule i=
s unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">Remove multi_context-&gt;iter<br><br>Th=
e multi_context-&gt;iter is basically a hash with only one bucket. This mak=
es<br>m-&gt;iter a linear list. Instead of maintaining this extra list use<=
br>m-&gt;instances instead. This is a fixed sized continuous array, so iter=
ating<br>over it should be very quick. When the number of connected clients=
<br>approaches max_clients, iterating over a static array should be faster =
than<br>a linked list, especially when considering cache locality.<br><br>O=
f the several places where m-&gt;iter is used only one is potentially on a<=
br>critical path: the usage of m-&gt;iter in multi_bcast.<br><br>However th=
is performance difference would be only visible with a lightly<br>loaded se=
rver with very few clients. And even in this scenario I could<br>not manage=
 to measure a difference.<br><br>Change-Id: Ibf8865e451866e1fffc8dbc8ad5ecf=
6bc5577ce4<br>---<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M sr=
c/openvpn/push_util.c<br>3 files changed, 25 insertions(+), 83 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/56/1556/3</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi.c b/src/open=
vpn/multi.c</span><br><span>index 1625fd0..9d4ea49 100644</span><br><span>-=
-- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><b=
r><span>@@ -300,14 +300,6 @@</span><br><span>     m-&gt;vhash =3D hash_init=
(t-&gt;options.virtual_hash_size, (uint32_t)get_random(),</span><br><span> =
                         mroute_addr_hash_function, mroute_addr_compare_fun=
ction);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * This=
 hash table is a clone of m-&gt;hash but with a</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * bucket size of one so that it can be used<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * for fast iterat=
ion through the list.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;iter=
 =3D hash_init(1, (uint32_t)get_random(), mroute_addr_hash_function,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        mrou=
te_addr_compare_function);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     m-&gt;=
cid_hash =3D hash_init(t-&gt;options.real_hash_size, 0, cid_hash_function, =
cid_compare_function);</span><br><span> #endif</span><br><span>@@ -591,10 +=
583,6 @@</span><br><span>         {</span><br><span>             ASSERT(has=
h_remove(m-&gt;hash, &amp;mi-&gt;real));</span><br><span>         }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;did_iter)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(hash_remove(m-&=
gt;iter, &amp;mi-&gt;real));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>=
         if (mi-&gt;did_cid_hash)</span><br><span>         {</span><br><spa=
n>@@ -664,23 +652,19 @@</span><br><span> {</span><br><span>     if (m-&gt;h=
ash)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        struct hash_iterator hi;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        struct hash_element *he;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        hash_iterator_init(m-&gt;iter, &amp;hi);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        while ((he =3D hash_iterator_next=
(&amp;hi)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
for (int i =3D 0; i &lt; m-&gt;max_clients; i++)</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct mu=
lti_instance *mi =3D (struct multi_instance *)he-&gt;value;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;did_iter =3D false=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_cl=
ose_instance(m, mi, true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            struct multi_instance *mi =3D m-&gt;instances[i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                multi_close_inst=
ance(m, mi, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span>         }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        hash_iterator_free(&amp;hi);</span><br><span> </s=
pan><br><span>         multi_reap_all(m);</span><br><span> </span><br><span=
>         hash_free(m-&gt;hash);</span><br><span>         hash_free(m-&gt;v=
hash);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hash_fr=
ee(m-&gt;iter);</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> =
        hash_free(m-&gt;cid_hash);</span><br><span> #endif</span><br><span>=
@@ -760,14 +744,6 @@</span><br><span>         generate_prefix(mi);</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!hash_add(m-&gt;iter, &amp;mi-&gt;real, mi, false))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_LOW, &quot;MULTI: unab=
le to add real address [%s] to iterator hash table&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            mroute_addr_print(&amp;mi-&=
gt;real, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      goto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;did_iter =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> #ifdef ENABLE_MANAGEMENT</span><br><span>     do</span><br><span>    =
 {</span><br><span>@@ -1348,27 +1324,21 @@</span><br><span>         const c=
har *new_cn =3D tls_common_name(new_mi-&gt;context.c2.tls_multi, true);</sp=
an><br><span>         if (new_cn)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            struct hash_iterator hi;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct ha=
sh_element *he;</span><br><span>             int count =3D 0;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_=
iterator_init(m-&gt;iter, &amp;hi);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            while ((he =3D hash_iterator_next(&amp;hi)))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            for (int i =
=3D 0; i &lt; m-&gt;max_clients; i++)</span><br><span>             {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                struct multi=
_instance *mi =3D (struct multi_instance *)he-&gt;value;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                if (mi !=3D new_mi &amp;=
&amp; !mi-&gt;halt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                struct multi_instance *mi =3D m-&gt;instances[i];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                if (mi &amp;&=
amp; mi !=3D new_mi &amp;&amp; !mi-&gt;halt)</span><br><span>              =
   {</span><br><span>                     const char *cn =3D tls_common_nam=
e(mi-&gt;context.c2.tls_multi, true);</span><br><span>                     =
if (cn &amp;&amp; !strcmp(cn, new_cn))</span><br><span>                    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     mi-&gt;did_iter =3D false;</span><br><span>                         mu=
lti_close_instance(m, mi, false);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        hash_iterator_delete_element(&amp;hi);<=
/span><br><span>                         ++count;</span><br><span>         =
            }</span><br><span>                 }</span><br><span>          =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_=
iterator_free(&amp;hi);</span><br><span> </span><br><span>             if (=
count)</span><br><span>             {</span><br><span>@@ -2906,9 +2876,6 @@=
</span><br><span> multi_bcast(struct multi_context *m, const struct buffer =
*buf,</span><br><span>             const struct multi_instance *sender_inst=
ance, uint16_t vid)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct hash_iterator hi;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct hash_element *he;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *mi;</span><br><s=
pan>     struct mbuf_buffer *mb;</span><br><span> </span><br><span>     if =
(BLEN(buf) &gt; 0)</span><br><span>@@ -2917,12 +2884,12 @@</span><br><span>=
         printf(&quot;BCAST len=3D%d\n&quot;, BLEN(buf));</span><br><span> =
#endif</span><br><span>         mb =3D mbuf_alloc_buf(buf);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        hash_iterator_init(m-&gt;iter=
, &amp;hi);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        while ((he =3D hash_iterator_next(&amp;hi)))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; m=
-&gt;max_clients; i++)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            mi =3D (struct multi_instance *)he-=
&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (mi !=3D sender_instance &amp;&amp; !mi-&gt;halt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            struct multi_instance *mi =3D=
 m-&gt;instances[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi=
 &amp;&amp; mi !=3D sender_instance &amp;&amp; !mi-&gt;halt)</span><br><spa=
n>             {</span><br><span>                 if (vid !=3D 0 &amp;&amp;=
 vid !=3D mi-&gt;context.options.vlan_pvid)</span><br><span>               =
  {</span><br><span>@@ -2931,8 +2898,6 @@</span><br><span>                 =
multi_add_mbuf(m, mi, mb);</span><br><span>             }</span><br><span> =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        hash_iterator_free(&amp;h=
i);</span><br><span>         mbuf_free_buf(mb);</span><br><span>     }</spa=
n><br><span> }</span><br><span>@@ -3182,7 +3147,6 @@</span><br><span> </spa=
n><br><span>     /* remove old address from hash table before changing addr=
ess */</span><br><span>     ASSERT(hash_remove(m-&gt;hash, &amp;mi-&gt;real=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(hash_re=
move(m-&gt;iter, &amp;mi-&gt;real));</span><br><span> </span><br><span>    =
 /* change external network address of the remote peer */</span><br><span> =
    mi-&gt;real =3D real;</span><br><span>@@ -3198,7 +3162,6 @@</span><br><=
span>     tls_update_remote_addr(mi-&gt;context.c2.tls_multi, &amp;mi-&gt;c=
ontext.c2.from);</span><br><span> </span><br><span>     ASSERT(hash_add(m-&=
gt;hash, &amp;mi-&gt;real, mi, false));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ASSERT(hash_add(m-&gt;iter, &amp;mi-&gt;real, mi, fal=
se));</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br=
><span>     ASSERT(hash_add(m-&gt;cid_hash, &amp;mi-&gt;context.c2.mda_cont=
ext.cid, mi, true));</span><br><span>@@ -3830,22 +3793,17 @@</span><br><spa=
n> static void</span><br><span> multi_push_restart_schedule_exit(struct mul=
ti_context *m, bool next_server)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct hash_iterator hi;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct hash_element *he;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* tell=
 all clients to restart */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    hash_iterator_init(m-&gt;iter, &amp;hi);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    while ((he =3D hash_iterator_next(&amp;hi))=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 0; i &lt; m-&gt;max_clients; i++)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        struct multi_instance *mi =3D (=
struct multi_instance *)he-&gt;value;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (!mi-&gt;halt &amp;&amp; proto_is_dgram(mi-&gt;c=
ontext.c2.link_sockets[0]-&gt;info.proto))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        struct multi_instance *mi =3D m-&gt;instance=
s[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (mi=
 &amp;&amp; !mi-&gt;halt &amp;&amp; proto_is_dgram(mi-&gt;context.c2.link_s=
ockets[0]-&gt;info.proto))</span><br><span>         {</span><br><span>     =
        send_control_channel_string(&amp;mi-&gt;context, next_server ? &quo=
t;RESTART,[N]&quot; : &quot;RESTART&quot;,</span><br><span>                =
                         D_PUSH);</span><br><span>             multi_schedu=
le_context_wakeup(m, mi);</span><br><span>         }</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hash_iterator_fre=
e(&amp;hi);</span><br><span> </span><br><span>     /* reschedule signal */<=
/span><br><span>     ASSERT(!openvpn_gettimeofday(&amp;m-&gt;deferred_shutd=
own_signal.wakeup, NULL));</span><br><span>@@ -3916,15 +3874,12 @@</span><b=
r><span> management_callback_kill_by_cn(void *arg, const char *del_cn)</spa=
n><br><span> {</span><br><span>     struct multi_context *m =3D (struct mul=
ti_context *)arg;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct hash_iterator hi;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct hash_element *he;</span><br><span>     int count =3D 0;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hash_=
iterator_init(m-&gt;iter, &amp;hi);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    while ((he =3D hash_iterator_next(&amp;hi)))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; m-&=
gt;max_clients; i++)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        struct multi_instance *mi =3D (struct multi_i=
nstance *)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (!mi-&gt;halt)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct multi_instance *mi =3D m-&gt;instances[i];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (mi &amp;&amp; !mi=
-&gt;halt)</span><br><span>         {</span><br><span>             const ch=
ar *cn =3D tls_common_name(mi-&gt;context.c2.tls_multi, false);</span><br><=
span>             if (cn &amp;&amp; !strcmp(cn, del_cn))</span><br><span>@@=
 -3934,7 +3889,6 @@</span><br><span>             }</span><br><span>        =
 }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    hash_iterator_free(&amp;hi);</span><br><span>     return count;</sp=
an><br><span> }</span><br><span> </span><br><span>@@ -3942,8 +3896,6 @@</sp=
an><br><span> management_callback_kill_by_addr(void *arg, const in_addr_t a=
ddr, const uint16_t port, const uint8_t proto)</span><br><span> {</span><br=
><span>     struct multi_context *m =3D (struct multi_context *)arg;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash_iterator hi;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash_eleme=
nt *he;</span><br><span>     struct openvpn_sockaddr saddr;</span><br><span=
>     struct mroute_addr maddr;</span><br><span>     int count =3D 0;</span=
><br><span>@@ -3955,17 +3907,15 @@</span><br><span>     maddr.proto =3D pro=
to;</span><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;maddr, &a=
mp;saddr, true))</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        hash_iterator_init(m-&gt;iter, &amp;hi);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        while ((he =3D hash_it=
erator_next(&amp;hi)))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        for (int i =3D 0; i &lt; m-&gt;max_clients; i++)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  struct multi_instance *mi =3D (struct multi_instance *)he-&gt;value;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!mi-&gt;ha=
lt &amp;&amp; mroute_addr_equal(&amp;maddr, &amp;mi-&gt;real))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            struct multi_instanc=
e *mi =3D m-&gt;instances[i];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (mi &amp;&amp; !mi-&gt;halt &amp;&amp; mroute_addr=
_equal(&amp;maddr, &amp;mi-&gt;real))</span><br><span>             {</span>=
<br><span>                 multi_signal_instance(m, mi, SIGTERM);</span><br=
><span>                 ++count;</span><br><span>             }</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  hash_iterator_free(&amp;hi);</span><br><span>     }</span><br><span>     =
return count;</span><br><span> }</span><br><span>diff --git a/src/openvpn/m=
ulti.h b/src/openvpn/multi.h</span><br><span>index c686e47..498409d 100644<=
/span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn=
/multi.h</span><br><span>@@ -132,7 +132,6 @@</span><br><span>     struct in=
6_addr reporting_addr_ipv6; /* IPv6 address in status listing */</span><br>=
<span> </span><br><span>     bool did_real_hash;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bool did_iter;</span><br><span> #ifdef ENABL=
E_MANAGEMENT</span><br><span>     bool did_cid_hash;</span><br><span>     s=
truct buffer_list *cc_config;</span><br><span>@@ -168,9 +167,6 @@</span><br=
><span>                                         *   address of the remote p=
eer. */</span><br><span>     struct hash *vhash;                /**&lt; VPN=
 tunnel instances indexed by</span><br><span>                              =
           *   virtual address of remote hosts. */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct hash *iter;                 /**&lt;=
 VPN tunnel instances indexed by real</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                        *   address of the =
remote peer, optimized</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                        *   for iteration. */</span><br><s=
pan>     struct schedule *schedule;</span><br><span>     struct mbuf_set *m=
buf;             /**&lt; Set of buffers for passing data</span><br><span>  =
                                       *   channel packets between VPN tunn=
el</span><br><span>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_=
util.c</span><br><span>index 51c7b5f..6456554 100644</span><br><span>--- a/=
src/openvpn/push_util.c</span><br><span>+++ b/src/openvpn/push_util.c</span=
><br><span>@@ -316,15 +316,12 @@</span><br><span>     }</span><br><span> </=
span><br><span>     int count =3D 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct hash_iterator hi;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const struct hash_element *he;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hash_iterator_init=
(m-&gt;iter, &amp;hi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; m-&gt;max_client=
s; i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        struct multi_instance *curr_mi =3D he-&gt;value;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        struct multi_instance=
 *curr_mi =3D m-&gt;instances[i];</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (curr_mi-&gt;halt || !support_pu=
sh_update(curr_mi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!curr_mi || curr_mi-&gt;halt || !support_push_update(curr_mi))<=
/span><br><span>         {</span><br><span>             continue;</span><br=
><span>         }</span><br><span>@@ -338,7 +335,6 @@</span><br><span>     =
    count++;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    hash_iterator_free(&amp;hi);</span><br>=
<span>     buffer_list_free(msgs);</span><br><span>     gc_free(&amp;gc);</=
span><br><span>     return count;</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1556?usp=3Demail=
">change 1556</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1556?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibf8865e451866e1fffc8dbc8ad5=
ecf6bc5577ce4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1556 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--XBxdHfUdsxM=--

