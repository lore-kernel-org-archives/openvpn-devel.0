From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 14 Sep 2025 17:38:09 +0000
In-Reply-To: <gerrit.1753360288000.I0272b709b907545de05bfded03a649b259ce5af6@...2715...>
References: <gerrit.1753360288000.I0272b709b907545de05bfded03a649b259ce5af6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <25439c251aac87ca22e6918cbcdec5c5912565e0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oRJaJbeWKbs="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oRJaJbeWKbs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#11) to the change originally created b=
y flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1107/11

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
Gerrit-MessageType: newpatchset

--oRJaJbeWKbs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #11</strong> to the change originally c=
reated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1107?usp=3Demail">View Change</a></p><p>The following approvals got out=
dated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">events: Make sure rwflags are treated as unsigned<br=
><br>event_set_return.rwflags is already unsigned, make sure the<br>flags a=
re as well to avoid spurious conversion warnings.<br><br>Requires to change=
 rwflags in proxy_connection struct as<br>well since those use the same fla=
gs.<br><br>Change-Id: I0272b709b907545de05bfded03a649b259ce5af6<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>URL: https://gerrit.openvpn.net/c/openvpn/+/110=
7<br>Message-Id: &lt;20250914135128.19621-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32918.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/ope=
nvpn/event.h<br>M src/openvpn/ps.c<br>2 files changed, 10 insertions(+), 9 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/07/1107/11</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/event.h b/src/openvpn/=
event.h</span><br><span>index 8422996..8a89a25 100644</span><br><span>--- a=
/src/openvpn/event.h</span><br><span>+++ b/src/openvpn/event.h</span><br><s=
pan>@@ -35,8 +35,8 @@</span><br><span> #define WRITE_SHIFT 1</span><br><spa=
n> </span><br><span> #define EVENT_UNDEF 4</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define EVENT_READ  (1 &lt;&lt; READ_SHIFT)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define EVENT_WRITE (1 &lt;&lt; =
WRITE_SHIFT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 EVENT_READ  (1u &lt;&lt; READ_SHIFT)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define EVENT_WRITE (1u &lt;&lt; WRITE_SHIFT)</span><br><=
span> </span><br><span> /* event flags returned by io_wait.</span><br><span=
>  *</span><br><span>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span=
><br><span>index e95a33b..a10df2e 100644</span><br><span>--- a/src/openvpn/=
ps.c</span><br><span>+++ b/src/openvpn/ps.c</span><br><span>@@ -70,7 +70,7 =
@@</span><br><span>     struct proxy_connection *counterpart;</span><br><sp=
an>     struct buffer buf;</span><br><span>     bool buffer_initial;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int rwflags;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int rwflags;</span=
><br><span>     int sd;</span><br><span>     char *jfn;</span><br><span> };=
</span><br><span>@@ -387,12 +387,12 @@</span><br><span> }</span><br><span> =
</span><br><span> static inline void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-proxy_connection_io_requeue(struct proxy_connection *pc, con=
st int rwflags_new,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
proxy_connection_io_requeue(struct proxy_connection *pc, const unsigned int=
 rwflags_new,</span><br><span>                             struct event_set=
 *es)</span><br><span> {</span><br><span>     if (socket_defined(pc-&gt;sd)=
 &amp;&amp; pc-&gt;rwflags !=3D rwflags_new)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /*dmsg (D_PS_PROXY_DE=
BUG, &quot;PORT SHARE PROXY: requeue[%d] rwflags=3D%d&quot;, (int)pc-&gt;sd=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*dmsg (D_=
PS_PROXY_DEBUG, &quot;PORT SHARE PROXY: requeue[%d] rwflags=3D%u&quot;, (in=
t)pc-&gt;sd,</span><br><span>          * rwflags_new);*/</span><br><span>  =
       event_ctl(es, pc-&gt;sd, rwflags_new, (void *)pc);</span><br><span> =
        pc-&gt;rwflags =3D rwflags_new;</span><br><span>@@ -652,7 +652,7 @@=
</span><br><span>  * Decide how the receipt of an EAGAIN status should affe=
ct our next IO queueing.</span><br><span>  */</span><br><span> static bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-proxy_connection_io_st=
atus(const int status, int *rwflags_pc, int *rwflags_cp)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+proxy_connection_io_status(const int s=
tatus, unsigned int *rwflags_pc, unsigned int *rwflags_cp)</span><br><span>=
 {</span><br><span>     switch (status)</span><br><span>     {</span><br><s=
pan>@@ -683,12 +683,13 @@</span><br><span>  * in the proxied connection.</s=
pan><br><span>  */</span><br><span> static int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-proxy_connection_io_dispatch(struct proxy_connecti=
on *pc, const int rwflags, struct event_set *es)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+proxy_connection_io_dispatch(struct proxy_conn=
ection *pc, const unsigned int rwflags,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                             struct event_set *es)</spa=
n><br><span> {</span><br><span>     const int max_transfer_per_iteration =
=3D 10000;</span><br><span>     struct proxy_connection *cp =3D pc-&gt;coun=
terpart;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int rwfla=
gs_pc =3D pc-&gt;rwflags;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int rwflags_cp =3D cp-&gt;rwflags;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    unsigned int rwflags_pc =3D pc-&gt;rwflags;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int rwflags=
_cp =3D cp-&gt;rwflags;</span><br><span> </span><br><span>     ASSERT(pc-&g=
t;defined &amp;&amp; cp-&gt;defined &amp;&amp; cp-&gt;counterpart =3D=3D pc=
);</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail">change 1107=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1107?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--oRJaJbeWKbs=--

