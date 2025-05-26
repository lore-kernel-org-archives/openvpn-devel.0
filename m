From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 May 2025 10:36:12 +0000
References: <gerrit.1748255754000.I83831060fdf5588a0ada8d6abbedc7ce3ded4182@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c93c532bc0feb2eea2b3a68042ba697f5d2c14da-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="57uukC87hQM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix various badly
 placed comments in preparation for reformat
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

--57uukC87hQM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1030?usp=3Demail

to review the following change.


Change subject: Fix various badly placed comments in preparation for reform=
at
......................................................................

Fix various badly placed comments in preparation for reformat

Change-Id: I83831060fdf5588a0ada8d6abbedc7ce3ded4182
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
M src/openvpn/multi_io.c
M src/openvpn/networking.h
M src/openvpn/options.c
M src/openvpn/otime.c
M src/openvpn/otime.h
M src/openvpn/tun.h
7 files changed, 15 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/1030/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index b2a5bf5..4b83eeb 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -910,7 +910,8 @@
     {
         return true;
     }
-    if ((flags & CC_PRINT) && (c >=3D 32 && c !=3D 127)) /* allow ascii no=
n-control and UTF-8, consider DEL to be a control */
+    /* allow ascii non-control and UTF-8, consider DEL to be a control */
+    if ((flags & CC_PRINT) && (c >=3D 32 && c !=3D 127))
     {
         return true;
     }
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 7f47319..6ab06bb 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -247,7 +247,8 @@
         case TA_TUN_WRITE:
             looking_for =3D TUN_WRITE;
             tun_input_pending =3D NULL;
