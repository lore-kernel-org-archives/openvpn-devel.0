From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 24 Jan 2025 11:45:53 +0000
References: <gerrit.1737719138000.Iff12c4dbac84a814612aa8b5b89224be08bb9058@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <05611c9b453f796e7b71feb86f8a69684c474d2e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Buxk1aHduuk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename occurences of
 'struct link_socket' from 'ls' to 'sock'
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

--Buxk1aHduuk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/874?usp=3Demail

to review the following change.


Change subject: Rename occurences of 'struct link_socket' from 'ls' to 'soc=
k'
......................................................................

Rename occurences of 'struct link_socket' from 'ls' to 'sock'

This commit renames all instances of 'struct link_socket'
from the abbreviation 'ls' to the more descriptive 'sock'
making it clearer that the variables represent
socket-related structures.

No functional changes have been introduced.

Change-Id: Iff12c4dbac84a814612aa8b5b89224be08bb9058
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/mudp.c
M src/openvpn/mudp.h
M src/openvpn/multi.c
M src/openvpn/multi.h
8 files changed, 35 insertions(+), 35 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/874/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d84f826..2ae3726 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4935,12 +4935,12 @@
 void
 inherit_context_child(struct context *dest,
                       const struct context *src,
-                      struct link_socket *ls)
+                      struct link_socket *sock)
 {
     CLEAR(*dest);

     /* proto_is_dgram will ASSERT(0) if proto is invalid */
-    dest->mode =3D proto_is_dgram(ls->info.proto) ? CM_CHILD_UDP : CM_CHIL=
D_TCP;
+    dest->mode =3D proto_is_dgram(sock->info.proto) ? CM_CHILD_UDP : CM_CH=
ILD_TCP;

     dest->gc =3D gc_new();

@@ -4966,7 +4966,7 @@

     /* options */
     dest->options =3D src->options;
-    dest->options.ce.proto =3D ls->info.proto;
+    dest->options.ce.proto =3D sock->info.proto;
     options_detach(&dest->options);

     dest->c2.event_set =3D src->c2.event_set;
@@ -4977,7 +4977,7 @@
          * The CM_TOP context does the socket listen(),
          * and the CM_CHILD_TCP context does the accept().
          */
-        dest->c2.accept_from =3D ls;
+        dest->c2.accept_from =3D sock;
     }

 #ifdef ENABLE_PLUGIN
@@ -5004,11 +5004,11 @@
         ALLOC_ARRAY_GC(dest->c2.link_sockets, struct link_socket *, 1, &de=
st->gc);

         /* inherit parent link_socket and tuntap */
-        dest->c2.link_sockets[0] =3D ls;
+        dest->c2.link_sockets[0] =3D sock;

         ALLOC_ARRAY_GC(dest->c2.link_socket_infos, struct link_socket_info=
 *, 1, &dest->gc);
         ALLOC_OBJ_GC(dest->c2.link_socket_infos[0], struct link_socket_inf=
o, &dest->gc);
-        *dest->c2.link_socket_infos[0] =3D ls->info;
+        *dest->c2.link_socket_infos[0] =3D sock->info;

         /* locally override some link_socket_info fields */
         dest->c2.link_socket_infos[0]->lsa =3D &dest->c1.link_socket_addrs=
[0];
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 11c32ac..50b38e3 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -96,7 +96,7 @@

 void inherit_context_child(struct context *dest,
                            const struct context *src,
-                           struct link_socket *ls);
+                           struct link_socket *sock);

 void inherit_context_top(struct context *dest,
                          const struct context *src);
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 582e9b3..38dd9f0 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -47,16 +47,16 @@
 };

 struct multi_instance *
