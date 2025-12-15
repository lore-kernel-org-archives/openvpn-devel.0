From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 13:35:55 +0000
In-Reply-To: <gerrit.1761570487000.I88cd7e1ebb49e97db33bad75c4fbbe23d196e964@...2715...>
References: <gerrit.1761570487000.I88cd7e1ebb49e97db33bad75c4fbbe23d196e964@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <006b61ec23896e7d081da403fcfe30aab7d16b2c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Tx/Hh9tGEsI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Tx/Hh9tGEsI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1313?usp=3Demail

to look at the new patch set (#9).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: multi: Fix various conversion warnings
......................................................................

multi: Fix various conversion warnings

Mostly make required casts explicit.

Change-Id: I88cd7e1ebb49e97db33bad75c4fbbe23d196e964
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/multi.c
1 file changed, 8 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/1313/9

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
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Tx/Hh9tGEsI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #9</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1313?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">multi: Fix various conversion warnin=
gs<br><br>Mostly make required casts explicit.<br><br>Change-Id: I88cd7e1eb=
b49e97db33bad75c4fbbe23d196e964<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 8 inse=
rtions(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/13/1313/9</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 20d72c1..92eac6=
f 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/sr=
c/openvpn/multi.c</span><br><span>@@ -245,11 +245,6 @@</span><br><span> </s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignore=
d &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span> static uint32_t</span><br=
><span> /*</span><br><span>@@ -2809,8 +2804,8 @@</span><br><span> multi_pro=
cess_file_closed(struct multi_context *m, const unsigned int mpp_flags)</sp=
an><br><span> {</span><br><span>     char buffer[INOTIFY_EVENT_BUFFER_SIZE]=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t buffer_i =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int r =3D r=
ead(m-&gt;top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t buffer_i =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ssize_t r =3D read=
(m-&gt;top.c2.inotify_fd, buffer, INOTIFY_EVENT_BUFFER_SIZE);</span><br><sp=
an> </span><br><span>     while (buffer_i &lt; r)</span><br><span>     {</s=
pan><br><span>@@ -2942,21 +2937,23 @@</span><br><span> static inline unsign=
ed int</span><br><span> compute_wakeup_sigma(const struct timeval *delta)</=
span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ASSERT(delta-&gt;tv_sec &gt;=3D 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(delta-&gt;tv_usec &gt;=3D 0);</span><br><span>=
     if (delta-&gt;tv_sec &lt; 1)</span><br><span>     {</span><br><span>  =
       /* if &lt; 1 sec, fuzz =3D # of microseconds / 8 */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return delta-&gt;tv_usec &gt;&=
gt; 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n (unsigned int)(delta-&gt;tv_usec &gt;&gt; 3);</span><br><span>     }</spa=
n><br><span>     else</span><br><span>     {</span><br><span>         /* if=
 &lt; 10 minutes, fuzz =3D 13.1% of timeout */</span><br><span>         if =
(delta-&gt;tv_sec &lt; 600)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            return delta-&gt;tv_sec &lt;&l=
t; 17;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn (unsigned int)(delta-&gt;tv_sec &lt;&lt; 17);</span><br><span>       =
  }</span><br><span>         else</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return 120000000; /* if =
&gt;=3D 10 minutes, fuzz =3D 2 minutes */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return 120 * 1000000; /* if &gt;=3D 10 mi=
nutes, fuzz =3D 2 minutes */</span><br><span>         }</span><br><span>   =
  }</span><br><span> }</span><br><span>@@ -3743,7 +3740,7 @@</span><br><spa=
n> </span><br><span>         for (i =3D 0; i &lt; parm.packet_size; ++i)</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            ASSERT(buf_write_u8(&amp;buf, get_random() &amp; 0xFF));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(buf_=
write_u8(&amp;buf, (uint8_t)(get_random() &amp; 0xFF)));</span><br><span>  =
       }</span><br><span> </span><br><span>         for (i =3D 0; i &lt; pa=
rm.n_packets; ++i)</span><br><span>@@ -3959,10 +3956,6 @@</span><br><span> =
    return count;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void<=
/span><br><span> management_delete_event(void *arg, event_t event)</span><b=
r><span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1313?usp=3Demail">change 1313</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1313?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88cd7e1ebb49e97db33bad75c4f=
bbe23d196e964 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1313 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--Tx/Hh9tGEsI=--

