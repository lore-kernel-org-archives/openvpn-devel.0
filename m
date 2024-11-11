From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 01:59:56 +0000
References: <gerrit.1731290343000.If470af2eb456b2b10f9f2806933e026842188c42@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <df9988bacf23b78a2dfd2332b82e95ab42bed28d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zH2zn5BBGgM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change internal id
 of packet id to uint64
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

--zH2zn5BBGgM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/802?usp=3Demail

to review the following change.


Change subject: Change internal id of packet id to uint64
......................................................................

Change internal id of packet id to uint64

This allows to get rid of multiple casts and also prepares for the
larger packet id used by epoch data format.

Change-Id: If470af2eb456b2b10f9f2806933e026842188c42
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/packet_id.c
M src/openvpn/packet_id.h
M tests/unit_tests/openvpn/test_packet_id.c
3 files changed, 55 insertions(+), 59 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/802/1

diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index fb962e4..117c95f 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -36,6 +36,8 @@

 #include "syshead.h"

+#include <stddef.h>
+
 #include "packet_id.h"
 #include "misc.h"
 #include "integer.h"
@@ -56,7 +58,7 @@
                                   const struct packet_id_rec *p,
                                   const struct packet_id_net *pin,
                                   const char *message,
-                                  int value);
+                                  packet_id_print_type value);

 #endif /* ENABLE_DEBUG */

@@ -65,7 +67,7 @@
                 const struct packet_id_rec *p,
                 const struct packet_id_net *pin,
                 const char *message,
-                int value)
+                uint64_t value)
 {
 #ifdef ENABLE_DEBUG
     if (unlikely(check_debug_level(msglevel)))
@@ -115,22 +117,21 @@
     const time_t local_now =3D now;
     if (p->seq_list)
     {
-        packet_id_type diff;
+        int64_t diff;

         /*
-         * If time value increases, start a new
-         * sequence number sequence.
+         * If time value increases, start a new sequence number sequence.
          */
         if (!CIRC_LIST_SIZE(p->seq_list)
             || pin->time > p->time
-            || (pin->id >=3D (packet_id_type)p->seq_backtrack
-                && pin->id - (packet_id_type)p->seq_backtrack > p->id))
+            || (pin->id >=3D p->seq_backtrack
+                && pin->id - p->seq_backtrack > p->id))
         {
             p->time =3D pin->time;
             p->id =3D 0;
-            if (pin->id > (packet_id_type)p->seq_backtrack)
+            if (pin->id > p->seq_backtrack)
             {
-                p->id =3D pin->id - (packet_id_type)p->seq_backtrack;
+                p->id =3D pin->id - p->seq_backtrack;
             }
             CIRC_LIST_RESET(p->seq_list);
         }
@@ -146,7 +147,7 @@
         }

         diff =3D p->id - pin->id;
