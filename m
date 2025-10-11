From: Gert Doering <gert@...1296...>
Date: Sat, 11 Oct 2025 10:22:11 +0200
Message-ID: <20251011082217.27568-1-gert@...1296...>
In-Reply-To: <gerrit.1760136547000.I62a8f62b9c0938cfcb99d184b07034515c076303@...2715...>
References: <gerrit.1760136547000.I62a8f62b9c0938cfcb99d184b07034515c076303@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Move build_dhcp_options_string from tun
 to dhcp
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

Seems suitably related and tun.c is one of the
huge ones.

In preparation of adding UTs for the code.

Change-Id: I62a8f62b9c0938cfcb99d184b07034515c076303
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1265
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1265
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
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
+write_dhcp_u8(struct buffer *buf, const int type, const int data, bool *error)
+{
+    if (!buf_safe(buf, 3))
+    {
+        *error = true;
+        msg(M_WARN, "write_dhcp_u8: buffer overflow building DHCP options");
+        return;
+    }
+    buf_write_u8(buf, type);
+    buf_write_u8(buf, 1);
+    buf_write_u8(buf, data);
+}
+
+static void
+write_dhcp_u32_array(struct buffer *buf, const int type, const uint32_t *data,
+                     const unsigned int len, bool *error)
+{
+    if (len > 0)
+    {
+        int i;
+        const int size = len * sizeof(uint32_t);
+
+        if (!buf_safe(buf, 2 + size))
+        {
+            *error = true;
+            msg(M_WARN, "write_dhcp_u32_array: buffer overflow building DHCP options");
+            return;
+        }
+        if (size < 1 || size > 255)
+        {
+            *error = true;
+            msg(M_WARN, "write_dhcp_u32_array: size (%d) must be > 0 and <= 255", size);
+            return;
+        }
+        buf_write_u8(buf, type);
+        buf_write_u8(buf, size);
+        for (i = 0; i < len; ++i)
+        {
+            buf_write_u32(buf, data[i]);
+        }
+    }
+}
+
+static void
+write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *error)
+{
+    const int len = strlen(str);
+    if (!buf_safe(buf, 2 + len))
+    {
+        *error = true;
+        msg(M_WARN, "write_dhcp_str: buffer overflow building DHCP options");
+        return;
+    }
+    if (len < 1 || len > 255)
+    {
+        *error = true;
+        msg(M_WARN, "write_dhcp_str: string '%s' must be > 0 bytes and <= 255 bytes", str);
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
+write_dhcp_search_str(struct buffer *buf, const int type, const char *const *str_array,
+                      int array_len, bool *error)
+{
+    char tmp_buf[256];
+    int i;
+    int len = 0;
+    int label_length_pos;
+
+    for (i = 0; i < array_len; i++)
+    {
+        const char *ptr = str_array[i];
+
+        if (strlen(ptr) + len + 1 > sizeof(tmp_buf))
+        {
+            *error = true;
+            msg(M_WARN, "write_dhcp_search_str: temp buffer overflow building DHCP options");
+            return;
+        }
+        /* Loop over all subdomains separated by a dot and replace the dot
+         * with the length of the subdomain */
+
+        /* label_length_pos points to the byte to be replaced by the length
+         * of the following domain label */
+        label_length_pos = len++;
+
+        while (true)
+        {
+            if (*ptr == '.' || *ptr == '\0')
+            {
+                tmp_buf[label_length_pos] = (len - label_length_pos) - 1;
+                label_length_pos = len;
+                if (*ptr == '\0')
+                {
+                    break;
+                }
+            }
+            tmp_buf[len++] = *ptr++;
+        }
+        /* And close off with an extra NUL char */
+        tmp_buf[len++] = 0;
+    }
+
+    if (!buf_safe(buf, 2 + len))
+    {
+        *error = true;
+        msg(M_WARN, "write_search_dhcp_str: buffer overflow building DHCP options");
+        return;
+    }
+    if (len > 255)
+    {
+        *error = true;
+        msg(M_WARN, "write_dhcp_search_str: search domain string must be <= 255 bytes");
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
+build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
+{
+    bool error = false;
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
+    write_dhcp_u32_array(buf, 44, (uint32_t *)o->wins, o->wins_len, &error);
+    write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
+    write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error);
+
+    if (o->domain_search_list_len > 0)
+    {
+        write_dhcp_search_str(buf, 119, o->domain_search_list, o->domain_search_list_len, &error);
+    }
+
+    /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
+     * is implemented as vendor option 001, value 002.
+     * A value of 001 means 'leave NBT alone' which is the default */
+    if (o->disable_nbt)
+    {
+        if (!buf_safe(buf, 8))
+        {
+            msg(M_WARN, "build_dhcp_options_string: buffer overflow building DHCP options");
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
+bool build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o);
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
-write_dhcp_u8(struct buffer *buf, const int type, const int data, bool *error)
-{
-    if (!buf_safe(buf, 3))
-    {
-        *error = true;
-        msg(M_WARN, "write_dhcp_u8: buffer overflow building DHCP options");
-        return;
-    }
-    buf_write_u8(buf, type);
-    buf_write_u8(buf, 1);
-    buf_write_u8(buf, data);
-}
-
-static void
-write_dhcp_u32_array(struct buffer *buf, const int type, const uint32_t *data,
-                     const unsigned int len, bool *error)
-{
-    if (len > 0)
-    {
-        int i;
-        const int size = len * sizeof(uint32_t);
-
-        if (!buf_safe(buf, 2 + size))
-        {
-            *error = true;
-            msg(M_WARN, "write_dhcp_u32_array: buffer overflow building DHCP options");
-            return;
-        }
-        if (size < 1 || size > 255)
-        {
-            *error = true;
-            msg(M_WARN, "write_dhcp_u32_array: size (%d) must be > 0 and <= 255", size);
-            return;
-        }
-        buf_write_u8(buf, type);
-        buf_write_u8(buf, size);
-        for (i = 0; i < len; ++i)
-        {
-            buf_write_u32(buf, data[i]);
-        }
-    }
-}
-
-static void
-write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *error)
-{
-    const int len = strlen(str);
-    if (!buf_safe(buf, 2 + len))
-    {
-        *error = true;
-        msg(M_WARN, "write_dhcp_str: buffer overflow building DHCP options");
-        return;
-    }
-    if (len < 1 || len > 255)
-    {
-        *error = true;
-        msg(M_WARN, "write_dhcp_str: string '%s' must be > 0 bytes and <= 255 bytes", str);
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
-write_dhcp_search_str(struct buffer *buf, const int type, const char *const *str_array,
-                      int array_len, bool *error)
-{
-    char tmp_buf[256];
-    int i;
-    int len = 0;
-    int label_length_pos;
-
-    for (i = 0; i < array_len; i++)
-    {
-        const char *ptr = str_array[i];
-
-        if (strlen(ptr) + len + 1 > sizeof(tmp_buf))
-        {
-            *error = true;
-            msg(M_WARN, "write_dhcp_search_str: temp buffer overflow building DHCP options");
-            return;
-        }
-        /* Loop over all subdomains separated by a dot and replace the dot
-         * with the length of the subdomain */
-
-        /* label_length_pos points to the byte to be replaced by the length
-         * of the following domain label */
-        label_length_pos = len++;
-
-        while (true)
-        {
-            if (*ptr == '.' || *ptr == '\0')
-            {
-                tmp_buf[label_length_pos] = (len - label_length_pos) - 1;
-                label_length_pos = len;
-                if (*ptr == '\0')
-                {
-                    break;
-                }
-            }
-            tmp_buf[len++] = *ptr++;
-        }
-        /* And close off with an extra NUL char */
-        tmp_buf[len++] = 0;
-    }
-
-    if (!buf_safe(buf, 2 + len))
-    {
-        *error = true;
-        msg(M_WARN, "write_search_dhcp_str: buffer overflow building DHCP options");
-        return;
-    }
-    if (len > 255)
-    {
-        *error = true;
-        msg(M_WARN, "write_dhcp_search_str: search domain string must be <= 255 bytes");
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
-build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
-{
-    bool error = false;
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
-    write_dhcp_u32_array(buf, 44, (uint32_t *)o->wins, o->wins_len, &error);
-    write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
-    write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error);
-
-    if (o->domain_search_list_len > 0)
-    {
-        write_dhcp_search_str(buf, 119, o->domain_search_list, o->domain_search_list_len, &error);
-    }
-
-    /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
-     * is implemented as vendor option 001, value 002.
-     * A value of 001 means 'leave NBT alone' which is the default */
-    if (o->disable_nbt)
-    {
-        if (!buf_safe(buf, 8))
-        {
-            msg(M_WARN, "build_dhcp_options_string: buffer overflow building DHCP options");
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