-multi_create_instance_tcp(struct multi_context *m, struct link_socket *ls)
+multi_create_instance_tcp(struct multi_context *m, struct link_socket *soc=
k)
 {
     struct gc_arena gc =3D gc_new();
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;

-    mi =3D multi_create_instance(m, NULL, ls);
-    if (mi && !proto_is_dgram(ls->info.proto))
+    mi =3D multi_create_instance(m, NULL, sock);
+    if (mi && !proto_is_dgram(sock->info.proto))
     {
-        mi->real.proto =3D ls->info.proto;
+        mi->real.proto =3D sock->info.proto;
         struct hash_element *he;
         const uint32_t hv =3D hash_value(hash, &mi->real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
@@ -139,10 +139,10 @@
 void
 multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_ins=
tance *mi)
 {
-    struct link_socket *ls =3D mi->context.c2.link_sockets[0];
-    if (ls && mi->socket_set_called)
+    struct link_socket *sock =3D mi->context.c2.link_sockets[0];
+    if (sock && mi->socket_set_called)
     {
-        event_del(multi_io->es, socket_event_handle(ls));
+        event_del(multi_io->es, socket_event_handle(sock));
         mi->socket_set_called =3D false;
     }
     multi_io->n_esr =3D 0;
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 0a5b045..a0ef6a4 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -46,7 +46,7 @@

 bool multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct=
 multi_instance *mi, const unsigned int mpp_flags);

-struct multi_instance *multi_create_instance_tcp(struct multi_context *m, =
struct link_socket *ls);
+struct multi_instance *multi_create_instance_tcp(struct multi_context *m, =
struct link_socket *sock);

 void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 86e1713..8496400 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -186,14 +186,14 @@

 struct multi_instance *
 multi_get_create_instance_udp(struct multi_context *m, bool *floated,
-                              struct link_socket *ls)
+                              struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
     struct mroute_addr real =3D {0};
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;
-    real.proto =3D ls->info.proto;
-    m->hmac_reply_ls =3D ls;
+    real.proto =3D sock->info.proto;
+    m->hmac_reply_ls =3D sock;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
@@ -259,7 +259,7 @@
                      * connect-freq but not against connect-freq-initial */
                     reflect_filter_rate_limit_decrease(m->initial_rate_lim=
iter);

-                    mi =3D multi_create_instance(m, &real, ls);
+                    mi =3D multi_create_instance(m, &real, sock);
                     if (mi)
                     {
                         hash_add_fast(hash, bucket, &mi->real, hv, mi);
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 357b684..37752e1 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -33,7 +33,7 @@

 unsigned int p2mp_iow_flags(const struct multi_context *m);

-void multi_process_io_udp(struct multi_context *m, struct link_socket *ls);
+void multi_process_io_udp(struct multi_context *m, struct link_socket *soc=
k);
 /*************************************************************************=
*/
 /**
  * Get, and if necessary create, the multi_instance associated with a
@@ -47,13 +47,13 @@
  * successful, returns the newly created instance.
  *
  * @param m           - The single multi_context structure.
- * @param ls          - Listening socket where this instance is connecting=
 to
+ * @param sock        - Listening socket where this instance is connecting=
 to
  *
  * @return A pointer to a multi_instance if one already existed for the
  *     packet's source address or if one was a newly created successfully.
  *      NULL if one did not yet exist and a new one was not created.
  */
 struct multi_instance *multi_get_create_instance_udp(struct multi_context =
*m, bool *floated,
-                                                     struct link_socket *l=
s);
+                                                     struct link_socket *s=
ock);

 #endif /* ifndef MUDP_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 809fde5..ee8a599 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -751,7 +751,7 @@
  */
 struct multi_instance *
 multi_create_instance(struct multi_context *m, const struct mroute_addr *r=
eal,
-                      struct link_socket *ls)
+                      struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
     struct multi_instance *mi;
@@ -774,7 +774,7 @@
         generate_prefix(mi);
     }

-    inherit_context_child(&mi->context, &m->top, ls);
+    inherit_context_child(&mi->context, &m->top, sock);
     if (IS_SIG(&mi->context))
     {
         goto err;
@@ -794,7 +794,7 @@
         {
             goto err;
         }
-        mi->real.proto =3D ls->info.proto;
+        mi->real.proto =3D sock->info.proto;
         generate_prefix(mi);
     }

@@ -3129,7 +3129,7 @@

 void
 multi_process_float(struct multi_context *m, struct multi_instance *mi,
-                    struct link_socket *ls)
+                    struct link_socket *sock)
 {
     struct mroute_addr real =3D {0};
     struct hash *hash =3D m->hash;
@@ -3185,7 +3185,7 @@
     mi->context.c2.to_link_addr =3D &mi->context.c2.from;

     /* inherit parent link_socket and link_socket_info */
-    mi->context.c2.link_sockets[0] =3D ls;
+    mi->context.c2.link_sockets[0] =3D sock;
     mi->context.c2.link_socket_infos[0]->lsa->actual =3D m->top.c2.from;

     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);
