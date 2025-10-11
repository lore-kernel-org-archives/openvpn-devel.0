From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 11 Oct 2025 08:33:16 +0000
In-Reply-To: <gerrit.1760136547000.I62a8f62b9c0938cfcb99d184b07034515c076303@...2715...>
References: <gerrit.1760136547000.I62a8f62b9c0938cfcb99d184b07034515c076303@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1ef617bb666c2e7b26964cf855f3f363ee16aec8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d+F6CgUeYAg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--d+F6CgUeYAg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
65?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I62a8f62b9c0938cfcb99d184b07034515c076303
Gerrit-Change-Number: 1265
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--d+F6CgUeYAg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1265?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Move build_dhcp_options_string from tun to dhcp<=
br><br>Seems suitably related and tun.c is one of the<br>huge ones.<br><br>=
In preparation of adding UTs for the code.<br><br>Change-Id: I62a8f62b9c093=
8cfcb99d184b07034515c076303<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit U=
RL: https://gerrit.openvpn.net/c/openvpn/+/1265<br>Message-Id: &lt;20251011=
082217.27568-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvp=
n/mailman/message/59245240/<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/dhcp.c<br>M src/openvpn/dhcp.h<br>M src/ope=
nvpn/tun.c<br>3 files changed, 207 insertions(+), 196 deletions(-)<br><br><=
/pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c</span><br><span>ind=
ex 850a4b6..653127d 100644</span><br><span>--- a/src/openvpn/dhcp.c</span><=
br><span>+++ b/src/openvpn/dhcp.c</span><br><span>@@ -185,3 +185,203 @@</sp=
an><br><span>     }</span><br><span>     return 0;</span><br><span> }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Convert DHCP options from the command lin=
e / config file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * i=
nto a raw DHCP-format options string.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+write_dhcp_u8(struct buff=
er *buf, const int type, const int data, bool *error)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!buf_safe(buf, 3))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        *error =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_WARN, &quot;write_dhcp_u8: buffer overflow buil=
ding DHCP options&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_writ=
e_u8(buf, type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 buf_write_u8(buf, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf_write_u8(buf, data);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+write_dhcp_u32_array(struct buffe=
r *buf, const int type, const uint32_t *data,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     const unsigned int len, bool=
 *error)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int i;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        const int size =3D len * sizeof(uint32=
_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (!buf_safe(buf, 2 + siz=
e))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            *error =3D tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M=
_WARN, &quot;write_dhcp_u32_array: buffer overflow building DHCP options&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (size &lt; 1 =
|| size &gt; 255)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
*error =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(M_WARN, &quot;write_dhcp_u32_array: size (%d) must be &gt; 0 a=
nd &lt;=3D 255&quot;, size);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       buf_write_u8(buf, type);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        buf_write_u8(buf, size);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; len; ++i)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            buf_write_u32(buf, data[i]);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_dhcp_str=
(struct buffer *buf, const int type, const char *str, bool *error)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const int len =3D strlen(str);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(buf, 2 + len)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        *error =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;w=
rite_dhcp_str: buffer overflow building DHCP options&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (len &lt; 1 || len &gt; 255)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        *error =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;write_dhcp_str: str=
ing &#39;%s&#39; must be &gt; 0 bytes and &lt;=3D 255 bytes&quot;, str);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(buf, type);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u8(buf, len);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(buf, str,=
 len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * RFC3397 states that multiple searchdomains are encoded as follow=
s:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - at start th=
e length of the entire option is given</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  - each subdomain is preceded by its length</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  - each searchdomain is se=
parated by a NUL character</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * e.g. if you want &quot;openvpn.net&quot; and &quot;duckduckgo.com=
&quot; then you end up with</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  0x1D  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+write_dhcp_search_str(struct buffer *buf, const=
 int type, const char *const *str_array,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                      int array_len, bool *error)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char tmp_buf[256];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int len =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int label_length_pos;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (i =3D 0; i &lt; array_len; i++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        const char *ptr =3D str_array[i];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (strlen(ptr) + len + 1 &gt; sizeof(tmp_=
buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            *error =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(M_WARN, &quot;write_dhcp_search_str: temp buffer overflow building DHCP op=
tions&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Loop =
over all subdomains separated by a dot and replace the dot</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * with the length of the su=
bdomain */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* label_length_pos =
points to the byte to be replaced by the length</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * of the following domain label */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        label_length_po=
s =3D len++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        while (true)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (*ptr =3D=3D &#39;.&=
#39; || *ptr =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                tmp_buf[label_length_pos] =3D (len - label_length_p=
os) - 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     label_length_pos =3D len;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                if (*ptr =3D=3D &#39;\0&#39;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            tmp_buf[len++] =3D *ptr++;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* And close off with an=
 extra NUL char */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       tmp_buf[len++] =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(buf, 2=
 + len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        *error =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, =
&quot;write_search_dhcp_str: buffer overflow building DHCP options&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; 255)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        *error =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;write_dhcp_search_s=
tr: search domain string must be &lt;=3D 255 bytes&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    buf_write_u8(buf, type);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_write_u8(buf, len);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_write(buf, tmp_buf, len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+build_dhcp_options_=
string(struct buffer *buf, const struct tuntap_options *o)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool error =3D false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (o-&gt;domain)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        write_dhcp_str(buf, 15, o-&gt;domain, &amp;error);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (o-&gt;netbios_scope)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        write_dhcp_str(buf, 47, o-&gt;netbios_scope, &amp;e=
rror);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (o-&gt;netbios_node_type)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        write_dhcp_u8(buf, 46, o-&gt;netbios_no=
de_type, &amp;error);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_u32_array(buf, 6=
, (uint32_t *)o-&gt;dns, o-&gt;dns_len, &amp;error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    write_dhcp_u32_array(buf, 44, (uint32=
_t *)o-&gt;wins, o-&gt;wins_len, &amp;error);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    write_dhcp_u32_array(buf, 42, (uint32_t *)o-&=
gt;ntp, o-&gt;ntp_len, &amp;error);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    write_dhcp_u32_array(buf, 45, (uint32_t *)o-&gt;nbdd, o=
-&gt;nbdd_len, &amp;error);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&=
gt;domain_search_list_len &gt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        write_dhcp_search_str(buf, 119, o-&gt;domain_search_list, o-&gt;dom=
ain_search_list_len, &amp;error);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the MS DHCP =
server option &#39;Disable Netbios-over-TCP/IP</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * is implemented as vendor option 001, valu=
e 002.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * A valu=
e of 001 means &#39;leave NBT alone&#39; which is the default */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;disable_nbt)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!buf_safe(buf, 8))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;build_=
dhcp_options_string: buffer overflow building DHCP options&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        buf_write_u8(buf, 43);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_write_u8(=
buf, 6); /* total length field */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        buf_write_u8(buf, 0x001);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        buf_write_u8(buf, 4); /* length of the =
vendor specified field */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        buf_write_u32(buf, 0x002);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return !error;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(_WIN32) */</s=
pan><br><span>diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h</span><b=
r><span>index af5c2c4..8e15a39 100644</span><br><span>--- a/src/openvpn/dhc=
p.h</span><br><span>+++ b/src/openvpn/dhcp.h</span><br><span>@@ -84,4 +84,1=
0 @@</span><br><span> </span><br><span> in_addr_t dhcp_extract_router_msg(s=
truct buffer *ipbuf);</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;tun.h&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool build_dhcp_options_string(struct buffer *buf, const struct tun=
tap_options *o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #endif /* ifndef DHCP_H */</span><br><span>diff --git a/src/openvpn/tun.c=
 b/src/openvpn/tun.c</span><br><span>index e35f889..097b9e8 100644</span><b=
r><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</sp=
an><br><span>@@ -45,6 +45,7 @@</span><br><span> #include &quot;win32.h&quot=
;</span><br><span> #include &quot;wfp_block.h&quot;</span><br><span> #inclu=
de &quot;networking.h&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;dhcp.h&quot;</span><br><span> </span><br><span> #inc=
lude &quot;memdbg.h&quot;</span><br><span> </span><br><span>@@ -5554,202 +5=
555,6 @@</span><br><span>     return ret;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Convert =
DHCP options from the command line / config file</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * into a raw DHCP-format options string.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wr=
ite_dhcp_u8(struct buffer *buf, const int type, const int data, bool *error=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!buf_safe(buf, 3))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        *error =3D true;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;write_dhcp_u8: buffer =
overflow building DHCP options&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b=
uf_write_u8(buf, type);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    buf_write_u8(buf, 1);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    buf_write_u8(buf, data);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-write_dhcp_u32_array(struct buffer *bu=
f, const int type, const uint32_t *data,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                     const unsigned int len, bool *error=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (len &gt; 0)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        const int size =3D len * sizeof(uint32_t);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (!buf_safe(buf, 2 + size))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            *error =3D true;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;write_dhcp_u32_a=
rray: buffer overflow building DHCP options&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (size &lt; 1 || size &gt; 255)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            *error =3D true;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;write_dhcp=
_u32_array: size (%d) must be &gt; 0 and &lt;=3D 255&quot;, size);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            return;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_write_u8(buf, type);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u8(buf, size);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0;=
 i &lt; len; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_=
write_u32(buf, data[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *=
error)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const int len =3D strlen(str);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_safe(buf,=
 2 + len))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        *error =3D true;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quo=
t;write_dhcp_str: buffer overflow building DHCP options&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (len &lt; 1 || len &gt; 255)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        *error =3D true;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;write_dhcp_str: string &#39;=
%s&#39; must be &gt; 0 bytes and &lt;=3D 255 bytes&quot;, str);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    buf_write_u8(buf, type);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    buf_write_u8(buf, len);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    buf_write(buf, str, len);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * RFC3397 states t=
hat multiple searchdomains are encoded as follows:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  - at start the length of the entire option=
 is given</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  - each s=
ubdomain is preceded by its length</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  - each searchdomain is separated by a NUL character</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * e.g. if you want &quot;op=
envpn.net&quot; and &quot;duckduckgo.com&quot; then you end up with</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  0x1D  0x7 openvpn 0x3 net=
 0x00 0x0A duckduckgo 0x3 com 0x00</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_dhcp_sear=
ch_str(struct buffer *buf, const int type, const char *const *str_array,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                      in=
t array_len, bool *error)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char tmp_buf=
[256];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int len =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int label_length_pos;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; array_len; i++)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const char *ptr =3D str_array[i];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (strlen(ptr) + len + 1 &gt; size=
of(tmp_buf))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *error =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
msg(M_WARN, &quot;write_dhcp_search_str: temp buffer overflow building DHCP=
 options&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Loop ove=
r all subdomains separated by a dot and replace the dot</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         * with the length of the subdoma=
in */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* label_length_pos points to=
 the byte to be replaced by the length</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-         * of the following domain label */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        label_length_pos =3D len++;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        while (true)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (*ptr =3D=3D &#39;.&#39; || *ptr =3D=3D =
&#39;\0&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
tmp_buf[label_length_pos] =3D (len - label_length_pos) - 1;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                label_length_pos =3D =
len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                i=
f (*ptr =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    break;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        tmp_buf[len++] =3D *ptr++;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        /* And close off with an extra NUL char */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        tmp_buf[len++] =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!buf_safe(buf, 2 + len))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      *error =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        msg(M_WARN, &quot;write_search_dhcp_str: buffer overflow building =
DHCP options&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (len &gt; 255)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        *error =3D true;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;write_dhcp=
_search_str: search domain string must be &lt;=3D 255 bytes&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    buf_write_u8(buf, type);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    buf_write_u8(buf, len);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    buf_write(buf, tmp_buf, len);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-build_dhcp_options_string(struct=
 buffer *buf, const struct tuntap_options *o)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    bool error =3D false;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (o-&gt;domain)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
write_dhcp_str(buf, 15, o-&gt;domain, &amp;error);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
o-&gt;netbios_scope)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        write_dhc=
p_str(buf, 47, o-&gt;netbios_scope, &amp;error);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-=
&gt;netbios_node_type)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        write_d=
hcp_u8(buf, 46, o-&gt;netbios_node_type, &amp;error);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    w=
rite_dhcp_u32_array(buf, 6, (uint32_t *)o-&gt;dns, o-&gt;dns_len, &amp;erro=
r);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    write_dhcp_u32=
_array(buf, 44, (uint32_t *)o-&gt;wins, o-&gt;wins_len, &amp;error);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    write_dhcp_u32_array(buf=
, 42, (uint32_t *)o-&gt;ntp, o-&gt;ntp_len, &amp;error);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    write_dhcp_u32_array(buf, 45, (uint3=
2_t *)o-&gt;nbdd, o-&gt;nbdd_len, &amp;error);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (o-&gt;domain_search_list_len &gt; 0)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        write_dhcp_search_str(buf, 119, o-&gt;domain_search_list=
, o-&gt;domain_search_list_len, &amp;error);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* the MS =
DHCP server option &#39;Disable Netbios-over-TCP/IP</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * is implemented as vendor option 001,=
 value 002.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * A v=
alue of 001 means &#39;leave NBT alone&#39; which is the default */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;disable_nbt)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (!buf_safe(buf, 8))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;build_dhcp_op=
tions_string: buffer overflow building DHCP options&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_write_u8(buf, 43);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u8(buf, 6); /* t=
otal length field */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       buf_write_u8(buf, 0x001);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        buf_write_u8(buf, 4); /* length of the vendor specified =
field */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_w=
rite_u32(buf, 0x002);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return !erro=
r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br=
><span> fork_dhcp_action(struct tuntap *tt)</span><br><span> {</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1265?usp=3Demail">change 1265</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1265?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--d+F6CgUeYAg=--

