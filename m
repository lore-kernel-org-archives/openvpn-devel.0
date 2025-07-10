From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 10 Jul 2025 09:39:47 +0000
References: <gerrit.1752140383000.I8cefa9a406fe90bb3cbe481304782c639691a3a0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4286a2d91285649c60e5a89156caff3c371d68c8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AugD/lVwLqE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: Move
 gc_arena inside reliable_print_ids
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

--AugD/lVwLqE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1083?usp=3Demail

to review the following change.


Change subject: reliable: Move gc_arena inside reliable_print_ids
......................................................................

reliable: Move gc_arena inside reliable_print_ids

There was no user that actually used it for
anything else. But there were some previous
users that generated a now useless gc_arena.

While looking through the code, modernize
the loop variable usage.

Change-Id: I8cefa9a406fe90bb3cbe481304782c639691a3a0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/reliable.c
1 file changed, 25 insertions(+), 56 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1083/1

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 424d194..6477c45 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -446,13 +446,13 @@
 #ifdef ENABLE_DEBUG
 /* print the current sequence of active packet IDs */
 static const char *
-reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)
+reliable_print_ids(const struct reliable *rel)
 {
-    struct buffer out =3D alloc_buf_gc(256, gc);
-    int i;
+    struct gc_arena gc =3D gc_new();
+    struct buffer out =3D alloc_buf_gc(256, &gc);

     buf_printf(&out, "[" packet_id_format "]", (packet_id_print_type)rel->=
packet_id);
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active)
@@ -460,6 +460,7 @@
             buf_printf(&out, " " packet_id_format, (packet_id_print_type)e=
->packet_id);
         }
     }
+    gc_free(&gc);
     return BSTR(&out);
 }
 #endif /* ENABLE_DEBUG */
@@ -468,9 +469,7 @@
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
@@ -478,8 +477,7 @@
             return true;
         }
     }
-    dmsg(D_REL_LOW, "ACK no free receive buffer available: %s", reliable_p=
rint_ids(rel, &gc));
-    gc_free(&gc);
+    dmsg(D_REL_LOW, "ACK no free receive buffer available: %s", reliable_p=
rint_ids(rel));
     return false;
 }

@@ -487,13 +485,11 @@
 bool
 reliable_not_replay(const struct reliable *rel, packet_id_type id)
 {
-    struct gc_arena gc =3D gc_new();
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
@@ -501,12 +497,10 @@
             goto bad;
         }
     }
-    gc_free(&gc);
     return true;

 bad:
-    dmsg(D_REL_DEBUG, "ACK " packet_id_format " is a replay: %s", (packet_=
id_print_type)id, reliable_print_ids(rel, &gc));
-    gc_free(&gc);
+    dmsg(D_REL_DEBUG, "ACK " packet_id_format " is a replay: %s", (packet_=
id_print_type)id, reliable_print_ids(rel));
     return false;
 }

@@ -514,19 +508,15 @@
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
         dmsg(D_REL_LOW, "ACK " packet_id_format " breaks sequentiality: %s=
",
-             (packet_id_print_type)id, reliable_print_ids(rel, &gc));
+             (packet_id_print_type)id, reliable_print_ids(rel));
     }

     dmsg(D_REL_DEBUG, "ACK RWBS rel->size=3D%d rel->packet_id=3D%08x id=3D=
%08x ret=3D%d", rel->size, rel->packet_id, id, ret);
-
-    gc_free(&gc);
     return ret;
 }