@@ -3335,7 +3335,7 @@
  */
 bool
 multi_process_incoming_link(struct multi_context *m, struct multi_instance=
 *instance,
-                            const unsigned int mpp_flags, struct link_sock=
et *ls)
+                            const unsigned int mpp_flags, struct link_sock=
et *sock)
 {
     struct gc_arena gc =3D gc_new();

@@ -3356,7 +3356,7 @@
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TCP/UDP -> TUN [%d]\n", BLEN(&m->top.c2.buf));
 #endif
-        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, ls=
));
+        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, so=
ck));
     }
     else
     {
@@ -3390,14 +3390,14 @@
             /* decrypt in instance context */

             perf_push(PERF_PROC_IN_LINK);
-            lsi =3D &ls->info;
+            lsi =3D &sock->info;
             orig_buf =3D c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
                 /* nonzero length means that we have a valid, decrypted pa=
cked */
                 if (floated && c->c2.buf.len > 0)
                 {
-                    multi_process_float(m, m->pending, ls);
+                    multi_process_float(m, m->pending, sock);
                 }

                 process_incoming_link_part2(c, lsi, orig_buf);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 092aed6..229f500 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -275,7 +275,7 @@
 void multi_top_free(struct multi_context *m);

 struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real,
-                                             struct link_socket *ls);
+                                             struct link_socket *sock);

 void multi_close_instance(struct multi_context *m, struct multi_instance *=
mi, bool shutdown);

@@ -290,7 +290,7 @@
  * updates hashtables in multi_context.
  */
 void multi_process_float(struct multi_context *m, struct multi_instance *m=
i,
-                         struct link_socket *ls);
+                         struct link_socket *sock);

 #define MPP_PRE_SELECT             (1<<0)
 #define MPP_CONDITIONAL_PRE_SELECT (1<<1)
@@ -355,10 +355,10 @@
  *                       when using TCP transport. Otherwise NULL, as is
  *                       the case when using UDP transport.
  * @param mpp_flags    - Fast I/O optimization flags.
