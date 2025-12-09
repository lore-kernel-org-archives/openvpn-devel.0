From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 18:12:06 +0000
In-Reply-To: <gerrit.1762964572000.I67f5bf53b80f53fd2e349f844479ed172a7b3aa1@...2715...>
References: <gerrit.1762964572000.I67f5bf53b80f53fd2e349f844479ed172a7b3aa1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1310b2a94c9b44296c8bbdb22ff58becd3bac006-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mxI73+5n8bI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mxI73+5n8bI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#11) to the change originally created b=
y flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1376?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1376
Message-Id: <20251209153715.15832-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
961.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/tun.c
M src/openvpn/tun.h
3 files changed, 28 insertions(+), 56 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1376/11

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6f1bc0c..913fb92 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1292,11 +1292,6 @@
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
@@ -1323,11 +1318,11 @@
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

@@ -1357,6 +1352,11 @@
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
index b4e3cb4..0299285 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1706,8 +1706,8 @@
 #include <netinet/ip.h>
 #include <sys/uio.h>

-static inline int
-header_modify_read_write_return(int len)
+static inline ssize_t
+header_modify_read_write_return(ssize_t len)
 {
     if (len > 0)
     {
@@ -1719,12 +1719,7 @@
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
@@ -1755,7 +1750,7 @@
     }
 }

-static int
+static ssize_t
 read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
@@ -1776,30 +1771,25 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* For MacOS this extra handling is conditional on the UTUN driver.
  * So it needs its own read_tun()/write_tun() with the necessary
  * checks. They are located in the macOS-specific section below.
  */
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
@@ -2056,13 +2046,13 @@
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
@@ -2261,27 +2251,18 @@
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
@@ -2606,7 +2587,7 @@
     argv_free(&argv);
 }

-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
@@ -2615,7 +2596,7 @@
     return putmsg(tt->fd, NULL, &sbuf, 0) >=3D 0 ? sbuf.len : -1;
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
@@ -3090,11 +3071,6 @@
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
@@ -3118,7 +3094,7 @@
     gc_free(&gc);
 }

-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
@@ -3131,7 +3107,7 @@
     }
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
@@ -3144,10 +3120,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #elif defined(TARGET_AIX)

 void
@@ -3270,13 +3242,13 @@
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
@@ -6322,13 +6294,13 @@
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
index 876f147..8bc876e 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -274,9 +274,9 @@

 void close_tun_handle(struct tuntap *tt);

-int write_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t write_tun(struct tuntap *tt, uint8_t *buf, int len);