-        if (diff < (packet_id_type) CIRC_LIST_SIZE(p->seq_list)
+        if (diff < CIRC_LIST_SIZE(p->seq_list)
             && local_now > SEQ_EXPIRED)
         {
             CIRC_LIST_ITEM(p->seq_list, diff) =3D local_now;
@@ -170,9 +171,8 @@
     const time_t local_now =3D now;
     if (p->time_backtrack)
     {
-        int i;
         bool expire =3D false;
-        for (i =3D 0; i < CIRC_LIST_SIZE(p->seq_list); ++i)
+        for (int i =3D 0; i < CIRC_LIST_SIZE(p->seq_list); ++i)
         {
             const time_t t =3D CIRC_LIST_ITEM(p->seq_list, i);
             if (t =3D=3D SEQ_EXPIRED)
@@ -200,7 +200,7 @@
 packet_id_test(struct packet_id_rec *p,
                const struct packet_id_net *pin)
 {
-    packet_id_type diff;
+    uint64_t diff;

     packet_id_debug(D_PID_DEBUG, p, pin, "PID_TEST", 0);

@@ -231,9 +231,9 @@
             diff =3D p->id - pin->id;

             /* keep track of maximum backtrack seen for debugging purposes=
 */
-            if ((int)diff > p->max_backtrack_stat)
+            if (diff > p->max_backtrack_stat)
             {
-                p->max_backtrack_stat =3D (int)diff;
+                p->max_backtrack_stat =3D diff;
                 packet_id_debug(D_PID_DEBUG_LOW, p, pin, "PID_ERR replay-w=
indow backtrack occurred", p->max_backtrack_stat);
             }

@@ -557,7 +557,7 @@
                       const struct packet_id_rec *p,
                       const struct packet_id_net *pin,
                       const char *message,
-                      int value)
+                      packet_id_print_type value)
 {
     struct gc_arena gc =3D gc_new();
     struct buffer out =3D alloc_buf_gc(256, &gc);
@@ -569,7 +569,7 @@
     CLEAR(tv);
     gettimeofday(&tv, NULL);

-    buf_printf(&out, "%s [%d]", message, value);
+    buf_printf(&out, "%s [" packet_id_format "]", message, value);
     buf_printf(&out, " [%s-%d] [", p->name, p->unit);
     for (i =3D 0; sl !=3D NULL && i < sl->x_size; ++i)
     {
@@ -604,17 +604,17 @@
         }
         buf_printf(&out, "%c", c);
     }
-    buf_printf(&out, "] %" PRIi64 ":" packet_id_format, (int64_t)p->time, =
(packet_id_print_type)p->id);
+    buf_printf(&out, "] %" PRIi64 ":" packet_id_format, (int64_t)p->time, =
p->id);
     if (pin)
     {
-        buf_printf(&out, " %" PRIi64 ":" packet_id_format, (int64_t)pin->t=
ime, (packet_id_print_type)pin->id);
+        buf_printf(&out, " %" PRIi64 ":" packet_id_format, (int64_t)pin->t=
ime, pin->id);
     }

     buf_printf(&out, " t=3D%" PRIi64 "[%d]",
                (int64_t)prev_now,
                (int)(prev_now - tv.tv_sec));

-    buf_printf(&out, " r=3D[%d,%d,%d,%d,%d]",
+    buf_printf(&out, " r=3D[%d,%" PRIu64 ",%d,%" PRIu64 ",%d]",
                (int)(p->last_reap - tv.tv_sec),
                p->seq_backtrack,
                p->time_backtrack,
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 3778d19..d8a3e1a 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -35,11 +35,13 @@
 #include "error.h"
 #include "otime.h"

-#if 1
 /*
- * These are the types that members of
- * a struct packet_id_net are converted
- * to for network transmission.
+ * These are the types that members of a struct packet_id_net are converted
+ * to for network transmission and for saving to a persistent file.
+ *
+ * Note: data epoch data uses a 64 bit packet ID
+ * compromised of 16 bit epoch and 48 bit per-epoch packet counter.
+ * These are ephemeral and are never saved to a file.
  */
 typedef uint32_t packet_id_type;
 #define PACKET_ID_MAX UINT32_MAX
@@ -64,31 +66,12 @@
 /* convert a net_time_t in network order to a time_t in host order */
 #define ntohtime(x) ((time_t)ntohl(x))

-#else  /* if 1 */
-
-/*
- * DEBUGGING ONLY.
- * Make packet_id_type and net_time_t small
- * to test wraparound logic and corner cases.
- */
-
-typedef uint8_t packet_id_type;
-typedef uint16_t net_time_t;
-
-#define PACKET_ID_WRAP_TRIGGER 0x80
-
-#define htonpid(x) (x)
-#define ntohpid(x) (x)
-#define htontime(x) htons((net_time_t)x)
-#define ntohtime(x) ((time_t)ntohs(x))
-
-#endif /* if 1 */

 /*
  * Printf formats for special types
  */
-#define packet_id_format "%u"
-typedef unsigned int packet_id_print_type;
+#define packet_id_format "%" PRIu64
+typedef uint64_t packet_id_print_type;

 /*
  * Maximum allowed backtrack in
@@ -128,10 +111,10 @@
 {
     time_t last_reap;         /* last call of packet_id_reap */
     time_t time;              /* highest time stamp received */
-    packet_id_type id;        /* highest sequence number received */
-    int seq_backtrack;        /* set from --replay-window */
+    uint64_t id;              /* highest sequence number received */
+    uint64_t seq_backtrack;   /* set from --replay-window */
     int time_backtrack;       /* set from --replay-window */
-    int max_backtrack_stat;   /* maximum backtrack seen so far */
+    uint64_t max_backtrack_stat;   /* maximum backtrack seen so far */
     bool initialized;         /* true if packet_id_init was called */
     struct seq_list *seq_list; /* packet-id "memory" */
     const char *name;
@@ -164,7 +147,7 @@
  */
 struct packet_id_send
 {
-    packet_id_type id;
+    uint64_t id;
     time_t time;
 };

@@ -174,8 +157,12 @@
  * sequence number.  A long packet-id
  * includes a timestamp as well.
  *
+ * An epoch packet-id is a 16 bit epoch
+ * counter plus a 48 per-epoch packet-id
+ *
  * Long packet-ids are used as IVs for
- * CFB/OFB ciphers.
+ * CFB/OFB ciphers and for control channel
+ * messages.
  *
  * This data structure is always sent
  * over the net in network byte order,
@@ -191,9 +178,16 @@
  * 64 bit platforms use a
  * 64 bit time_t.
  */
+
+/**
+ * Data structure for describing the packet id that is received/send to the
+ * network. This struct does not match the on wire format.
+ */
 struct packet_id_net
 {
-    packet_id_type id;
+    /* converted to packet_id_type on non-epoch data ids, does not contain
+     * the epoch but is a flat id */
+    uint64_t id;
     time_t time; /* converted to net_time_t before transmission */
 };

diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index a3567bc..d918985 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -90,8 +90,8 @@
=20
     now =3D 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, false));
-    assert(data->pis.id =3D=3D 1);
-    assert(data->pis.time =3D=3D now);
+    assert_int_equal(data->pis.id, 1);
+    assert_int_equal(data->pis.time, now);
     assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
     assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
 }
@@ -117,8 +117,8 @@
     data->test_buf.offset =3D sizeof(data->test_buf_data);
     now =3D 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, true));
-    assert(data->pis.id =3D=3D 1);
-    assert(data->pis.time =3D=3D now);
+    assert_int_equal(data->pis.id, 1);
+    assert_int_equal(data->pis.time, now);
     assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
     assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
 }
