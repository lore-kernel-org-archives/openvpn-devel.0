From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 17:45:21 +0000
In-Reply-To: <gerrit.1760452015000.Ie22f4902162b7004542f030c734b968de71e0e9e@...2715...>
References: <gerrit.1760452015000.Ie22f4902162b7004542f030c734b968de71e0e9e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2c8ef8cf806f645141dc4b4d30f4a7dda2f1c021-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hpWOfxPvhR4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: otime: Fix various
 conversion warnings
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

--hpWOfxPvhR4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
74?usp=3Demail )

Change subject: otime: Fix various conversion warnings
......................................................................

otime: Fix various conversion warnings

Generally just use better types. Use typedef
to handle the Win32 situation where tv_sec
is long which is smaller than time_t (which
is long long).

Change-Id: Ie22f4902162b7004542f030c734b968de71e0e9e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1274
Message-Id: <20251116135757.15805-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
462.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/otime.c
M src/openvpn/otime.h
2 files changed, 26 insertions(+), 39 deletions(-)




diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index d9bf157..1b3b096 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -95,50 +95,37 @@
 const char *
 tv_string_abs(const struct timeval *tv, struct gc_arena *gc)
 {
-    return time_string((time_t)tv->tv_sec, (long)tv->tv_usec, true, gc);
+    return time_string(tv->tv_sec, tv->tv_usec, true, gc);
 }

 /* format a time_t as ascii, or use current time if 0 */

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 const char *
-time_string(time_t t, long usec, bool show_usec, struct gc_arena *gc)
+time_string(time_t t, tv_usec_t usec, bool show_usec, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(64, gc);
     struct timeval tv;

-    if (t)
-    {
-        tv.tv_sec =3D t;
-        tv.tv_usec =3D usec;
-    }
-    else
+    if (!t)
     {
         gettimeofday(&tv, NULL);
+        t =3D tv.tv_sec;
+        usec =3D tv.tv_usec;
     }

-    t =3D tv.tv_sec;
     struct tm *tm =3D localtime(&t);

     buf_printf(&out, "%04d-%02d-%02d %02d:%02d:%02d", tm->tm_year + 1900, =
tm->tm_mon + 1,
                tm->tm_mday, tm->tm_hour, tm->tm_min, tm->tm_sec);

-    if (show_usec && tv.tv_usec)
+    if (show_usec && usec)
     {
-        buf_printf(&out, " us=3D%ld", (long)tv.tv_usec);
+        buf_printf(&out, " us=3D%ld", (long)usec);
     }
=20
     return BSTR(&out);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Limit the frequency of an event stream.
  *
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 108d0f2..60533fd 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -27,6 +27,14 @@
 #include "integer.h"
 #include "buffer.h"

+#ifdef _WIN32
+typedef long tv_sec_t;
+typedef long tv_usec_t;
+#else
+typedef time_t tv_sec_t;
+typedef suseconds_t tv_usec_t;
+#endif
+
 struct frequency_limit
 {
     int max;
@@ -42,7 +50,7 @@
 bool frequency_limit_event_allowed(struct frequency_limit *f);

 /* format a time_t as ascii, or use current time if 0 */
-const char *time_string(time_t t, long usec, bool show_usec, struct gc_are=
na *gc);
+const char *time_string(time_t t, tv_usec_t usec, bool show_usec, struct g=
c_arena *gc);

 /* struct timeval functions */

@@ -59,11 +67,6 @@
 extern time_t now_usec;
 void update_now_usec(struct timeval *tv);

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static inline int
 openvpn_gettimeofday(struct timeval *tv, void *tz)
 {
@@ -71,8 +74,8 @@
     if (!status)
     {
         update_now_usec(tv);
-        tv->tv_sec =3D now;
-        tv->tv_usec =3D now_usec;
+        tv->tv_sec =3D (tv_sec_t)now;
+        tv->tv_usec =3D (tv_usec_t)now_usec;
     }
     return status;
 }
@@ -116,20 +119,21 @@

 /* return tv1 - tv2 in usec, constrained by max_seconds */
 static inline int
-tv_subtract(const struct timeval *tv1, const struct timeval *tv2, const un=
signed int max_seconds)
+tv_subtract(const struct timeval *tv1, const struct timeval *tv2, const in=
t max_seconds)
 {
     const int max_usec =3D max_seconds * 1000000;
-    const int sec_diff =3D tv1->tv_sec - tv2->tv_sec;
+    const tv_sec_t sec_diff =3D tv1->tv_sec - tv2->tv_sec;

-    if (sec_diff > ((int)max_seconds + 10))
+    if (sec_diff > (max_seconds + 10))
     {
         return max_usec;
     }
-    else if (sec_diff < -((int)max_seconds + 10))
+    else if (sec_diff < -(max_seconds + 10))
     {
         return -max_usec;
     }
-    return constrain_int(sec_diff * 1000000 + (tv1->tv_usec - tv2->tv_usec=
), -max_usec, max_usec);
+    const time_t complete_diff =3D sec_diff * 1000000 + (tv1->tv_usec - tv=
2->tv_usec);
+    return constrain_int((int)complete_diff, -max_usec, max_usec);
 }

 static inline void
@@ -223,8 +227,8 @@
 static inline void
 tv_delta(struct timeval *dest, const struct timeval *t1, const struct time=
val *t2)
 {
-    int sec =3D t2->tv_sec - t1->tv_sec;
-    int usec =3D t2->tv_usec - t1->tv_usec;
+    tv_sec_t sec =3D t2->tv_sec - t1->tv_sec;
+    tv_usec_t usec =3D t2->tv_usec - t1->tv_usec;

     while (usec < 0)
     {
@@ -241,10 +245,6 @@
     dest->tv_usec =3D usec;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #define TV_WITHIN_SIGMA_MAX_SEC  600
 #define TV_WITHIN_SIGMA_MAX_USEC (TV_WITHIN_SIGMA_MAX_SEC * 1000000)


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1274?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie22f4902162b7004542f030c734b968de71e0e9e
Gerrit-Change-Number: 1274
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hpWOfxPvhR4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1274?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">otime: Fix various conversion warnings<br><br>Ge=
nerally just use better types. Use typedef<br>to handle the Win32 situation=
 where tv_sec<br>is long which is smaller than time_t (which<br>is long lon=
g).<br><br>Change-Id: Ie22f4902162b7004542f030c734b968de71e0e9e<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvp=
n/+/1274<br>Message-Id: &lt;20251116135757.15805-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg344=
62.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpn/otime.c<br>M src/openvpn/otime.h<br>2 files changed, 26 inserti=
ons(+), 39 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c</span><br><span>i=
ndex d9bf157..1b3b096 100644</span><br><span>--- a/src/openvpn/otime.c</spa=
n><br><span>+++ b/src/openvpn/otime.c</span><br><span>@@ -95,50 +95,37 @@</=
span><br><span> const char *</span><br><span> tv_string_abs(const struct ti=
meval *tv, struct gc_arena *gc)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return time_string((time_t)tv-&gt;tv_sec, =
(long)tv-&gt;tv_usec, true, gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return time_string(tv-&gt;tv_sec, tv-&gt;tv_usec, true, gc=
);</span><br><span> }</span><br><span> </span><br><span> /* format a time_t=
 as ascii, or use current time if 0 */</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> const char *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-time_string(time_t t, long usec, bool show_usec, struct gc_=
arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+time_stri=
ng(time_t t, tv_usec_t usec, bool show_usec, struct gc_arena *gc)</span><br=
><span> {</span><br><span>     struct buffer out =3D alloc_buf_gc(64, gc);<=
/span><br><span>     struct timeval tv;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (t)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        tv.tv_sec =3D t;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        tv.tv_usec =3D usec;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!t)</span><br><span>     {</span><br><span>         gettimeofday(&amp;tv, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t =3D =
tv.tv_sec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
sec =3D tv.tv_usec;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    t =3D tv.tv_sec;</span><br><span=
>     struct tm *tm =3D localtime(&amp;t);</span><br><span> </span><br><spa=
n>     buf_printf(&amp;out, &quot;%04d-%02d-%02d %02d:%02d:%02d&quot;, tm-&=
gt;tm_year + 1900, tm-&gt;tm_mon + 1,</span><br><span>                tm-&g=
t;tm_mday, tm-&gt;tm_hour, tm-&gt;tm_min, tm-&gt;tm_sec);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (show_usec &am=
p;&amp; tv.tv_usec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (show_usec &amp;&amp; usec)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot; us=
=3D%ld&quot;, (long)tv.tv_usec);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        buf_printf(&amp;out, &quot; us=3D%ld&quot;, (long)usec=
);</span><br><span>     }</span><br><span> </span><br><span>     return BST=
R(&amp;out);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><spa=
n>  * Limit the frequency of an event stream.</span><br><span>  *</span><br=
><span>diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h</span><br><sp=
an>index 108d0f2..60533fd 100644</span><br><span>--- a/src/openvpn/otime.h<=
/span><br><span>+++ b/src/openvpn/otime.h</span><br><span>@@ -27,6 +27,14 @=
@</span><br><span> #include &quot;integer.h&quot;</span><br><span> #include=
 &quot;buffer.h&quot;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+typedef long tv_sec_t;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+typedef long tv_usec_t;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+typedef time_t tv_sec_t;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+typedef suseconds_t tv_usec_t;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> struct frequency_limit</span><br><span> {</span=
><br><span>     int max;</span><br><span>@@ -42,7 +50,7 @@</span><br><span>=
 bool frequency_limit_event_allowed(struct frequency_limit *f);</span><br><=
span> </span><br><span> /* format a time_t as ascii, or use current time if=
 0 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *time=
_string(time_t t, long usec, bool show_usec, struct gc_arena *gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+const char *time_string(time=
_t t, tv_usec_t usec, bool show_usec, struct gc_arena *gc);</span><br><span=
> </span><br><span> /* struct timeval functions */</span><br><span> </span>=
<br><span>@@ -59,11 +67,6 @@</span><br><span> extern time_t now_usec;</span=
><br><span> void update_now_usec(struct timeval *tv);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> static inline int</span><br><span> =
openvpn_gettimeofday(struct timeval *tv, void *tz)</span><br><span> {</span=
><br><span>@@ -71,8 +74,8 @@</span><br><span>     if (!status)</span><br><s=
pan>     {</span><br><span>         update_now_usec(tv);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        tv-&gt;tv_sec =3D now;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        tv-&gt;tv_usec =3D now_=
usec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tv-&gt=
;tv_sec =3D (tv_sec_t)now;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tv-&gt;tv_usec =3D (tv_usec_t)now_usec;</span><br><span>    =
 }</span><br><span>     return status;</span><br><span> }</span><br><span>@=
@ -116,20 +119,21 @@</span><br><span> </span><br><span> /* return tv1 - tv2=
 in usec, constrained by max_seconds */</span><br><span> static inline int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_subtract(const stru=
ct timeval *tv1, const struct timeval *tv2, const unsigned int max_seconds)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tv_subtract(const s=
truct timeval *tv1, const struct timeval *tv2, const int max_seconds)</span=
><br><span> {</span><br><span>     const int max_usec =3D max_seconds * 100=
0000;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int se=
c_diff =3D tv1-&gt;tv_sec - tv2-&gt;tv_sec;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const tv_sec_t sec_diff =3D tv1-&gt;tv_sec - tv=
2-&gt;tv_sec;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (sec_diff &gt; ((int)max_seconds + 10))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (sec_diff &gt; (max_seconds + 1=
0))</span><br><span>     {</span><br><span>         return max_usec;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse if (sec_diff &lt; -((int)max_seconds + 10))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else if (sec_diff &lt; -(max_seconds + 10))=
</span><br><span>     {</span><br><span>         return -max_usec;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn constrain_int(sec_diff * 1000000 + (tv1-&gt;tv_usec - tv2-&gt;tv_usec),=
 -max_usec, max_usec);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const time_t complete_diff =3D sec_diff * 1000000 + (tv1-&gt;tv_usec=
 - tv2-&gt;tv_usec);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return constrain_int((int)complete_diff, -max_usec, max_usec);</span><=
br><span> }</span><br><span> </span><br><span> static inline void</span><br=
><span>@@ -223,8 +227,8 @@</span><br><span> static inline void</span><br><s=
pan> tv_delta(struct timeval *dest, const struct timeval *t1, const struct =
timeval *t2)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int sec =3D t2-&gt;tv_sec - t1-&gt;tv_sec;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int usec =3D t2-&gt;tv_usec - t1-&gt=
;tv_usec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tv_sec=
_t sec =3D t2-&gt;tv_sec - t1-&gt;tv_sec;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    tv_usec_t usec =3D t2-&gt;tv_usec - t1-&gt;tv_use=
c;</span><br><span> </span><br><span>     while (usec &lt; 0)</span><br><sp=
an>     {</span><br><span>@@ -241,10 +245,6 @@</span><br><span>     dest-&g=
t;tv_usec =3D usec;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define TV=
_WITHIN_SIGMA_MAX_SEC  600</span><br><span> #define TV_WITHIN_SIGMA_MAX_USE=
C (TV_WITHIN_SIGMA_MAX_SEC * 1000000)</span><br><span> </span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1274?usp=3Demail">change 1274</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1274?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie22f4902162b7004542f030c734=
b968de71e0e9e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1274 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--hpWOfxPvhR4=--

