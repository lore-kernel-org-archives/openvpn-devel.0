From: Gert Doering <gert@...1296...>
Date: Mon, 13 Oct 2025 18:17:53 +0200
Message-ID: <20251013161759.1656-1-gert@...1296...>
In-Reply-To: <gerrit.1760136547000.I30a50826350ac3176443cf3bf16d3972609723a2@...2715...>
References: <gerrit.1760136547000.I30a50826350ac3176443cf3bf16d3972609723a2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] dhcp: Clean up type handling of
 write_dhcp_*
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

Use more appropriate types. Add casts where
necessary but ensure that they are safe.

Change-Id: I30a50826350ac3176443cf3bf16d3972609723a2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1268
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1268
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 0893ec7..a34bfca 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -188,18 +188,13 @@
 
 #if defined(_WIN32) || defined(DHCP_UNIT_TEST)
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Convert DHCP options from the command line / config file
  * into a raw DHCP-format options string.
  */
 
 static void
-write_dhcp_u8(struct buffer *buf, const int type, const int data, bool *error)
+write_dhcp_u8(struct buffer *buf, const uint8_t type, const uint8_t data, bool *error)
 {
     if (!buf_safe(buf, 3))
     {
@@ -213,13 +208,12 @@
 }
 
 static void
-write_dhcp_u32_array(struct buffer *buf, const int type, const uint32_t *data,
+write_dhcp_u32_array(struct buffer *buf, const uint8_t type, const uint32_t *data,
                      const unsigned int len, bool *error)
 {
     if (len > 0)
     {
-        int i;
-        const int size = len * sizeof(uint32_t);
+        const size_t size = len * sizeof(uint32_t);
 
         if (!buf_safe(buf, 2 + size))
         {
@@ -230,12 +224,12 @@
         if (size < 1 || size > 255)
         {
             *error = true;
-            msg(M_WARN, "write_dhcp_u32_array: size (%d) must be > 0 and <= 255", size);
+            msg(M_WARN, "write_dhcp_u32_array: size (%zu) must be > 0 and <= 255", size);
             return;
         }
         buf_write_u8(buf, type);
-        buf_write_u8(buf, size);
-        for (i = 0; i < len; ++i)
+        buf_write_u8(buf, (uint8_t)size);
+        for (unsigned int i = 0; i < len; ++i)
         {
             buf_write_u32(buf, data[i]);
         }
@@ -243,9 +237,9 @@
 }
 
 static void
-write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *error)
+write_dhcp_str(struct buffer *buf, const uint8_t type, const char *str, bool *error)
 {
-    const int len = strlen(str);
+    const size_t len = strlen(str);
     if (!buf_safe(buf, 2 + len))
     {
         *error = true;
@@ -259,7 +253,7 @@
         return;
     }
     buf_write_u8(buf, type);
-    buf_write_u8(buf, len);
+    buf_write_u8(buf, (uint8_t)len);
     buf_write(buf, str, len);
 }
 
@@ -272,15 +266,14 @@
  *  0x1D  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
  */
 static void
-write_dhcp_search_str(struct buffer *buf, const int type, const char *const *str_array,
+write_dhcp_search_str(struct buffer *buf, const uint8_t type, const char *const *str_array,
                       int array_len, bool *error)
 {
     char tmp_buf[256];
-    int i;
-    int len = 0;
-    int label_length_pos;
+    size_t len = 0;
+    size_t label_length_pos;
 
-    for (i = 0; i < array_len; i++)
+    for (int i = 0; i < array_len; i++)
     {
         const char *ptr = str_array[i];
 
@@ -301,7 +294,8 @@
         {
             if (*ptr == '.' || *ptr == '\0')
             {
-                tmp_buf[label_length_pos] = (len - label_length_pos) - 1;
+                /* cast is protected by sizeof(tmp_buf) */
+                tmp_buf[label_length_pos] = (char)(len - label_length_pos - 1);
                 label_length_pos = len;
                 if (*ptr == '\0')
                 {
@@ -328,14 +322,10 @@
     }
 
     buf_write_u8(buf, type);
-    buf_write_u8(buf, len);
+    buf_write_u8(buf, (uint8_t)len);
     buf_write(buf, tmp_buf, len);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
 {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fec17b4..c0d8fe6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1322,7 +1322,7 @@
     SHOW_BOOL(dhcp_pre_release);
     SHOW_STR(domain);
     SHOW_STR(netbios_scope);
-    SHOW_INT(netbios_node_type);
+    SHOW_UNSIGNED(netbios_node_type);
     SHOW_BOOL(disable_nbt);
 
     show_dhcp_option_addrs("DNS", o->dns, o->dns_len);
@@ -8001,7 +8001,7 @@
                 msg(msglevel, "--dhcp-option NBT: parameter (%d) must be 1, 2, 4, or 8", t);
                 goto err;
             }
-            o->netbios_node_type = t;
+            o->netbios_node_type = (uint8_t)t;
             o->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
         }
         else if (streq(p[1], "WINS") && p[2] && !p[3])
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 741798d..e13f99f 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -104,11 +104,10 @@
 
     const char *netbios_scope; /* NBS (47) */
 
-    int netbios_node_type;     /* NBT 1,2,4,8 (46) */
+    uint8_t netbios_node_type; /* NBT 1,2,4,8 (46) */
 
-#define N_DHCP_ADDR                     \
-    4 /* Max # of addresses allowed for \
-       * DNS, WINS, etc. */
+/* Max # of addresses allowed for  DNS, WINS, etc. */
+#define N_DHCP_ADDR 4
 
     /* DNS (6) */
     in_addr_t dns[N_DHCP_ADDR];

