From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 11 Oct 2025 08:33:13 +0000
In-Reply-To: <gerrit.1760136547000.I62a8f62b9c0938cfcb99d184b07034515c076303@...2715...>
References: <gerrit.1760136547000.I62a8f62b9c0938cfcb99d184b07034515c076303@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1ef617bb666c2e7b26964cf855f3f363ee16aec8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="luyMARyCUww="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move
 build_dhcp_options_string from tun to dhcp
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

--luyMARyCUww=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1265?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Move build_dhcp_options_string from tun to dhcp
......................................................................

Move build_dhcp_options_string from tun to dhcp

Seems suitably related and tun.c is one of the
huge ones.

In preparation of adding UTs for the code.

Change-Id: I62a8f62b9c0938cfcb99d184b07034515c076303
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1265
Message-Id: <20251011082217.27568-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59245240/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dhcp.c
M src/openvpn/dhcp.h
M src/openvpn/tun.c
3 files changed, 207 insertions(+), 196 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1265/2

diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 850a4b6..653127d 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -185,3 +185,203 @@
     }
     return 0;
 }
+
+#if defined(_WIN32)
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
+/*
+ * Convert DHCP options from the command line / config file
+ * into a raw DHCP-format options string.
+ */
+
+static void
+write_dhcp_u8(struct buffer *buf, const int type, const int data, bool *er=
ror)
+{
+    if (!buf_safe(buf, 3))
+    {
+        *error =3D true;
+        msg(M_WARN, "write_dhcp_u8: buffer overflow building DHCP options"=
);
+        return;
+    }
+    buf_write_u8(buf, type);
+    buf_write_u8(buf, 1);
+    buf_write_u8(buf, data);
+}
+
+static void
+write_dhcp_u32_array(struct buffer *buf, const int type, const uint32_t *d=
ata,
+                     const unsigned int len, bool *error)
+{
+    if (len > 0)
+    {
+        int i;
+        const int size =3D len * sizeof(uint32_t);
+
+        if (!buf_safe(buf, 2 + size))
+        {
+            *error =3D true;
+            msg(M_WARN, "write_dhcp_u32_array: buffer overflow building DH=
CP options");
+            return;
+        }
+        if (size < 1 || size > 255)
+        {
+            *error =3D true;
+            msg(M_WARN, "write_dhcp_u32_array: size (%d) must be > 0 and <=
=3D 255", size);
+            return;
+        }
+        buf_write_u8(buf, type);
+        buf_write_u8(buf, size);
+        for (i =3D 0; i < len; ++i)
+        {
+            buf_write_u32(buf, data[i]);
+        }
+    }
+}
+
+static void
+write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *=
error)
+{
+    const int len =3D strlen(str);
+    if (!buf_safe(buf, 2 + len))
+    {
+        *error =3D true;
+        msg(M_WARN, "write_dhcp_str: buffer overflow building DHCP options=
");
+        return;
+    }
+    if (len < 1 || len > 255)
+    {
+        *error =3D true;
+        msg(M_WARN, "write_dhcp_str: string '%s' must be > 0 bytes and <=
=3D 255 bytes", str);
+        return;
+    }
+    buf_write_u8(buf, type);
+    buf_write_u8(buf, len);
+    buf_write(buf, str, len);
+}
+
+/*
+ * RFC3397 states that multiple searchdomains are encoded as follows:
+ *  - at start the length of the entire option is given
+ *  - each subdomain is preceded by its length
+ *  - each searchdomain is separated by a NUL character
+ * e.g. if you want "openvpn.net" and "duckduckgo.com" then you end up with
+ *  0x1D  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
+ */
+static void
+write_dhcp_search_str(struct buffer *buf, const int type, const char *cons=
t *str_array,
+                      int array_len, bool *error)
+{
+    char tmp_buf[256];
+    int i;
+    int len =3D 0;
+    int label_length_pos;
+
+    for (i =3D 0; i < array_len; i++)
+    {
+        const char *ptr =3D str_array[i];
+
+        if (strlen(ptr) + len + 1 > sizeof(tmp_buf))
+        {
+            *error =3D true;
+            msg(M_WARN, "write_dhcp_search_str: temp buffer overflow build=
ing DHCP options");
+            return;
+        }
+        /* Loop over all subdomains separated by a dot and replace the dot
+         * with the length of the subdomain */
+
+        /* label_length_pos points to the byte to be replaced by the length
+         * of the following domain label */
+        label_length_pos =3D len++;
+
+        while (true)
+        {
+            if (*ptr =3D=3D '.' || *ptr =3D=3D '\0')
+            {
+                tmp_buf[label_length_pos] =3D (len - label_length_pos) - 1;
+                label_length_pos =3D len;
+                if (*ptr =3D=3D '\0')
+                {
+                    break;
+                }
+            }
+            tmp_buf[len++] =3D *ptr++;
+        }
+        /* And close off with an extra NUL char */
+        tmp_buf[len++] =3D 0;
+    }
+
+    if (!buf_safe(buf, 2 + len))
+    {
+        *error =3D true;
+        msg(M_WARN, "write_search_dhcp_str: buffer overflow building DHCP =
options");
+        return;
+    }
+    if (len > 255)
+    {
+        *error =3D true;
+        msg(M_WARN, "write_dhcp_search_str: search domain string must be <=
=3D 255 bytes");
+        return;
+    }
+
+    buf_write_u8(buf, type);
+    buf_write_u8(buf, len);
+    buf_write(buf, tmp_buf, len);
+}
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
+bool
+build_dhcp_options_string(struct buffer *buf, const struct tuntap_options =
*o)
+{
+    bool error =3D false;
+    if (o->domain)
+    {
+        write_dhcp_str(buf, 15, o->domain, &error);
+    }
+
+    if (o->netbios_scope)
+    {
+        write_dhcp_str(buf, 47, o->netbios_scope, &error);
+    }
+
+    if (o->netbios_node_type)
+    {
+        write_dhcp_u8(buf, 46, o->netbios_node_type, &error);
+    }
+
+    write_dhcp_u32_array(buf, 6, (uint32_t *)o->dns, o->dns_len, &error);
+    write_dhcp_u32_array(buf, 44, (uint32_t *)o->wins, o->wins_len, &error=
);
+    write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
+    write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error=
);
+
+    if (o->domain_search_list_len > 0)
+    {
+        write_dhcp_search_str(buf, 119, o->domain_search_list, o->domain_s=
earch_list_len, &error);
+    }
+
+    /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
+     * is implemented as vendor option 001, value 002.
+     * A value of 001 means 'leave NBT alone' which is the default */
+    if (o->disable_nbt)
+    {
+        if (!buf_safe(buf, 8))
+        {
+            msg(M_WARN, "build_dhcp_options_string: buffer overflow buildi=
ng DHCP options");
+            return false;
+        }
+        buf_write_u8(buf, 43);
+        buf_write_u8(buf, 6); /* total length field */
+        buf_write_u8(buf, 0x001);
+        buf_write_u8(buf, 4); /* length of the vendor specified field */
+        buf_write_u32(buf, 0x002);
+    }
+    return !error;
+}
+
+#endif /* defined(_WIN32) */
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index af5c2c4..8e15a39 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -84,4 +84,10 @@

 in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);

+#if defined(_WIN32)
+#include "tun.h"
+
+bool build_dhcp_options_string(struct buffer *buf, const struct tuntap_opt=
ions *o);
+#endif
+
 #endif /* ifndef DHCP_H */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e35f889..097b9e8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -45,6 +45,7 @@
 #include "win32.h"
 #include "wfp_block.h"
 #include "networking.h"
+#include "dhcp.h"

 #include "memdbg.h"

@@ -5554,202 +5555,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-/*
- * Convert DHCP options from the command line / config file
- * into a raw DHCP-format options string.
- */
-
-static void
-write_dhcp_u8(struct buffer *buf, const int type, const int data, bool *er=
ror)
-{
-    if (!buf_safe(buf, 3))
-    {
-        *error =3D true;
-        msg(M_WARN, "write_dhcp_u8: buffer overflow building DHCP options"=
);
-        return;
-    }
-    buf_write_u8(buf, type);
-    buf_write_u8(buf, 1);
-    buf_write_u8(buf, data);
-}
-
-static void
-write_dhcp_u32_array(struct buffer *buf, const int type, const uint32_t *d=
ata,
-                     const unsigned int len, bool *error)
-{
-    if (len > 0)
-    {
-        int i;
-        const int size =3D len * sizeof(uint32_t);
-
-        if (!buf_safe(buf, 2 + size))
-        {
-            *error =3D true;
-            msg(M_WARN, "write_dhcp_u32_array: buffer overflow building DH=
CP options");
-            return;
-        }
-        if (size < 1 || size > 255)
-        {
-            *error =3D true;
-            msg(M_WARN, "write_dhcp_u32_array: size (%d) must be > 0 and <=
=3D 255", size);
-            return;
-        }
-        buf_write_u8(buf, type);
-        buf_write_u8(buf, size);
-        for (i =3D 0; i < len; ++i)
-        {
-            buf_write_u32(buf, data[i]);
-        }
-    }
-}
-
-static void
-write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *=
error)
-{
-    const int len =3D strlen(str);
-    if (!buf_safe(buf, 2 + len))
-    {
-        *error =3D true;
-        msg(M_WARN, "write_dhcp_str: buffer overflow building DHCP options=
");
-        return;
-    }
-    if (len < 1 || len > 255)
-    {
-        *error =3D true;
-        msg(M_WARN, "write_dhcp_str: string '%s' must be > 0 bytes and <=
=3D 255 bytes", str);
-        return;
-    }
-    buf_write_u8(buf, type);
-    buf_write_u8(buf, len);
-    buf_write(buf, str, len);
-}
-
-/*
- * RFC3397 states that multiple searchdomains are encoded as follows:
- *  - at start the length of the entire option is given
- *  - each subdomain is preceded by its length
- *  - each searchdomain is separated by a NUL character
- * e.g. if you want "openvpn.net" and "duckduckgo.com" then you end up with
- *  0x1D  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
- */
-static void
-write_dhcp_search_str(struct buffer *buf, const int type, const char *cons=
t *str_array,
-                      int array_len, bool *error)
-{
-    char tmp_buf[256];
-    int i;
-    int len =3D 0;
-    int label_length_pos;
-
-    for (i =3D 0; i < array_len; i++)
-    {
-        const char *ptr =3D str_array[i];
-
-        if (strlen(ptr) + len + 1 > sizeof(tmp_buf))
-        {
-            *error =3D true;
-            msg(M_WARN, "write_dhcp_search_str: temp buffer overflow build=
ing DHCP options");
-            return;
-        }
-        /* Loop over all subdomains separated by a dot and replace the dot
-         * with the length of the subdomain */
-
-        /* label_length_pos points to the byte to be replaced by the length
-         * of the following domain label */
-        label_length_pos =3D len++;
-
-        while (true)
-        {
-            if (*ptr =3D=3D '.' || *ptr =3D=3D '\0')
-            {
-                tmp_buf[label_length_pos] =3D (len - label_length_pos) - 1;
-                label_length_pos =3D len;
-                if (*ptr =3D=3D '\0')
-                {
-                    break;
-                }
-            }
-            tmp_buf[len++] =3D *ptr++;
-        }
-        /* And close off with an extra NUL char */
-        tmp_buf[len++] =3D 0;
-    }
-
-    if (!buf_safe(buf, 2 + len))
-    {
-        *error =3D true;
-        msg(M_WARN, "write_search_dhcp_str: buffer overflow building DHCP =
options");
-        return;
-    }
-    if (len > 255)
-    {
-        *error =3D true;
-        msg(M_WARN, "write_dhcp_search_str: search domain string must be <=
=3D 255 bytes");
-        return;
-    }
-
-    buf_write_u8(buf, type);
-    buf_write_u8(buf, len);
-    buf_write(buf, tmp_buf, len);
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-static bool
-build_dhcp_options_string(struct buffer *buf, const struct tuntap_options =
*o)
-{
-    bool error =3D false;
-    if (o->domain)
-    {
-        write_dhcp_str(buf, 15, o->domain, &error);
-    }
-
-    if (o->netbios_scope)
-    {
-        write_dhcp_str(buf, 47, o->netbios_scope, &error);
-    }
-
-    if (o->netbios_node_type)
-    {
-        write_dhcp_u8(buf, 46, o->netbios_node_type, &error);
-    }
-
-    write_dhcp_u32_array(buf, 6, (uint32_t *)o->dns, o->dns_len, &error);
-    write_dhcp_u32_array(buf, 44, (uint32_t *)o->wins, o->wins_len, &error=
);
-    write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
-    write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error=
);
-
-    if (o->domain_search_list_len > 0)
-    {
-        write_dhcp_search_str(buf, 119, o->domain_search_list, o->domain_s=
earch_list_len, &error);
-    }
-
-    /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
-     * is implemented as vendor option 001, value 002.
-     * A value of 001 means 'leave NBT alone' which is the default */
-    if (o->disable_nbt)
-    {
-        if (!buf_safe(buf, 8))
-        {
-            msg(M_WARN, "build_dhcp_options_string: buffer overflow buildi=
ng DHCP options");
-            return false;
-        }
-        buf_write_u8(buf, 43);
-        buf_write_u8(buf, 6); /* total length field */
-        buf_write_u8(buf, 0x001);
-        buf_write_u8(buf, 4); /* length of the vendor specified field */
-        buf_write_u32(buf, 0x002);
-    }
-    return !error;
-}
-
 static void
 fork_dhcp_action(struct tuntap *tt)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1265?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I62a8f62b9c0938cfcb99d184b07034515c076303
Gerrit-Change-Number: 1265
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--luyMARyCUww=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1265?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Move build_dhcp_options_string from=
 tun to dhcp<br><br>Seems suitably related and tun.c is one of the<br>huge =
ones.<br><br>In preparation of adding UTs for the code.<br><br>Change-Id: I=
62a8f62b9c0938cfcb99d184b07034515c076303<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt=
;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1265<br>Message-Id:=
 &lt;20251011082217.27568-1-gert@...1296...&gt;<br>URL: https://sourceforge=
.net/p/openvpn/mailman/message/59245240/<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/dhcp.c<br>M src/openvpn/dhcp.h=
<br>M src/openvpn/tun.c<br>3 files changed, 207 insertions(+), 196 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/65/1265/2</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dhcp.c b/src/o=
penvpn/dhcp.c</span><br><span>index 850a4b6..653127d 100644</span><br><span=
>--- a/src/openvpn/dhcp.c</span><br><span>+++ b/src/openvpn/dhcp.c</span><b=
r><span>@@ -185,3 +185,203 @@</span><br><span>     }</span><br><span>     r=
eturn 0;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Convert =
DHCP options from the command line / config file</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * into a raw DHCP-format options string.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+write_dhcp_u8(struct buffer *buf, const int type, const int data, b=
ool *error)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(buf, 3))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        *error =3D true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;wr=
ite_dhcp_u8: buffer overflow building DHCP options&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_write_u8(buf, type);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_write_u8(buf, 1);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(buf, data);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
write_dhcp_u32_array(struct buffer *buf, const int type, const uint32_t *da=
ta,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
     const unsigned int len, bool *error)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        in=
t i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const i=
nt size =3D len * sizeof(uint32_t);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!buf_safe(buf, 2 + size))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            *error =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(M_WARN, &quot;write_dhcp_u32_array: buffer ov=
erflow building DHCP options&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (size &lt; 1 || size &gt; 255)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            *error =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;write_dhcp_u32_ar=
ray: size (%d) must be &gt; 0 and &lt;=3D 255&quot;, size);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        buf_write_u8(buf, type);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        buf_write_u8(buf, size);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D =
0; i &lt; len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  buf_write_u32(buf, data[i]);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+write_dhcp_str(struct buffer *buf, const int type, const c=
har *str, bool *error)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int l=
en =3D strlen(str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!buf_safe(buf, 2 + len))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       *error =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_WARN, &quot;write_dhcp_str: buffer overflow building DHCP=
 options&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 1 ||=
 len &gt; 255)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *error =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_=
WARN, &quot;write_dhcp_str: string &#39;%s&#39; must be &gt; 0 bytes and &l=
t;=3D 255 bytes&quot;, str);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_w=
rite_u8(buf, type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    buf_write_u8(buf, len);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    buf_write(buf, str, len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * RFC3397 states that multiple sear=
chdomains are encoded as follows:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  - at start the length of the entire option is given</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - each subdomain is p=
receded by its length</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  - each searchdomain is separated by a NUL character</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * e.g. if you want &quot;openvpn.net=
&quot; and &quot;duckduckgo.com&quot; then you end up with</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  0x1D  0x7 openvpn 0x3 net 0x00 0=
x0A duckduckgo 0x3 com 0x00</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_dhcp_searc=
h_str(struct buffer *buf, const int type, const char *const *str_array,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                      i=
nt array_len, bool *error)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char tm=
p_buf[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int len =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int label_leng=
th_pos;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; array_=
len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *ptr =
=3D str_array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strlen(pt=
r) + len + 1 &gt; sizeof(tmp_buf))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            *error =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(M_WARN, &quot;write_dhcp_search_str: temp buf=
fer overflow building DHCP options&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            return;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* Loop over all subdomains separated by a dot and rep=
lace the dot</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * with the length of the subdomain */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* label_length_pos points to the byte to be replaced by the lengt=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * of the =
following domain label */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        label_length_pos =3D len++;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        while (true)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (*ptr =3D=3D &#39;.&#39; || *ptr =3D=3D &#39;\0&#39;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                tmp_buf[label_length_p=
os] =3D (len - label_length_pos) - 1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                label_length_pos =3D len;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                if (*ptr =3D=3D &#3=
9;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
tmp_buf[len++] =3D *ptr++;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* And close off with an extra NUL char */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        tmp_buf[len++] =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!buf_safe(buf, 2 + len))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        *error =3D true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_WARN, &quot;write_search_dhcp_str: buffer overflow b=
uilding DHCP options&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (l=
en &gt; 255)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *error =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WA=
RN, &quot;write_dhcp_search_str: search domain string must be &lt;=3D 255 b=
ytes&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buf_write_u8(buf, type);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(buf, len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(buf, tmp_buf,=
 len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+build_dhcp_options_string(struct buffer *buf, const struct tuntap_=
options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    bool error =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;domain=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        write_dhcp_str(buf, 15, =
o-&gt;domain, &amp;error);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;netbios_scop=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        write_dhcp_str(buf, 47,=
 o-&gt;netbios_scope, &amp;error);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;netb=
ios_node_type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        write_dhcp_=
u8(buf, 46, o-&gt;netbios_node_type, &amp;error);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 write_dhcp_u32_array(buf, 6, (uint32_t *)o-&gt;dns, o-&gt;dns_len, &amp;er=
ror);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    write_dhcp=
_u32_array(buf, 44, (uint32_t *)o-&gt;wins, o-&gt;wins_len, &amp;error);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_u32_arr=
ay(buf, 42, (uint32_t *)o-&gt;ntp, o-&gt;ntp_len, &amp;error);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_u32_array(buf, 45=
, (uint32_t *)o-&gt;nbdd, o-&gt;nbdd_len, &amp;error);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (o-&gt;domain_search_list_len &gt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        write_dhcp_search_str(buf, 119, o-&gt;do=
main_search_list, o-&gt;domain_search_list_len, &amp;error);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* the MS DHCP server option &#39;Disable Netbios-over-TCP/IP</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * is implemented=
 as vendor option 001, value 002.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * A value of 001 means &#39;leave NBT alone&#39; which i=
s the default */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (o-&gt;disable_nbt)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!buf_safe(buf, 8))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_WARN, &quot;build_dhcp_options_string: buffer overflow building DH=
CP options&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   buf_write_u8(buf, 43);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        buf_write_u8(buf, 6); /* total length field */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        buf_write_u8(buf, 0x001);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_write_u8=
(buf, 4); /* length of the vendor specified field */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_write_u32(buf, 0x002);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return !error;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif /* defined(_WIN32) */</span><br><span>diff --git a/src/openvpn/dhcp.h b=
/src/openvpn/dhcp.h</span><br><span>index af5c2c4..8e15a39 100644</span><br=
><span>--- a/src/openvpn/dhcp.h</span><br><span>+++ b/src/openvpn/dhcp.h</s=
pan><br><span>@@ -84,4 +84,10 @@</span><br><span> </span><br><span> in_addr=
_t dhcp_extract_router_msg(struct buffer *ipbuf);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;tun.h&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool build_dhcp_options_string(struct b=
uffer *buf, const struct tuntap_options *o);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #endif /* ifndef DHCP_H */</span><br><span>di=
ff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index e35f=
889..097b9e8 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span=
>+++ b/src/openvpn/tun.c</span><br><span>@@ -45,6 +45,7 @@</span><br><span>=
 #include &quot;win32.h&quot;</span><br><span> #include &quot;wfp_block.h&q=
uot;</span><br><span> #include &quot;networking.h&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;dhcp.h&quot;</span><br><=
span> </span><br><span> #include &quot;memdbg.h&quot;</span><br><span> </sp=
an><br><span>@@ -5554,202 +5555,6 @@</span><br><span>     return ret;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * Convert DHCP options from the command line / config fil=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * into a raw DHCP-f=
ormat options string.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-write_dhcp_u8(struct buffer *buf, const int type,=
 const int data, bool *error)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf=
_safe(buf, 3))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *error =3D true=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, =
&quot;write_dhcp_u8: buffer overflow building DHCP options&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    buf_write_u8(buf, type);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf_write_u8(buf, 1);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    buf_write_u8(buf, data);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_dh=
cp_u32_array(struct buffer *buf, const int type, const uint32_t *data,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                     const=
 unsigned int len, bool *error)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (le=
n &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        const int size =3D len * si=
zeof(uint32_t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!buf_safe(buf, =
2 + size))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *error =3D =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
M_WARN, &quot;write_dhcp_u32_array: buffer overflow building DHCP options&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
urn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (size &lt; 1 || si=
ze &gt; 255)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *error =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
msg(M_WARN, &quot;write_dhcp_u32_array: size (%d) must be &gt; 0 and &lt;=
=3D 255&quot;, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_wr=
ite_u8(buf, type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     buf_write_u8(buf, size);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        for (i =3D 0; i &lt; len; ++i)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            buf_write_u32(buf, data[i]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-write_dhcp_str(struct buffer *buf, const int ty=
pe, const char *str, bool *error)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t int len =3D strlen(str);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!buf_safe(buf, 2 + len))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        *error =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(M_WARN, &quot;write_dhcp_str: buffer overflow building DHCP =
options&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (len &lt; 1 || len &g=
t; 255)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        *error =3D true;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;w=
rite_dhcp_str: string &#39;%s&#39; must be &gt; 0 bytes and &lt;=3D 255 byt=
es&quot;, str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write_u8(buf, type);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write_u8(buf,=
 len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write(b=
uf, str, len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * RFC3397 states that multiple searchdomains are encoded as follow=
s:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - at start the =
length of the entire option is given</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  - each subdomain is preceded by its length</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *  - each searchdomain is separate=
d by a NUL character</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* e.g. if you want &quot;openvpn.net&quot; and &quot;duckduckgo.com&quot; t=
hen you end up with</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  0x1D  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-write_dhcp_search_str(struct buffer *buf, const int type, const=
 char *const *str_array,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                      int array_len, bool *error)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    char tmp_buf[256];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int label_length_pos;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; =
i &lt; array_len; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const c=
har *ptr =3D str_array[i];</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (strl=
en(ptr) + len + 1 &gt; sizeof(tmp_buf))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            *error =3D true;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(M_WARN, &quot;write_dhcp_search_str: temp buff=
er overflow building DHCP options&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            return;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        /* Loop over all subdomains separated by a dot and replace th=
e dot</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * with =
the length of the subdomain */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* l=
abel_length_pos points to the byte to be replaced by the length</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-         * of the following domai=
n label */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        lab=
el_length_pos =3D len++;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        while (tru=
e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            if (*ptr =3D=3D &#3=
9;.&#39; || *ptr =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                tmp_buf[label_length_pos] =3D (len - label_length_p=
os) - 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   label_length_pos =3D len;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                if (*ptr =3D=3D &#39;\0&#39;)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    break;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            tmp_buf[len++] =3D *ptr++;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /* And close off with an extra NUL char *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tmp_buf[len+=
+] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (!buf_safe(buf, 2 + len))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        *error =3D true;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;write_search_dhcp_str: bu=
ffer overflow building DHCP options&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (len &gt; 255)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *error =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_WARN, &quot;write_dhcp_search_str: search domain string must be &lt;=3D 2=
55 bytes&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    buf_write_u8(buf, type);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    buf_write_u8(buf, len);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    buf_write(buf, tmp_buf, len);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-build_dh=
cp_options_string(struct buffer *buf, const struct tuntap_options *o)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    bool error =3D false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;domain)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        write_dhcp_str(buf, 15, o-&gt;domain, &amp;error);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (o-&gt;netbios_scope)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        write_dhcp_str(buf, 47, o-&gt;netbios_scope, &amp;error);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (o-&gt;netbios_node_type)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        write_dhcp_u8(buf, 46, o-&gt;netbios_node_type, &amp;error=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    write_dhcp_u32_array(buf, 6, (uint32_t *)o-&gt;dns, =
o-&gt;dns_len, &amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    write_dhcp_u32_array(buf, 44, (uint32_t *)o-&gt;wins, o-&gt;wins_=
len, &amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
write_dhcp_u32_array(buf, 42, (uint32_t *)o-&gt;ntp, o-&gt;ntp_len, &amp;er=
ror);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    write_dhcp_u=
32_array(buf, 45, (uint32_t *)o-&gt;nbdd, o-&gt;nbdd_len, &amp;error);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (o-&gt;domain_search_list_len &gt; 0)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        write_dhcp_search_str(buf, 119, =
o-&gt;domain_search_list, o-&gt;domain_search_list_len, &amp;error);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* the MS DHCP server option &#39;Disable Netbios-over-TCP/I=
P</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * is implemente=
d as vendor option 001, value 002.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     * A value of 001 means &#39;leave NBT alone&#39; which is=
 the default */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (o-&gt;disable_nbt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!buf_=
safe(buf, 8))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WA=
RN, &quot;build_dhcp_options_string: buffer overflow building DHCP options&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            re=
turn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u8(b=
uf, 43);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_w=
rite_u8(buf, 6); /* total length field */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        buf_write_u8(buf, 0x001);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_write_u8(buf, 4); /* length of =
the vendor specified field */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        buf_write_u32(buf, 0x002);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return !error;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
static void</span><br><span> fork_dhcp_action(struct tuntap *tt)</span><br>=
<span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1265?usp=3Demail">change 1265</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1265?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I62a8f62b9c0938cfcb99d184b07=
034515c076303 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1265 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--luyMARyCUww=--

