From: Gert Doering <gert@...1296...>
Date: Thu, 30 Oct 2025 15:52:26 +0100
Message-ID: <20251030145231.2792-1-gert@...1296...>
In-Reply-To: <gerrit.1761324750000.Id7bacec23edc6dcd94465c308ea2144c7329a0c1@...2715...>
References: <gerrit.1761324750000.Id7bacec23edc6dcd94465c308ea2144c7329a0c1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] ssl: Clean up type handling in
 export_user_keying_material()
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

For this we actually change the API of the
format_hex{,_ex} functions by changing int
to size_t for length parameters. While we
call this function with int paramters in
a lot of places (usually BLEN), this will
not produce warnings under
-Wno-sign-conversion. And we're sure those
values are positive since format_hex already
uses size_t internally.

Change-Id: Id7bacec23edc6dcd94465c308ea2144c7329a0c1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1301
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1301
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 28de00f..293622f 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -480,18 +480,17 @@
  */
 
 char *
-format_hex_ex(const uint8_t *data, int size, int maxoutput, unsigned int space_break_flags,
+format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, unsigned int space_break_flags,
               const char *separator, struct gc_arena *gc)
 {
     const size_t bytes_per_hexblock = space_break_flags & FHE_SPACE_BREAK_MASK;
     const size_t separator_len = separator ? strlen(separator) : 0;
-    static_assert(INT_MAX <= SIZE_MAX, "Code assumes INT_MAX <= SIZE_MAX");
     const size_t out_len = maxoutput > 0
                                ? maxoutput
                                : ((size * 2) + ((size / bytes_per_hexblock) * separator_len) + 2);
 
     struct buffer out = alloc_buf_gc(out_len, gc);
-    for (int i = 0; i < size; ++i)
+    for (size_t i = 0; i < size; ++i)
     {
         if (separator && i && !(i % bytes_per_hexblock))
         {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 148cee0..ab2a29d 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -496,11 +496,11 @@
  */
 #define FHE_SPACE_BREAK_MASK 0xFF  /* space_break parameter in lower 8 bits */
 #define FHE_CAPS             0x100 /* output hex in caps */
-char *format_hex_ex(const uint8_t *data, int size, int maxoutput, unsigned int space_break_flags,
+char *format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, unsigned int space_break_flags,
                     const char *separator, struct gc_arena *gc);
 
 static inline char *
-format_hex(const uint8_t *data, int size, int maxoutput, struct gc_arena *gc)
+format_hex(const uint8_t *data, size_t size, size_t maxoutput, struct gc_arena *gc)
 {
     return format_hex_ex(data, size, maxoutput, 4, " ", gc);
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index be29367..987d450 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1829,11 +1829,6 @@
     return len;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static char *
 read_string_alloc(struct buffer *buf)
 {
@@ -2174,15 +2169,15 @@
 {
     if (session->opt->ekm_size > 0)
     {
-        unsigned int size = session->opt->ekm_size;
+        const size_t size = session->opt->ekm_size;
         struct gc_arena gc = gc_new();
 
-        unsigned char *ekm = gc_malloc(session->opt->ekm_size, true, &gc);
+        unsigned char *ekm = gc_malloc(size, true, &gc);
         if (key_state_export_keying_material(session, session->opt->ekm_label,
                                              session->opt->ekm_label_size, ekm,
                                              session->opt->ekm_size))
         {
-            unsigned int len = (size * 2) + 2;
+            const size_t len = (size * 2) + 2;
 
             const char *key = format_hex_ex(ekm, size, len, 0, NULL, &gc);
             setenv_str(session->opt->es, "exported_keying_material", key);
@@ -2199,6 +2194,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * Handle reading key data, peer-info, username/password, OCC
  * from the TLS control channel (cleartext).

