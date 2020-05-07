From: Arne Schwabe <arne@...1227...>
Date: Thu,  7 May 2020 15:25:34 +0200
Message-Id: <20200507132534.6380-1-arne@...1227...>
In-Reply-To: <5e8d7dc1-b8da-49ca-e757-4e45b7267d42@...1856...>
References: <5e8d7dc1-b8da-49ca-e757-4e45b7267d42@...1856...>
Subject: [Openvpn-devel] [PATCH v4] Do not write extra 0 byte for --gen-key
 with auth-token/tls-crypt-v2
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

Change crypto_pem_encode to not put a nul-terminated terminated
string into the buffer. This was  useful for printf but should
not be written into the file.

Instead do not assume that the buffer is null terminated and
print only the number of bytes in the buffer. Also fix a
similar case in printing static key where the 0 byte was
never added to the buffer

Patch V2: make pem_encode behave more like other similar functions in OpenVPN
          and do not null terminate.

Patch V3: also make the mbed TLS variant of pem_decode behave like other
          similar functions in OpeNVPN and accept a not null-terminated
          buffer.

Patch V4: The newly introduced unit test
          test_tls_crypt_v2_write_client_key_file_metadata
          was added after the V3 version of the patch and now misses the
          strlen with memcmp replacment that were added to
          test_tls_crypt_v2_write_client_key_file. Also add the
          modifictions to this function.

          Unconditionally allocate buffer in mbed TLS path as
          requested by Steffan.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c                      |  4 ++--
 src/openvpn/crypto_mbedtls.c              | 19 ++++++++++++-------
 src/openvpn/crypto_openssl.c              |  3 +--
 src/openvpn/tls_crypt.c                   |  2 +-
 tests/unit_tests/openvpn/test_tls_crypt.c |  9 ++++++---
 5 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1678cba8..b05262e1 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1478,7 +1478,7 @@ write_key_file(const int nkeys, const char *filename)
     /* write key file to stdout if no filename given */
     if (!filename || strcmp(filename, "")==0)
     {
-        printf("%s\n", BPTR(&out));
+        printf("%.*s\n", BLEN(&out), BPTR(&out));
     }
     /* write key file, now formatted in out, to file */
     else if (!buffer_write_file(filename, &out))
@@ -1887,7 +1887,7 @@ write_pem_key_file(const char *filename, const char *pem_name)
 
     if (!filename || strcmp(filename, "")==0)
     {
-        printf("%s\n", BPTR(&server_key_pem));
+        printf("%.*s", BLEN(&server_key_pem), BPTR(&server_key_pem));
     }
     else if (!buffer_write_file(filename, &server_key_pem))
     {
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 3e77fa9e..b6458abf 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -239,10 +239,12 @@ crypto_pem_encode(const char *name, struct buffer *dst,
         return false;
     }
 
+    /* We set the size buf to out_len-1 to NOT include the 0 byte that
+     * mbedtls_pem_write_buffer in its length calculation */
     *dst = alloc_buf_gc(out_len, gc);
     if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src),
                                           BPTR(dst), BCAP(dst), &out_len))
-        || !buf_inc_len(dst, out_len))
+        || !buf_inc_len(dst, out_len-1))
     {
         CLEAR(*dst);
         return false;
@@ -259,11 +261,6 @@ crypto_pem_decode(const char *name, struct buffer *dst,
     char header[1000+1] = { 0 };
     char footer[1000+1] = { 0 };
 
-    if (*(BLAST(src)) != '\0')
-    {
-        msg(M_WARN, "PEM decode error: source buffer not null-terminated");
-        return false;
-    }
     if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
     {
         return false;
@@ -273,9 +270,16 @@ crypto_pem_decode(const char *name, struct buffer *dst,
         return false;
     }
 
+    /* mbed TLS requires the src to be null-terminated */
+    /* allocate a new buffer to avoid modifying the src buffer */
+    struct gc_arena gc = gc_new();
+    struct buffer input = alloc_buf_gc(BLEN(src) + 1, &gc);
+    buf_copy(&input, src);
+    buf_null_terminate(&input);
+
     size_t use_len = 0;
     mbedtls_pem_context ctx = { 0 };
-    bool ret = mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(src),
+    bool ret = mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input),
                                                NULL, 0, &use_len));
     if (ret && !buf_write(dst, ctx.buf, ctx.buflen))
     {
@@ -284,6 +288,7 @@ crypto_pem_decode(const char *name, struct buffer *dst,
     }
 
     mbedtls_pem_free(&ctx);
+    gc_free(&gc);
     return ret;
 }
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index a81dcfd8..4fa65ba8 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -400,9 +400,8 @@ crypto_pem_encode(const char *name, struct buffer *dst,
     BUF_MEM *bptr;
     BIO_get_mem_ptr(bio, &bptr);
 
-    *dst = alloc_buf_gc(bptr->length + 1, gc);
+    *dst = alloc_buf_gc(bptr->length, gc);
     ASSERT(buf_write(dst, bptr->data, bptr->length));
-    buf_null_terminate(dst);
 
     ret = true;
 cleanup:
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index e9f9cc2a..3018c18e 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -702,7 +702,7 @@ tls_crypt_v2_write_client_key_file(const char *filename,
 
     if (!filename || streq(filename, ""))
     {
-        printf("%s\n", BPTR(&client_key_pem));
+        printf("%.*s\n", BLEN(&client_key_pem), BPTR(&client_key_pem));
         client_filename = INLINE_FILE_TAG;
         client_inline = (const char *)BPTR(&client_key_pem);
     }
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 8406d89d..28bebb6e 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -548,7 +548,8 @@ test_tls_crypt_v2_write_server_key_file(void **state)
     const char *filename = "testfilename.key";
 
     expect_string(__wrap_buffer_write_file, filename, filename);
-    expect_string(__wrap_buffer_write_file, pem, test_server_key);
+    expect_memory(__wrap_buffer_write_file, pem, test_server_key,
+                  strlen(test_server_key));
     will_return(__wrap_buffer_write_file, true);
 
     tls_crypt_v2_write_server_key_file(filename);
@@ -561,7 +562,8 @@ test_tls_crypt_v2_write_client_key_file(void **state)
 
     /* Test writing the client key */
     expect_string(__wrap_buffer_write_file, filename, filename);
-    expect_string(__wrap_buffer_write_file, pem, test_client_key);
+    expect_memory(__wrap_buffer_write_file, pem, test_client_key,
+                  strlen(test_client_key));
     will_return(__wrap_buffer_write_file, true);
 
     /* Key generation re-reads the created file as a sanity check */
@@ -580,7 +582,8 @@ test_tls_crypt_v2_write_client_key_file_metadata(void **state)
 
     /* Test writing the client key */
     expect_string(__wrap_buffer_write_file, filename, filename);
-    expect_string(__wrap_buffer_write_file, pem, test_client_key_metadata);
+    expect_memory(__wrap_buffer_write_file, pem, test_client_key_metadata,
+                strlen(test_client_key_metadata));
     will_return(__wrap_buffer_write_file, true);
 
     /* Key generation re-reads the created file as a sanity check */
-- 
2.26.0


