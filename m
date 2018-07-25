From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 25 Jul 2018 18:08:47 +0200
Message-ID: <1532534933-3858-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 1/7] Introduce buffer_write_file()
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

Rewrite buf_write_string_file to buffer_write_file, which is simpler to
use and can deal with not-null-terminated strings.  Mostly implemented so
this can be easily reused for tls-crypt-v2 (client) key files.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v3: split change out of "generate client key", reuse in write_key_file()

 src/openvpn/buffer.c | 31 ++++++++++++++++++++++++-------
 src/openvpn/buffer.h |  7 ++-----
 src/openvpn/crypto.c | 30 +++++-------------------------
 3 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 0972139..20e2b9c 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -343,16 +343,33 @@ convert_to_one_line(struct buffer *buf)
     }
 }
 
-/* NOTE: requires that string be null terminated */
-void
-buf_write_string_file(const struct buffer *buf, const char *filename, int fd)
+bool
+buffer_write_file(const char *filename, const struct buffer *buf)
 {
-    const int len = strlen((char *) BPTR(buf));
-    const int size = write(fd, BPTR(buf), len);
-    if (size != len)
+    bool ret = false;
+    int fd = platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY,
+                           S_IRUSR | S_IWUSR);
+    if (fd == -1)
+    {
+        msg(M_ERRNO, "Cannot open file '%s' for write", filename);
+        goto cleanup;
+    }
+
+    const int size = write(fd, BPTR(buf), BLEN(buf));
+    if (size != BLEN(buf))
     {
-        msg(M_ERR, "Write error on file '%s'", filename);
+        msg(M_ERRNO, "Write error on file '%s'", filename);
+        goto cleanup;
+    }
+
+    ret = true;
+cleanup:
+    if (close(fd))
+    {
+        msg(M_ERRNO, "Close error on file %s", filename);
+        ret = false;
     }
+    return ret;
 }
 
 /*
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 6b6025e..180dd56 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -469,11 +469,8 @@ const char *skip_leading_whitespace(const char *str);
 
 void string_null_terminate(char *str, int len, int capacity);
 
-/*
- * Write string in buf to file descriptor fd.
- * NOTE: requires that string be null terminated.
- */
-void buf_write_string_file(const struct buffer *buf, const char *filename, int fd);
+/** Write buffer contents to file */
+bool buffer_write_file(const char *filename, const struct buffer *buf);
 
 /*
  * write a string to the end of a buffer that was
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 5381ef2..35bd243 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1427,27 +1427,19 @@ write_key_file(const int nkeys, const char *filename)
 {
     struct gc_arena gc = gc_new();
 
-    int fd, i;
-    int nbits = 0;
+    int nbits = nkeys * sizeof(struct key) * 8;
 
     /* must be large enough to hold full key file */
     struct buffer out = alloc_buf_gc(2048, &gc);
-    struct buffer nbits_head_text = alloc_buf_gc(128, &gc);
 
     /* how to format the ascii file representation of key */
     const int bytes_per_line = 16;
 
-    /* open key file */
-    fd = platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR);
-
-    if (fd == -1)
-    {
-        msg(M_ERR, "Cannot open shared secret file '%s' for write", filename);
-    }
-
+    /* write header */
+    buf_printf(&out, "#\n# %d bit OpenVPN static key\n#\n", nbits);
     buf_printf(&out, "%s\n", static_key_head);
 
-    for (i = 0; i < nkeys; ++i)
+    for (int i = 0; i < nkeys; ++i)
     {
         struct key key;
         char *fmt;
@@ -1463,9 +1455,6 @@ write_key_file(const int nkeys, const char *filename)
                             "\n",
                             &gc);
 
-        /* increment random bits counter */
-        nbits += sizeof(key) * 8;
-
         /* write to holding buffer */
         buf_printf(&out, "%s\n", fmt);
 
@@ -1476,17 +1465,8 @@ write_key_file(const int nkeys, const char *filename)
 
     buf_printf(&out, "%s\n", static_key_foot);
 
-    /* write number of bits */
-    buf_printf(&nbits_head_text, "#\n# %d bit OpenVPN static key\n#\n", nbits);
-    buf_write_string_file(&nbits_head_text, filename, fd);
-
     /* write key file, now formatted in out, to file */
-    buf_write_string_file(&out, filename, fd);
-
-    if (close(fd))
-    {
-        msg(M_ERR, "Close error on shared secret file %s", filename);
-    }
+    buffer_write_file(filename, &out);
 
     /* zero memory which held file content (memory will be freed by GC) */
     buf_clear(&out);
-- 
2.7.4