-            c->c2.timeval.tv_sec =3D 1; /* For some reason, the Linux 2.2 =
TUN/TAP driver hits this timeout */
+            /* For some reason, the Linux 2.2 TUN/TAP driver hits this tim=
eout */
+            c->c2.timeval.tv_sec =3D 1;
             perf_push(PERF_PROC_OUT_TUN_MTCP);
             io_wait(c, IOW_TO_TUN);
             perf_pop();
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index f06d6df..d9aca1e 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -302,7 +302,7 @@
                      int metric);

 /**
- * Delete a route for an IPv4 address/network
+ * Delete a route for an IPv6 address/network
  *
  * @param ctx       the implementation specific context
  * @param dst       the destination of the route
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bcc18a5..4528edd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8398,9 +8398,10 @@
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
         setenv_foreign_option(options, (const char **)p, 3, es);
     }
-    else if (streq(p[0], "route-method") && p[1] && !p[2]) /* ignore when =
pushed to non-Windows OS */
+    else if (streq(p[0], "route-method") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);
+        /* ignore when pushed to non-Windows OS */
     }
 #endif /* ifdef _WIN32 */
 #if PASSTOS_CAPABILITY
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index d77c99e..7a362e0 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -44,8 +44,10 @@
 void
 update_now(const time_t system_time)
 {
-    const int forward_threshold =3D 86400; /* threshold at which to dampen=
 forward jumps */
-    const int backward_trigger  =3D 10;  /* backward jump must be >=3D thi=
s many seconds before we adjust */
+    /* threshold at which to dampen forward jumps */
+    const int forward_threshold =3D 86400;
+    /* backward jump must be >=3D this many seconds before we adjust */
+    const int backward_trigger =3D 10;
     time_t real_time =3D system_time + now_adj;

     if (real_time > now)
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 9543732..04aa5c6 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -246,7 +246,8 @@
 static inline bool
 tv_within_sigma(const struct timeval *t1, const struct timeval *t2, unsign=
ed int sigma)
 {
-    const int delta =3D tv_subtract(t1, t2, TV_WITHIN_SIGMA_MAX_SEC); /* s=
igma should be less than 10 minutes */
+    /* sigma should be less than 10 minutes */
+    const int delta =3D tv_subtract(t1, t2, TV_WITHIN_SIGMA_MAX_SEC);
     return -(int)sigma <=3D delta && delta <=3D (int)sigma;
 }

diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index de1876a..379a31a 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -212,7 +212,8 @@

 #ifdef _WIN32
     HANDLE hand;
-    OVERLAPPED dco_new_peer_ov; /* used for async NEW_PEER dco call, which=
 might wait for TCP connect */
+    /* used for async NEW_PEER dco call, which might wait for TCP connect =
*/
+    OVERLAPPED dco_new_peer_ov;
     struct overlapped_io reads;
     struct overlapped_io writes;
     struct rw_handle rw_handle;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1030?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I83831060fdf5588a0ada8d6abbedc7ce3ded4182
Gerrit-Change-Number: 1030
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--57uukC87hQM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1030?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Fix various badly placed comments in preparation for reforma=
t<br><br>Change-Id: I83831060fdf5588a0ada8d6abbedc7ce3ded4182<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/buf=
fer.c<br>M src/openvpn/multi_io.c<br>M src/openvpn/networking.h<br>M src/op=
envpn/options.c<br>M src/openvpn/otime.c<br>M src/openvpn/otime.h<br>M src/=
openvpn/tun.h<br>7 files changed, 15 insertions(+), 8 deletions(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/1030/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><s=
pan>index b2a5bf5..4b83eeb 100644</span><br><span>--- a/src/openvpn/buffer.=
c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -910,7 +910=
,8 @@</span><br><span>     {</span><br><span>         return true;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
((flags &amp; CC_PRINT) &amp;&amp; (c &gt;=3D 32 &amp;&amp; c !=3D 127)) /*=
 allow ascii non-control and UTF-8, consider DEL to be a control */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* allow ascii non-cont=
rol and UTF-8, consider DEL to be a control */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if ((flags &amp; CC_PRINT) &amp;&amp; (c &gt=
;=3D 32 &amp;&amp; c !=3D 127))</span><br><span>     {</span><br><span>    =
     return true;</span><br><span>     }</span><br><span>diff --git a/src/o=
penvpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index 7f47319..6=
ab06bb 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>=
+++ b/src/openvpn/multi_io.c</span><br><span>@@ -247,7 +247,8 @@</span><br>=
<span>         case TA_TUN_WRITE:</span><br><span>             looking_for =
=3D TUN_WRITE;</span><br><span>             tun_input_pending =3D NULL;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2.time=
val.tv_sec =3D 1; /* For some reason, the Linux 2.2 TUN/TAP driver hits thi=
s timeout */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     /* For some reason, the Linux 2.2 TUN/TAP driver hits this timeout */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=
.timeval.tv_sec =3D 1;</span><br><span>             perf_push(PERF_PROC_OUT=
_TUN_MTCP);</span><br><span>             io_wait(c, IOW_TO_TUN);</span><br>=
<span>             perf_pop();</span><br><span>diff --git a/src/openvpn/net=
working.h b/src/openvpn/networking.h</span><br><span>index f06d6df..d9aca1e=
 100644</span><br><span>--- a/src/openvpn/networking.h</span><br><span>+++ =
b/src/openvpn/networking.h</span><br><span>@@ -302,7 +302,7 @@</span><br><s=
pan>                      int metric);</span><br><span> </span><br><span> /=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Delete a route f=
or an IPv4 address/network</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Delete a route for an IPv6 address/network</span><br><span>  *</s=
pan><br><span>  * @param ctx       the implementation specific context</spa=
n><br><span>  * @param dst       the destination of the route</span><br><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index bcc18a5..4528edd 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -8398,9 +8=
398,10 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span>=
<br><span>         setenv_foreign_option(options, (const char **)p, 3, es);=
</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else if (streq(p[0], &quot;route-method&quot;) &amp;&amp; p[1] &amp;&=
amp; !p[2]) /* ignore when pushed to non-Windows OS */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;route-met=
hod&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><=
br><span>         VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* ignore when pushed to non-W=
indows OS */</span><br><span>     }</span><br><span> #endif /* ifdef _WIN32=
 */</span><br><span> #if PASSTOS_CAPABILITY</span><br><span>diff --git a/sr=
c/openvpn/otime.c b/src/openvpn/otime.c</span><br><span>index d77c99e..7a36=
2e0 100644</span><br><span>--- a/src/openvpn/otime.c</span><br><span>+++ b/=
src/openvpn/otime.c</span><br><span>@@ -44,8 +44,10 @@</span><br><span> voi=
d</span><br><span> update_now(const time_t system_time)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int forward_=
threshold =3D 86400; /* threshold at which to dampen forward jumps */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int backward_trig=
ger  =3D 10;  /* backward jump must be &gt;=3D this many seconds before we =
adjust */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* thr=
eshold at which to dampen forward jumps */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const int forward_threshold =3D 86400;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* backward jump must be =
&gt;=3D this many seconds before we adjust */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const int backward_trigger =3D 10;</span><br>=
<span>     time_t real_time =3D system_time + now_adj;</span><br><span> </s=
pan><br><span>     if (real_time &gt; now)</span><br><span>diff --git a/src=
/openvpn/otime.h b/src/openvpn/otime.h</span><br><span>index 9543732..04aa5=
c6 100644</span><br><span>--- a/src/openvpn/otime.h</span><br><span>+++ b/s=
rc/openvpn/otime.h</span><br><span>@@ -246,7 +246,8 @@</span><br><span> sta=
tic inline bool</span><br><span> tv_within_sigma(const struct timeval *t1, =
const struct timeval *t2, unsigned int sigma)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const int delta =3D tv_subtr=
act(t1, t2, TV_WITHIN_SIGMA_MAX_SEC); /* sigma should be less than 10 minut=
es */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sigma s=
hould be less than 10 minutes */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const int delta =3D tv_subtract(t1, t2, TV_WITHIN_SIGMA_MA=
X_SEC);</span><br><span>     return -(int)sigma &lt;=3D delta &amp;&amp; de=
lta &lt;=3D (int)sigma;</span><br><span> }</span><br><span> </span><br><spa=
n>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index =
de1876a..379a31a 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><=
span>+++ b/src/openvpn/tun.h</span><br><span>@@ -212,7 +212,8 @@</span><br>=
<span> </span><br><span> #ifdef _WIN32</span><br><span>     HANDLE hand;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    OVERLAPPED dco_new_p=
eer_ov; /* used for async NEW_PEER dco call, which might wait for TCP conne=
ct */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* used fo=
r async NEW_PEER dco call, which might wait for TCP connect */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    OVERLAPPED dco_new_peer_ov;<=
/span><br><span>     struct overlapped_io reads;</span><br><span>     struc=
t overlapped_io writes;</span><br><span>     struct rw_handle rw_handle;</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1030?usp=3Demail">change 1030</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1030?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I83831060fdf5588a0ada8d6abbe=
dc7ce3ded4182 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1030 </div>
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


--57uukC87hQM=--

