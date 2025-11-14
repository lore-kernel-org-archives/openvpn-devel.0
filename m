From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 14 Nov 2025 14:47:08 +0000
References: <gerrit.1762964572000.I67f5bf53b80f53fd2e349f844479ed172a7b3aa1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <413dd44fe86c5a68da50d5c04d669d4bdce31fbf-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YPezh1zX4Os="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tun: Change return
 type of write_tun/read_tun to ssize_t
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

--YPezh1zX4Os=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1376?usp=3Demail

to review the following change.


Change subject: tun: Change return type of write_tun/read_tun to ssize_t
......................................................................

tun: Change return type of write_tun/read_tun to ssize_t

So we can directly give back the actual return
type from write/read. Even if we then cast it
back to int. The cast should be safe since we
also specify an int as we also put an int in
as length.

Change-Id: I67f5bf53b80f53fd2e349f844479ed172a7b3aa1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/forward.c
M src/openvpn/tun.c
M src/openvpn/tun.h
3 files changed, 28 insertions(+), 56 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1376/5

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d54c679..ed42960 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1293,11 +1293,6 @@
 #endif /* if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARG=
ET_FREEBSD)) */
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Output: c->c2.buf
  */
@@ -1324,11 +1319,11 @@
     if (c->c1.tuntap->backend_driver =3D=3D DRIVER_AFUNIX)
     {
         c->c2.buf.len =3D
-            read_tun_afunix(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame.bu=
f.payload_size);
+            (int)read_tun_afunix(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.fra=
me.buf.payload_size);
     }
     else
     {
-        c->c2.buf.len =3D read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.f=
rame.buf.payload_size);
+        c->c2.buf.len =3D (int)read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c-=
>c2.frame.buf.payload_size);
     }
 #endif /* ifdef _WIN32 */

@@ -1358,6 +1353,11 @@
     check_status(c->c2.buf.len, "read from TUN/TAP", NULL, c->c1.tuntap);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * Drops UDP packets which OS decided to route via tun.
  *
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 90505a0..d1fc442 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1708,8 +1708,8 @@
 #include <netinet/ip.h>
 #include <sys/uio.h>

-static inline int
-header_modify_read_write_return(int len)
+static inline ssize_t
+header_modify_read_write_return(ssize_t len)
 {
     if (len > 0)
     {
@@ -1721,12 +1721,7 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-static int
+static ssize_t
 write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
@@ -1757,7 +1752,7 @@
     }
 }

-static int
+static ssize_t
 read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
@@ -1778,26 +1773,21 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #if !defined(TARGET_DARWIN)
-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return write_tun_header(tt, buf, len);
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return read_tun_header(tt, buf, len);
 }
 #endif

-
-#endif /* defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(=
TARGET_NETBSD) || if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */
+#endif /* if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defin=
ed(TARGET_NETBSD) || defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */

 bool
 tun_name_is_fixed(const char *dev)
@@ -2054,13 +2044,13 @@
     free(tt);
 }

-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
@@ -2268,27 +2258,18 @@
     free(tt);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #elif defined(TARGET_SOLARIS)

 #ifndef TUNNEWPPA
@@ -2613,7 +2594,7 @@
     argv_free(&argv);
 }
=20
-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
@@ -2622,7 +2603,7 @@
     return putmsg(tt->fd, NULL, &sbuf, 0) >=3D 0 ? sbuf.len : -1;
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
@@ -3097,11 +3078,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 void
 close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
@@ -3125,7 +3101,7 @@
     gc_free(&gc);
 }

-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
@@ -3138,7 +3114,7 @@
     }
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
@@ -3151,10 +3127,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #elif defined(TARGET_AIX)

 void
@@ -3277,13 +3249,13 @@
     argv_free(&argv);
 }

-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
@@ -6329,13 +6301,13 @@
     free(tt);
 }

