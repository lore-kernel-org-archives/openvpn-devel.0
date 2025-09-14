From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 14 Sep 2025 17:38:11 +0000
In-Reply-To: <gerrit.1753360288000.I0272b709b907545de05bfded03a649b259ce5af6@...2715...>
References: <gerrit.1753360288000.I0272b709b907545de05bfded03a649b259ce5af6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <25439c251aac87ca22e6918cbcdec5c5912565e0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f+8RLeNaJ5A="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: events: Make sure
 rwflags are treated as unsigned
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

--f+8RLeNaJ5A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
07?usp=3Demail )

Change subject: events: Make sure rwflags are treated as unsigned
......................................................................

events: Make sure rwflags are treated as unsigned

event_set_return.rwflags is already unsigned, make sure the
flags are as well to avoid spurious conversion warnings.

Requires to change rwflags in proxy_connection struct as
well since those use the same flags.

Change-Id: I0272b709b907545de05bfded03a649b259ce5af6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
URL: https://gerrit.openvpn.net/c/openvpn/+/1107
Message-Id: <20250914135128.19621-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
918.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/event.h
M src/openvpn/ps.c
2 files changed, 10 insertions(+), 9 deletions(-)




diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 8422996..8a89a25 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -35,8 +35,8 @@
 #define WRITE_SHIFT 1

 #define EVENT_UNDEF 4
-#define EVENT_READ  (1 << READ_SHIFT)
-#define EVENT_WRITE (1 << WRITE_SHIFT)
+#define EVENT_READ  (1u << READ_SHIFT)
+#define EVENT_WRITE (1u << WRITE_SHIFT)

 /* event flags returned by io_wait.
  *
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index e95a33b..a10df2e 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -70,7 +70,7 @@
     struct proxy_connection *counterpart;
     struct buffer buf;
     bool buffer_initial;
-    int rwflags;
+    unsigned int rwflags;
     int sd;
     char *jfn;
 };
@@ -387,12 +387,12 @@
 }

 static inline void
-proxy_connection_io_requeue(struct proxy_connection *pc, const int rwflags=
_new,
+proxy_connection_io_requeue(struct proxy_connection *pc, const unsigned in=
t rwflags_new,
                             struct event_set *es)
 {
     if (socket_defined(pc->sd) && pc->rwflags !=3D rwflags_new)
     {
-        /*dmsg (D_PS_PROXY_DEBUG, "PORT SHARE PROXY: requeue[%d] rwflags=
=3D%d", (int)pc->sd,
+        /*dmsg (D_PS_PROXY_DEBUG, "PORT SHARE PROXY: requeue[%d] rwflags=
=3D%u", (int)pc->sd,
          * rwflags_new);*/
         event_ctl(es, pc->sd, rwflags_new, (void *)pc);
         pc->rwflags =3D rwflags_new;
@@ -652,7 +652,7 @@
  * Decide how the receipt of an EAGAIN status should affect our next IO qu=
eueing.
  */
 static bool
