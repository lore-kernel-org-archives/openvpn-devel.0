From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 14:45:50 +0000
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2e251ec239bbcd3e7b7d641b1bd6ebc4d0c5b2c2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P1iD6T/9DA0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: packet_id: Avoid
 conversion warnings
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

--P1iD6T/9DA0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1407?usp=3Demail

to review the following change.


Change subject: packet_id: Avoid conversion warnings
......................................................................

packet_id: Avoid conversion warnings

Most of these already have checks that the
values are as expected, so we can just add
the required casts.

Only the circ list x_sizeof is changed to
size_t since that is its purpose (and it is
not actually used anyway).

Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/circ_list.h
M src/openvpn/packet_id.c
M src/openvpn/packet_id.h
3 files changed, 21 insertions(+), 37 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1407/1

diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index eebf087..12f2bea 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -33,7 +33,7 @@
         int x_head;           \
         int x_size;           \
         int x_cap;            \
-        int x_sizeof;         \
+        size_t x_sizeof;      \
         type x_list[];        \
     }

@@ -58,14 +58,14 @@
         (obj)->x_size =3D 0;   \
     }

-#define CIRC_LIST_ALLOC(dest, list_type, size)                            =
     \
-    {                                                                     =
     \
-        const int so =3D sizeof(list_type) + sizeof((dest)->x_list[0]) * (=
size); \
-        (dest) =3D (list_type *)malloc(so);                               =
       \
-        check_malloc_return(dest);                                        =
     \
-        memset((dest), 0, so);                                            =
     \
-        (dest)->x_cap =3D size;                                           =
       \
-        (dest)->x_sizeof =3D so;                                          =
       \
+#define CIRC_LIST_ALLOC(dest, list_type, size)                            =
        \
+    {                                                                     =
        \
+        const size_t so =3D sizeof(list_type) + sizeof((dest)->x_list[0]) =
* (size); \
+        (dest) =3D (list_type *)malloc(so);                               =
          \
+        check_malloc_return(dest);                                        =
        \
+        memset((dest), 0, so);                                            =
        \
+        (dest)->x_cap =3D size;                                           =
          \
+        (dest)->x_sizeof =3D so;                                          =
          \
     }

 #define CIRC_LIST_FREE(dest) free(dest)
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 08d9d9b..12525d1 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -71,11 +71,6 @@
 #endif
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack, int time=
_backtrack,
                     const char *name, int unit)
@@ -119,7 +114,7 @@

     /* Reinitalise the source */
     CLEAR(*src);
-    packet_id_init_recv(src, dest->seq_backtrack, dest->time_backtrack, de=
st->name, dest->unit);
+    packet_id_init_recv(src, (int)dest->seq_backtrack, dest->time_backtrac=
k, dest->name, dest->unit);
 }

 void
@@ -170,7 +165,7 @@
         diff =3D p->id - pin->id;
         if (diff < CIRC_LIST_SIZE(p->seq_list) && local_now > SEQ_EXPIRED)
         {
-            CIRC_LIST_ITEM(p->seq_list, diff) =3D local_now;
+            CIRC_LIST_ITEM(p->seq_list, (int)diff) =3D local_now;
         }
     }
     else
