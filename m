From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 2 Aug 2018 17:46:19 +0200
Message-ID: <1533224779-13216-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <e5bcbb69-2b69-4f57-c541-35dd403f6199@...1435...>
References: <e5bcbb69-2b69-4f57-c541-35dd403f6199@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 1/7] Introduce buffer_write_file()
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
v4: improve doxygen and error handling

 src/openvpn/buffer.c | 31 ++++++++++++++++++++++++-------
 src/openvpn/buffer.h | 12 ++++++++----
 src/openvpn/crypto.c | 33 ++++++---------------------------
 src/openvpn/crypto.h |  5 +++++
 src/openvpn/init.c   |  4 ++++
 5 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 0972139..7f540d7 100644
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
+    if (close(fd) < 0)
+    {
+        msg(M_ERRNO, "Close error on file %s", filename);
+        ret = false;
     }
+    return ret;
 }
 
 /*
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 6b6025e..704129a 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -469,11 +469,15 @@ const char *skip_leading_whitespace(const char *str);
 
 void string_null_terminate(char *str, int len, int capacity);
 
-/*
- * Write string in buf to file descriptor fd.
- * NOTE: requires that string be null terminated.
+/**
+ * Write buffer contents to file.
+ *
+ * @param filename  The filename to write the buffer to.
+ * @param buf       Thu buffer to write to the file.
+ *
+ * @return true on success, false otherwise.
  */
-void buf_write_string_file(const struct buffer *buf, const char *filename, int fd);
+bool buffer_write_file(const char *filename, const struct buffer *buf);
 
 /*
  * write a string to the end of a buffer that was
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 5381ef2..c8d95f3 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1418,36 +1418,24 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
     gc_free(&gc);
 }
 
-/*
- * Write key to file, return number of random bits
- * written.
- */
 int
 write_key_file(const int nkeys, const char *filename)
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
@@ -1463,9 +1451,6 @@ write_key_file(const int nkeys, const char *filename)
                             "\n",
                             &gc);
 
-        /* increment random bits counter */
-        nbits += sizeof(key) * 8;
-
         /* write to holding buffer */
         buf_printf(&out, "%s\n", fmt);
 
@@ -1476,16 +1461,10 @@ write_key_file(const int nkeys, const char *filename)
 
     buf_printf(&out, "%s\n", static_key_foot);
 
-    /* write number of bits */
-    buf_printf(&nbits_head_text, "#\n# %d bit OpenVPN static key\n#\n", nbits);
-    buf_write_string_file(&nbits_head_text, filename, fd);
-
     /* write key file, now formatted in out, to file */
-    buf_write_string_file(&out, filename, fd);
-
-    if (close(fd))
+    if(!buffer_write_file(filename, &out))
     {
-        msg(M_ERR, "Close error on shared secret file %s", filename);
+        nbits = -1;
     }
 
     /* zero memory which held file content (memory will be freed by GC) */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 9417fa1..0dc597f 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -271,6 +271,11 @@ struct crypto_options
 #define RKF_INLINE       (1<<1)
 void read_key_file(struct key2 *key2, const char *file, const unsigned int flags);
 
+/**
+ * Write nkeys 1024-bits keys to file.
+ *
+ * @returns number of random bits written, or -1 on failure.
+ */
 int write_key_file(const int nkeys, const char *filename);
 
 int read_passphrase_hash(const char *passphrase_file,
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f432106..2933d55 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1041,6 +1041,10 @@ do_genkey(const struct options *options)
         }
 
         nbits_written = write_key_file(2, options->shared_secret_file);
+        if (nbits_written < 0)
+        {
+            msg(M_FATAL, "Failed to write key file");
+        }
 
         msg(D_GENKEY | M_NOPREFIX,
             "Randomly generated %d bit key written to %s", nbits_written,
-- 
2.7.4


