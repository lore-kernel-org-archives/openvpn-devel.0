From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 11:19:33 +0000
In-Reply-To: <gerrit.1763122662000.Ifd9384287648d1f37a625d9ed6a09733208fa56c@...2715...>
References: <gerrit.1763122662000.Ifd9384287648d1f37a625d9ed6a09733208fa56c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <aa8babd4215dd0dae9e575a55d2e8ec0ffd9cbd3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dSeAITwnRwY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tun: Refactor BSD
 write_tun/read_tun
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

--dSeAITwnRwY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1378?usp=3Demail

to look at the new patch set (#7).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: tun: Refactor BSD write_tun/read_tun
......................................................................

tun: Refactor BSD write_tun/read_tun

There was a lot of duplicated code, merge it together.

Change-Id: Ifd9384287648d1f37a625d9ed6a09733208fa56c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/tun.c
1 file changed, 26 insertions(+), 233 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1378/7

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 7c61dcf..b4e3cb4 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1685,10 +1685,10 @@
 #endif
 }

-#if defined(TARGET_OPENBSD) || defined(TARGET_DARWIN)
+#if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET=
_NETBSD) || defined(TARGET_OPENBSD) || defined(TARGET_DARWIN)

 /*
- * OpenBSD and Mac OS X when using utun
+ * BSDs and Mac OS X when using utun
  * have a slightly incompatible TUN device from
  * the rest of the world, in that it prepends a
  * uint32 to the beginning of the IP header
@@ -1699,10 +1699,8 @@
  * We strip off this field on reads and
  * put it back on writes.
  *
- * I have not tested TAP devices on OpenBSD,
- * but I have conditionalized the special
- * TUN handling code described above to
- * go away for TAP devices.
+ * For TAP devices, this is not needed and must
+ * not be done.
  */

 #include <netinet/ip.h>
@@ -1733,11 +1731,9 @@
     {
         u_int32_t type;
         struct iovec iv[2];
-        struct openvpn_iphdr *iph;
+        struct ip *iph =3D (struct ip *)buf;

-        iph =3D (struct openvpn_iphdr *)buf;
-
-        if (OPENVPN_IPH_GET_VER(iph->version_len) =3D=3D 6)
+        if (iph->ip_v =3D=3D 6)
         {
             type =3D htonl(AF_INET6);
         }
@@ -1784,7 +1780,26 @@
 #pragma GCC diagnostic pop
 #endif

-#endif /* if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */
+/* For MacOS this extra handling is conditional on the UTUN driver.
+ * So it needs its own read_tun()/write_tun() with the necessary
+ * checks. They are located in the macOS-specific section below.
+ */
+#if !defined(TARGET_DARWIN)
+int
+write_tun(struct tuntap *tt, uint8_t *buf, int len)
+{
+    return write_tun_header(tt, buf, len);
+}
+
+int
+read_tun(struct tuntap *tt, uint8_t *buf, int len)
+{
+    return read_tun_header(tt, buf, len);
+}
+#endif
+
+
+#endif /* defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(=
TARGET_NETBSD) || if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */

 bool
 tun_name_is_fixed(const char *dev)
@@ -2679,18 +2694,6 @@
     argv_free(&argv);
 }