- * @param ls           - Socket where the packet was received.
+ * @param sock         - Socket where the packet was received.
  */
 bool multi_process_incoming_link(struct multi_context *m, struct multi_ins=
tance *instance, const unsigned int mpp_flags,
-                                 struct link_socket *ls);
+                                 struct link_socket *sock);


 /**

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/874?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff12c4dbac84a814612aa8b5b89224be08bb9058
Gerrit-Change-Number: 874
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Buxk1aHduuk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/874?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Rename occurences of &#39;struct link_socket&#39; from &#39;l=
s&#39; to &#39;sock&#39;<br><br>This commit renames all instances of &#39;s=
truct link_socket&#39;<br>from the abbreviation &#39;ls&#39; to the more de=
scriptive &#39;sock&#39;<br>making it clearer that the variables represent<=
br>socket-related structures.<br><br>No functional changes have been introd=
uced.<br><br>Change-Id: Iff12c4dbac84a814612aa8b5b89224be08bb9058<br>Signed=
-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/=
openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/mtcp.c<br>M src/ope=
nvpn/mtcp.h<br>M src/openvpn/mudp.c<br>M src/openvpn/mudp.h<br>M src/openvp=
n/multi.c<br>M src/openvpn/multi.h<br>8 files changed, 35 insertions(+), 35=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/74/874/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/in=
it.c</span><br><span>index d84f826..2ae3726 100644</span><br><span>--- a/sr=
c/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@=
@ -4935,12 +4935,12 @@</span><br><span> void</span><br><span> inherit_conte=
xt_child(struct context *dest,</span><br><span>                       const=
 struct context *src,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                      struct link_socket *ls)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                      struct link_socket *sock)</=
span><br><span> {</span><br><span>     CLEAR(*dest);</span><br><span> </spa=
n><br><span>     /* proto_is_dgram will ASSERT(0) if proto is invalid */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    dest-&gt;mode =3D pr=
oto_is_dgram(ls-&gt;info.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;mode =3D proto_is_d=
gram(sock-&gt;info.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span><br><span> <=
/span><br><span>     dest-&gt;gc =3D gc_new();</span><br><span> </span><br>=
<span>@@ -4966,7 +4966,7 @@</span><br><span> </span><br><span>     /* optio=
ns */</span><br><span>     dest-&gt;options =3D src-&gt;options;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    dest-&gt;options.ce.proto =
=3D ls-&gt;info.proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    dest-&gt;options.ce.proto =3D sock-&gt;info.proto;</span><br><span> =
    options_detach(&amp;dest-&gt;options);</span><br><span> </span><br><spa=
n>     dest-&gt;c2.event_set =3D src-&gt;c2.event_set;</span><br><span>@@ -=
4977,7 +4977,7 @@</span><br><span>          * The CM_TOP context does the s=
ocket listen(),</span><br><span>          * and the CM_CHILD_TCP context do=
es the accept().</span><br><span>          */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        dest-&gt;c2.accept_from =3D ls;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        dest-&gt;c2.accept_from=
 =3D sock;</span><br><span>     }</span><br><span> </span><br><span> #ifdef=
 ENABLE_PLUGIN</span><br><span>@@ -5004,11 +5004,11 @@</span><br><span>    =
     ALLOC_ARRAY_GC(dest-&gt;c2.link_sockets, struct link_socket *, 1, &amp=
;dest-&gt;gc);</span><br><span> </span><br><span>         /* inherit parent=
 link_socket and tuntap */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        dest-&gt;c2.link_sockets[0] =3D ls;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        dest-&gt;c2.link_sockets[0] =3D sock;<=
/span><br><span> </span><br><span>         ALLOC_ARRAY_GC(dest-&gt;c2.link_=
socket_infos, struct link_socket_info *, 1, &amp;dest-&gt;gc);</span><br><s=
pan>         ALLOC_OBJ_GC(dest-&gt;c2.link_socket_infos[0], struct link_soc=
ket_info, &amp;dest-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        *dest-&gt;c2.link_socket_infos[0] =3D ls-&gt;info;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        *dest-&gt;c2.link_soc=
ket_infos[0] =3D sock-&gt;info;</span><br><span> </span><br><span>         =
/* locally override some link_socket_info fields */</span><br><span>       =
  dest-&gt;c2.link_socket_infos[0]-&gt;lsa =3D &amp;dest-&gt;c1.link_socket=
_addrs[0];</span><br><span>diff --git a/src/openvpn/init.h b/src/openvpn/in=
it.h</span><br><span>index 11c32ac..50b38e3 100644</span><br><span>--- a/sr=
c/openvpn/init.h</span><br><span>+++ b/src/openvpn/init.h</span><br><span>@=
@ -96,7 +96,7 @@</span><br><span> </span><br><span> void inherit_context_ch=
ild(struct context *dest,</span><br><span>                            const=
 struct context *src,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                           struct link_socket *ls);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           struct link_so=
cket *sock);</span><br><span> </span><br><span> void inherit_context_top(st=
ruct context *dest,</span><br><span>                          const struct =
context *src);</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvp=
n/mtcp.c</span><br><span>index 582e9b3..38dd9f0 100644</span><br><span>--- =
a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><sp=
an>@@ -47,16 +47,16 @@</span><br><span> };</span><br><span> </span><br><spa=
n> struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-multi_create_instance_tcp(struct multi_context *m, struct link_socket =
*ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_create_in=
stance_tcp(struct multi_context *m, struct link_socket *sock)</span><br><sp=
an> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     struct multi_instance *mi =3D NULL;</span><br><span>     struct hash =
*hash =3D m-&gt;hash;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    mi =3D multi_create_instance(m, NULL, ls);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (mi &amp;&amp; !proto_is_=
dgram(ls-&gt;info.proto))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    mi =3D multi_create_instance(m, NULL, sock);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; !proto_is_dgram(so=
ck-&gt;info.proto))</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        mi-&gt;real.proto =3D ls-&gt;info.proto;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;real.proto=
 =3D sock-&gt;info.proto;</span><br><span>         struct hash_element *he;=