@@ -534,8 +524,7 @@
 struct buffer *
 reliable_get_buf(struct reliable *rel)
 {
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         if (!e->active)
@@ -550,7 +539,6 @@
 int
 reliable_get_num_output_sequenced_available(struct reliable *rel)
 {
-    struct gc_arena gc =3D gc_new();
     packet_id_type min_id =3D 0;
     bool min_id_defined =3D false;

@@ -573,7 +561,6 @@
     {
         ret -=3D subtract_pid(rel->packet_id, min_id);
     }
-    gc_free(&gc);
     return ret;
 }

@@ -581,14 +568,12 @@
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
@@ -607,9 +592,8 @@
     }
     else
     {
-        dmsg(D_REL_LOW, "ACK output sequence broken: %s", reliable_print_i=
ds(rel, &gc));
+        dmsg(D_REL_LOW, "ACK output sequence broken: %s", reliable_print_i=
ds(rel));
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
@@ -633,10 +616,8 @@
 bool
 reliable_can_send(const struct reliable *rel)
 {
-    struct gc_arena gc =3D gc_new();
-    int i;
     int n_active =3D 0, n_current =3D 0;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active)
@@ -652,9 +633,8 @@
     dmsg(D_REL_DEBUG, "ACK reliable_can_send active=3D%d current=3D%d : %s=
",
          n_active,
          n_current,
-         reliable_print_ids(rel, &gc));
+         reliable_print_ids(rel));

-    gc_free(&gc);
     return n_current > 0 && !rel->hold;
 }

@@ -662,11 +642,10 @@
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

@@ -701,10 +680,9 @@
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
@@ -720,12 +698,10 @@
 interval_t
 reliable_send_timeout(const struct reliable *rel)
 {
-    struct gc_arena gc =3D gc_new();
     interval_t ret =3D BIG_TIMEOUT;
-    int i;
     const time_t local_now =3D now;

-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e =3D &rel->array[i];
         if (e->active)
@@ -744,9 +720,8 @@

     dmsg(D_REL_DEBUG, "ACK reliable_send_timeout %d %s",
          (int) ret,
-         reliable_print_ids(rel, &gc));
+         reliable_print_ids(rel));

-    gc_free(&gc);
     return ret;
 }

@@ -758,8 +733,7 @@
 reliable_mark_active_incoming(struct reliable *rel, struct buffer *buf,
                               packet_id_type pid, int opcode)
 {
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         if (buf =3D=3D &e->buf)
@@ -790,8 +764,7 @@
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
@@ -817,8 +790,7 @@
 void
 reliable_mark_deleted(struct reliable *rel, struct buffer *buf)
 {
-    int i;
-    for (i =3D 0; i < rel->size; ++i)
+    for (int i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
         if (buf =3D=3D &e->buf)
@@ -836,10 +808,8 @@
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
@@ -848,14 +818,13 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--AugD/lVwLqE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1083?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">reliable: Move gc_arena inside reliable_print_ids<br><br>The=
re was no user that actually used it for<br>anything else. But there were s=
ome previous<br>users that generated a now useless gc_arena.<br><br>While l=
ooking through the code, modernize<br>the loop variable usage.<br><br>Chang=
e-Id: I8cefa9a406fe90bb3cbe481304782c639691a3a0<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/reliable.c<br>1 f=
ile changed, 25 insertions(+), 56 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/83/1083/1</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpn/reliable.c b/src/openvpn/reliable.c</span><br><span>index 424d19=
4..6477c45 100644</span><br><span>--- a/src/openvpn/reliable.c</span><br><s=
pan>+++ b/src/openvpn/reliable.c</span><br><span>@@ -446,13 +446,13 @@</spa=
n><br><span> #ifdef ENABLE_DEBUG</span><br><span> /* print the current sequ=
ence of active packet IDs */</span><br><span> static const char *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-reliable_print_ids(const struct=
 reliable *rel, struct gc_arena *gc)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+reliable_print_ids(const struct reliable *rel)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buf=
fer out =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer out =3D alloc_buf_gc(256, &amp;gc);<=
/span><br><span> </span><br><span>     buf_printf(&amp;out, &quot;[&quot; p=
acket_id_format &quot;]&quot;, (packet_id_print_type)rel-&gt;packet_id);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt;=
 rel-&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</spa=
n><br><span>         const struct reliable_entry *e =3D &amp;rel-&gt;array[=
i];</span><br><span>         if (e-&gt;active)</span><br><span>@@ -460,6 +4=
60,7 @@</span><br><span>             buf_printf(&amp;out, &quot; &quot; pac=
ket_id_format, (packet_id_print_type)e-&gt;packet_id);</span><br><span>    =
     }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span>     return BSTR(&amp;out);=
</span><br><span> }</span><br><span> #endif /* ENABLE_DEBUG */</span><br><s=
pan>@@ -468,9 +469,7 @@</span><br><span> bool</span><br><span> reliable_can=
_get(const struct reliable *rel)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; =
++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span>   =
      const struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><=
span>         if (!e-&gt;active)</span><br><span>@@ -478,8 +477,7 @@</span>=
<br><span>             return true;</span><br><span>         }</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_=
REL_LOW, &quot;ACK no free receive buffer available: %s&quot;, reliable_pri=
nt_ids(rel, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    dmsg(D_REL_LOW, &quot;ACK no free receive buffer available: %s&quot;=
, reliable_print_ids(rel));</span><br><span>     return false;</span><br><s=
pan> }</span><br><span> </span><br><span>@@ -487,13 +485,11 @@</span><br><s=
pan> bool</span><br><span> reliable_not_replay(const struct reliable *rel, =
packet_id_type id)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     if (reliabl=
e_pid_min(id, rel-&gt;packet_id))</span><br><span>     {</span><br><span>  =
       goto bad;</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-=
&gt;size; ++i)</span><br><span>     {</span><br><span>         const struct=
 reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><span>         if (=
e-&gt;active &amp;&amp; e-&gt;packet_id =3D=3D id)</span><br><span>@@ -501,=
12 +497,10 @@</span><br><span>             goto bad;</span><br><span>      =
   }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    gc_free(&amp;gc);</span><br><span>     return true;</span><br><sp=
