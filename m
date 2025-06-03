From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 3 Jun 2025 16:36:39 +0000
In-Reply-To: <gerrit.1748255754000.I83831060fdf5588a0ada8d6abbedc7ce3ded4182@...2715...>
References: <gerrit.1748255754000.I83831060fdf5588a0ada8d6abbedc7ce3ded4182@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <461f0633ab316e6f5ae5cac10b27eee54517a1eb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TH/4Vb4iOhE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TH/4Vb4iOhE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1030?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/1030/2

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
Gerrit-MessageType: newpatchset

--TH/4Vb4iOhE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1030?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix various badly placed comments in preparation for=
 reformat<br><br>Change-Id: I83831060fdf5588a0ada8d6abbedc7ce3ded4182<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert D=
oering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250603163040.31169-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg31872.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/multi_io.c<br>M=
 src/openvpn/networking.h<br>M src/openvpn/options.c<br>M src/openvpn/otime=
.c<br>M src/openvpn/otime.h<br>M src/openvpn/tun.h<br>7 files changed, 15 i=
nsertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/30/1030/2</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer.=
c b/src/openvpn/buffer.c</span><br><span>index fd81323..dd6044b 100644</spa=
n><br><span>--- a/src/openvpn/buffer.c</span><br><span>+++ b/src/openvpn/bu=
ffer.c</span><br><span>@@ -910,7 +910,8 @@</span><br><span>     {</span><br=
><span>         return true;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if ((flags &amp; CC_PRINT) &amp;&amp; (=
c &gt;=3D 32 &amp;&amp; c !=3D 127)) /* allow ascii non-control and UTF-8, =
consider DEL to be a control */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* allow ascii non-control and UTF-8, consider DEL to be a =
control */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((=
flags &amp; CC_PRINT) &amp;&amp; (c &gt;=3D 32 &amp;&amp; c !=3D 127))</spa=
n><br><span>     {</span><br><span>         return true;</span><br><span>  =
   }</span><br><span>diff --git a/src/openvpn/multi_io.c b/src/openvpn/mult=
i_io.c</span><br><span>index 2bce272..4854f4b 100644</span><br><span>--- a/=
src/openvpn/multi_io.c</span><br><span>+++ b/src/openvpn/multi_io.c</span><=
br><span>@@ -247,7 +247,8 @@</span><br><span>         case TA_TUN_WRITE:</s=
pan><br><span>             looking_for =3D TUN_WRITE;</span><br><span>     =
        tun_input_pending =3D NULL;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            c-&gt;c2.timeval.tv_sec =3D 1; /* For some reason=
, the Linux 2.2 TUN/TAP driver hits this timeout */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* For some reason, the Linux=
 2.2 TUN/TAP driver hits this timeout */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            c-&gt;c2.timeval.tv_sec =3D 1;</span><br><=
span>             perf_push(PERF_PROC_OUT_TUN_MTCP);</span><br><span>      =
       io_wait(c, IOW_TO_TUN);</span><br><span>             perf_pop();</sp=
an><br><span>diff --git a/src/openvpn/networking.h b/src/openvpn/networking=
.h</span><br><span>index 6f5a6d6..0ba4963 100644</span><br><span>--- a/src/=
openvpn/networking.h</span><br><span>+++ b/src/openvpn/networking.h</span><=
br><span>@@ -302,7 +302,7 @@</span><br><span>                      int metr=
ic);</span><br><span> </span><br><span> /**</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * Delete a route for an IPv4 address/network</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Delete a route for an IP=
v6 address/network</span><br><span>  *</span><br><span>  * @param ctx      =
 the implementation specific context</span><br><span>  * @param dst       t=
he destination of the route</span><br><span>diff --git a/src/openvpn/option=
s.c b/src/openvpn/options.c</span><br><span>index b9708343..6ea01d4 100644<=
/span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openv=
pn/options.c</span><br><span>@@ -8392,9 +8392,10 @@</span><br><span>       =
  VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span>         setenv_foreign=
_option(options, (const char **)p, 3, es);</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;=
route-method&quot;) &amp;&amp; p[1] &amp;&amp; !p[2]) /* ignore when pushed=
 to non-Windows OS */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (streq(p[0], &quot;route-method&quot;) &amp;&amp; p[1] &amp;&=
amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSI=
ON(OPT_P_ROUTE_EXTRAS);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* ignore when pushed to non-Windows OS */</span><br><span>    =
 }</span><br><span> #endif /* ifdef _WIN32 */</span><br><span> #if PASSTOS_=
CAPABILITY</span><br><span>diff --git a/src/openvpn/otime.c b/src/openvpn/o=
time.c</span><br><span>index e604a28..d423067 100644</span><br><span>--- a/=
src/openvpn/otime.c</span><br><span>+++ b/src/openvpn/otime.c</span><br><sp=
an>@@ -44,8 +44,10 @@</span><br><span> void</span><br><span> update_now(con=
st time_t system_time)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const int forward_threshold =3D 86400; /* threshold=
 at which to dampen forward jumps */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const int backward_trigger  =3D 10;  /* backward jump mu=
st be &gt;=3D this many seconds before we adjust */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* threshold at which to dampen forwa=
rd jumps */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t int forward_threshold =3D 86400;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* backward jump must be &gt;=3D this many seconds befor=
e we adjust */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst int backward_trigger =3D 10;</span><br><span>     time_t real_time =3D=
 system_time + now_adj;</span><br><span> </span><br><span>     if (real_tim=
e &gt; now)</span><br><span>diff --git a/src/openvpn/otime.h b/src/openvpn/=
otime.h</span><br><span>index 5c3e86f..448389d 100644</span><br><span>--- a=
/src/openvpn/otime.h</span><br><span>+++ b/src/openvpn/otime.h</span><br><s=
pan>@@ -246,7 +246,8 @@</span><br><span> static inline bool</span><br><span=
> tv_within_sigma(const struct timeval *t1, const struct timeval *t2, unsig=
ned int sigma)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const int delta =3D tv_subtract(t1, t2, TV_WITHIN_SIGMA_MAX=
_SEC); /* sigma should be less than 10 minutes */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* sigma should be less than 10 minutes *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int delt=
a =3D tv_subtract(t1, t2, TV_WITHIN_SIGMA_MAX_SEC);</span><br><span>     re=
turn -(int)sigma &lt;=3D delta &amp;&amp; delta &lt;=3D (int)sigma;</span><=
br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/tun.=
h b/src/openvpn/tun.h</span><br><span>index ec0f4da..5407e47 100644</span><=
br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</s=
pan><br><span>@@ -212,7 +212,8 @@</span><br><span> </span><br><span> #ifdef=
 _WIN32</span><br><span>     HANDLE hand;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    OVERLAPPED dco_new_peer_ov; /* used for async NEW_P=
EER dco call, which might wait for TCP connect */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* used for async NEW_PEER dco call, whic=
h might wait for TCP connect */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    OVERLAPPED dco_new_peer_ov;</span><br><span>     struct ove=
rlapped_io reads;</span><br><span>     struct overlapped_io writes;</span><=
br><span>     struct rw_handle rw_handle;</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1030?usp=
=3Demail">change 1030</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1030?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--TH/4Vb4iOhE=--