@@ -128,7 +128,8 @@
 {
     struct test_packet_id_write_data *data =3D *state;

-    data->pis.id =3D ~0;
+    /* maximum 32-bit packet id */
+    data->pis.id =3D (packet_id_type)(~0);
     assert_false(packet_id_write(&data->pis, &data->test_buf, false, false=
));
 }

@@ -137,7 +138,8 @@
 {
     struct test_packet_id_write_data *data =3D *state;

-    data->pis.id =3D ~0;
+    /* maximum 32-bit packet id */
+    data->pis.id =3D (packet_id_type)(~0);
     data->pis.time =3D 5006;

     /* Write fails if time did not change */
@@ -148,8 +150,8 @@
     now =3D 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, false));

-    assert(data->pis.id =3D=3D 1);
-    assert(data->pis.time =3D=3D now);
+    assert_int_equal(data->pis.id, 1);
+    assert_int_equal(data->pis.time, now);
     assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
     assert_true(data->test_buf_data.buf_time =3D=3D htonl((uint32_t)now));
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/802?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If470af2eb456b2b10f9f2806933e026842188c42
Gerrit-Change-Number: 802
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--zH2zn5BBGgM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/802?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Change internal id of packet id to uint64<br><br>This allows =
to get rid of multiple casts and also prepares for the<br>larger packet id =
used by epoch data format.<br><br>Change-Id: If470af2eb456b2b10f9f2806933e0=
26842188c42<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<b=
r>M src/openvpn/packet_id.c<br>M src/openvpn/packet_id.h<br>M tests/unit_te=
sts/openvpn/test_packet_id.c<br>3 files changed, 55 insertions(+), 59 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/02/802/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/packet_id.c b/src/openvpn/pac=
ket_id.c</span><br><span>index fb962e4..117c95f 100644</span><br><span>--- =
a/src/openvpn/packet_id.c</span><br><span>+++ b/src/openvpn/packet_id.c</sp=
an><br><span>@@ -36,6 +36,8 @@</span><br><span> </span><br><span> #include =
&quot;syshead.h&quot;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &lt;stddef.h&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;packet_id.h&quot=
;</span><br><span> #include &quot;misc.h&quot;</span><br><span> #include &q=
uot;integer.h&quot;</span><br><span>@@ -56,7 +58,7 @@</span><br><span>     =
                              const struct packet_id_rec *p,</span><br><spa=