-proxy_connection_io_status(const int status, int *rwflags_pc, int *rwflags=
_cp)
+proxy_connection_io_status(const int status, unsigned int *rwflags_pc, uns=
igned int *rwflags_cp)
 {
     switch (status)
     {
@@ -683,12 +683,13 @@
  * in the proxied connection.
  */
 static int
-proxy_connection_io_dispatch(struct proxy_connection *pc, const int rwflag=
s, struct event_set *es)
+proxy_connection_io_dispatch(struct proxy_connection *pc, const unsigned i=
nt rwflags,
+                             struct event_set *es)
 {
     const int max_transfer_per_iteration =3D 10000;
     struct proxy_connection *cp =3D pc->counterpart;
-    int rwflags_pc =3D pc->rwflags;
-    int rwflags_cp =3D cp->rwflags;
+    unsigned int rwflags_pc =3D pc->rwflags;
+    unsigned int rwflags_cp =3D cp->rwflags;

     ASSERT(pc->defined && cp->defined && cp->counterpart =3D=3D pc);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0272b709b907545de05bfded03a649b259ce5af6
Gerrit-Change-Number: 1107
Gerrit-PatchSet: 11
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--f+8RLeNaJ5A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1107?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">events: Make sure rwflags are treated as unsi=
gned<br><br>event_set_return.rwflags is already unsigned, make sure the<br>=
flags are as well to avoid spurious conversion warnings.<br><br>Requires to=
 change rwflags in proxy_connection struct as<br>well since those use the s=
ame flags.<br><br>Change-Id: I0272b709b907545de05bfded03a649b259ce5af6<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert =
Doering &lt;gert@...1296...&gt;<br>URL: https://gerrit.openvpn.net/c/openvp=
n/+/1107<br>Message-Id: &lt;20250914135128.19621-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg329=
18.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpn/event.h<br>M src/openvpn/ps.c<br>2 files changed, 10 insertions=
(+), 9 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span>i=
ndex 8422996..8a89a25 100644</span><br><span>--- a/src/openvpn/event.h</spa=
n><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ -35,8 +35,8 @@</sp=
an><br><span> #define WRITE_SHIFT 1</span><br><span> </span><br><span> #def=
ine EVENT_UNDEF 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine EVENT_READ  (1 &lt;&lt; READ_SHIFT)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define EVENT_WRITE (1 &lt;&lt; WRITE_SHIFT)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define EVENT_READ  (1u &lt;&lt;=
 READ_SHIFT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 EVENT_WRITE (1u &lt;&lt; WRITE_SHIFT)</span><br><span> </span><br><span> /=
* event flags returned by io_wait.</span><br><span>  *</span><br><span>diff=
 --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><span>index e95a33b.=
.a10df2e 100644</span><br><span>--- a/src/openvpn/ps.c</span><br><span>+++ =
b/src/openvpn/ps.c</span><br><span>@@ -70,7 +70,7 @@</span><br><span>     s=
truct proxy_connection *counterpart;</span><br><span>     struct buffer buf=
;</span><br><span>     bool buffer_initial;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int rwflags;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    unsigned int rwflags;</span><br><span>     int sd;</=
span><br><span>     char *jfn;</span><br><span> };</span><br><span>@@ -387,=
12 +387,12 @@</span><br><span> }</span><br><span> </span><br><span> static =
inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-proxy_conn=
ection_io_requeue(struct proxy_connection *pc, const int rwflags_new,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_connection_io_reque=
ue(struct proxy_connection *pc, const unsigned int rwflags_new,</span><br><=
span>                             struct event_set *es)</span><br><span> {<=
/span><br><span>     if (socket_defined(pc-&gt;sd) &amp;&amp; pc-&gt;rwflag=
s !=3D rwflags_new)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /*dmsg (D_PS_PROXY_DEBUG, &quot;PORT SHARE PRO=
XY: requeue[%d] rwflags=3D%d&quot;, (int)pc-&gt;sd,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /*dmsg (D_PS_PROXY_DEBUG, &quot;P=
ORT SHARE PROXY: requeue[%d] rwflags=3D%u&quot;, (int)pc-&gt;sd,</span><br>=
<span>          * rwflags_new);*/</span><br><span>         event_ctl(es, pc=
-&gt;sd, rwflags_new, (void *)pc);</span><br><span>         pc-&gt;rwflags =
=3D rwflags_new;</span><br><span>@@ -652,7 +652,7 @@</span><br><span>  * De=
cide how the receipt of an EAGAIN status should affect our next IO queueing=
.</span><br><span>  */</span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-proxy_connection_io_status(const int status=
, int *rwflags_pc, int *rwflags_cp)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+proxy_connection_io_status(const int status, unsigned int *=
rwflags_pc, unsigned int *rwflags_cp)</span><br><span> {</span><br><span>  =
   switch (status)</span><br><span>     {</span><br><span>@@ -683,12 +683,1=
3 @@</span><br><span>  * in the proxied connection.</span><br><span>  */</s=
pan><br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-proxy_connection_io_dispatch(struct proxy_connection *pc, const int rwf=
lags, struct event_set *es)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+proxy_connection_io_dispatch(struct proxy_connection *pc, const uns=
igned int rwflags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                            struct event_set *es)</span><br><span> {</span>=
<br><span>     const int max_transfer_per_iteration =3D 10000;</span><br><s=
pan>     struct proxy_connection *cp =3D pc-&gt;counterpart;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    int rwflags_pc =3D pc-&gt;rwflag=
s;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int rwflags_cp =
=3D cp-&gt;rwflags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    unsigned int rwflags_pc =3D pc-&gt;rwflags;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    unsigned int rwflags_cp =3D cp-&gt;rwflags;=
</span><br><span> </span><br><span>     ASSERT(pc-&gt;defined &amp;&amp; cp=
-&gt;defined &amp;&amp; cp-&gt;counterpart =3D=3D pc);</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1107?usp=3Demail">change 1107</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1107?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0272b709b907545de05bfded03a=
649b259ce5af6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1107 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--f+8RLeNaJ5A=--

