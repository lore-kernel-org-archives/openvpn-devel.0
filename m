From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 16:21:45 +0000
In-Reply-To: <gerrit.1762964572000.I67f5bf53b80f53fd2e349f844479ed172a7b3aa1@...2715...>
References: <gerrit.1762964572000.I67f5bf53b80f53fd2e349f844479ed172a7b3aa1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <e4b9774d21d10cea68ef5d8880036d18f736c751-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s/XKuTGK+OE="; charset=UTF-8
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

--s/XKuTGK+OE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1376?usp=3Demail

to look at the new patch set (#9).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1376/9

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
index 9c04b6b..d2274e0 100644
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
@@ -2259,27 +2249,18 @@
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
@@ -2604,7 +2585,7 @@
     argv_free(&argv);
 }

-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
@@ -2613,7 +2594,7 @@
     return putmsg(tt->fd, NULL, &sbuf, 0) >=3D 0 ? sbuf.len : -1;
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     struct strbuf sbuf;
@@ -3088,11 +3069,6 @@
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
@@ -3116,7 +3092,7 @@
     gc_free(&gc);
 }

-int
+ssize_t
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
@@ -3129,7 +3105,7 @@
     }
 }

-int
+ssize_t
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
@@ -3142,10 +3118,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #elif defined(TARGET_AIX)

 void