n>                                   const struct packet_id_net *pin,</span=
><br><span>                                   const char *message,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
    int value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                              packet_id_print_type value);</span><br><span>=
 </span><br><span> #endif /* ENABLE_DEBUG */</span><br><span> </span><br><s=
pan>@@ -65,7 +67,7 @@</span><br><span>                 const struct packet_=
id_rec *p,</span><br><span>                 const struct packet_id_net *pin=
,</span><br><span>                 const char *message,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                int value)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                uint64_t value)</s=
pan><br><span> {</span><br><span> #ifdef ENABLE_DEBUG</span><br><span>     =
if (unlikely(check_debug_level(msglevel)))</span><br><span>@@ -115,22 +117,=
21 @@</span><br><span>     const time_t local_now =3D now;</span><br><span>=
     if (p-&gt;seq_list)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        packet_id_type diff;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        int64_t diff;</span><br><span> <=
/span><br><span>         /*</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-         * If time value increases, start a new</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * sequence number sequence.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * If time value i=
ncreases, start a new sequence number sequence.</span><br><span>          *=
/</span><br><span>         if (!CIRC_LIST_SIZE(p-&gt;seq_list)</span><br><s=
pan>             || pin-&gt;time &gt; p-&gt;time</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            || (pin-&gt;id &gt;=3D (packet_id_ty=
pe)p-&gt;seq_backtrack</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                &amp;&amp; pin-&gt;id - (packet_id_type)p-&gt;seq_backtrac=
k &gt; p-&gt;id))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          || (pin-&gt;id &gt;=3D p-&gt;seq_backtrack</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; pin-&gt;id - p=
-&gt;seq_backtrack &gt; p-&gt;id))</span><br><span>         {</span><br><sp=
an>             p-&gt;time =3D pin-&gt;time;</span><br><span>             p=
-&gt;id =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (pin-&gt;id &gt; (packet_id_type)p-&gt;seq_backtrack)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (pin-&gt;id &gt; p=
-&gt;seq_backtrack)</span><br><span>             {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                p-&gt;id =3D pin-&gt;id - (pac=
ket_id_type)p-&gt;seq_backtrack;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                p-&gt;id =3D pin-&gt;id - p-&gt;seq_backtrack;=
</span><br><span>             }</span><br><span>             CIRC_LIST_RESE=
T(p-&gt;seq_list);</span><br><span>         }</span><br><span>@@ -146,7 +14=
7,7 @@</span><br><span>         }</span><br><span> </span><br><span>       =
  diff =3D p-&gt;id - pin-&gt;id;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (diff &lt; (packet_id_type) CIRC_LIST_SIZE(p-&gt;seq=
_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (d=
iff &lt; CIRC_LIST_SIZE(p-&gt;seq_list)</span><br><span>             &amp;&=
amp; local_now &gt; SEQ_EXPIRED)</span><br><span>         {</span><br><span=
>             CIRC_LIST_ITEM(p-&gt;seq_list, diff) =3D local_now;</span><br=
><span>@@ -170,9 +171,8 @@</span><br><span>     const time_t local_now =3D =
now;</span><br><span>     if (p-&gt;time_backtrack)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><=
br><span>         bool expire =3D false;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        for (i =3D 0; i &lt; CIRC_LIST_SIZE(p-&gt;seq_li=
st); ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fo=
r (int i =3D 0; i &lt; CIRC_LIST_SIZE(p-&gt;seq_list); ++i)</span><br><span=
>         {</span><br><span>             const time_t t =3D CIRC_LIST_ITEM(=
p-&gt;seq_list, i);</span><br><span>             if (t =3D=3D SEQ_EXPIRED)<=
/span><br><span>@@ -200,7 +200,7 @@</span><br><span> packet_id_test(struct =
packet_id_rec *p,</span><br><span>                const struct packet_id_ne=
t *pin)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    packet_id_type diff;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint64_t diff;</span><br><span> </span><br><span>     packet_=
id_debug(D_PID_DEBUG, p, pin, &quot;PID_TEST&quot;, 0);</span><br><span> </=
span><br><span>@@ -231,9 +231,9 @@</span><br><span>             diff =3D p-=
&gt;id - pin-&gt;id;</span><br><span> </span><br><span>             /* keep=
 track of maximum backtrack seen for debugging purposes */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if ((int)diff &gt; p-&gt;m=
ax_backtrack_stat)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (diff &gt; p-&gt;max_backtrack_stat)</span><br><span>        =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 p-&gt;max_backtrack_stat =3D (int)diff;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                p-&gt;max_backtrack_stat =3D diff;</sp=
an><br><span>                 packet_id_debug(D_PID_DEBUG_LOW, p, pin, &quo=
t;PID_ERR replay-window backtrack occurred&quot;, p-&gt;max_backtrack_stat)=
;</span><br><span>             }</span><br><span> </span><br><span>@@ -557,=
7 +557,7 @@</span><br><span>                       const struct packet_id_r=
ec *p,</span><br><span>                       const struct packet_id_net *p=
in,</span><br><span>                       const char *message,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                      int value)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
  packet_id_print_type value)</span><br><span> {</span><br><span>     struc=
t gc_arena gc =3D gc_new();</span><br><span>     struct buffer out =3D allo=
c_buf_gc(256, &amp;gc);</span><br><span>@@ -569,7 +569,7 @@</span><br><span=
>     CLEAR(tv);</span><br><span>     gettimeofday(&amp;tv, NULL);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_prin=
tf(&amp;out, &quot;%s [%d]&quot;, message, value);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;%s [&quot; pa=
cket_id_format &quot;]&quot;, message, value);</span><br><span>     buf_pri=
ntf(&amp;out, &quot; [%s-%d] [&quot;, p-&gt;name, p-&gt;unit);</span><br><s=
pan>     for (i =3D 0; sl !=3D NULL &amp;&amp; i &lt; sl-&gt;x_size; ++i)</=
span><br><span>     {</span><br><span>@@ -604,17 +604,17 @@</span><br><span=
>         }</span><br><span>         buf_printf(&amp;out, &quot;%c&quot;, c=
);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    buf_printf(&amp;out, &quot;] %&quot; PRIi64 &quot;:&quot; packet_id=
_format, (int64_t)p-&gt;time, (packet_id_print_type)p-&gt;id);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;]=
 %&quot; PRIi64 &quot;:&quot; packet_id_format, (int64_t)p-&gt;time, p-&gt;=