-int
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    return write_tun_header(tt, buf, len);
-}
-
-int
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    return read_tun_header(tt, buf, len);
-}
-
 #elif defined(TARGET_NETBSD)

 /*
@@ -2792,88 +2795,8 @@
     argv_free(&argv);
 }

-static inline int
-netbsd_modify_read_write_return(int len)
-{
-    if (len > 0)
-    {
-        return len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;
-    }
-    else
-    {
-        return len;
-    }
-}
-
-int
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type =3D=3D DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-        struct openvpn_iphdr *iph;
-
-        iph =3D (struct openvpn_iphdr *)buf;
-
-        if (OPENVPN_IPH_GET_VER(iph->version_len) =3D=3D 6)
-        {
-            type =3D htonl(AF_INET6);
-        }
-        else
-        {
-            type =3D htonl(AF_INET);
-        }
-
-        iv[0].iov_base =3D (char *)&type;
-        iv[0].iov_len =3D sizeof(type);
-        iv[1].iov_base =3D buf;
-        iv[1].iov_len =3D len;
-
-        return netbsd_modify_read_write_return(writev(tt->fd, iv, 2));
-    }
-    else
-    {
-        return write(tt->fd, buf, len);
-    }
-}
-
-int
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type =3D=3D DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-
-        iv[0].iov_base =3D (char *)&type;
-        iv[0].iov_len =3D sizeof(type);
-        iv[1].iov_base =3D buf;
-        iv[1].iov_len =3D len;
-
-        return netbsd_modify_read_write_return(readv(tt->fd, iv, 2));
-    }
-    else
-    {
-        return read(tt->fd, buf, len);
-    }
-}
-
 #elif defined(TARGET_FREEBSD)

-static inline int
-freebsd_modify_read_write_return(int len)
-{
-    if (len > 0)
-    {
-        return len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;
-    }
-    else
-    {
-        return len;
-    }
-}
-
 void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, stru=
ct tuntap *tt,
          openvpn_net_ctx_t *ctx)
@@ -2946,84 +2869,8 @@
     argv_free(&argv);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-int
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type =3D=3D DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-        struct ip *iph;
-
-        iph =3D (struct ip *)buf;
-
-        if (iph->ip_v =3D=3D 6)
-        {
-            type =3D htonl(AF_INET6);
-        }
-        else
-        {
-            type =3D htonl(AF_INET);
-        }
-
-        iv[0].iov_base =3D (char *)&type;
-        iv[0].iov_len =3D sizeof(type);
-        iv[1].iov_base =3D buf;
-        iv[1].iov_len =3D len;
-
-        return freebsd_modify_read_write_return(writev(tt->fd, iv, 2));
-    }
-    else
-    {
-        return write(tt->fd, buf, len);
-    }
-}
-
-int
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type =3D=3D DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-
-        iv[0].iov_base =3D (char *)&type;
-        iv[0].iov_len =3D sizeof(type);
-        iv[1].iov_base =3D buf;
-        iv[1].iov_len =3D len;
-
-        return freebsd_modify_read_write_return(readv(tt->fd, iv, 2));
-    }
-    else
-    {
-        return read(tt->fd, buf, len);
-    }
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #elif defined(TARGET_DRAGONFLY)

-static inline int
-dragonfly_modify_read_write_return(int len)
-{
-    if (len > 0)
-    {
-        return len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;
-    }
-    else
-    {
-        return len;
-    }
-}
-
 void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, stru=
ct tuntap *tt,
          openvpn_net_ctx_t *ctx)
@@ -3050,60 +2897,6 @@
     free(tt);
 }

-int
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type =3D=3D DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-        struct ip *iph;
-
-        iph =3D (struct ip *)buf;
-
-        if (iph->ip_v =3D=3D 6)
-        {
-            type =3D htonl(AF_INET6);
-        }
-        else
-        {
-            type =3D htonl(AF_INET);
-        }
-
-        iv[0].iov_base =3D (char *)&type;
-        iv[0].iov_len =3D sizeof(type);
-        iv[1].iov_base =3D buf;
-        iv[1].iov_len =3D len;
-
-        return dragonfly_modify_read_write_return(writev(tt->fd, iv, 2));
-    }
-    else
-    {
-        return write(tt->fd, buf, len);
-    }
-}
-
-int
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type =3D=3D DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-
-        iv[0].iov_base =3D (char *)&type;
-        iv[0].iov_len =3D sizeof(type);
-        iv[1].iov_base =3D buf;
-        iv[1].iov_len =3D len;
-
-        return dragonfly_modify_read_write_return(readv(tt->fd, iv, 2));
-    }
-    else
-    {
-        return read(tt->fd, buf, len);
-    }
-}
-
 #elif defined(TARGET_DARWIN)

 /* Darwin (MacOS X) is mostly "just use the generic stuff", but there

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1378?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd9384287648d1f37a625d9ed6a09733208fa56c
Gerrit-Change-Number: 1378
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--dSeAITwnRwY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #7</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1378?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">tun: Refactor BSD write_tun/read_tu=
n<br><br>There was a lot of duplicated code, merge it together.<br><br>Chan=
ge-Id: Ifd9384287648d1f37a625d9ed6a09733208fa56c<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file =
changed, 26 insertions(+), 233 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1378/7</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 7c=
61dcf..b4e3cb4 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><sp=
an>+++ b/src/openvpn/tun.c</span><br><span>@@ -1685,10 +1685,10 @@</span><b=
r><span> #endif</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_OPENBSD) || defined(TARG=
ET_DARWIN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) |=
| defined(TARGET_OPENBSD) || defined(TARGET_DARWIN)</span><br><span> </span=
><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Open=
BSD and Mac OS X when using utun</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * BSDs and Mac OS X when using utun</span><br><span>  * have =
a slightly incompatible TUN device from</span><br><span>  * the rest of the=
 world, in that it prepends a</span><br><span>  * uint32 to the beginning o=
f the IP header</span><br><span>@@ -1699,10 +1699,8 @@</span><br><span>  * =
We strip off this field on reads and</span><br><span>  * put it back on wri=
tes.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * I have not tested TAP devices on OpenBSD,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * but I have conditionalized the special</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * TUN handling code describe=
d above to</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * go away =
for TAP devices.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
For TAP devices, this is not needed and must</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * not be done.</span><br><span>  */</span><br><sp=
an> </span><br><span> #include &lt;netinet/ip.h&gt;</span><br><span>@@ -173=
3,11 +1731,9 @@</span><br><span>     {</span><br><span>         u_int32_t t=
ype;</span><br><span>         struct iovec iv[2];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        struct openvpn_iphdr *iph;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct ip *iph =3D (stru=
ct ip *)buf;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        iph =3D (struct openvpn_iphdr *)buf;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (OPENVPN_IPH_GET_VER(iph-&gt;version_len) =3D=3D 6)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (iph-&gt;i=
p_v =3D=3D 6)</span><br><span>         {</span><br><span>             type =
=3D htonl(AF_INET6);</span><br><span>         }</span><br><span>@@ -1784,7 =
+1780,26 @@</span><br><span> #pragma GCC diagnostic pop</span><br><span> #e=
ndif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif /* if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* For MacOS this extra han=
dling is conditional on the UTUN driver.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * So it needs its own read_tun()/write_tun() with the=
 necessary</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * checks=
. They are located in the macOS-specific section below.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if !defined(TARGET_DARWIN)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return write_tun_header(tt, buf, len);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read=
_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return read_tun_header(tt, buf, len);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(TARGET_FREEBSD) || d=
efined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || if defined (TARGET_OP=
ENBSD) || defined(TARGET_DARWIN) */</span><br><span> </span><br><span> bool=
</span><br><span> tun_name_is_fixed(const char *dev)</span><br><span>@@ -26=
79,18 +2694,6 @@</span><br><span>     argv_free(&amp;argv);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct t=
untap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn write_tun_header(tt, buf, len);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int =
len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return read_tun_header(tt, buf, l=
en);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGE=
T_NETBSD)</span><br><span> </span><br><span> /*</span><br><span>@@ -2792,88=
 +2795,8 @@</span><br><span>     argv_free(&amp;argv);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-netbsd_mo=
dify_read_write_return(int len)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (le=
n &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return len &gt; size=
of(u_int32_t) ? len - sizeof(u_int32_t) : 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return len;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap =
*tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt=
;type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u_i=
nt32_t type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
truct iovec iv[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     struct openvpn_iphdr *iph;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iph=
 =3D (struct openvpn_iphdr *)buf;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (OPENVPN_IPH_GET_VER(iph-&gt;version_len) =3D=3D 6)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            type =3D htonl(AF_INET6);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            type =3D htonl(AF_INET);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[0].i=
ov_base =3D (char *)&amp;type;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        iv[0].iov_len =3D sizeof(type);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        iv[1].iov_base =3D buf;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        iv[1].iov_len =3D len;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return netbsd_modify_read_write_return(wri=
tev(tt-&gt;fd, iv, 2));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return write(tt-&gt;fd, buf, len);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap=
 *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&g=
t;type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u_=
int32_t type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
struct iovec iv[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[0].iov_base =
=3D (char *)&amp;type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        iv[0].iov_len =3D sizeof(type);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        iv[1].iov_base =3D buf;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        iv[1].iov_len =3D len;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return netbsd_modify_read_write_return(readv(tt-&g=
t;fd, iv, 2));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return read(tt-&gt;fd, buf, len);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> #elif defined(TARGET_FREEBSD)</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-freebsd_modify_read_write_re=
turn(int len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (len &gt; 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return len &gt; sizeof(u_int32_t) ? le=
n - sizeof(u_int32_t) : 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return len;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> void</span><br><span> open_tun(const char *dev, const char *=
dev_type, const char *dev_node, struct tuntap *tt,</span><br><span>        =
  openvpn_net_ctx_t *ctx)</span><br><span>@@ -2946,84 +2869,8 @@</span><br>=
<span>     argv_free(&amp;argv);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tu=
ntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (t=
t-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  u_int32_t type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    struct iovec iv[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct ip *iph;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iph =3D (=
struct ip *)buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (iph-&gt;ip_v =
=3D=3D 6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            type =3D hto=
nl(AF_INET6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            type =3D htonl(AF_INET);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        iv[0].iov_base =3D (char *)&amp;type;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        iv[0].iov_len =3D sizeof(ty=
pe);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1].iov=
_base =3D buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 iv[1].iov_len =3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return free=
bsd_modify_read_write_return(writev(tt-&gt;fd, iv, 2));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn write(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        u_int32_t type;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        struct iovec iv[2];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        iv[0].iov_base =3D (char *)&amp;type;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        iv[0].iov_len =3D sizeof(type);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1].iov_base=
 =3D buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1=
].iov_len =3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return freebsd_m=
odify_read_write_return(readv(tt-&gt;fd, iv, 2));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return re=
ad(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGET_DRA=
GONFLY)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
dragonfly_modify_read_write_return(int len)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (len &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return l=
en &gt; sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> open_tun=
(const char *dev, const char *dev_type, const char *dev_node, struct tuntap=
 *tt,</span><br><span>          openvpn_net_ctx_t *ctx)</span><br><span>@@ =
-3050,60 +2897,6 @@</span><br><span>     free(tt);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt=
, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;ty=
pe =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u_int3=
2_t type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stru=
ct iovec iv[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct ip *iph;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        iph =3D (struct i=
p *)buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (iph-&gt;ip_v =3D=3D 6)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            type =3D htonl(AF_INE=
T6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            type =3D htonl(AF_INET);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        iv[0].iov_base =3D (char *)&amp;type;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        iv[0].iov_len =3D sizeof(type);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1].iov_base =
=3D buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1]=
.iov_len =3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return dragonfly_=
modify_read_write_return(writev(tt-&gt;fd, iv, 2));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n write(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        u_int32_t type;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        struct iovec iv[2];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        iv[0].iov_base =3D (char *)&amp;type;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        iv[0].iov_len =3D sizeof(type);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1].iov_base =
=3D buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1]=
.iov_len =3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return dragonfly_=
modify_read_write_return(readv(tt-&gt;fd, iv, 2));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return r=
ead(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(=
TARGET_DARWIN)</span><br><span> </span><br><span> /* Darwin (MacOS X) is mo=
stly &quot;just use the generic stuff&quot;, but there</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1378?usp=3Demail">change 1378</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1378?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd9384287648d1f37a625d9ed6a=
09733208fa56c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1378 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--dSeAITwnRwY=--

