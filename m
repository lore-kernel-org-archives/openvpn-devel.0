From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 15:47:53 +0000
In-Reply-To: <gerrit.1761570487000.I88cd7e1ebb49e97db33bad75c4fbbe23d196e964@...2715...>
References: <gerrit.1761570487000.I88cd7e1ebb49e97db33bad75c4fbbe23d196e964@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <45fc0a45a56e4a853f13a44fdfd4f5ce6e825f7f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qG1KiEBWFPo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: Fix various
 conversion warnings
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

--qG1KiEBWFPo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#10) to the change originally created b=
y flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1313?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: multi: Fix various conversion warnings
......................................................................

multi: Fix various conversion warnings

Mostly make required casts explicit.

Change-Id: I88cd7e1ebb49e97db33bad75c4fbbe23d196e964
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1313
Message-Id: <20251215145840.18310-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
073.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 8 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/1313/10

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 20d72c1..92eac6f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -245,11 +245,6 @@

 #endif

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 #ifdef ENABLE_ASYNC_PUSH
 static uint32_t
 /*
@@ -2809,8 +2804,8 @@
 multi_process_file_closed(struct multi_context *m, const unsigned int mpp_=
flags)
 {
     char buffer[INOTIFY_EVENT_BUFFER_SIZE];
-    size_t buffer_i =3D 0;
-    int r =3D read(m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE=
);
+    ssize_t buffer_i =3D 0;
+    ssize_t r =3D read(m->top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_=
SIZE);

     while (buffer_i < r)
     {
@@ -2942,21 +2937,23 @@
 static inline unsigned int
 compute_wakeup_sigma(const struct timeval *delta)
 {
+    ASSERT(delta->tv_sec >=3D 0);
+    ASSERT(delta->tv_usec >=3D 0);
     if (delta->tv_sec < 1)
     {
         /* if < 1 sec, fuzz =3D # of microseconds / 8 */
-        return delta->tv_usec >> 3;
+        return (unsigned int)(delta->tv_usec >> 3);
     }
     else
     {
         /* if < 10 minutes, fuzz =3D 13.1% of timeout */
         if (delta->tv_sec < 600)
         {
-            return delta->tv_sec << 17;
+            return (unsigned int)(delta->tv_sec << 17);
         }
         else
         {
-            return 120000000; /* if >=3D 10 minutes, fuzz =3D 2 minutes */
+            return 120 * 1000000; /* if >=3D 10 minutes, fuzz =3D 2 minute=
s */
         }
     }
 }
@@ -3743,7 +3740,7 @@

         for (i =3D 0; i < parm.packet_size; ++i)
         {
-            ASSERT(buf_write_u8(&buf, get_random() & 0xFF));
+            ASSERT(buf_write_u8(&buf, (uint8_t)(get_random() & 0xFF)));
         }

         for (i =3D 0; i < parm.n_packets; ++i)
@@ -3959,10 +3956,6 @@
     return count;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 management_delete_event(void *arg, event_t event)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1313?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88cd7e1ebb49e97db33bad75c4fbbe23d196e964
Gerrit-Change-Number: 1313
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qG1KiEBWFPo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #10</strong> to the change originally created by flichtenhe=
ld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1313?usp=3Demail=
">View Change</a></p><p>The following approvals got outdated and were remov=
ed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">multi: Fix various conversion w=
arnings<br><br>Mostly make required casts explicit.<br><br>Change-Id: I88cd=
7e1ebb49e97db33bad75c4fbbe23d196e964<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...2477...=
.&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1313<br>Message=
-Id: &lt;20251215145840.18310-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg35073.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/multi.c=
<br>1 file changed, 8 insertions(+), 15 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/1313/1=
0</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br>=
<span>index 20d72c1..92eac6f 100644</span><br><span>--- a/src/openvpn/multi=
.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -245,11 +24=
5,6 @@</span><br><span> </span><br><span> #endif</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span=
> static uint32_t</span><br><span> /*</span><br><span>@@ -2809,8 +2804,8 @@=
</span><br><span> multi_process_file_closed(struct multi_context *m, const =
unsigned int mpp_flags)</span><br><span> {</span><br><span>     char buffer=
[INOTIFY_EVENT_BUFFER_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    size_t buffer_i =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int r =3D read(m-&gt;top.c2.inotify_fd, buffer, INOTIFY_EVE=
NT_BUFFER_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ssize_t buffer_i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ssize_t r =3D read(m-&gt;top.c2.inotify_fd, buffer, INOTIFY_EVENT_=
BUFFER_SIZE);</span><br><span> </span><br><span>     while (buffer_i &lt; r=
)</span><br><span>     {</span><br><span>@@ -2942,21 +2937,23 @@</span><br>=
<span> static inline unsigned int</span><br><span> compute_wakeup_sigma(con=
st struct timeval *delta)</span><br><span> {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(delta-&gt;tv_sec &gt;=3D 0);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(delta-&gt;tv_usec &=
gt;=3D 0);</span><br><span>     if (delta-&gt;tv_sec &lt; 1)</span><br><spa=
n>     {</span><br><span>         /* if &lt; 1 sec, fuzz =3D # of microseco=
nds / 8 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn delta-&gt;tv_usec &gt;&gt; 3;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return (unsigned int)(delta-&gt;tv_usec &gt;&gt; 3);<=
/span><br><span>     }</span><br><span>     else</span><br><span>     {</sp=
an><br><span>         /* if &lt; 10 minutes, fuzz =3D 13.1% of timeout */</=
span><br><span>         if (delta-&gt;tv_sec &lt; 600)</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
urn delta-&gt;tv_sec &lt;&lt; 17;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return (unsigned int)(delta-&gt;tv_sec &lt;&lt; 1=
7);</span><br><span>         }</span><br><span>         else</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   return 120000000; /* if &gt;=3D 10 minutes, fuzz =3D 2 minutes */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return 120 * 1=
000000; /* if &gt;=3D 10 minutes, fuzz =3D 2 minutes */</span><br><span>   =
      }</span><br><span>     }</span><br><span> }</span><br><span>@@ -3743,=
7 +3740,7 @@</span><br><span> </span><br><span>         for (i =3D 0; i &lt=
; parm.packet_size; ++i)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ASSERT(buf_write_u8(&amp;buf, g=
et_random() &amp; 0xFF));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            ASSERT(buf_write_u8(&amp;buf, (uint8_t)(get_random() &amp=
; 0xFF)));</span><br><span>         }</span><br><span> </span><br><span>   =
      for (i =3D 0; i &lt; parm.n_packets; ++i)</span><br><span>@@ -3959,10=
 +3956,6 @@</span><br><span>     return count;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> static void</span><br><span> management_delete_event(void =
*arg, event_t event)</span><br><span> {</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1313?usp=
=3Demail">change 1313</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1313?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88cd7e1ebb49e97db33bad75c4f=
bbe23d196e964 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1313 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--qG1KiEBWFPo=--