id);</span><br><span>     if (pin)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot; %&q=
uot; PRIi64 &quot;:&quot; packet_id_format, (int64_t)pin-&gt;time, (packet_=
id_print_type)pin-&gt;id);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        buf_printf(&amp;out, &quot; %&quot; PRIi64 &quot;:&quot; pac=
ket_id_format, (int64_t)pin-&gt;time, pin-&gt;id);</span><br><span>     }</=
span><br><span> </span><br><span>     buf_printf(&amp;out, &quot; t=3D%&quo=
t; PRIi64 &quot;[%d]&quot;,</span><br><span>                (int64_t)prev_n=
ow,</span><br><span>                (int)(prev_now - tv.tv_sec));</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_print=
f(&amp;out, &quot; r=3D[%d,%d,%d,%d,%d]&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot; r=3D[%d,%&quot; =
PRIu64 &quot;,%d,%&quot; PRIu64 &quot;,%d]&quot;,</span><br><span>         =
       (int)(p-&gt;last_reap - tv.tv_sec),</span><br><span>                =
p-&gt;seq_backtrack,</span><br><span>                p-&gt;time_backtrack,<=
/span><br><span>diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_i=
d.h</span><br><span>index 3778d19..d8a3e1a 100644</span><br><span>--- a/src=
/openvpn/packet_id.h</span><br><span>+++ b/src/openvpn/packet_id.h</span><b=
r><span>@@ -35,11 +35,13 @@</span><br><span> #include &quot;error.h&quot;</=
span><br><span> #include &quot;otime.h&quot;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if 1</span><br><span> /*</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * These are the types that me=
mbers of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * a struct p=
acket_id_net are converted</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * to for network transmission.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * These are the types that members of a struct packet_id_=
net are converted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 to for network transmission and for saving to a persistent file.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Note: data epoch data uses a 64 bit packet =
ID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * compromised of=
 16 bit epoch and 48 bit per-epoch packet counter.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * These are ephemeral and are never saved t=
o a file.</span><br><span>  */</span><br><span> typedef uint32_t packet_id_=
type;</span><br><span> #define PACKET_ID_MAX UINT32_MAX</span><br><span>@@ =
-64,31 +66,12 @@</span><br><span> /* convert a net_time_t in network order =
to a time_t in host order */</span><br><span> #define ntohtime(x) ((time_t)=
ntohl(x))</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#else  /* if 1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * DEBUGGING ONLY.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Make packet_id_type and net_time_t sma=
ll</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * to test wraparou=
nd logic and corner cases.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-typedef uint8_t packet_id_type;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef uint16_t net_tim=
e_t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define PACKET_ID_WRAP_TRIGGER 0x80</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define htonpid(x) (x)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define ntohpid(x) (x)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define htontime(x) htons((net_time_t)x)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define ntohtime(x) ((=
time_t)ntohs(x))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if 1 */</span><b=
r><span> </span><br><span> /*</span><br><span>  * Printf formats for specia=
l types</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define packet_id_format &quot;%u&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-typedef unsigned int packet_id_print_type;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define packet_id_format &q=
uot;%&quot; PRIu64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
ypedef uint64_t packet_id_print_type;</span><br><span> </span><br><span> /*=
</span><br><span>  * Maximum allowed backtrack in</span><br><span>@@ -128,1=
0 +111,10 @@</span><br><span> {</span><br><span>     time_t last_reap;     =
    /* last call of packet_id_reap */</span><br><span>     time_t time;    =
          /* highest time stamp received */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    packet_id_type id;        /* highest sequence num=
ber received */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t seq_backtrack;        /* set from --replay-window */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint64_t id;              /* highest=
 sequence number received */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint64_t seq_backtrack;   /* set from --replay-window */</span=
