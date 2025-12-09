From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 15:25:38 +0000
In-Reply-To: <gerrit.1763122662000.Ifd9384287648d1f37a625d9ed6a09733208fa56c@...2715...>
References: <gerrit.1763122662000.Ifd9384287648d1f37a625d9ed6a09733208fa56c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e184d4b67a7659d02180569fb042997639ec1f4f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/bS6mq56AtI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/bS6mq56AtI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1378?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: tun: Refactor BSD write_tun/read_tun
......................................................................

tun: Refactor BSD write_tun/read_tun

There was a lot of duplicated code, merge it together.

Change-Id: Ifd9384287648d1f37a625d9ed6a09733208fa56c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1378
Message-Id: <20251209133038.5088-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
946.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
1 file changed, 26 insertions(+), 233 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/1378/8

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
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/bS6mq56AtI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1378?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">tun: Refactor BSD write_tun/read_tu=
n<br><br>There was a lot of duplicated code, merge it together.<br><br>Chan=
ge-Id: Ifd9384287648d1f37a625d9ed6a09733208fa56c<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1378<br>Mes=
sage-Id: &lt;20251209133038.5088-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34946.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/tun.=
c<br>1 file changed, 26 insertions(+), 233 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/137=
8/8</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><s=
pan>index 7c61dcf..b4e3cb4 100644</span><br><span>--- a/src/openvpn/tun.c</=
span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -1685,10 +1685,10=
 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_OPENBSD) || d=