an> </span><br><span> bad:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    dmsg(D_REL_DEBUG, &quot;ACK &quot; packet_id_format &quot; is a re=
play: %s&quot;, (packet_id_print_type)id, reliable_print_ids(rel, &amp;gc))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_REL_DEB=
UG, &quot;ACK &quot; packet_id_format &quot; is a replay: %s&quot;, (packet=
_id_print_type)id, reliable_print_ids(rel));</span><br><span>     return fa=
lse;</span><br><span> }</span><br><span> </span><br><span>@@ -514,19 +508,1=
5 @@</span><br><span> bool</span><br><span> reliable_wont_break_sequentiali=
ty(const struct reliable *rel, packet_id_type id)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan>     const int ret =3D reliable_pid_in_range2(id, rel-&gt;packet_id, re=
l-&gt;size);</span><br><span> </span><br><span>     if (!ret)</span><br><sp=
an>     {</span><br><span>         dmsg(D_REL_LOW, &quot;ACK &quot; packet_=
id_format &quot; breaks sequentiality: %s&quot;,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-             (packet_id_print_type)id, reliable_=
print_ids(rel, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+             (packet_id_print_type)id, reliable_print_ids(rel));</spa=
n><br><span>     }</span><br><span> </span><br><span>     dmsg(D_REL_DEBUG,=
 &quot;ACK RWBS rel-&gt;size=3D%d rel-&gt;packet_id=3D%08x id=3D%08x ret=3D=
%d&quot;, rel-&gt;size, rel-&gt;packet_id, id, ret);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    gc_free(&amp;gc);</span><br><span>     return ret;</span><br=
><span> }</span><br><span> </span><br><span>@@ -534,8 +524,7 @@</span><br><=
span> struct buffer *</span><br><span> reliable_get_buf(struct reliable *re=
l)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; rel-&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><spa=
n>     {</span><br><span>         struct reliable_entry *e =3D &amp;rel-&gt=
;array[i];</span><br><span>         if (!e-&gt;active)</span><br><span>@@ -=
550,7 +539,6 @@</span><br><span> int</span><br><span> reliable_get_num_outp=
ut_sequenced_available(struct reliable *rel)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new=
();</span><br><span>     packet_id_type min_id =3D 0;</span><br><span>     =
bool min_id_defined =3D false;</span><br><span> </span><br><span>@@ -573,7 =
+561,6 @@</span><br><span>     {</span><br><span>         ret -=3D subtract=
_pid(rel-&gt;packet_id, min_id);</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span>   =
  return ret;</span><br><span> }</span><br><span> </span><br><span>@@ -581,=
14 +568,12 @@</span><br><span> struct buffer *</span><br><span> reliable_ge=
t_buf_output_sequenced(struct reliable *rel)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><=
br><span>     packet_id_type min_id =3D 0;</span><br><span>     bool min_id=
_defined =3D false;</span><br><span>     struct buffer *ret =3D NULL;</span=
><br><span> </span><br><span>     /* find minimum active packet_id */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; re=
l-&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><=
br><span>         const struct reliable_entry *e =3D &amp;rel-&gt;array[i];=
</span><br><span>         if (e-&gt;active)</span><br><span>@@ -607,9 +592,=
8 @@</span><br><span>     }</span><br><span>     else</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_REL_L=
OW, &quot;ACK output sequence broken: %s&quot;, reliable_print_ids(rel, &am=
p;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg=
(D_REL_LOW, &quot;ACK output sequence broken: %s&quot;, reliable_print_ids(=
rel));</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    gc_free(&amp;gc);</span><br><span>     return ret;</span><br><s=
pan> }</span><br><span> </span><br><span>@@ -617,8 +601,7 @@</span><br><spa=
n> struct reliable_entry *</span><br><span> reliable_get_entry_sequenced(st=
ruct reliable *rel)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++=
i)</span><br><span>     {</span><br><span>         struct reliable_entry *e=
 =3D &amp;rel-&gt;array[i];</span><br><span>         if (e-&gt;active &amp;=
&amp; e-&gt;packet_id =3D=3D rel-&gt;packet_id)</span><br><span>@@ -633,10 =
+616,8 @@</span><br><span> bool</span><br><span> reliable_can_send(const st=
ruct reliable *rel)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     int n_activ=
e =3D 0, n_current =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)=
</span><br><span>     {</span><br><span>         const struct reliable_entr=
y *e =3D &amp;rel-&gt;array[i];</span><br><span>         if (e-&gt;active)<=
/span><br><span>@@ -652,9 +633,8 @@</span><br><span>     dmsg(D_REL_DEBUG, =
&quot;ACK reliable_can_send active=3D%d current=3D%d : %s&quot;,</span><br>=
<span>          n_active,</span><br><span>          n_current,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-         reliable_print_ids(rel, &=
amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         r=
eliable_print_ids(rel));</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span>     return n_cu=
rrent &gt; 0 &amp;&amp; !rel-&gt;hold;</span><br><span> }</span><br><span> =
</span><br><span>@@ -662,11 +642,10 @@</span><br><span> struct buffer *</sp=
an><br><span> reliable_send(struct reliable *rel, int *opcode)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</spa=
n><br><span>     struct reliable_entry *best =3D NULL;</span><br><span>    =
 const time_t local_now =3D now;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span>         s=
truct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><span> </span>=
<br><span>@@ -701,10 +680,9 @@</span><br><span> void</span><br><span> relia=
ble_schedule_now(struct reliable *rel)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     dmsg(D_=
REL_DEBUG, &quot;ACK reliable_schedule_now&quot;);</span><br><span>     rel=
-&gt;hold =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</spa=
n><br><span>     {</span><br><span>         struct reliable_entry *e =3D &a=
mp;rel-&gt;array[i];</span><br><span>         if (e-&gt;active)</span><br><=
span>@@ -720,12 +698,10 @@</span><br><span> interval_t</span><br><span> rel=
iable_send_timeout(const struct reliable *rel)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_n=
ew();</span><br><span>     interval_t ret =3D BIG_TIMEOUT;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     const =
time_t local_now =3D now;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++i)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; =
rel-&gt;size; ++i)</span><br><span>     {</span><br><span>         const st=
ruct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><span>         =
if (e-&gt;active)</span><br><span>@@ -744,9 +720,8 @@</span><br><span> </sp=
an><br><span>     dmsg(D_REL_DEBUG, &quot;ACK reliable_send_timeout %d %s&q=
uot;,</span><br><span>          (int) ret,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         reliable_print_ids(rel, &amp;gc));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         reliable_print_ids(re=
l));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    gc_free(&amp;gc);</span><br><span>     return ret;</span><br><span> }<=
/span><br><span> </span><br><span>@@ -758,8 +733,7 @@</span><br><span> reli=
able_mark_active_incoming(struct reliable *rel, struct buffer *buf,</span><=
br><span>                               packet_id_type pid, int opcode)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0;=
 i &lt; rel-&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>    =
 {</span><br><span>         struct reliable_entry *e =3D &amp;rel-&gt;array=
[i];</span><br><span>         if (buf =3D=3D &amp;e-&gt;buf)</span><br><spa=
n>@@ -790,8 +764,7 @@</span><br><span> void</span><br><span> reliable_mark_=
active_outgoing(struct reliable *rel, struct buffer *buf, int opcode)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i=
 &lt; rel-&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {=
</span><br><span>         struct reliable_entry *e =3D &amp;rel-&gt;array[i=
];</span><br><span>         if (buf =3D=3D &amp;e-&gt;buf)</span><br><span>=
@@ -817,8 +790,7 @@</span><br><span> void</span><br><span> reliable_mark_de=
leted(struct reliable *rel, struct buffer *buf)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; rel-&gt;size; ++=
i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     {</span><br><span>   =
      struct reliable_entry *e =3D &amp;rel-&gt;array[i];</span><br><span> =
        if (buf =3D=3D &amp;e-&gt;buf)</span><br><span>@@ -836,10 +808,8 @@=
</span><br><span> void</span><br><span> reliable_ack_debug_print(const stru=
ct reliable_ack *ack, char *desc)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>     printf(&quot;********* struct re=
liable_ack %s\n&quot;, desc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    for (i =3D 0; i &lt; ack-&gt;len; ++i)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; ack-&gt;len; ++=
i)</span><br><span>     {</span><br><span>         printf(&quot;  %d: &quot=
; packet_id_format &quot;\n&quot;, i, (packet_id_print_type) ack-&gt;packet=
_id[i]);</span><br><span>     }</span><br><span>@@ -848,14 +818,13 @@</span=
><br><span> void</span><br><span> reliable_debug_print(const struct reliabl=
e *rel, char *desc)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int i;</span><br><span>     update_time();</span><br><=
span> </span><br><span>     printf(&quot;********* struct reliable %s\n&quo=
t;, desc);</span><br><span>     printf(&quot;  initial_timeout=3D%d\n&quot;=
, (int)rel-&gt;initial_timeout);</span><br><span>     printf(&quot;  packet=
_id=3D&quot; packet_id_format &quot;\n&quot;, rel-&gt;packet_id);</span><br=
><span>     printf(&quot;  now=3D%&quot; PRIi64 &quot;\n&quot;, (int64_t)no=
w);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; =
i &lt; rel-&gt;size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>     =
{</span><br><span>         const struct reliable_entry *e =3D &amp;rel-&gt;=
array[i];</span><br><span>         if (e-&gt;active)</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1083?usp=3Demail">change 1083</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1083?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8cefa9a406fe90bb3cbe4813047=
82c639691a3a0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1083 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--AugD/lVwLqE=--