@@ -3268,13 +3240,13 @@
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
@@ -6320,13 +6292,13 @@
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
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--s/XKuTGK+OE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #9</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1376?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">tun: Change return type of write_tun=
/read_tun to ssize_t<br><br>So we can directly give back the actual return<=
br>type from write/read. Even if we then cast it<br>back to int. The cast s=
hould be safe since we<br>also specify an int as we also put an int in<br>a=
s length.<br><br>Change-Id: I67f5bf53b80f53fd2e349f844479ed172a7b3aa1<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/ope=
nvpn/forward.c<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>3 files cha=
nged, 28 insertions(+), 56 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/1376/9</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>inde=
x 6f1bc0c..913fb92 100644</span><br><span>--- a/src/openvpn/forward.c</span=
><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1292,11 +1292,6 =
@@</span><br><span> #endif /* if defined(ENABLE_DCO) &amp;&amp; (defined(TA=
RGET_LINUX) || defined(TARGET_FREEBSD)) */</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Ou=
tput: c-&gt;c2.buf</span><br><span>  */</span><br><span>@@ -1323,11 +1318,1=
1 @@</span><br><span>     if (c-&gt;c1.tuntap-&gt;backend_driver =3D=3D DRI=
VER_AFUNIX)</span><br><span>     {</span><br><span>         c-&gt;c2.buf.le=
n =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            read=
_tun_afunix(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.pa=
yload_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     (int)read_tun_afunix(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf), c-&gt;c=
2.frame.buf.payload_size);</span><br><span>     }</span><br><span>     else=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        c-&gt;c2.buf.len =3D read_tun(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2=
.buf), c-&gt;c2.frame.buf.payload_size);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        c-&gt;c2.buf.len =3D (int)read_tun(c-&gt;c1.tu=
ntap, BPTR(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size);</span><br>=
<span>     }</span><br><span> #endif /* ifdef _WIN32 */</span><br><span> </=
span><br><span>@@ -1357,6 +1352,11 @@</span><br><span>     check_status(c-&=
gt;c2.buf.len, &quot;read from TUN/TAP&quot;, NULL, c-&gt;c1.tuntap);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /**</span><br><span>  * Drops UDP packets which OS decided to rou=
te via tun.</span><br><span>  *</span><br><span>diff --git a/src/openvpn/tu=
n.c b/src/openvpn/tun.c</span><br><span>index 9c04b6b..d2274e0 100644</span=
><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c<=
/span><br><span>@@ -1708,8 +1708,8 @@</span><br><span> #include &lt;netinet=
/ip.h&gt;</span><br><span> #include &lt;sys/uio.h&gt;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-header_modify_read_write_retu=
rn(int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nline ssize_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+header=
_modify_read_write_return(ssize_t len)</span><br><span> {</span><br><span> =
    if (len &gt; 0)</span><br><span>     {</span><br><span>@@ -1721,12 +172=
1,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static ssize_=
t</span><br><span> write_tun_header(struct tuntap *tt, uint8_t *buf, int le=
n)</span><br><span> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_=
TUN)</span><br><span>@@ -1757,7 +1752,7 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic ssize_t</span><br><span> read_tun_header(struct tuntap *tt, uint8_t *bu=
f, int len)</span><br><span> {</span><br><span>     if (tt-&gt;type =3D=3D =
DEV_TYPE_TUN)</span><br><span>@@ -1778,26 +1773,21 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> #if !defined(TARGET_DARWIN)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> write_tun(str=
uct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span> =
    return write_tun_header(tt, buf, len);</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span> read_tun=
(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><sp=
an>     return read_tun_header(tt, buf, len);</span><br><span> }</span><br>=
<span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* d=
efined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBS=
D) || if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_FREE=
BSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || defined (TAR=
GET_OPENBSD) || defined(TARGET_DARWIN) */</span><br><span> </span><br><span=
> bool</span><br><span> tun_name_is_fixed(const char *dev)</span><br><span>=
@@ -2054,13 +2044,13 @@</span><br><span>     free(tt);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><sp=
an> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {<=
/span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><s=
pan> read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {<=
/span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><span>@@ -=
2259,27 +2249,18 @@</span><br><span>     free(tt);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ssize_t</span><br><span> write_tun(struct tuntap *tt, uint8_t *buf, int le=
n)</span><br><span> {</span><br><span>     return write(tt-&gt;fd, buf, len=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ssize_t</span><br><span> read_tun(struct tuntap *tt, uint8_t *buf, int le=
n)</span><br><span> {</span><br><span>     return read(tt-&gt;fd, buf, len)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGET_SOLARIS=
)</span><br><span> </span><br><span> #ifndef TUNNEWPPA</span><br><span>@@ -=
2604,7 +2585,7 @@</span><br><span>     argv_free(&amp;argv);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><=
br><span> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><sp=
an> {</span><br><span>     struct strbuf sbuf;</span><br><span>@@ -2613,7 +=
2594,7 @@</span><br><span>     return putmsg(tt-&gt;fd, NULL, &amp;sbuf, 0)=
 &gt;=3D 0 ? sbuf.len : -1;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ssize_t</span><br><span> read_tun(struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     struct =
strbuf sbuf;</span><br><span>@@ -3088,11 +3069,6 @@</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &=
quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> void</span><br><span> close_tun(struct tuntap *tt, openvpn_net_ctx_t *=
ctx)</span><br><span> {</span><br><span>@@ -3116,7 +3092,7 @@</span><br><sp=
an>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ssize_t</span><br><span> write_tun(struct tuntap *=
tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&=
gt;backend_driver =3D=3D DRIVER_UTUN)</span><br><span>@@ -3129,7 +3105,7 @@=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ssize_t</span><br><span> read_tun(struct tuntap *tt,=
 uint8_t *buf, int len)</span><br><span> {</span><br><span>     if (tt-&gt;=
backend_driver =3D=3D DRIVER_UTUN)</span><br><span>@@ -3142,10 +3118,6 @@</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif de=
fined(TARGET_AIX)</span><br><span> </span><br><span> void</span><br><span>@=
@ -3268,13 +3240,13 @@</span><br><span>     argv_free(&amp;argv);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</s=
pan><br><span> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><b=
r><span> {</span><br><span>     return write(tt-&gt;fd, buf, len);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</=
span><br><span> read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><b=
r><span> {</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br=
><span>@@ -6320,13 +6292,13 @@</span><br><span>     free(tt);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span>=
<br><span> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><s=
pan> {</span><br><span>     return write(tt-&gt;fd, buf, len);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span=
><br><span> read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><s=
pan> {</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><sp=
an>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index=
 876f147..8bc876e 100644</span><br><span>--- a/src/openvpn/tun.h</span><br>=
<span>+++ b/src/openvpn/tun.h</span><br><span>@@ -274,9 +274,9 @@</span><br=
><span> </span><br><span> void close_tun_handle(struct tuntap *tt);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int write_t=
un(struct tuntap *tt, uint8_t *buf, int len);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ssize_t write_tun(struct tuntap *tt, uint8_t *buf=
, int len);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-int read_tun(struct tuntap *tt, uint8_t *buf, int len);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ssize_t read_tun(struct tuntap =
*tt, uint8_t *buf, int len);</span><br><span> </span><br><span> #ifdef ENAB=
LE_FEATURE_TUN_PERSIST</span><br><span> void tuncfg(const char *dev, const =
char *dev_type, const char *dev_node, int persist_mode,</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1376?usp=3Demail">change 1376</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1376?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I67f5bf53b80f53fd2e349f84447=
9ed172a7b3aa1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1376 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--s/XKuTGK+OE=--