efined(TARGET_DARWIN)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGE=
T_NETBSD) || defined(TARGET_OPENBSD) || defined(TARGET_DARWIN)</span><br><s=
pan> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * OpenBSD and Mac OS X when using utun</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * BSDs and Mac OS X when using utun</span><br><spa=
n>  * have a slightly incompatible TUN device from</span><br><span>  * the =
rest of the world, in that it prepends a</span><br><span>  * uint32 to the =
beginning of the IP header</span><br><span>@@ -1699,10 +1699,8 @@</span><br=
><span>  * We strip off this field on reads and</span><br><span>  * put it =
back on writes.</span><br><span>  *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * I have not tested TAP devices on OpenBSD,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * but I have conditionalized the spec=
ial</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * TUN handling co=
de described above to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * go away for TAP devices.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * For TAP devices, this is not needed and must</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * not be done.</span><br><span>  */</s=
pan><br><span> </span><br><span> #include &lt;netinet/ip.h&gt;</span><br><s=
pan>@@ -1733,11 +1731,9 @@</span><br><span>     {</span><br><span>         =
u_int32_t type;</span><br><span>         struct iovec iv[2];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        struct openvpn_iphdr *iph;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct ip *ip=
h =3D (struct ip *)buf;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        iph =3D (struct openvpn_iphdr *)buf;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (OPENVPN_IPH_GET_VER(iph-&gt;version_len) =
=3D=3D 6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (iph-&gt;ip_v =3D=3D 6)</span><br><span>         {</span><br><span>       =
      type =3D htonl(AF_INET6);</span><br><span>         }</span><br><span>=
@@ -1784,7 +1780,26 @@</span><br><span> #pragma GCC diagnostic pop</span><b=
r><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif /* if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN)=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* For MacOS thi=
s extra handling is conditional on the UTUN driver.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * So it needs its own read_tun()/write_t=
un() with the necessary</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * checks. They are located in the macOS-specific section below.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_DARWIN)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+write_tun(struct tuntap *tt, uint8_t *buf, int le=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return write_tun_header(tt, buf=
, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return read_tun_header(tt, buf, len);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(TARGET=
_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || if defi=
ned (TARGET_OPENBSD) || defined(TARGET_DARWIN) */</span><br><span> </span><=
br><span> bool</span><br><span> tun_name_is_fixed(const char *dev)</span><b=
r><span>@@ -2679,18 +2694,6 @@</span><br><span>     argv_free(&amp;argv);</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-writ=
e_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return write_tun_header(tt, buf, len);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint=
8_t *buf, int len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return read_tun_hea=
der(tt, buf, len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif=
 defined(TARGET_NETBSD)</span><br><span> </span><br><span> /*</span><br><sp=
an>@@ -2792,88 +2795,8 @@</span><br><span>     argv_free(&amp;argv);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-netbsd_modify_read_write_return(int len)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (len &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return=
 len &gt; sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
return len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(=
struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        u_int32_t type;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        struct iovec iv[2];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct openvpn_iphdr *iph;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        iph =3D (struct openvpn_iphdr *)buf;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (OPENVPN_IPH_GET_VER(iph-&gt;version_len) =3D=3D 6)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            type =3D htonl(AF_INET6);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            type =3D htonl(AF_INET);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       iv[0].iov_base =3D (char *)&amp;type;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        iv[0].iov_len =3D sizeof(type);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        iv[1].iov_base =3D buf;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1].iov_len =
=3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return netbsd_modify_read_=
write_return(writev(tt-&gt;fd, iv, 2));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return write(tt-&gt=
;fd, buf, len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_t=
un(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        u_int32_t type;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        struct iovec iv[2];</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 iv[0].iov_base =3D (char *)&amp;type;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        iv[0].iov_len =3D sizeof(type);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        iv[1].iov_base =3D buf;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1].iov_len =3D len;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return netbsd_modify_read_write_re=
turn(readv(tt-&gt;fd, iv, 2));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return read(tt-&gt;fd, buf, =
len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGET_FREEBSD)</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static i=
nline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-freebsd_modi=
fy_read_write_return(int len)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (len =
&gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return len &gt; sizeof=
(u_int32_t) ? len - sizeof(u_int32_t) : 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return len;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> void</span><br><span> open_tun(const char *d=
ev, const char *dev_type, const char *dev_node, struct tuntap *tt,</span><b=
r><span>          openvpn_net_ctx_t *ctx)</span><br><span>@@ -2946,84 +2869=
,8 @@</span><br><span>     argv_free(&amp;argv);</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wri=
te_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        u_int32_t type;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        struct iovec iv[2];</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct ip *iph;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       iph =3D (struct ip *)buf;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (iph-&gt;ip_v =3D=3D 6)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   type =3D htonl(AF_INET6);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            type =3D htonl=
(AF_INET);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        iv[0].iov_base =3D (char *)&amp;typ=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[0].iov_l=
en =3D sizeof(type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       iv[1].iov_base =3D buf;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        iv[1].iov_len =3D len;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return freebsd_modify_read_write_return(writev(tt-&gt;fd, iv, 2));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return write(tt-&gt;fd, buf, len);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TUN)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        u_int32_t type;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        struct iovec iv[2];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        iv[0].iov_base =3D (char *)&amp;type;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[0].iov_len =3D =
sizeof(type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
iv[1].iov_base =3D buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        iv[1].iov_len =3D len;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn freebsd_modify_read_write_return(readv(tt-&gt;fd, iv, 2));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return read(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif defi=
ned(TARGET_DRAGONFLY)</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-dragonfly_modify_read_write_return(int len)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (len &gt; 0)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return len &gt; sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return len;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><=
span> open_tun(const char *dev, const char *dev_type, const char *dev_node,=
 struct tuntap *tt,</span><br><span>          openvpn_net_ctx_t *ctx)</span=
><br><span>@@ -3050,60 +2897,6 @@</span><br><span>     free(tt);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(str=
uct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        u_int32_t type;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct iovec iv[2];</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        struct ip *iph;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iph=
 =3D (struct ip *)buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (iph-&gt;=
ip_v =3D=3D 6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            type =
=3D htonl(AF_INET6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            type =3D htonl(AF_INET=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        iv[0].iov_base =3D (char *)&amp;type;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[0].iov_len =3D si=
zeof(type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv=
[1].iov_base =3D buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        iv[1].iov_len =3D len;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn dragonfly_modify_read_write_return(writev(tt-&gt;fd, iv, 2));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return write(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        u_int32_t type;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        struct iovec iv[2];</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        iv[0].iov_base =3D (char *)&amp;type;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        iv[0].iov_len =3D sizeof=
(type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iv[1].=
iov_base =3D buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    iv[1].iov_len =3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return d=
ragonfly_modify_read_write_return(readv(tt-&gt;fd, iv, 2));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return read(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif=
 defined(TARGET_DARWIN)</span><br><span> </span><br><span> /* Darwin (MacOS=
 X) is mostly &quot;just use the generic stuff&quot;, but there</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1378?usp=3Demail">change 1378</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1378?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd9384287648d1f37a625d9ed6a=
09733208fa56c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1378 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--/bS6mq56AtI=--