</span><br><span>         const uint32_t hv =3D hash_value(hash, &amp;mi-&g=
t;real);</span><br><span>         struct hash_bucket *bucket =3D hash_bucke=
t(hash, hv);</span><br><span>@@ -139,10 +139,10 @@</span><br><span> void</s=
pan><br><span> multi_tcp_dereference_instance(struct multi_io *multi_io, st=
ruct multi_instance *mi)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct link_socket *ls =3D mi-&gt;context.c2.link=
_sockets[0];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (l=
s &amp;&amp; mi-&gt;socket_set_called)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct link_socket *sock =3D mi-&gt;context.c2.link_=
sockets[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
sock &amp;&amp; mi-&gt;socket_set_called)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        event_del(multi_io-&gt;e=
s, socket_event_handle(ls));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        event_del(multi_io-&gt;es, socket_event_handle(sock));</sp=
an><br><span>         mi-&gt;socket_set_called =3D false;</span><br><span> =
    }</span><br><span>     multi_io-&gt;n_esr =3D 0;</span><br><span>diff -=
-git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h</span><br><span>index 0a5b04=
5..a0ef6a4 100644</span><br><span>--- a/src/openvpn/mtcp.h</span><br><span>=
+++ b/src/openvpn/mtcp.h</span><br><span>@@ -46,7 +46,7 @@</span><br><span>=
 </span><br><span> bool multi_tcp_process_outgoing_link_ready(struct multi_=
context *m, struct multi_instance *mi, const unsigned int mpp_flags);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct mu=
lti_instance *multi_create_instance_tcp(struct multi_context *m, struct lin=
k_socket *ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struc=
t multi_instance *multi_create_instance_tcp(struct multi_context *m, struct=
 link_socket *sock);</span><br><span> </span><br><span> void multi_tcp_link=
_out_deferred(struct multi_context *m, struct multi_instance *mi);</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mud=
p.c</span><br><span>index 86e1713..8496400 100644</span><br><span>--- a/src=
/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@=
 -186,14 +186,14 @@</span><br><span> </span><br><span> struct multi_instanc=
e *</span><br><span> multi_get_create_instance_udp(struct multi_context *m,=
 bool *floated,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                        struct link_socket *ls)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                              struct link_socke=
t *sock)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span>     struct mroute_addr real =3D {0};</span><br><spa=
n>     struct multi_instance *mi =3D NULL;</span><br><span>     struct hash=
 *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    real.proto =3D ls-&gt;info.proto;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    m-&gt;hmac_reply_ls =3D ls;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    real.proto =3D sock-&gt;info.proto;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;hmac_reply_ls =
=3D sock;</span><br><span> </span><br><span>     if (mroute_extract_openvpn=
_sockaddr(&amp;real, &amp;m-&gt;top.c2.from.dest, true)</span><br><span>   =
      &amp;&amp; m-&gt;top.c2.buf.len &gt; 0)</span><br><span>@@ -259,7 +25=
9,7 @@</span><br><span>                      * connect-freq but not against=
 connect-freq-initial */</span><br><span>                     reflect_filte=