-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return write(tt->fd, buf, len);
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index e13f99f..77c3c09 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -274,9 +274,9 @@

 void close_tun_handle(struct tuntap *tt);

-int write_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t write_tun(struct tuntap *tt, uint8_t *buf, int len);

-int read_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);

 void tuncfg(const char *dev, const char *dev_type, const char *dev_node, i=
nt persist_mode,
             const char *username, const char *groupname, const struct tunt=
ap_options *options,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1376?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I67f5bf53b80f53fd2e349f844479ed172a7b3aa1
Gerrit-Change-Number: 1376
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--YPezh1zX4Os=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1376?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tun: Change return type of write_tun/read_t=
un to ssize_t<br><br>So we can directly give back the actual return<br>type=
 from write/read. Even if we then cast it<br>back to int. The cast should b=
e safe since we<br>also specify an int as we also put an int in<br>as lengt=
h.<br><br>Change-Id: I67f5bf53b80f53fd2e349f844479ed172a7b3aa1<br>Signed-of=
f-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/fo=
rward.c<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>3 files changed, 2=
8 insertions(+), 56 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/76/1376/5</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index d=
54c679..ed42960 100644</span><br><span>--- a/src/openvpn/forward.c</span><b=
r><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1293,11 +1293,6 @@<=
/span><br><span> #endif /* if defined(ENABLE_DCO) &amp;&amp; (defined(TARGE=
T_LINUX) || defined(TARGET_FREEBSD)) */</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Output:=
 c-&gt;c2.buf</span><br><span>  */</span><br><span>@@ -1324,11 +1319,11 @@<=
/span><br><span>     if (c-&gt;c1.tuntap-&gt;backend_driver =3D=3D DRIVER_A=
FUNIX)</span><br><span>     {</span><br><span>         c-&gt;c2.buf.len =3D=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            read_tun_=
afunix(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload=
_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
(int)read_tun_afunix(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf), c-&gt;c2.fra=
me.buf.payload_size);</span><br><span>     }</span><br><span>     else</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     c-&gt;c2.buf.len =3D read_tun(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf)=
, c-&gt;c2.frame.buf.payload_size);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        c-&gt;c2.buf.len =3D (int)read_tun(c-&gt;c1.tuntap,=
 BPTR(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size);</span><br><span=
>     }</span><br><span> #endif /* ifdef _WIN32 */</span><br><span> </span>=
<br><span>@@ -1358,6 +1353,11 @@</span><br><span>     check_status(c-&gt;c2=
.buf.len, &quot;read from TUN/TAP&quot;, NULL, c-&gt;c1.tuntap);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot=
;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> /**</span><br><span>  * Drops UDP packets which OS decided to route vi=
a tun.</span><br><span>  *</span><br><span>diff --git a/src/openvpn/tun.c b=
/src/openvpn/tun.c</span><br><span>index 90505a0..d1fc442 100644</span><br>=
<span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span=
><br><span>@@ -1708,8 +1708,8 @@</span><br><span> #include &lt;netinet/ip.h=
&gt;</span><br><span> #include &lt;sys/uio.h&gt;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-header_modify_read_write_return(in=
t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline=
 ssize_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+header_modi=
fy_read_write_return(ssize_t len)</span><br><span> {</span><br><span>     i=
f (len &gt; 0)</span><br><span>     {</span><br><span>@@ -1721,12 +1721,7 @=
@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma=
 GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static ssize_t</sp=
an><br><span> write_tun_header(struct tuntap *tt, uint8_t *buf, int len)</s=
pan><br><span> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)<=
/span><br><span>@@ -1757,7 +1752,7 @@</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static s=
size_t</span><br><span> read_tun_header(struct tuntap *tt, uint8_t *buf, in=
t len)</span><br><span> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_T=
YPE_TUN)</span><br><span>@@ -1778,26 +1773,21 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> #if !defined(TARGET_DARWIN)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> write_tun(struct=
 tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>    =
 return write_tun_header(tt, buf, len);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> read_tun(st=
ruct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>=
     return read_tun_header(tt, buf, len);</span><br><span> }</span><br><sp=
an> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* defi=
ned(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) =
|| if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_FREEBSD=
) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || defined (TARGET=
_OPENBSD) || defined(TARGET_DARWIN) */</span><br><span> </span><br><span> b=
ool</span><br><span> tun_name_is_fixed(const char *dev)</span><br><span>@@ =
-2054,13 +2044,13 @@</span><br><span>     free(tt);</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span>=
 write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</sp=