><br><span>     int time_backtrack;       /* set from --replay-window */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int max_backtrack_st=
at;   /* maximum backtrack seen so far */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint64_t max_backtrack_stat;   /* maximum backtra=
ck seen so far */</span><br><span>     bool initialized;         /* true if=
 packet_id_init was called */</span><br><span>     struct seq_list *seq_lis=
t; /* packet-id &quot;memory&quot; */</span><br><span>     const char *name=
;</span><br><span>@@ -164,7 +147,7 @@</span><br><span>  */</span><br><span>=
 struct packet_id_send</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    packet_id_type id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint64_t id;</span><br><span>     time_t time;</=
span><br><span> };</span><br><span> </span><br><span>@@ -174,8 +157,12 @@</=
span><br><span>  * sequence number.  A long packet-id</span><br><span>  * i=
ncludes a timestamp as well.</span><br><span>  *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * An epoch packet-id is a 16 bit epoch</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * counter plus a 48 per-e=
poch packet-id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span>  * Long packet-ids are used as IVs for</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * CFB/OFB ciphers.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * CFB/OFB ciphers and for control channe=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * messages.</span=
><br><span>  *</span><br><span>  * This data structure is always sent</span=
><br><span>  * over the net in network byte order,</span><br><span>@@ -191,=
9 +178,16 @@</span><br><span>  * 64 bit platforms use a</span><br><span>  *=
 64 bit time_t.</span><br><span>  */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Data structure =
