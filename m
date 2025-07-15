From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 15 Jul 2025 20:05:07 +0000
In-Reply-To: <gerrit.1752140383000.I8cefa9a406fe90bb3cbe481304782c639691a3a0@...2715...>
References: <gerrit.1752140383000.I8cefa9a406fe90bb3cbe481304782c639691a3a0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fc474c6506558c871e4cec397a9c663c05a8decd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jC/22+JclKs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: Review and
 fix gc_arena usage
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

--jC/22+JclKs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
83?usp=3Demail )

Change subject: reliable: Review and fix gc_arena usage
......................................................................

reliable: Review and fix gc_arena usage

Check for unused objects (in
reliable_get_num_output_sequenced_available)
and missing free (in reliable_can_get).

While looking through the code, modernize
the loop variable usage.

Change-Id: I8cefa9a406fe90bb3cbe481304782c639691a3a0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250715143750.9719-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
157.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/reliable.c
1 file changed, 29 insertions(+), 56 deletions(-)




diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 424d194..5505f56 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -98,8 +98,7 @@
 static inline bool
 reliable_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pi=
d)
 {
-    int i;
-    for (i =3D 0; i < ack->len; ++i)
+    for (int i =3D 0; i < ack->len; ++i)
     {
         if (ack->packet_id[i] =3D=3D pid)
         {
@@ -312,10 +311,7 @@
 const char *
 reliable_ack_print(struct buffer *buf, bool verbose, struct gc_arena *gc)
 {
-    int i;
     uint8_t n_ack;
-    struct session_id sid_ack;
-    packet_id_type pid;
     struct buffer out =3D alloc_buf_gc(256, gc);

     buf_printf(&out, "[");
@@ -323,8 +319,9 @@
     {
         goto done;
     }
-    for (i =3D 0; i < n_ack; ++i)
+    for (int i =3D 0; i < n_ack; ++i)
     {
+        packet_id_type pid;
         if (!buf_read(buf, &pid, sizeof(pid)))
         {
             goto done;
@@ -334,6 +331,7 @@
     }
     if (n_ack)
     {
+        struct session_id sid_ack;
         if (!session_id_read(&sid_ack, buf))
         {
             goto done;
@@ -356,14 +354,12 @@
 void
 reliable_init(struct reliable *rel, int buf_size, int offset, int array_si=
ze, bool hold)
 {
-    int i;
-
     CLEAR(*rel);
     ASSERT(array_size > 0 && array_size <=3D RELIABLE_CAPACITY);
     rel->hold =3D hold;
     rel->size =3D array_size;
     rel->offset =3D offset;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         e->buf =3D alloc_buf(buf_size);
@@ -378,8 +374,7 @@
     {
         return;
     }
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         free_buf(&e->buf);
@@ -391,8 +386,7 @@
 bool
 reliable_empty(const struct reliable *rel)
 {
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active)
@@ -407,11 +401,10 @@
 void
 reliable_send_purge(struct reliable *rel, const struct reliable_ack *ack)
 {
-    int i, j;
-    for (i =3D 0; i < ack->len; ++i)
+    for (int i =3D 0; i < ack->len; ++i)
     {
         packet_id_type pid =3D ack->packet_id[i];
-        for (j =3D 0; j < rel->size; ++j)
+        for (int j =3D 0; j < rel->size; ++j)
         {
             struct reliable_entry *e =3D &rel->array[j];
             if (e->active && e->packet_id =3D=3D pid)
@@ -449,10 +442,9 @@
 reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
-    int i;

     buf_printf(&out, "[" packet_id_format "]", (packet_id_print_type)rel->=
packet_id);
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active)
@@ -468,9 +460,7 @@
 bool
 reliable_can_get(const struct reliable *rel)
 {
-    struct gc_arena gc =3D gc_new();
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (!e->active)
@@ -478,6 +468,7 @@
             return true;
         }
     }
+    struct gc_arena gc =3D gc_new();
     dmsg(D_REL_LOW, "ACK no free receive buffer available: %s", reliable_p=
rint_ids(rel, &gc));
     gc_free(&gc);
     return false;
@@ -488,12 +479,11 @@
 reliable_not_replay(const struct reliable *rel, packet_id_type id)
 {
     struct gc_arena gc =3D gc_new();
-    int i;
     if (reliable_pid_min(id, rel->packet_id))
     {
         goto bad;
     }
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active && e->packet_id =3D=3D id)
@@ -514,19 +504,17 @@
 bool
 reliable_wont_break_sequentiality(const struct reliable *rel, packet_id_ty=
pe id)
 {
-    struct gc_arena gc =3D gc_new();
-
     const int ret =3D reliable_pid_in_range2(id, rel->packet_id, rel->size=
);

     if (!ret)
     {
+        struct gc_arena gc =3D gc_new();
         dmsg(D_REL_LOW, "ACK " packet_id_format " breaks sequentiality: %s=
",
              (packet_id_print_type)id, reliable_print_ids(rel, &gc));
+        gc_free(&gc);
     }

     dmsg(D_REL_DEBUG, "ACK RWBS rel->size=3D%d rel->packet_id=3D%08x id=3D=
%08x ret=3D%d", rel->size, rel->packet_id, id, ret);
-
-    gc_free(&gc);
     return ret;
 }

@@ -534,8 +522,7 @@
 struct buffer *
 reliable_get_buf(struct reliable *rel)
 {
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         if (!e->active)
@@ -550,7 +537,6 @@
 int
 reliable_get_num_output_sequenced_available(struct reliable *rel)
 {
-    struct gc_arena gc =3D gc_new();
     packet_id_type min_id =3D 0;
     bool min_id_defined =3D false;

@@ -573,7 +559,6 @@
     {
         ret -=3D subtract_pid(rel->packet_id, min_id);
     }
-    gc_free(&gc);
     return ret;
 }

@@ -581,14 +566,12 @@
 struct buffer *
 reliable_get_buf_output_sequenced(struct reliable *rel)
 {
-    struct gc_arena gc =3D gc_new();
-    int i;
     packet_id_type min_id =3D 0;
     bool min_id_defined =3D false;
     struct buffer *ret =3D NULL;

     /* find minimum active packet_id */
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active)
@@ -607,9 +590,10 @@
     }
     else
     {
+        struct gc_arena gc =3D gc_new();
         dmsg(D_REL_LOW, "ACK output sequence broken: %s", reliable_print_i=
ds(rel, &gc));
+        gc_free(&gc);
     }
-    gc_free(&gc);
     return ret;
 }

@@ -617,8 +601,7 @@
 struct reliable_entry *
 reliable_get_entry_sequenced(struct reliable *rel)
 {
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         if (e->active && e->packet_id =3D=3D rel->packet_id)
@@ -634,9 +617,8 @@
 reliable_can_send(const struct reliable *rel)
 {
     struct gc_arena gc =3D gc_new();
-    int i;
     int n_active =3D 0, n_current =3D 0;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active)
@@ -662,11 +644,10 @@
 struct buffer *
 reliable_send(struct reliable *rel, int *opcode)
 {
-    int i;
     struct reliable_entry *best =3D NULL;
     const time_t local_now =3D now;

-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];

@@ -701,10 +682,9 @@
 void
 reliable_schedule_now(struct reliable *rel)
 {
-    int i;
     dmsg(D_REL_DEBUG, "ACK reliable_schedule_now");
     rel->hold =3D false;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         if (e->active)
@@ -722,10 +702,9 @@
 {
     struct gc_arena gc =3D gc_new();
     interval_t ret =3D BIG_TIMEOUT;
-    int i;
     const time_t local_now =3D now;

-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active)
@@ -758,8 +737,7 @@
 reliable_mark_active_incoming(struct reliable *rel, struct buffer *buf,
                               packet_id_type pid, int opcode)
 {
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         if (buf =3D=3D &e->buf)
@@ -790,8 +768,7 @@
 void
 reliable_mark_active_outgoing(struct reliable *rel, struct buffer *buf, in=
t opcode)
 {
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         if (buf =3D=3D &e->buf)
@@ -817,8 +794,7 @@
 void
 reliable_mark_deleted(struct reliable *rel, struct buffer *buf)
 {
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         if (buf =3D=3D &e->buf)
@@ -836,10 +812,8 @@
 void
 reliable_ack_debug_print(const struct reliable_ack *ack, char *desc)
 {
-    int i;
-
     printf("********* struct reliable_ack %s\n", desc);
-    for (i =3D 0; i < ack->len; ++i)
+    for (int i =3D 0; i < ack->len; ++i)
     {
         printf("  %d: " packet_id_format "\n", i, (packet_id_print_type) a=
ck->packet_id[i]);
     }
@@ -848,14 +822,13 @@
 void
 reliable_debug_print(const struct reliable *rel, char *desc)
 {
-    int i;
     update_time();

     printf("********* struct reliable %s\n", desc);
     printf("  initial_timeout=3D%d\n", (int)rel->initial_timeout);
     printf("  packet_id=3D" packet_id_format "\n", rel->packet_id);
     printf("  now=3D%" PRIi64 "\n", (int64_t)now);
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1083?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8cefa9a406fe90bb3cbe481304782c639691a3a0
Gerrit-Change-Number: 1083
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--jC/22+JclKs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1083?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">reliable: Review and fix gc_arena usage<br><b=
r>Check for unused objects (in<br>reliable_get_num_output_sequenced_availab=
le)<br>and missing free (in reliable_can_get).<br><br>While looking through=
 the code, modernize<br>the loop variable usage.<br><br>Change-Id: I8cefa9a=
406fe90bb3cbe481304782c639691a3a0<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&g=
t;<br>Message-Id: &lt;20250715143750.9719-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32157.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/ope=
nvpn/reliable.c<br>1 file changed, 29 insertions(+), 56 deletions(-)<br><br=
></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c</span><br><=
span>index 424d194..5505f56 100644</span><br><span>--- a/src/openvpn/reliab=
le.c</span><br><span>+++ b/src/openvpn/reliable.c</span><br><span>@@ -98,8 =
+98,7 @@</span><br><span> static inline bool</span><br><span> reliable_ack_=
packet_id_present(struct reliable_ack *ack, packet_id_type pid)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; =
ack-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  for (int i =3D 0; i &lt; ack-&gt;len; ++i)</span><br><span>     {</span><=
br><span>         if (ack-&gt;packet_id[i] =3D=3D pid)</span><br><span>    =
     {</span><br><span>@@ -312,10 +311,7 @@</span><br><span> const char *</=
span><br><span> reliable_ack_print(struct buffer *buf, bool verbose, struct=
 gc_arena *gc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int i;</span><br><span>     uint8_t n_ack;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct session_id sid_ack;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_type pid;</span=
><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><br><spa=
n> </span><br><span>     buf_printf(&amp;out, &quot;[&quot;);</span><br><sp=
an>@@ -323,8 +319,9 @@</span><br><span>     {</span><br><span>         goto=
 done;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    for (i =3D 0; i &lt; n_ack; ++i)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n_ack; ++i)</span><br=
><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  packet_id_type pid;</span><br><span>         if (!buf_read(buf, &amp;pid,=
 sizeof(pid)))</span><br><span>         {</span><br><span>             goto=
 done;</span><br><span>@@ -334,6 +331,7 @@</span><br><span>     }</span><br=
><span>     if (n_ack)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct session_id sid_ack;</span><br><spa=
n>         if (!session_id_read(&amp;sid_ack, buf))</span><br><span>       =
  {</span><br><span>             goto done;</span><br><span>@@ -356,14 +354=
,12 @@</span><br><span> void</span><br><span> reliable_init(struct reliable=
 *rel, int buf_size, int offset, int array_size, bool hold)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     CLEAR(*=
rel);</span><br><span>     ASSERT(array_size &gt; 0 &amp;&amp; array_size &=
lt;=3D RELIABLE_CAPACITY);</span><br><span>     rel-&gt;hold =3D hold;</spa=
n><br><span>     rel-&gt;size =3D array_size;</span><br><span>     rel-&gt;=
offset =3D offset;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span>=
<br><span>     {</span><br><span>         struct reliable_entry *e =3D &amp=
;rel-&gt;array[i];</span><br><span>         e-&gt;buf =3D alloc_buf(buf_siz=
e);</span><br><span>@@ -378,8 +374,7 @@</span><br><span>     {</span><br><s=
pan>         return;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;siz=
e; ++i)</span><br><span>     {</span><br><span>         struct reliable_ent=
ry *e =3D &amp;rel-&gt;array[i];</span><br><span>         free_buf(&amp;e-&=
gt;buf);</span><br><span>@@ -391,8 +386,7 @@</span><br><span> bool</span><b=
r><span> reliable_empty(const struct reliable *rel)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size=
; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int =
i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span> =
        const struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br=
><span>         if (e-&gt;active)</span><br><span>@@ -407,11 +401,10 @@</sp=
an><br><span> void</span><br><span> reliable_send_purge(struct reliable *re=
l, const struct reliable_ack *ack)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i, j;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; ack-&gt;len; ++i)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt;=
 ack-&gt;len; ++i)</span><br><span>     {</span><br><span>         packet_i=
d_type pid =3D ack-&gt;packet_id[i];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        for (j =3D 0; j &lt; rel-&gt;size; ++j)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        for (int j =3D 0; j &lt;=
 rel-&gt;size; ++j)</span><br><span>         {</span><br><span>            =
 struct reliable_entry *e =3D &amp;rel-&gt;array[j];</span><br><span>      =
       if (e-&gt;active &amp;&amp; e-&gt;packet_id =3D=3D pid)</span><br><s=
pan>@@ -449,10 +442,9 @@</span><br><span> reliable_print_ids(const struct r=
eliable *rel, struct gc_arena *gc)</span><br><span> {</span><br><span>     =
struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    int i;</span><br><span> </span><br><span>     bu=
f_printf(&amp;out, &quot;[&quot; packet_id_format &quot;]&quot;, (packet_id=
_print_type)rel-&gt;packet_id);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;size=
; ++i)</span><br><span>     {</span><br><span>         const struct reliabl=
e_entry *e =3D &amp;rel-&gt;array[i];</span><br><span>         if (e-&gt;ac=
tive)</span><br><span>@@ -468,9 +460,7 @@</span><br><span> bool</span><br><=
span> reliable_can_get(const struct reliable *rel)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt=
; rel-&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</sp=
an><br><span>         const struct reliable_entry *e =3D &amp;rel-&gt;array=
[i];</span><br><span>         if (!e-&gt;active)</span><br><span>@@ -478,6 =
+468,7 @@</span><br><span>             return true;</span><br><span>       =
  }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span>     dmsg(D_REL=
_LOW, &quot;ACK no free receive buffer available: %s&quot;, reliable_print_=
ids(rel, &amp;gc));</span><br><span>     gc_free(&amp;gc);</span><br><span>=
     return false;</span><br><span>@@ -488,12 +479,11 @@</span><br><span> r=
eliable_not_replay(const struct reliable *rel, packet_id_type id)</span><br=
><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     i=
f (reliable_pid_min(id, rel-&gt;packet_id))</span><br><span>     {</span><b=
r><span>         goto bad;</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i=
 &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span>         co=
nst struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><span>   =
      if (e-&gt;active &amp;&amp; e-&gt;packet_id =3D=3D id)</span><br><spa=
n>@@ -514,19 +504,17 @@</span><br><span> bool</span><br><span> reliable_won=
t_break_sequentiality(const struct reliable *rel, packet_id_type id)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span>     const int ret =3D reliable_pid_in_range2(id, re=
l-&gt;packet_id, rel-&gt;size);</span><br><span> </span><br><span>     if (=
!ret)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct gc_arena gc =3D gc_new();</span><br><span>         =
dmsg(D_REL_LOW, &quot;ACK &quot; packet_id_format &quot; breaks sequentiali=
ty: %s&quot;,</span><br><span>              (packet_id_print_type)id, relia=
ble_print_ids(rel, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        gc_free(&amp;gc);</span><br><span>     }</span><br><span>=
 </span><br><span>     dmsg(D_REL_DEBUG, &quot;ACK RWBS rel-&gt;size=3D%d r=
el-&gt;packet_id=3D%08x id=3D%08x ret=3D%d&quot;, rel-&gt;size, rel-&gt;pac=
ket_id, id, ret);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</sp=
an><br><span>     return ret;</span><br><span> }</span><br><span> </span><b=
r><span>@@ -534,8 +522,7 @@</span><br><span> struct buffer *</span><br><spa=
n> reliable_get_buf(struct reliable *rel)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i=
 &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span>         st=
ruct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><span>         =
if (!e-&gt;active)</span><br><span>@@ -550,7 +537,6 @@</span><br><span> int=
</span><br><span> reliable_get_num_output_sequenced_available(struct reliab=
le *rel)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct gc_arena gc =3D gc_new();</span><br><span>     packet_id_t=
ype min_id =3D 0;</span><br><span>     bool min_id_defined =3D false;</span=
><br><span> </span><br><span>@@ -573,7 +559,6 @@</span><br><span>     {</sp=
an><br><span>         ret -=3D subtract_pid(rel-&gt;packet_id, min_id);</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  gc_free(&amp;gc);</span><br><span>     return ret;</span><br><span> }</sp=
an><br><span> </span><br><span>@@ -581,14 +566,12 @@</span><br><span> struc=
t buffer *</span><br><span> reliable_get_buf_output_sequenced(struct reliab=
le *rel)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int i;</span><br><span>     packet_id_type min_id =
=3D 0;</span><br><span>     bool min_id_defined =3D false;</span><br><span>=
     struct buffer *ret =3D NULL;</span><br><span> </span><br><span>     /*=
 find minimum active packet_id */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;si=
ze; ++i)</span><br><span>     {</span><br><span>         const struct relia=
ble_entry *e =3D &amp;rel-&gt;array[i];</span><br><span>         if (e-&gt;=
active)</span><br><span>@@ -607,9 +590,10 @@</span><br><span>     }</span><=
br><span>     else</span><br><span>     {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><s=
pan>         dmsg(D_REL_LOW, &quot;ACK output sequence broken: %s&quot;, re=
liable_print_ids(rel, &amp;gc));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        gc_free(&amp;gc);</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><sp=
an>     return ret;</span><br><span> }</span><br><span> </span><br><span>@@=
 -617,8 +601,7 @@</span><br><span> struct reliable_entry *</span><br><span>=
 reliable_get_entry_sequenced(struct reliable *rel)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size=
; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int =
i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span> =
        struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><span=
>         if (e-&gt;active &amp;&amp; e-&gt;packet_id =3D=3D rel-&gt;packet=
_id)</span><br><span>@@ -634,9 +617,8 @@</span><br><span> reliable_can_send=
(const struct reliable *rel)</span><br><span> {</span><br><span>     struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int i;</span><br><span>     int n_active =3D 0, n_current =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt=
; rel-&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</sp=
an><br><span>         const struct reliable_entry *e =3D &amp;rel-&gt;array=
[i];</span><br><span>         if (e-&gt;active)</span><br><span>@@ -662,11 =
+644,10 @@</span><br><span> struct buffer *</span><br><span> reliable_send(=
struct reliable *rel, int *opcode)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     struct reli=
able_entry *best =3D NULL;</span><br><span>     const time_t local_now =3D =
now;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</s=
pan><br><span>     {</span><br><span>         struct reliable_entry *e =3D =
&amp;rel-&gt;array[i];</span><br><span> </span><br><span>@@ -701,10 +682,9 =
@@</span><br><span> void</span><br><span> reliable_schedule_now(struct reli=
able *rel)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int i;</span><br><span>     dmsg(D_REL_DEBUG, &quot;ACK reliabl=
e_schedule_now&quot;);</span><br><span>     rel-&gt;hold =3D false;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-=
&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
or (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br=
><span>         struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><=
br><span>         if (e-&gt;active)</span><br><span>@@ -722,10 +702,9 @@</s=
pan><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</spa=
n><br><span>     interval_t ret =3D BIG_TIMEOUT;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int i;</span><br><span>     const time_t loc=
al_now =3D now;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;si=
ze; ++i)</span><br><span>     {</span><br><span>         const struct relia=
ble_entry *e =3D &amp;rel-&gt;array[i];</span><br><span>         if (e-&gt;=
active)</span><br><span>@@ -758,8 +737,7 @@</span><br><span> reliable_mark_=
active_incoming(struct reliable *rel, struct buffer *buf,</span><br><span> =
                              packet_id_type pid, int opcode)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; re=
l-&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><=
br><span>         struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span=
><br><span>         if (buf =3D=3D &amp;e-&gt;buf)</span><br><span>@@ -790,=
8 +768,7 @@</span><br><span> void</span><br><span> reliable_mark_active_out=
going(struct reliable *rel, struct buffer *buf, int opcode)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-=
&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
or (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br=
><span>         struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><=
br><span>         if (buf =3D=3D &amp;e-&gt;buf)</span><br><span>@@ -817,8 =
+794,7 @@</span><br><span> void</span><br><span> reliable_mark_deleted(stru=
ct reliable *rel, struct buffer *buf)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt=
; rel-&gt;size; ++i)</span><br><span>     {</span><br><span>         struct=
 reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><span>         if (=
buf =3D=3D &amp;e-&gt;buf)</span><br><span>@@ -836,10 +812,8 @@</span><br><=
span> void</span><br><span> reliable_ack_debug_print(const struct reliable_=
ack *ack, char *desc)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span>     printf(&quot;********* struct reliable_ack %s=
\n&quot;, desc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    f=
or (i =3D 0; i &lt; ack-&gt;len; ++i)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int i =3D 0; i &lt; ack-&gt;len; ++i)</span><br>=
<span>     {</span><br><span>         printf(&quot;  %d: &quot; packet_id_f=
ormat &quot;\n&quot;, i, (packet_id_print_type) ack-&gt;packet_id[i]);</spa=
n><br><span>     }</span><br><span>@@ -848,14 +822,13 @@</span><br><span> v=
oid</span><br><span> reliable_debug_print(const struct reliable *rel, char =
*desc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int i;</span><br><span>     update_time();</span><br><span> </span>=
<br><span>     printf(&quot;********* struct reliable %s\n&quot;, desc);</s=
pan><br><span>     printf(&quot;  initial_timeout=3D%d\n&quot;, (int)rel-&g=
t;initial_timeout);</span><br><span>     printf(&quot;  packet_id=3D&quot; =
packet_id_format &quot;\n&quot;, rel-&gt;packet_id);</span><br><span>     p=
rintf(&quot;  now=3D%&quot; PRIi64 &quot;\n&quot;, (int64_t)now);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&g=
t;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><=
span>         const struct reliable_entry *e =3D &amp;rel-&gt;array[i];</sp=
an><br><span>         if (e-&gt;active)</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1083?usp=
=3Demail">change 1083</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1083?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8cefa9a406fe90bb3cbe4813047=
82c639691a3a0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1083 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--jC/22+JclKs=--