r_rate_limit_decrease(m-&gt;initial_rate_limiter);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    mi =3D m=
ulti_create_instance(m, &amp;real, ls);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    mi =3D multi_create_instance(m, &am=
p;real, sock);</span><br><span>                     if (mi)</span><br><span=
>                     {</span><br><span>                         hash_add_f=
ast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span>diff --git a/s=
rc/openvpn/mudp.h b/src/openvpn/mudp.h</span><br><span>index 357b684..37752=
e1 100644</span><br><span>--- a/src/openvpn/mudp.h</span><br><span>+++ b/sr=
c/openvpn/mudp.h</span><br><span>@@ -33,7 +33,7 @@</span><br><span> </span>=
<br><span> unsigned int p2mp_iow_flags(const struct multi_context *m);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void mul=
ti_process_io_udp(struct multi_context *m, struct link_socket *ls);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_process_io_udp(s=
truct multi_context *m, struct link_socket *sock);</span><br><span> /******=
********************************************************************/</span=
><br><span> /**</span><br><span>  * Get, and if necessary create, the multi=
_instance associated with a</span><br><span>@@ -47,13 +47,13 @@</span><br><=
span>  * successful, returns the newly created instance.</span><br><span>  =
*</span><br><span>  * @param m           - The single multi_context structu=
re.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ls      =
    - Listening socket where this instance is connecting to</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param sock        - Listening s=
ocket where this instance is connecting to</span><br><span>  *</span><br><s=
pan>  * @return A pointer to a multi_instance if one already existed for th=
e</span><br><span>  *     packet&#39;s source address or if one was a newly=
 created successfully.</span><br><span>  *      NULL if one did not yet exi=
st and a new one was not created.</span><br><span>  */</span><br><span> str=
uct multi_instance *multi_get_create_instance_udp(struct multi_context *m, =
bool *floated,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                                              struct link_socket *ls);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                             struct link_socket *sock);</span><br><span> </=
span><br><span> #endif /* ifndef MUDP_H */</span><br><span>diff --git a/src=
/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 809fde5..ee8a5=
99 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/s=
rc/openvpn/multi.c</span><br><span>@@ -751,7 +751,7 @@</span><br><span>  */=
</span><br><span> struct multi_instance *</span><br><span> multi_create_ins=
tance(struct multi_context *m, const struct mroute_addr *real,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                      struct link_=
socket *ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
              struct link_socket *sock)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span>     struct multi_ins=