-int read_tun(struct tuntap *tt, uint8_t *buf, int len);
+ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);

 #ifdef ENABLE_FEATURE_TUN_PERSIST
 void tuncfg(const char *dev, const char *dev_type, const char *dev_node, i=
nt persist_mode,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1376?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I67f5bf53b80f53fd2e349f844479ed172a7b3aa1
Gerrit-Change-Number: 1376
Gerrit-PatchSet: 11
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mxI73+5n8bI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #11</strong> to the change originally created by flichtenhe=
ld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1376?usp=3Demail=
">View Change</a></p><p>The following approvals got outdated and were remov=
ed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">tun: Change return type of write_tu=
n/read_tun to ssize_t<br><br>So we can directly give back the actual return=
<br>type from write/read. Even if we then cast it<br>back to int. The cast =
should be safe since we<br>also specify an int as we also put an int in<br>=
as length.<br><br>Change-Id: I67f5bf53b80f53fd2e349f844479ed172a7b3aa1<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert =
Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c=
/openvpn/+/1376<br>Message-Id: &lt;20251209153715.15832-1-gert@...1296...&g=
t;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg34961.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>--=
-<br>M src/openvpn/forward.c<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<=
br>3 files changed, 28 insertions(+), 56 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1376/=
11</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span=
><br><span>index 6f1bc0c..913fb92 100644</span><br><span>--- a/src/openvpn/=
forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1=
292,11 +1292,6 @@</span><br><span> #endif /* if defined(ENABLE_DCO) &amp;&a=
mp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD)) */</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br=
><span>  * Output: c-&gt;c2.buf</span><br><span>  */</span><br><span>@@ -13=
23,11 +1318,11 @@</span><br><span>     if (c-&gt;c1.tuntap-&gt;backend_driv=
er =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>         c-=
&gt;c2.buf.len =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         read_tun_afunix(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf), c-&gt;c2=
.frame.buf.payload_size);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            (int)read_tun_afunix(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.=
buf), c-&gt;c2.frame.buf.payload_size);</span><br><span>     }</span><br><s=
pan>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        c-&gt;c2.buf.len =3D read_tun(c-&gt;c1.tuntap, BPTR(=
&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2.buf.len =3D (int)read_tu=
n(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size=
);</span><br><span>     }</span><br><span> #endif /* ifdef _WIN32 */</span>=
<br><span> </span><br><span>@@ -1357,6 +1352,11 @@</span><br><span>     che=
ck_status(c-&gt;c2.buf.len, &quot;read from TUN/TAP&quot;, NULL, c-&gt;c1.t=
untap);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /**</span><br><span>  * Drops UDP packets which OS d=
ecided to route via tun.</span><br><span>  *</span><br><span>diff --git a/s=
rc/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index b4e3cb4..0299285=
 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/o=
penvpn/tun.c</span><br><span>@@ -1706,8 +1706,8 @@</span><br><span> #includ=
e &lt;netinet/ip.h&gt;</span><br><span> #include &lt;sys/uio.h&gt;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inlin=
e int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-header_modify_re=
ad_write_return(int len)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static inline ssize_t</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+header_modify_read_write_return(ssize_t len)</span><br><span> {</spa=
n><br><span>     if (len &gt; 0)</span><br><span>     {</span><br><span>@@ =
-1719,12 +1719,7 @@</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static ssize_t</span><br><span> write_tun_header(struct tuntap *tt, uint8=
_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;type =
=3D=3D DEV_TYPE_TUN)</span><br><span>@@ -1755,7 +1750,7 @@</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static ssize_t</span><br><span> read_tun_header(struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-=
&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>@@ -1776,30 +1771,25 @@</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* For MacOS=
 this extra handling is conditional on the UTUN driver.</span><br><span>  *=
 So it needs its own read_tun()/write_tun() with the necessary</span><br><s=
pan>  * checks. They are located in the macOS-specific section below.</span=
><br><span>  */</span><br><span> #if !defined(TARGET_DARWIN)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ssize_t</span><br><span> write_tun(struct tuntap *tt=
, uint8_t *buf, int len)</span><br><span> {</span><br><span>     return wri=
te_tun_header(tt, buf, len);</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ssize_t</span><br><span> read_tun(struct tuntap=
 *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     return=
 read_tun_header(tt, buf, len);</span><br><span> }</span><br><span> #endif<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* defined(TARGET_=
FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || if defin=
ed (TARGET_OPENBSD) || defined(TARGET_DARWIN) */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_FREEBSD) || define=
d(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || defined (TARGET_OPENBSD) |=
| defined(TARGET_DARWIN) */</span><br><span> </span><br><span> bool</span><=
br><span> tun_name_is_fixed(const char *dev)</span><br><span>@@ -2056,13 +2=
046,13 @@</span><br><span>     free(tt);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> write_tun(=
struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><spa=
n>     return write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> read_tun(=
struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><spa=
n>     return read(tt-&gt;fd, buf, len);</span><br><span>@@ -2261,27 +2251,=
18 @@</span><br><span>     free(tt);</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span=
><br><span> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><=
span> {</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</spa=
n><br><span> read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><=
span> {</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> #elif defined(TARGET_SOLARIS)</span><br>=
<span> </span><br><span> #ifndef TUNNEWPPA</span><br><span>@@ -2606,7 +2587=
,7 @@</span><br><span>     argv_free(&amp;argv);</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> wr=
ite_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span>=
<br><span>     struct strbuf sbuf;</span><br><span>@@ -2615,7 +2596,7 @@</s=
pan><br><span>     return putmsg(tt-&gt;fd, NULL, &amp;sbuf, 0) &gt;=3D 0 ?=
 sbuf.len : -1;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ssize_t</span><br><span> read_tun(struct tuntap *tt, uint8_=
t *buf, int len)</span><br><span> {</span><br><span>     struct strbuf sbuf=
;</span><br><span>@@ -3090,11 +3071,6 @@</span><br><span>     }</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconv=
ersion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</=
span><br><span> close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span>=
<br><span> {</span><br><span>@@ -3118,7 +3094,7 @@</span><br><span>     gc_=
free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ssize_t</span><br><span> write_tun(struct tuntap *tt, uint8=
_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;backen=
d_driver =3D=3D DRIVER_UTUN)</span><br><span>@@ -3131,7 +3107,7 @@</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ssize_t</span><br><span> read_tun(struct tuntap *tt, uint8_=
t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;backend=
_driver =3D=3D DRIVER_UTUN)</span><br><span>@@ -3144,10 +3120,6 @@</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defined=
(TARGET_AIX)</span><br><span> </span><br><span> void</span><br><span>@@ -32=
70,13 +3242,13 @@</span><br><span>     argv_free(&amp;argv);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><=
br><span> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><sp=
an> {</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span>=
<br><span> read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><sp=
an> {</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><spa=
n>@@ -6322,13 +6294,13 @@</span><br><span>     free(tt);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><=
span> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> =
{</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br>=
<span> read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> =
{</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><span>di=
ff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index 876f=
147..8bc876e 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><span=
>+++ b/src/openvpn/tun.h</span><br><span>@@ -274,9 +274,9 @@</span><br><spa=
n> </span><br><span> void close_tun_handle(struct tuntap *tt);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int write_tun(st=
ruct tuntap *tt, uint8_t *buf, int len);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ssize_t write_tun(struct tuntap *tt, uint8_t *buf, int=
 len);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int read_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ssize_t read_tun(struct tuntap *tt, =
uint8_t *buf, int len);</span><br><span> </span><br><span> #ifdef ENABLE_FE=
ATURE_TUN_PERSIST</span><br><span> void tuncfg(const char *dev, const char =
*dev_type, const char *dev_node, int persist_mode,</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1376?usp=3Demail">change 1376</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/13=
76?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I67f5bf53b80f53fd2e349f84447=
9ed172a7b3aa1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1376 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--mxI73+5n8bI=--

