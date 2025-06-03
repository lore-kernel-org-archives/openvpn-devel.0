From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 3 Jun 2025 16:36:41 +0000
In-Reply-To: <gerrit.1748255754000.I83831060fdf5588a0ada8d6abbedc7ce3ded4182@...2715...>
References: <gerrit.1748255754000.I83831060fdf5588a0ada8d6abbedc7ce3ded4182@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <461f0633ab316e6f5ae5cac10b27eee54517a1eb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yVC8AUkX528="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yVC8AUkX528=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
30?usp=3Demail )

Change subject: Fix various badly placed comments in preparation for reform=
at
......................................................................

Fix various badly placed comments in preparation for reformat

Change-Id: I83831060fdf5588a0ada8d6abbedc7ce3ded4182
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250603163040.31169-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
872.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
M src/openvpn/multi_io.c
M src/openvpn/networking.h
M src/openvpn/options.c
M src/openvpn/otime.c
M src/openvpn/otime.h
M src/openvpn/tun.h
7 files changed, 15 insertions(+), 8 deletions(-)




diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index fd81323..dd6044b 100644
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
index 2bce272..4854f4b 100644
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
index 6f5a6d6..0ba4963 100644
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
index b9708343..6ea01d4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8392,9 +8392,10 @@
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
index e604a28..d423067 100644
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
index 5c3e86f..448389d 100644
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
index ec0f4da..5407e47 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--yVC8AUkX528=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1030?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix various badly placed comments in preparat=
ion for reformat<br><br>Change-Id: I83831060fdf5588a0ada8d6abbedc7ce3ded418=
2<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250603163040.311=
69-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg31872.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/multi_io=
.c<br>M src/openvpn/networking.h<br>M src/openvpn/options.c<br>M src/openvp=
n/otime.c<br>M src/openvpn/otime.h<br>M src/openvpn/tun.h<br>7 files change=
d, 15 insertions(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span=
>index fd81323..dd6044b 100644</span><br><span>--- a/src/openvpn/buffer.c</=
span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -910,7 +910,8 =
@@</span><br><span>     {</span><br><span>         return true;</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((f=
lags &amp; CC_PRINT) &amp;&amp; (c &gt;=3D 32 &amp;&amp; c !=3D 127)) /* al=
low ascii non-control and UTF-8, consider DEL to be a control */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* allow ascii non-control=
 and UTF-8, consider DEL to be a control */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if ((flags &amp; CC_PRINT) &amp;&amp; (c &gt;=
=3D 32 &amp;&amp; c !=3D 127))</span><br><span>     {</span><br><span>     =
    return true;</span><br><span>     }</span><br><span>diff --git a/src/op=
envpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index 2bce272..48=
54f4b 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+=
++ b/src/openvpn/multi_io.c</span><br><span>@@ -247,7 +247,8 @@</span><br><=
span>         case TA_TUN_WRITE:</span><br><span>             looking_for =
=3D TUN_WRITE;</span><br><span>             tun_input_pending =3D NULL;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2.time=
val.tv_sec =3D 1; /* For some reason, the Linux 2.2 TUN/TAP driver hits thi=
s timeout */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     /* For some reason, the Linux 2.2 TUN/TAP driver hits this timeout */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=
.timeval.tv_sec =3D 1;</span><br><span>             perf_push(PERF_PROC_OUT=
_TUN_MTCP);</span><br><span>             io_wait(c, IOW_TO_TUN);</span><br>=
<span>             perf_pop();</span><br><span>diff --git a/src/openvpn/net=
working.h b/src/openvpn/networking.h</span><br><span>index 6f5a6d6..0ba4963=
 100644</span><br><span>--- a/src/openvpn/networking.h</span><br><span>+++ =
b/src/openvpn/networking.h</span><br><span>@@ -302,7 +302,7 @@</span><br><s=
pan>                      int metric);</span><br><span> </span><br><span> /=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Delete a route f=
or an IPv4 address/network</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Delete a route for an IPv6 address/network</span><br><span>  *</s=
pan><br><span>  * @param ctx       the implementation specific context</spa=
n><br><span>  * @param dst       the destination of the route</span><br><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index b9708343..6ea01d4 100644</span><br><span>--- a/src/openvpn/options=
.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -8392,9 +=
8392,10 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span=
><br><span>         setenv_foreign_option(options, (const char **)p, 3, es)=
;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    else if (streq(p[0], &quot;route-method&quot;) &amp;&amp; p[1] &amp;=
&amp; !p[2]) /* ignore when pushed to non-Windows OS */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;route-me=
thod&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span>=
<br><span>         VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* ignore when pushed to non-=
Windows OS */</span><br><span>     }</span><br><span> #endif /* ifdef _WIN3=
2 */</span><br><span> #if PASSTOS_CAPABILITY</span><br><span>diff --git a/s=
rc/openvpn/otime.c b/src/openvpn/otime.c</span><br><span>index e604a28..d42=
3067 100644</span><br><span>--- a/src/openvpn/otime.c</span><br><span>+++ b=
/src/openvpn/otime.c</span><br><span>@@ -44,8 +44,10 @@</span><br><span> vo=
id</span><br><span> update_now(const time_t system_time)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int forward=
_threshold =3D 86400; /* threshold at which to dampen forward jumps */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int backward_tri=
gger  =3D 10;  /* backward jump must be &gt;=3D this many seconds before we=
 adjust */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* th=
reshold at which to dampen forward jumps */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const int forward_threshold =3D 86400;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* backward jump must be=
 &gt;=3D this many seconds before we adjust */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const int backward_trigger =3D 10;</span><br=
><span>     time_t real_time =3D system_time + now_adj;</span><br><span> </=
span><br><span>     if (real_time &gt; now)</span><br><span>diff --git a/sr=
c/openvpn/otime.h b/src/openvpn/otime.h</span><br><span>index 5c3e86f..4483=
89d 100644</span><br><span>--- a/src/openvpn/otime.h</span><br><span>+++ b/=
src/openvpn/otime.h</span><br><span>@@ -246,7 +246,8 @@</span><br><span> st=
atic inline bool</span><br><span> tv_within_sigma(const struct timeval *t1,=
 const struct timeval *t2, unsigned int sigma)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const int delta =3D tv_subt=
ract(t1, t2, TV_WITHIN_SIGMA_MAX_SEC); /* sigma should be less than 10 minu=
tes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sigma =
should be less than 10 minutes */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const int delta =3D tv_subtract(t1, t2, TV_WITHIN_SIGMA_M=
AX_SEC);</span><br><span>     return -(int)sigma &lt;=3D delta &amp;&amp; d=
elta &lt;=3D (int)sigma;</span><br><span> }</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index=
 ec0f4da..5407e47 100644</span><br><span>--- a/src/openvpn/tun.h</span><br>=
<span>+++ b/src/openvpn/tun.h</span><br><span>@@ -212,7 +212,8 @@</span><br=
><span> </span><br><span> #ifdef _WIN32</span><br><span>     HANDLE hand;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OVERLAPPED dco_new_=
peer_ov; /* used for async NEW_PEER dco call, which might wait for TCP conn=
ect */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* used f=
or async NEW_PEER dco call, which might wait for TCP connect */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    OVERLAPPED dco_new_peer_ov;=
</span><br><span>     struct overlapped_io reads;</span><br><span>     stru=
ct overlapped_io writes;</span><br><span>     struct rw_handle rw_handle;</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1030?usp=3Demail">change 1030</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1030?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I83831060fdf5588a0ada8d6abbe=
dc7ce3ded4182 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1030 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--yVC8AUkX528=--