tance *mi;</span><br><span>@@ -774,7 +774,7 @@</span><br><span>         gen=
erate_prefix(mi);</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    inherit_context_child(&amp;mi-&gt;=
context, &amp;m-&gt;top, ls);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    inherit_context_child(&amp;mi-&gt;context, &amp;m-&gt;top, so=
ck);</span><br><span>     if (IS_SIG(&amp;mi-&gt;context))</span><br><span>=
     {</span><br><span>         goto err;</span><br><span>@@ -794,7 +794,7 =
@@</span><br><span>         {</span><br><span>             goto err;</span>=
<br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       mi-&gt;real.proto =3D ls-&gt;info.proto;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        mi-&gt;real.proto =3D sock-&gt;info.pro=
to;</span><br><span>         generate_prefix(mi);</span><br><span>     }</s=
pan><br><span> </span><br><span>@@ -3129,7 +3129,7 @@</span><br><span> </sp=
an><br><span> void</span><br><span> multi_process_float(struct multi_contex=
t *m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    struct link_socket *ls)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    struct link_socket *=
sock)</span><br><span> {</span><br><span>     struct mroute_addr real =3D {=
0};</span><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><span>=
@@ -3185,7 +3185,7 @@</span><br><span>     mi-&gt;context.c2.to_link_addr =
=3D &amp;mi-&gt;context.c2.from;</span><br><span> </span><br><span>     /* =
inherit parent link_socket and link_socket_info */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    mi-&gt;context.c2.link_sockets[0] =3D ls;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context.c=
2.link_sockets[0] =3D sock;</span><br><span>     mi-&gt;context.c2.link_soc=
ket_infos[0]-&gt;lsa-&gt;actual =3D m-&gt;top.c2.from;</span><br><span> </s=
pan><br><span>     tls_update_remote_addr(mi-&gt;context.c2.tls_multi, &amp=
;mi-&gt;context.c2.from);</span><br><span>@@ -3335,7 +3335,7 @@</span><br><=
span>  */</span><br><span> bool</span><br><span> multi_process_incoming_lin=
k(struct multi_context *m, struct multi_instance *instance,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                            const uns=
igned int mpp_flags, struct link_socket *ls)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                            const unsigned int mpp=
_flags, struct link_socket *sock)</span><br><span> {</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -3356,=
7 +3356,7 @@</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span=
>         printf(&quot;TCP/UDP -&gt; TUN [%d]\n&quot;, BLEN(&amp;m-&gt;top.=
c2.buf));</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        multi_set_pending(m, multi_get_create_instance_udp(m, &=
amp;floated, ls));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       multi_set_pending(m, multi_get_create_instance_udp(m, &amp;floated, =
sock));</span><br><span>     }</span><br><span>     else</span><br><span>  =
   {</span><br><span>@@ -3390,14 +3390,14 @@</span><br><span>             /=
* decrypt in instance context */</span><br><span> </span><br><span>        =
     perf_push(PERF_PROC_IN_LINK);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            lsi =3D &amp;ls-&gt;info;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            lsi =3D &amp;sock-&gt;info;</spa=
n><br><span>             orig_buf =3D c-&gt;c2.buf.data;</span><br><span>  =
           if (process_incoming_link_part1(c, lsi, floated))</span><br><spa=
n>             {</span><br><span>                 /* nonzero length means t=
hat we have a valid, decrypted packed */</span><br><span>                 i=
f (floated &amp;&amp; c-&gt;c2.buf.len &gt; 0)</span><br><span>            =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     multi_process_float(m, m-&gt;pending, ls);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    multi_process_float(m, m-&g=
t;pending, sock);</span><br><span>                 }</span><br><span> </spa=
n><br><span>                 process_incoming_link_part2(c, lsi, orig_buf);=
</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</sp=
an><br><span>index 092aed6..229f500 100644</span><br><span>--- a/src/openvp=
n/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -275=
,7 +275,7 @@</span><br><span> void multi_top_free(struct multi_context *m);=
</span><br><span> </span><br><span> struct multi_instance *multi_create_ins=
tance(struct multi_context *m, const struct mroute_addr *real,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
           struct link_socket *ls);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                             struct link_so=
cket *sock);</span><br><span> </span><br><span> void multi_close_instance(s=
truct multi_context *m, struct multi_instance *mi, bool shutdown);</span><b=
r><span> </span><br><span>@@ -290,7 +290,7 @@</span><br><span>  * updates h=
ashtables in multi_context.</span><br><span>  */</span><br><span> void mult=
i_process_float(struct multi_context *m, struct multi_instance *mi,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                         stru=
ct link_socket *ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                         struct link_socket *sock);</span><br><span> </spa=
n><br><span> #define MPP_PRE_SELECT             (1&lt;&lt;0)</span><br><spa=
n> #define MPP_CONDITIONAL_PRE_SELECT (1&lt;&lt;1)</span><br><span>@@ -355,=
10 +355,10 @@</span><br><span>  *                       when using TCP tran=
sport. Otherwise NULL, as is</span><br><span>  *                       the =
case when using UDP transport.</span><br><span>  * @param mpp_flags    - Fa=
st I/O optimization flags.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @param ls           - Socket where the packet was received.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sock         - So=
cket where the packet was received.</span><br><span>  */</span><br><span> b=
ool multi_process_incoming_link(struct multi_context *m, struct multi_insta=
nce *instance, const unsigned int mpp_flags,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                 struct link_socket =
*ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   struct link_socket *sock);</span><br><span> </span><br><=
span> </span><br><span> /**</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/874?usp=3Demail">chang=
e 874</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/874?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff12c4dbac84a814612aa8b5b89=
224be08bb9058 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 874 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Buxk1aHduuk=--