an><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span=
> read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</sp=
an><br><span>     return read(tt-&gt;fd, buf, len);</span><br><span>@@ -226=
8,27 +2258,18 @@</span><br><span>     free(tt);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ss=
ize_t</span><br><span> write_tun(struct tuntap *tt, uint8_t *buf, int len)<=
/span><br><span> {</span><br><span>     return write(tt-&gt;fd, buf, len);<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
size_t</span><br><span> read_tun(struct tuntap *tt, uint8_t *buf, int len)<=
/span><br><span> {</span><br><span>     return read(tt-&gt;fd, buf, len);</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGET_SOLARIS)</=
span><br><span> </span><br><span> #ifndef TUNNEWPPA</span><br><span>@@ -261=
3,7 +2594,7 @@</span><br><span>     argv_free(&amp;argv);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br>=
<span> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span>=
 {</span><br><span>     struct strbuf sbuf;</span><br><span>@@ -2622,7 +260=
3,7 @@</span><br><span>     return putmsg(tt-&gt;fd, NULL, &amp;sbuf, 0) &g=
t;=3D 0 ? sbuf.len : -1;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ssize_t</span><br><span> read_tun(struct tuntap *tt=
, uint8_t *buf, int len)</span><br><span> {</span><br><span>     struct str=
buf sbuf;</span><br><span>@@ -3097,11 +3078,6 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quo=
t;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> void</span><br><span> close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx=
)</span><br><span> {</span><br><span>@@ -3125,7 +3101,7 @@</span><br><span>=
     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ssize_t</span><br><span> write_tun(struct tuntap *tt,=
 uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;=
backend_driver =3D=3D DRIVER_UTUN)</span><br><span>@@ -3138,7 +3114,7 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ssize_t</span><br><span> read_tun(struct tuntap *tt, ui=
nt8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;bac=
kend_driver =3D=3D DRIVER_UTUN)</span><br><span>@@ -3151,10 +3127,6 @@</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defin=
ed(TARGET_AIX)</span><br><span> </span><br><span> void</span><br><span>@@ -=
3277,13 +3249,13 @@</span><br><span>     argv_free(&amp;argv);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span=
><br><span> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><=
span> {</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</spa=
n><br><span> read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><=
span> {</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><s=
pan>@@ -6329,13 +6301,13 @@</span><br><span>     free(tt);</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br=
><span> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span=
> {</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><b=
r><span> read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span=
> {</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><span>=
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index e1=
3f99f..77c3c09 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><sp=
an>+++ b/src/openvpn/tun.h</span><br><span>@@ -274,9 +274,9 @@</span><br><s=
pan> </span><br><span> void close_tun_handle(struct tuntap *tt);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int write_tun(=
struct tuntap *tt, uint8_t *buf, int len);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ssize_t write_tun(struct tuntap *tt, uint8_t *buf, i=
nt len);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int read_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ssize_t read_tun(struct tuntap *tt=
, uint8_t *buf, int len);</span><br><span> </span><br><span> void tuncfg(co=
nst char *dev, const char *dev_type, const char *dev_node, int persist_mode=
,</span><br><span>             const char *username, const char *groupname,=
 const struct tuntap_options *options,</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1376?usp=3D=
email">change 1376</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1376?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I67f5bf53b80f53fd2e349f84447=
9ed172a7b3aa1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1376 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--YPezh1zX4Os=--

