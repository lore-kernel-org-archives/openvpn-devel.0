From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Dec 2022 20:01:40 +0100
Message-Id: <20221215190143.2107896-6-arne@...1227...>
In-Reply-To: <20221215190143.2107896-1-arne@...1227...>
References: <20221215190143.2107896-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/8] Eliminate or comment empty blocks and
 switch fallthrough
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

These empty blocks are intentional but trigger code checkers and
were pointed out by Trail of Bits in the security audits. Add comments
to them or eliminate them whatever makes more sense.

For fallthrough C23 [1] has a standard way to signal that but we not
adding a C23 feature to our codebase, so use a comment for now.

[1] https://en.cppreference.com/w/c/language/attributes/fallthrough

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/comp-lz4.c    |  1 +
 src/openvpn/crypto.c      |  1 +
 src/openvpn/init.c        |  1 +
 src/openvpn/lzo.c         |  1 +
 src/openvpn/options.c     |  5 +--
 src/openvpn/ssl_openssl.c | 68 ++++++++++++++++++---------------------
 6 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index b456182e7..b54775b7e 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -237,6 +237,7 @@ lz4_decompress(struct buffer *buf, struct buffer work,
     }
     else if (c == NO_COMPRESS_BYTE_SWAP) /* packet was not compressed */
     {
+        /* nothing to do */
     }
     else
     {
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d266716c7..d735d7160 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1300,6 +1300,7 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
                 }
                 else if (isspace(c))
                 {
+                    /* ignore white space characters */
                 }
                 else
                 {
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 74b380327..219bff84c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2921,6 +2921,7 @@ do_init_crypto_tls_c1(struct context *c)
 
                 case AR_INTERACT:
                     ssl_purge_auth(false);
+                /* Intentional [[fallthrough]]; */
 
                 case AR_NOINTERACT:
                     c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Password failure error */
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 39e833cb3..ef6c4c8d7 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -250,6 +250,7 @@ lzo_decompress(struct buffer *buf, struct buffer work,
     }
     else if (c == NO_COMPRESS_BYTE)     /* packet was not compressed */
     {
+        /* nothing to do */
     }
     else
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1d6c0572c..4383c953e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2973,10 +2973,7 @@ options_postprocess_verify_ce(const struct options *options,
                             "--auth-user-pass");
                     }
                 }
-                else if (sum == 2)
-                {
-                }
-                else
+                else if (sum != 2)
                 {
                     msg(M_USAGE, "If you use one of --cert or --key, you must use them both");
                 }
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index cd6d84246..dbf909269 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1826,10 +1826,7 @@ bio_write(BIO *bio, const uint8_t *data, int size, const char *desc)
 
         if (i < 0)
         {
-            if (BIO_should_retry(bio))
-            {
-            }
-            else
+            if (!BIO_should_retry(bio))
             {
                 crypto_msg(D_TLS_ERRORS, "TLS ERROR: BIO write %s error", desc);
                 ret = -1;
@@ -1873,51 +1870,48 @@ bio_write_post(const int status, struct buffer *buf)
 static int
 bio_read(BIO *bio, struct buffer *buf, const char *desc)
 {
-    int i;
-    int ret = 0;
     ASSERT(buf->len >= 0);
     if (buf->len)
     {
+        /* we only want to write empty buffers, ignore read request
+         * if the buffer is not empty */
+        return 0;
     }
-    else
-    {
-        int len = buf_forward_capacity(buf);
+    int len = buf_forward_capacity(buf);
 
-        /*
-         * BIO_read brackets most of the serious RSA
-         * key negotiation number crunching.
-         */
-        i = BIO_read(bio, BPTR(buf), len);
+    /*
+     * BIO_read brackets most of the serious RSA
+     * key negotiation number crunching.
+     */
+    int i = BIO_read(bio, BPTR(buf), len);
 
-        VALGRIND_MAKE_READABLE((void *) &i, sizeof(i));
+    VALGRIND_MAKE_READABLE((void *) &i, sizeof(i));
 
 #ifdef BIO_DEBUG
-        bio_debug_data("read", bio, BPTR(buf), i, desc);
+    bio_debug_data("read", bio, BPTR(buf), i, desc);
 #endif
-        if (i < 0)
-        {
-            if (BIO_should_retry(bio))
-            {
-            }
-            else
-            {
-                crypto_msg(D_TLS_ERRORS, "TLS_ERROR: BIO read %s error", desc);
-                buf->len = 0;
-                ret = -1;
-                ERR_clear_error();
-            }
-        }
-        else if (!i)
+
+    int ret = 0;
+    if (i < 0)
+    {
+        if (!BIO_should_retry(bio))
         {
+            crypto_msg(D_TLS_ERRORS, "TLS_ERROR: BIO read %s error", desc);
             buf->len = 0;
+            ret = -1;
+            ERR_clear_error();
         }
-        else
-        {                       /* successful read */
-            dmsg(D_HANDSHAKE_VERBOSE, "BIO read %s %d bytes", desc, i);
-            buf->len = i;
-            ret = 1;
-            VALGRIND_MAKE_READABLE((void *) BPTR(buf), BLEN(buf));
-        }
+    }
+    else if (!i)
+    {
+        buf->len = 0;
+    }
+    else
+    {                       /* successful read */
+        dmsg(D_HANDSHAKE_VERBOSE, "BIO read %s %d bytes", desc, i);
+        buf->len = i;
+        ret = 1;
+        VALGRIND_MAKE_READABLE((void *) BPTR(buf), BLEN(buf));
     }
     return ret;
 }
-- 
2.37.1 (Apple Git-137.1)