@@ -264,7 +259,7 @@
             }

             {
-                const time_t v =3D CIRC_LIST_ITEM(p->seq_list, diff);
+                const time_t v =3D CIRC_LIST_ITEM(p->seq_list, (int)diff);
                 if (v =3D=3D 0)
                 {
                     return true;
@@ -386,7 +381,7 @@
         return false;
     }

-    const packet_id_type net_id =3D htonpid(p->id);
+    const packet_id_type net_id =3D htonpid((packet_id_type)p->id);
     const net_time_t net_time =3D htontime(p->time);
     if (prepend)
     {
@@ -640,7 +635,7 @@
                p->seq_backtrack, p->time_backtrack, p->max_backtrack_stat,=
 (int)p->initialized);
     if (sl !=3D NULL)
     {
-        buf_printf(&out, " sl=3D[%d,%d,%d,%d]", sl->x_head, sl->x_size, sl=
->x_cap, sl->x_sizeof);
+        buf_printf(&out, " sl=3D[%d,%d,%d,%zu]", sl->x_head, sl->x_size, s=
l->x_cap, sl->x_sizeof);
     }


@@ -655,7 +650,6 @@
 {
     uint64_t packet_id;

-
     if (!buf_read(buf, &packet_id, sizeof(packet_id)))
     {
         return 0;
@@ -663,16 +657,12 @@

     uint64_t id =3D ntohll(packet_id);
     /* top most 16 bits */
-    uint16_t epoch =3D id >> 48;
+    uint16_t epoch =3D (uint16_t)(id >> 48);

     pin->id =3D id & PACKET_ID_MASK;
     return epoch;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 packet_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buf=
fer *buf)
 {
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index e9d3647..cdc734d 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -280,26 +280,20 @@
     return p->fd >=3D 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-/* transfer packet_id -> packet_id_persist */
+/* transfer packet_id -> packet_id_persist
+   Note: Only supported for non-epoch format (i.e. 32bit ID, not 64bit for=
mat),
+   must be enforced at the caller.
+ */
 static inline void
 packet_id_persist_save_obj(struct packet_id_persist *p, const struct packe=
t_id *pid)
 {
-    if (packet_id_persist_enabled(p) && pid->rec.time)
+    if (packet_id_persist_enabled(p) && pid->rec.time && pid->rec.id <=3D =
PACKET_ID_MAX)
     {
         p->time =3D pid->rec.time;
-        p->id =3D pid->rec.id;
+        p->id =3D (packet_id_type)pid->rec.id;
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Reset the current send packet id to its initial state.
  * Use very carefully (e.g. in the standalone reset packet context) to

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1407?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
Gerrit-Change-Number: 1407
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--P1iD6T/9DA0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1407?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">packet_id: Avoid conversion warnings<br><br=
>Most of these already have checks that the<br>values are as expected, so w=
e can just add<br>the required casts.<br><br>Only the circ list x_sizeof is=
 changed to<br>size_t since that is its purpose (and it is<br>not actually =
used anyway).<br><br>Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src=
/openvpn/circ_list.h<br>M src/openvpn/packet_id.c<br>M src/openvpn/packet_i=
d.h<br>3 files changed, 21 insertions(+), 37 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1=
407/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.=
h</span><br><span>index eebf087..12f2bea 100644</span><br><span>--- a/src/o=
penvpn/circ_list.h</span><br><span>+++ b/src/openvpn/circ_list.h</span><br>=
<span>@@ -33,7 +33,7 @@</span><br><span>         int x_head;           \</s=
pan><br><span>         int x_size;           \</span><br><span>         int=
 x_cap;            \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       int x_sizeof;         \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        size_t x_sizeof;      \</span><br><span>         type x_=
list[];        \</span><br><span>     }</span><br><span> </span><br><span>@=
@ -58,14 +58,14 @@</span><br><span>         (obj)-&gt;x_size =3D 0;   \</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define CIRC_LIST_ALLOC(dest, list_type, size)             =
                    \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {                                                                      =
    \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const in=
t so =3D sizeof(list_type) + sizeof((dest)-&gt;x_list[0]) * (size); \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        (dest) =3D (list_ty=
pe *)malloc(so);                                      \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        check_malloc_return(dest);       =
                                      \</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        memset((dest), 0, so);                           =
                      \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        (dest)-&gt;x_cap =3D size;                                       =
           \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (=
dest)-&gt;x_sizeof =3D so;                                                 =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CIRC_LIST_=
ALLOC(dest, list_type, size)                                    \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {                        =
                                                     \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        const size_t so =3D sizeof(list_=
type) + sizeof((dest)-&gt;x_list[0]) * (size); \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        (dest) =3D (list_type *)malloc(so);   =
                                      \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        check_malloc_return(dest);                     =
                           \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        memset((dest), 0, so);                                    =
                \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      (dest)-&gt;x_cap =3D size;                                           =
          \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
(dest)-&gt;x_sizeof =3D so;                                                =
    \</span><br><span>     }</span><br><span> </span><br><span> #define CIR=
C_LIST_FREE(dest) free(dest)</span><br><span>diff --git a/src/openvpn/packe=
t_id.c b/src/openvpn/packet_id.c</span><br><span>index 08d9d9b..12525d1 100=
644</span><br><span>--- a/src/openvpn/packet_id.c</span><br><span>+++ b/src=
/openvpn/packet_id.c</span><br><span>@@ -71,11 +71,6 @@</span><br><span> #e=
ndif</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic igno=
red &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> static void</span><br><span> packet_id_init_recv(struct packet_id=
_rec *rec, int seq_backtrack, int time_backtrack,</span><br><span>         =
            const char *name, int unit)</span><br><span>@@ -119,7 +114,7 @@=
</span><br><span> </span><br><span>     /* Reinitalise the source */</span>=
<br><span>     CLEAR(*src);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    packet_id_init_recv(src, dest-&gt;seq_backtrack, dest-&gt;time_ba=
cktrack, dest-&gt;name, dest-&gt;unit);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    packet_id_init_recv(src, (int)dest-&gt;seq_backtrac=
k, dest-&gt;time_backtrack, dest-&gt;name, dest-&gt;unit);</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span>@@ -170,7 +165,7=
 @@</span><br><span>         diff =3D p-&gt;id - pin-&gt;id;</span><br><spa=
n>         if (diff &lt; CIRC_LIST_SIZE(p-&gt;seq_list) &amp;&amp; local_no=
w &gt; SEQ_EXPIRED)</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            CIRC_LIST_ITEM(p-&gt;seq_list, diff) =
=3D local_now;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       CIRC_LIST_ITEM(p-&gt;seq_list, (int)diff) =3D local_now;</span><br><=
span>         }</span><br><span>     }</span><br><span>     else</span><br>=
<span>@@ -264,7 +259,7 @@</span><br><span>             }</span><br><span> <=
/span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                const time_t v =3D CIRC_LIST_ITEM(p-&gt;seq_list, =
diff);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   const time_t v =3D CIRC_LIST_ITEM(p-&gt;seq_list, (int)diff);</span><br>=
<span>                 if (v =3D=3D 0)</span><br><span>                 {</=
span><br><span>                     return true;</span><br><span>@@ -386,7 =
+381,7 @@</span><br><span>         return false;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st packet_id_type net_id =3D htonpid(p-&gt;id);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const packet_id_type net_id =3D htonpid((pa=
cket_id_type)p-&gt;id);</span><br><span>     const net_time_t net_time =3D =
htontime(p-&gt;time);</span><br><span>     if (prepend)</span><br><span>   =
  {</span><br><span>@@ -640,7 +635,7 @@</span><br><span>                p-&=
gt;seq_backtrack, p-&gt;time_backtrack, p-&gt;max_backtrack_stat, (int)p-&g=
t;initialized);</span><br><span>     if (sl !=3D NULL)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(=
&amp;out, &quot; sl=3D[%d,%d,%d,%d]&quot;, sl-&gt;x_head, sl-&gt;x_size, sl=
-&gt;x_cap, sl-&gt;x_sizeof);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        buf_printf(&amp;out, &quot; sl=3D[%d,%d,%d,%zu]&quot;, sl=
-&gt;x_head, sl-&gt;x_size, sl-&gt;x_cap, sl-&gt;x_sizeof);</span><br><span=
>     }</span><br><span> </span><br><span> </span><br><span>@@ -655,7 +650,=
6 @@</span><br><span> {</span><br><span>     uint64_t packet_id;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>     if (!buf_read(buf, &amp;packet_id, sizeof(packet_id)))</span><br><s=
pan>     {</span><br><span>         return 0;</span><br><span>@@ -663,16 +6=
57,12 @@</span><br><span> </span><br><span>     uint64_t id =3D ntohll(pack=
et_id);</span><br><span>     /* top most 16 bits */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint16_t epoch =3D id &gt;&gt; 48;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t epoch =3D (=
uint16_t)(id &gt;&gt; 48);</span><br><span> </span><br><span>     pin-&gt;i=
d =3D id &amp; PACKET_ID_MASK;</span><br><span>     return epoch;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> bool</span><br><span> packet_id_write_e=
poch(struct packet_id_send *p, uint16_t epoch, struct buffer *buf)</span><b=
r><span> {</span><br><span>diff --git a/src/openvpn/packet_id.h b/src/openv=
pn/packet_id.h</span><br><span>index e9d3647..cdc734d 100644</span><br><spa=
n>--- a/src/openvpn/packet_id.h</span><br><span>+++ b/src/openvpn/packet_id=
.h</span><br><span>@@ -280,26 +280,20 @@</span><br><span>     return p-&gt;=
fd &gt;=3D 0;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* transfer packet_i=
d -&gt; packet_id_persist */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* transfer packet_id -&gt; packet_id_persist</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+   Note: Only supported for non-epoch fo=
rmat (i.e. 32bit ID, not 64bit format),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+   must be enforced at the caller.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline void<=
/span><br><span> packet_id_persist_save_obj(struct packet_id_persist *p, co=
nst struct packet_id *pid)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (packet_id_persist_enabled(p) &amp;&amp; pid=
-&gt;rec.time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (packet_id_persist_enabled(p) &amp;&amp; pid-&gt;rec.time &amp;&amp; pid-=
&gt;rec.id &lt;=3D PACKET_ID_MAX)</span><br><span>     {</span><br><span>  =
       p-&gt;time =3D pid-&gt;rec.time;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        p-&gt;id =3D pid-&gt;rec.id;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        p-&gt;id =3D (packet_id_type)pid=
-&gt;rec.id;</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> /**</span><br><span>  * Reset the current send packet id to its initi=
al state.</span><br><span>  * Use very carefully (e.g. in the standalone re=
set packet context) to</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1407?usp=3Demail">change 14=
07</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1407?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9c=
b0e6f5eb901ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1407 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--P1iD6T/9DA0=--