for describing the packet id that is received/send to the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * network. This struct does not matc=
h the on wire format.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span> struct packet_id_net</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    packet_id_type id;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* converted to packet_id_t=
ype on non-epoch data ids, does not contain</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * the epoch but is a flat id */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint64_t id;</span><br><span> =
    time_t time; /* converted to net_time_t before transmission */</span><b=
r><span> };</span><br><span> </span><br><span>diff --git a/tests/unit_tests=
/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c</span=
><br><span>index a3567bc..d918985 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/test_packet_id.c</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_packet_id.c</span><br><span>@@ -90,8 +90,8 @@</span><br><span> </spa=
n><br><span>     now =3D 5010;</span><br><span>     assert_true(packet_id_w=
rite(&amp;data-&gt;pis, &amp;data-&gt;test_buf, true, false));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    assert(data-&gt;pis.id =3D=3D =
1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert(data-&g=
t;pis.time =3D=3D now);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(data-&gt;pis.id, 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;pis.time, now);</sp=
an><br><span>     assert_true(data-&gt;test_buf_data.buf_id =3D=3D htonl(1)=
);</span><br><span>     assert_true(data-&gt;test_buf_data.buf_time =3D=3D =
htonl((uint32_t)now));</span><br><span> }</span><br><span>@@ -117,8 +117,8 =
@@</span><br><span>     data-&gt;test_buf.offset =3D sizeof(data-&gt;test_b=
uf_data);</span><br><span>     now =3D 5010;</span><br><span>     assert_tr=
ue(packet_id_write(&amp;data-&gt;pis, &amp;data-&gt;test_buf, true, true));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert(data-&gt;p=
is.id =3D=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a=
ssert(data-&gt;pis.time =3D=3D now);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(data-&gt;pis.id, 1);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;pis.ti=
me, now);</span><br><span>     assert_true(data-&gt;test_buf_data.buf_id =
=3D=3D htonl(1));</span><br><span>     assert_true(data-&gt;test_buf_data.b=
uf_time =3D=3D htonl((uint32_t)now));</span><br><span> }</span><br><span>@@=
 -128,7 +128,8 @@</span><br><span> {</span><br><span>     struct test_packe=
t_id_write_data *data =3D *state;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    data-&gt;pis.id =3D ~0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* maximum 32-bit packet id */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    data-&gt;pis.id =
=3D (packet_id_type)(~0);</span><br><span>     assert_false(packet_id_write=
(&amp;data-&gt;pis, &amp;data-&gt;test_buf, false, false));</span><br><span=
> }</span><br><span> </span><br><span>@@ -137,7 +138,8 @@</span><br><span> =
{</span><br><span>     struct test_packet_id_write_data *data =3D *state;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    d=
ata-&gt;pis.id =3D ~0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* maximum 32-bit packet id */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    data-&gt;pis.id =3D (packet_id_type)(~0);</span><br><=
span>     data-&gt;pis.time =3D 5006;</span><br><span> </span><br><span>   =
  /* Write fails if time did not change */</span><br><span>@@ -148,8 +150,8=
 @@</span><br><span>     now =3D 5010;</span><br><span>     assert_true(pac=
ket_id_write(&amp;data-&gt;pis, &amp;data-&gt;test_buf, true, false));</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asse=
rt(data-&gt;pis.id =3D=3D 1);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    assert(data-&gt;pis.time =3D=3D now);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(data-&gt;pis.id, 1);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(da=
ta-&gt;pis.time, now);</span><br><span>     assert_true(data-&gt;test_buf_d=
ata.buf_id =3D=3D htonl(1));</span><br><span>     assert_true(data-&gt;test=
_buf_data.buf_time =3D=3D htonl((uint32_t)now));</span><br><span> }</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/802?usp=3Demail">change 802</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/802?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If470af2eb456b2b10f9f2806933=
e026842188c42 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 802 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--zH2zn5BBGgM=--

