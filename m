From: Steffan Karger <steffan@...1856...>
Date: Fri, 23 Dec 2016 23:40:54 +0100
Message-Id: <1482532854-13699-1-git-send-email-steffan@...1856...>
In-Reply-To: <CAKuzo_hbGphKBoB3MEtA5mn6JLNanGshntvmJxisxVTDWAWKxA@...278...>
References: <CAKuzo_hbGphKBoB3MEtA5mn6JLNanGshntvmJxisxVTDWAWKxA@...278...>
Subject: [Openvpn-devel] [PATCH v2] More broadly enforce Allman style and
	braces-around-conditionals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

We want { and } aligned, which means also adding a newline between each
for() and {, while() and {, etc.

Also, we agreed to always use braces with conditionals.  The previous
uncrustify config added these for if()s, now also add these for while()
and for().

Signed-off-by: Steffan Karger <steffan@...1856...>
---
This patch replaces the "Add nl_for_brace=add to uncrustify.conf" patch.

v2: also add nl_do_brace=add and mod_full_brace_do=add

 dev-tools/uncrustify.conf          |  8 +++++
 src/compat/compat-daemon.c         |  3 +-
 src/compat/compat-dirname.c        |  7 +++-
 src/compat/compat-inet_ntop.c      |  3 +-
 src/compat/compat-inet_pton.c      |  3 +-
 src/compat/compat-versionhelpers.h | 36 ++++++++++++++-------
 src/openvpn/argv.c                 | 10 ++++++
 src/openvpn/base64.c               | 11 +++++--
 src/openvpn/buffer.c               |  9 +++++-
 src/openvpn/buffer.h               |  2 ++
 src/openvpn/comp-lz4.c             |  3 +-
 src/openvpn/compstub.c             |  3 +-
 src/openvpn/console.c              |  6 ++--
 src/openvpn/crypto.c               | 18 +++++++----
 src/openvpn/crypto.h               |  3 +-
 src/openvpn/crypto_mbedtls.h       |  3 +-
 src/openvpn/crypto_openssl.c       |  6 ++--
 src/openvpn/cryptoapi.c            |  9 ++++--
 src/openvpn/dhcp.c                 | 11 +++++--
 src/openvpn/error.c                |  3 +-
 src/openvpn/error.h                |  3 +-
 src/openvpn/event.c                |  4 +++
 src/openvpn/fragment.c             |  9 +++++-
 src/openvpn/gremlin.c              | 15 ++++++---
 src/openvpn/httpdigest.c           |  3 +-
 src/openvpn/init.c                 | 11 ++++++-
 src/openvpn/interval.h             |  3 +-
 src/openvpn/list.c                 |  6 ++--
 src/openvpn/lzo.c                  |  3 +-
 src/openvpn/manage.c               | 15 +++++++--
 src/openvpn/mbuf.c                 |  3 +-
 src/openvpn/memdbg.h               |  3 +-
 src/openvpn/misc.c                 |  9 +++++-
 src/openvpn/mroute.c               |  3 +-
 src/openvpn/mss.c                  |  3 +-
 src/openvpn/mtcp.c                 |  3 +-
 src/openvpn/multi.c                | 14 ++++++--
 src/openvpn/ntlm.c                 | 14 +++++---
 src/openvpn/occ.c                  |  3 +-
 src/openvpn/openvpn.c              |  6 ++--
 src/openvpn/options.c              | 52 +++++++++++++++++++++++++++---
 src/openvpn/otime.h                |  3 +-
 src/openvpn/packet_id.c            |  3 +-
 src/openvpn/perf.c                 |  5 ++-
 src/openvpn/perf.h                 |  9 ++++--
 src/openvpn/pkcs11.c               | 66 +++++++++++++++++++++++++-------------
 src/openvpn/plugin.c               | 11 ++++++-
 src/openvpn/pool.c                 |  2 ++
 src/openvpn/proxy.c                | 10 ++++--
 src/openvpn/reliable.c             |  7 +++-
 src/openvpn/route.c                | 13 +++++++-
 src/openvpn/route.h                |  3 +-
 src/openvpn/schedule.c             |  4 +++
 src/openvpn/session_id.c           |  3 +-
 src/openvpn/shaper.c               |  3 +-
 src/openvpn/socket.c               | 12 +++++--
 src/openvpn/socket.h               | 24 +++++++++-----
 src/openvpn/ssl.c                  | 26 +++++++++++----
 src/openvpn/ssl_mbedtls.c          |  8 +++--
 src/openvpn/ssl_openssl.c          |  3 +-
 src/openvpn/ssl_verify.c           |  6 ++++
 src/openvpn/ssl_verify_mbedtls.c   |  2 ++
 src/openvpn/ssl_verify_openssl.c   |  3 +-
 src/openvpn/tls_crypt.c            |  6 ++--
 src/openvpn/tun.c                  | 26 +++++++++++----
 src/openvpn/win32.c                |  8 +++--
 src/openvpnserv/automatic.c        |  3 +-
 src/openvpnserv/interactive.c      |  5 ++-
 src/plugins/auth-pam/utils.c       |  5 ++-
 src/plugins/down-root/down-root.c  |  2 ++
 70 files changed, 479 insertions(+), 144 deletions(-)

diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
index 95e0b2a..d8ea870 100644
--- a/dev-tools/uncrustify.conf
+++ b/dev-tools/uncrustify.conf
@@ -9,6 +9,11 @@ nl_brace_else=add
 nl_elseif_brace=add
 nl_else_brace=add
 nl_else_if=remove
+nl_for_brace=add
+nl_while_brace=add
+nl_switch_brace=add
+nl_fdef_brace=add
+nl_do_brace=add
 sp_func_proto_paren=Remove
 sp_func_def_paren=Remove
 sp_func_call_paren=Remove
@@ -44,6 +49,9 @@ nl_after_func_proto=2
 # Always use scoping braces for conditionals
 mod_full_brace_if=add
 mod_full_brace_if_chain=false
+mod_full_brace_while=add
+mod_full_brace_for=add
+mod_full_brace_do=add
 
 # Annotate #else and #endif statements
 mod_add_long_ifdef_endif_comment=20
diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
index 5093942..b54e813 100644
--- a/src/compat/compat-daemon.c
+++ b/src/compat/compat-daemon.c
@@ -58,7 +58,8 @@ int
 daemon(int nochdir, int noclose)
 {
 #if defined(HAVE_FORK) && defined(HAVE_SETSID)
-    switch (fork()) {
+    switch (fork())
+    {
         case -1:
             return (-1);
 
diff --git a/src/compat/compat-dirname.c b/src/compat/compat-dirname.c
index 7687108..7747dbd 100644
--- a/src/compat/compat-dirname.c
+++ b/src/compat/compat-dirname.c
@@ -44,7 +44,8 @@ __memrchr(const char *str, int c, size_t n)
     const char *end = str;
 
     end += n - 1; /* Go to the end of the string */
-    while (end >= str) {
+    while (end >= str)
+    {
         if (c == *end)
         {
             return end;
@@ -82,10 +83,12 @@ dirname(char *path)
         char *runp;
 
         for (runp = last_slash; runp != path; --runp)
+        {
             if (runp[-1] != separator)
             {
                 break;
             }
+        }
 
         /* The '/' is the last character, we have to look further.  */
         if (runp != path)
@@ -100,10 +103,12 @@ dirname(char *path)
         char *runp;
 
         for (runp = last_slash; runp != path; --runp)
+        {
             if (runp[-1] != separator)
             {
                 break;
             }
+        }
 
         /* Terminate the path.  */
         if (runp == path)
diff --git a/src/compat/compat-inet_ntop.c b/src/compat/compat-inet_ntop.c
index dd7abb5..07d0dde 100644
--- a/src/compat/compat-inet_ntop.c
+++ b/src/compat/compat-inet_ntop.c
@@ -52,7 +52,8 @@ inet_ntop(int af, const void *src, char *dst, socklen_t size)
     ZeroMemory(&ss, sizeof(ss));
     ss.ss_family = af;
 
-    switch (af) {
+    switch (af)
+    {
         case AF_INET:
             ((struct sockaddr_in *)&ss)->sin_addr = *(struct in_addr *)src;
             break;
diff --git a/src/compat/compat-inet_pton.c b/src/compat/compat-inet_pton.c
index 1e41fa2..170e294 100644
--- a/src/compat/compat-inet_pton.c
+++ b/src/compat/compat-inet_pton.c
@@ -59,7 +59,8 @@ inet_pton(int af, const char *src, void *dst)
 
     if (WSAStringToAddress(src_copy, af, NULL, (struct sockaddr *)&ss, &size) == 0)
     {
-        switch (af) {
+        switch (af)
+        {
             case AF_INET:
                 *(struct in_addr *)dst = ((struct sockaddr_in *)&ss)->sin_addr;
                 return 1;
diff --git a/src/compat/compat-versionhelpers.h b/src/compat/compat-versionhelpers.h
index a793056..251fb04 100644
--- a/src/compat/compat-versionhelpers.h
+++ b/src/compat/compat-versionhelpers.h
@@ -30,62 +30,74 @@ IsWindowsVersionOrGreater(WORD major, WORD minor, WORD servpack)
 }
 
 VERSIONHELPERAPI
-IsWindowsXPOrGreater(void) {
+IsWindowsXPOrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 0);
 }
 
 VERSIONHELPERAPI
-IsWindowsXPSP1OrGreater(void) {
+IsWindowsXPSP1OrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 1);
 }
 
 VERSIONHELPERAPI
-IsWindowsXPSP2OrGreater(void) {
+IsWindowsXPSP2OrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 2);
 }
 
 VERSIONHELPERAPI
-IsWindowsXPSP3OrGreater(void) {
+IsWindowsXPSP3OrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 3);
 }
 
 VERSIONHELPERAPI
-IsWindowsVistaOrGreater(void) {
+IsWindowsVistaOrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 0);
 }
 
 VERSIONHELPERAPI
-IsWindowsVistaSP1OrGreater(void) {
+IsWindowsVistaSP1OrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 1);
 }
 
 VERSIONHELPERAPI
-IsWindowsVistaSP2OrGreater(void) {
+IsWindowsVistaSP2OrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 2);
 }
 
 VERSIONHELPERAPI
-IsWindows7OrGreater(void) {
+IsWindows7OrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 0);
 }
 
 VERSIONHELPERAPI
-IsWindows7SP1OrGreater(void) {
+IsWindows7SP1OrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 1);
 }
 
 VERSIONHELPERAPI
-IsWindows8OrGreater(void) {
+IsWindows8OrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN8), LOBYTE(_WIN32_WINNT_WIN8), 0);
 }
 
 VERSIONHELPERAPI
-IsWindows8Point1OrGreater(void) {
+IsWindows8Point1OrGreater(void)
+{
     return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINBLUE), LOBYTE(_WIN32_WINNT_WINBLUE), 0);
 }
 
 VERSIONHELPERAPI
-IsWindowsServer(void) {
+IsWindowsServer(void)
+{
     OSVERSIONINFOEXW vi = {sizeof(vi),0,0,0,0,{0},0,0,0,VER_NT_WORKSTATION};
     return !VerifyVersionInfoW(&vi, VER_PRODUCT_TYPE, VerSetConditionMask(0, VER_PRODUCT_TYPE, VER_EQUAL));
 }
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index cc813ed..59caa6f 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -60,7 +60,9 @@ argv_reset(struct argv *a)
 {
     size_t i;
     for (i = 0; i < a->argc; ++i)
+    {
         free(a->argv[i]);
+    }
     free(a->argv);
     argv_init(a);
 }
@@ -74,7 +76,9 @@ argv_extend(struct argv *a, const size_t newcap)
         size_t i;
         ALLOC_ARRAY_CLEAR(newargv, char *, newcap);
         for (i = 0; i < a->argc; ++i)
+        {
             newargv[i] = a->argv[i];
+        }
         free(a->argv);
         a->argv = newargv;
         a->capacity = newcap;
@@ -104,11 +108,15 @@ argv_clone(const struct argv *a, const size_t headroom)
 
     argv_init(&r);
     for (i = 0; i < headroom; ++i)
+    {
         argv_append(&r, NULL);
+    }
     if (a)
     {
         for (i = 0; i < a->argc; ++i)
+        {
             argv_append(&r, string_alloc(a->argv[i], NULL));
+        }
     }
     return r;
 }
@@ -332,7 +340,9 @@ argv_parse_cmd(struct argv *a, const char *s)
     {
         int i;
         for (i = 0; i < nparms; ++i)
+        {
             argv_append(a, string_alloc(parms[i], NULL));
+        }
     }
     else
     {
diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index c799ede..0ac65e9 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -69,7 +69,8 @@ openvpn_base64_encode(const void *data, int size, char **str)
     }
     q = (const unsigned char *) data;
     i = 0;
-    for (i = 0; i < size; ) {
+    for (i = 0; i < size; )
+    {
         c = q[i++];
         c *= 256;
         if (i < size)
@@ -107,10 +108,12 @@ pos(char c)
 {
     char *p;
     for (p = base64_chars; *p; p++)
+    {
         if (*p == c)
         {
             return p - base64_chars;
         }
+    }
     return -1;
 }
 
@@ -126,7 +129,8 @@ token_decode(const char *token)
     {
         return DECODE_ERROR;
     }
-    for (i = 0; i < 4; i++) {
+    for (i = 0; i < 4; i++)
+    {
         val *= 64;
         if (token[i] == '=')
         {
@@ -164,7 +168,8 @@ openvpn_base64_decode(const char *str, void *data, int size)
     {
         e = q + size;
     }
-    for (p = str; *p && (*p == '=' || strchr(base64_chars, *p)); p += 4) {
+    for (p = str; *p && (*p == '=' || strchr(base64_chars, *p)); p += 4)
+    {
         unsigned int val = token_decode(p);
         unsigned int marker = (val >> 24) & 0xff;
         if (val == DECODE_ERROR)
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 3004a41..9938257 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -449,7 +449,9 @@ gc_transfer(struct gc_arena *dest, struct gc_arena *src)
         if (e)
         {
             while (e->next != NULL)
+            {
                 e = e->next;
+            }
             e->next = dest->list;
             dest->list = src->list;
             src->list = NULL;
@@ -605,7 +607,8 @@ void
 rm_trailing_chars(char *str, const char *what_to_delete)
 {
     bool modified;
-    do {
+    do
+    {
         const int len = strlen(str);
         modified = false;
         if (len > 0)
@@ -688,7 +691,9 @@ string_array_len(const char **array)
     if (array)
     {
         while (array[i])
+        {
             ++i;
+        }
     }
     return i;
 }
@@ -1326,7 +1331,9 @@ buffer_list_file(const char *fn, int max_line_len)
         {
             bl = buffer_list_new(0);
             while (fgets(line, max_line_len, fp) != NULL)
+            {
                 buffer_list_push(bl, (unsigned char *)line);
+            }
             free(line);
         }
         fclose(fp);
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 80977ac..e74a1d7 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -411,7 +411,9 @@ secure_memzero(void *data, size_t len)
 #else
     volatile char *p = (volatile char *) data;
     while (len--)
+    {
         *p++ = 0;
+    }
 #endif
 }
 
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index fa65f87..e1f83e7 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -316,6 +316,7 @@ const struct compress_alg lz4v2_alg = {
 
 #else  /* if defined(ENABLE_LZ4) */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ENABLE_LZ4 */
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index 5070c82..dd9c175 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -179,6 +179,7 @@ const struct compress_alg comp_stub_alg = {
 
 #else  /* if defined(USE_COMP) */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* USE_STUB */
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 90c8a94..2c418ac 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -49,7 +49,8 @@ query_user_clear()
 {
     int i;
 
-    for (i = 0; i < QUERY_USER_NUMSLOTS; i++) {
+    for (i = 0; i < QUERY_USER_NUMSLOTS; i++)
+    {
         CLEAR(query_user[i]);
     }
 }
@@ -68,7 +69,8 @@ query_user_add(char *prompt, size_t prompt_len,
     ASSERT( prompt_len > 0 && prompt != NULL && resp_len > 0 && resp != NULL );
 
     /* Seek to the last unused slot */
-    for (i = 0; i < QUERY_USER_NUMSLOTS; i++) {
+    for (i = 0; i < QUERY_USER_NUMSLOTS; i++)
+    {
         if (query_user[i].prompt == NULL)
         {
             break;
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 63f8806..fd1e630 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -65,7 +65,8 @@
 
 static void
 openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
-                     struct crypto_options *opt) {
+                     struct crypto_options *opt)
+{
 #ifdef HAVE_AEAD_CIPHER_MODES
     struct gc_arena gc;
     int outlen = 0;
@@ -343,7 +344,8 @@ openvpn_encrypt(struct buffer *buf, struct buffer work,
 bool
 crypto_check_replay(struct crypto_options *opt,
                     const struct packet_id_net *pin, const char *error_prefix,
-                    struct gc_arena *gc) {
+                    struct gc_arena *gc)
+{
     bool ret = false;
     packet_id_reap_test(&opt->packet_id.rec);
     if (packet_id_test(&opt->packet_id.rec, pin))
@@ -1036,7 +1038,8 @@ generate_key_random(struct key *key, const struct key_type *kt)
 
     struct gc_arena gc = gc_new();
 
-    do {
+    do
+    {
         CLEAR(*key);
         if (kt)
         {
@@ -1817,7 +1820,8 @@ get_random()
 }
 
 static const cipher_name_pair *
-get_cipher_name_pair(const char *cipher_name) {
+get_cipher_name_pair(const char *cipher_name)
+{
     const cipher_name_pair *pair;
     size_t i = 0;
 
@@ -1837,7 +1841,8 @@ get_cipher_name_pair(const char *cipher_name) {
 }
 
 const char *
-translate_cipher_name_from_openvpn(const char *cipher_name) {
+translate_cipher_name_from_openvpn(const char *cipher_name)
+{
     const cipher_name_pair *pair = get_cipher_name_pair(cipher_name);
 
     if (NULL == pair)
@@ -1849,7 +1854,8 @@ translate_cipher_name_from_openvpn(const char *cipher_name) {
 }
 
 const char *
-translate_cipher_name_to_openvpn(const char *cipher_name) {
+translate_cipher_name_to_openvpn(const char *cipher_name)
+{
     const cipher_name_pair *pair = get_cipher_name_pair(cipher_name);
 
     if (NULL == pair)
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 99d7689..4a03a4a 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -510,7 +510,8 @@ void crypto_read_openvpn_key(const struct key_type *key_type,
  * Returns 0 when data is equal, non-zero otherwise.
  */
 static inline int
-memcmp_constant_time(const void *a, const void *b, size_t size) {
+memcmp_constant_time(const void *a, const void *b, size_t size)
+{
     const uint8_t *a1 = a;
     const uint8_t *b1 = b;
     int ret = 0;
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index e23e275..e4c1537 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -123,7 +123,8 @@ bool mbed_log_func_line(unsigned int flags, int errval, const char *func,
 /** Wraps mbed_log_func_line() to prevent function calls for non-errors */
 static inline bool
 mbed_log_func_line_lite(unsigned int flags, int errval,
-                        const char *func, int line) {
+                        const char *func, int line)
+{
     if (errval)
     {
         return mbed_log_func_line(flags, errval, func, line);
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index bd0065c..fd1a245 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -191,7 +191,8 @@ crypto_clear_error(void)
 }
 
 void
-crypto_print_openssl_errors(const unsigned int flags) {
+crypto_print_openssl_errors(const unsigned int flags)
+{
     size_t err = 0;
 
     while ((err = ERR_get_error()))
@@ -558,7 +559,8 @@ cipher_kt_iv_size(const EVP_CIPHER *cipher_kt)
 }
 
 int
-cipher_kt_block_size(const EVP_CIPHER *cipher) {
+cipher_kt_block_size(const EVP_CIPHER *cipher)
+{
     /*
      * OpenSSL reports OFB/CFB/GCM cipher block sizes as '1 byte'.  To work
      * around that, try to replace the mode with 'CBC' and return the block size
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 6eecd77..c2ffbfa 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -308,7 +308,9 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa,
     }
     /* now we have to reverse the byte-order of the CryptSignHash() result... */
     for (i = 0; i < len; i++)
+    {
         to[i] = buf[len - i - 1];
+    }
     free(buf);
 
     CryptDestroyHash(hash);
@@ -423,7 +425,9 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
             }
             hash[i] = x;
             /* skip any space(s) between hex numbers */
-            for (p++; *p && *p == ' '; p++) ;
+            for (p++; *p && *p == ' '; p++)
+            {
+            }
         }
         blob.cbData = i;
         blob.pbData = (unsigned char *) &hash;
@@ -593,7 +597,8 @@ err:
 #ifdef _MSC_VER
 /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif
 #endif /* ifdef ENABLE_CRYPTOAPI */
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index c17a22e..4ffa9d6 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -160,17 +160,20 @@ udp_checksum(const uint8_t *buf,
 
     /* make 16 bit words out of every two adjacent 8 bit words and  */
     /* calculate the sum of all 16 bit words */
-    for (i = 0; i < len_udp; i += 2) {
+    for (i = 0; i < len_udp; i += 2)
+    {
         word16 = ((buf[i] << 8) & 0xFF00) + ((i + 1 < len_udp) ? (buf[i+1] & 0xFF) : 0);
         sum += word16;
     }
 
     /* add the UDP pseudo header which contains the IP source and destination addresses */
-    for (i = 0; i < 4; i += 2) {
+    for (i = 0; i < 4; i += 2)
+    {
         word16 = ((src_addr[i] << 8) & 0xFF00) + (src_addr[i+1] & 0xFF);
         sum += word16;
     }
-    for (i = 0; i < 4; i += 2) {
+    for (i = 0; i < 4; i += 2)
+    {
         word16 = ((dest_addr[i] << 8) & 0xFF00) + (dest_addr[i+1] & 0xFF);
         sum += word16;
     }
@@ -180,7 +183,9 @@ udp_checksum(const uint8_t *buf,
 
     /* keep only the last 16 bits of the 32 bit calculated sum and add the carries */
     while (sum >> 16)
+    {
         sum = (sum & 0xFFFF) + (sum >> 16);
+    }
 
     /* Take the one's complement of sum */
     return ((uint16_t) ~sum);
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index e78f272..dbff81d 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -836,7 +836,8 @@ strerror_win32(DWORD errnum, struct gc_arena *gc)
      * Posix equivalents.
      */
 #if 1
-    switch (errnum) {
+    switch (errnum)
+    {
         /*
          * When the TAP-Windows driver returns STATUS_UNSUCCESSFUL, this code
          * gets returned to user space.
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index df4eee7..c86b956 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -394,7 +394,8 @@ ignore_sys_error(const int err)
 
 /** Convert fatal errors to nonfatal, don't touch other errors */
 static inline unsigned int
-nonfatal(const unsigned int err) {
+nonfatal(const unsigned int err)
+{
     return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
 }
 
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index f4922e0..e77bc4c 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -394,11 +394,13 @@ we_wait(struct event_set *es, const struct timeval *tv, struct event_set_return
     {
         int i;
         for (i = 0; i < wes->n_events; ++i)
+        {
             dmsg(D_EVENT_WAIT, "[%d] ev=%p rwflags=0x%04x arg=" ptr_format,
                  i,
                  wes->events[i],
                  wes->esr[i].rwflags,
                  (ptr_type)wes->esr[i].arg);
+        }
     }
 #endif
 
@@ -922,7 +924,9 @@ se_reset(struct event_set *es)
     FD_ZERO(&ses->readfds);
     FD_ZERO(&ses->writefds);
     for (i = 0; i <= ses->maxfd; ++i)
+    {
         ses->args[i] = NULL;
+    }
     ses->maxfd = -1;
 }
 
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 6fbfe08..c504a4f 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -44,7 +44,9 @@ fragment_list_buf_init(struct fragment_list *list, const struct frame *frame)
 {
     int i;
     for (i = 0; i < N_FRAG_BUF; ++i)
+    {
         list->fragments[i].buf = alloc_buf(BUF_SIZE(frame));
+    }
 }
 
 static void
@@ -52,7 +54,9 @@ fragment_list_buf_free(struct fragment_list *list)
 {
     int i;
     for (i = 0; i < N_FRAG_BUF; ++i)
+    {
         free_buf(&list->fragments[i].buf);
+    }
 }
 
 /*
@@ -67,7 +71,9 @@ fragment_list_get_buf(struct fragment_list *list, int seq_id)
     {
         int i;
         for (i = 0; i < N_FRAG_BUF; ++i)
+        {
             list->fragments[i].defined = false;
+        }
         list->index = 0;
         list->seq_id = seq_id;
         diff = 0;
@@ -433,6 +439,7 @@ fragment_wakeup(struct fragment_master *f, struct frame *frame)
 
 #else  /* ifdef ENABLE_FRAGMENT */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ifdef ENABLE_FRAGMENT */
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index 5bff5e8..b077ae3 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -95,7 +95,8 @@ get_packet_flood_parms(int level)
  * Return true with probability 1/n
  */
 static bool
-flip(int n) {
+flip(int n)
+{
     return (get_random() % n) == 0;
 }
 
@@ -104,7 +105,8 @@ flip(int n) {
  * low and high.
  */
 static int
-roll(int low, int high) {
+roll(int low, int high)
+{
     int ret;
     ASSERT(low <= high);
     ret = low + (get_random() % (high - low + 1));
@@ -181,7 +183,8 @@ ask_gremlin(int flags)
  * Possibly corrupt a packet.
  */
 void
-corrupt_gremlin(struct buffer *buf, int flags) {
+corrupt_gremlin(struct buffer *buf, int flags)
+{
     const int corrupt_level = GREMLIN_CORRUPT_LEVEL(flags);
     if (corrupt_level)
     {
@@ -194,7 +197,8 @@ corrupt_gremlin(struct buffer *buf, int flags) {
                     uint8_t r = roll(0, 255);
                     int method = roll(0, 5);
 
-                    switch (method) {
+                    switch (method)
+                    {
                         case 0: /* corrupt the first byte */
                             *BPTR(buf) = r;
                             break;
@@ -232,6 +236,7 @@ corrupt_gremlin(struct buffer *buf, int flags) {
 
 #else  /* ifdef ENABLE_DEBUG */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ifdef ENABLE_DEBUG */
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 01301c0..ae4a638 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -44,7 +44,8 @@ CvtHex(
     unsigned short i;
     unsigned char j;
 
-    for (i = 0; i < HASHLEN; i++) {
+    for (i = 0; i < HASHLEN; i++)
+    {
         j = (Bin[i] >> 4) & 0xf;
         if (j <= 9)
         {
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4ff7725..3d34a7e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -331,7 +331,8 @@ next_connection_entry(struct context *c)
     struct connection_entry *ce;
     int n_cycles = 0;
 
-    do {
+    do
+    {
         ce_defined = true;
         if (c->options.no_advance && l->current >= 0)
         {
@@ -533,8 +534,10 @@ context_init_1(struct context *c)
         int i;
         pkcs11_initialize(true, c->options.pkcs11_pin_cache_period);
         for (i = 0; i<MAX_PARMS && c->options.pkcs11_providers[i] != NULL; i++)
+        {
             pkcs11_addProvider(c->options.pkcs11_providers[i], c->options.pkcs11_protected_authentication[i],
                                c->options.pkcs11_private_mode[i], c->options.pkcs11_cert_private[i]);
+        }
     }
 #endif
 
@@ -614,7 +617,9 @@ init_static(void)
     {
         int i;
         for (i = 0; i < argc; ++i)
+        {
             msg(M_INFO, "argv[%d] = '%s'", i, argv[i]);
+        }
     }
 #endif
 
@@ -760,7 +765,9 @@ init_static(void)
                 {
                     int i;
                     for (i = 0; i < SIZE(text); ++i)
+                    {
                         buffer_list_push(bl, (unsigned char *)text[i]);
+                    }
                 }
                 printf("[cap=%d i=%d] *************************\n", listcap, iter);
                 if (!(iter & 8))
@@ -783,7 +790,9 @@ init_static(void)
                         int c;
                         printf("'");
                         while ((c = buf_read_u8(buf)) >= 0)
+                        {
                             putchar(c);
+                        }
                         printf("'\n");
                         buffer_list_advance(bl, 0);
                     }
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index 5ed64a9..e87d751 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -106,7 +106,8 @@ interval_schedule_wakeup(struct interval *top, interval_t *wakeup)
  * In wakeup seconds, interval_test will return true once.
  */
 static inline void
-interval_future_trigger(struct interval *top, interval_t wakeup) {
+interval_future_trigger(struct interval *top, interval_t wakeup)
+{
     if (wakeup)
     {
 #if INTERVAL_DEBUG
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index fb9f664..d08b599 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -476,7 +476,8 @@ list_test(void)
             int inc = 0;
             int count = 0;
 
-            for (base = 0; base < hash_n_buckets(hash); base += inc) {
+            for (base = 0; base < hash_n_buckets(hash); base += inc)
+            {
                 struct hash_iterator hi;
                 struct hash_element *he;
                 inc = (get_random() % 3) + 1;
@@ -670,6 +671,7 @@ hash_func(const uint8_t *k, uint32_t length, uint32_t initval)
 
 #else  /* if P2MP_SERVER */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* P2MP_SERVER */
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 3d6891e..155507d 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -267,6 +267,7 @@ const struct compress_alg lzo_alg = {
 
 #else  /* if defined(ENABLE_LZO) */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ENABLE_LZO */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 763f6c6..58b65c2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1984,7 +1984,9 @@ man_process_command(struct management *man, const char *line)
         {
             int i;
             for (i = 0; i < nparms; ++i)
+            {
                 msg(M_INFO, "[%d] '%s'", i, parms[i]);
+            }
         }
 #endif
 
@@ -3088,7 +3090,8 @@ management_io(struct management *man)
                 if (net_events & FD_READ)
                 {
                     while (man_read(man) > 0)
-                        ;
+                    {
+                    }
                     net_event_win32_clear_selected_events(&man->connection.ne32, FD_READ);
                 }
 
@@ -3311,7 +3314,8 @@ man_wait_for_client_connection(struct management *man,
         {
             msg(D_MANAGEMENT, "Need information from management interface, waiting...");
         }
-        do {
+        do
+        {
             man_standalone_event_loop(man, signal_received, expire);
             if (signal_received && *signal_received)
             {
@@ -3929,7 +3933,9 @@ log_history_free_contents(struct log_history *h)
 {
     int i;
     for (i = 0; i < h->size; ++i)
+    {
         log_entry_free_contents(&h->array[log_index(h, i)]);
+    }
     free(h->array);
 }
 
@@ -3973,7 +3979,9 @@ log_history_resize(struct log_history *h, const int capacity)
         log_history_obj_init(&newlog, capacity);
 
         for (i = 0; i < h->size; ++i)
+        {
             log_history_add(&newlog, &h->array[log_index(h, i)]);
+        }
 
         log_history_free_contents(h);
         *h = newlog;
@@ -3995,6 +4003,7 @@ log_history_ref(const struct log_history *h, const int index)
 
 #else  /* ifdef ENABLE_MANAGEMENT */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ENABLE_MANAGEMENT */
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 7a23e59..ceee0fd 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -174,6 +174,7 @@ mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *mi)
 
 #else  /* if P2MP */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* P2MP */
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index 0b4da96..7c6972c 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -90,7 +90,8 @@
 #include "dmalloc.h"
 
 static inline void *
-openvpn_dmalloc(const char *file, int line, size_t size) {
+openvpn_dmalloc(const char *file, int line, size_t size)
+{
     void *ret = dmalloc_malloc(file, line, size, DMALLOC_FUNC_MALLOC, 0, 0);
     check_malloc_return(ret);
     return ret;
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 87f03be..a2f45b6 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -650,7 +650,8 @@ const char *
 env_set_get(const struct env_set *es, const char *name)
 {
     const struct env_item *item = es->list;
-    while (item && !env_string_equal(item->string, name)) {
+    while (item && !env_string_equal(item->string, name))
+    {
         item = item->next;
     }
     return item ? item->string : NULL;
@@ -1547,7 +1548,9 @@ make_env_array(const struct env_set *es,
     if (es)
     {
         for (e = es->list; e != NULL; e = e->next)
+        {
             ++n;
+        }
     }
 
     /* alloc return array */
@@ -1609,7 +1612,9 @@ make_inline_array(const char *str, struct gc_arena *gc)
 
     buf_set_read(&buf, (const uint8_t *) str, strlen(str));
     while (buf_parse(&buf, '\n', line, sizeof(line)))
+    {
         ++len;
+    }
 
     /* alloc return array */
     ALLOC_ARRAY_CLEAR_GC(ret, char *, len + 1, gc);
@@ -1639,7 +1644,9 @@ make_arg_copy(char **p, struct gc_arena *gc)
     ALLOC_ARRAY_CLEAR_GC(ret, char *, max_parms, gc);
 
     for (i = 0; i < len; ++i)
+    {
         ret[i] = p[i];
+    }
 
     return (const char **)ret;
 }
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 8b466b6..33c2ef4 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -562,6 +562,7 @@ mroute_helper_free(struct mroute_helper *mh)
 
 #else  /* if P2MP_SERVER */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* P2MP_SERVER */
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 5b110d2..51e1ae0 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -161,7 +161,8 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
     for (olen = hlen - sizeof(struct openvpn_tcphdr),
          opt = (uint8_t *)(tc + 1);
          olen > 0;
-         olen -= optlen, opt += optlen) {
+         olen -= optlen, opt += optlen)
+    {
         if (*opt == OPENVPN_TCPOPT_EOL)
         {
             break;
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b5471b1..195d08d 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -587,7 +587,8 @@ multi_tcp_action(struct multi_context *m, struct multi_instance *mi, int action,
 {
     bool tun_input_pending = false;
 
-    do {
+    do
+    {
         dmsg(D_MULTI_DEBUG, "MULTI TCP: multi_tcp_action a=%s p=%d",
              pract(action),
              poll);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f6f3f5d..56009b7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -537,10 +537,14 @@ multi_del_iroutes(struct multi_context *m,
     if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
         for (ir = mi->context.options.iroutes; ir != NULL; ir = ir->next)
+        {
             mroute_helper_del_iroute46(m->route_helper, ir->netbits);
+        }
 
         for (ir6 = mi->context.options.iroutes_ipv6; ir6 != NULL; ir6 = ir6->next)
+        {
             mroute_helper_del_iroute46(m->route_helper, ir6->netbits);
+        }
     }
 }
 
@@ -819,7 +823,8 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
     mi->did_iter = true;
 
 #ifdef MANAGEMENT_DEF_AUTH
-    do {
+    do
+    {
         mi->context.c2.mda_context.cid = m->cid_counter++;
     } while (!hash_add(m->cid_hash, &mi->context.c2.mda_context.cid, mi, false));
     mi->did_cid_hash = true;
@@ -2949,10 +2954,14 @@ gremlin_flood_clients(struct multi_context *m)
             parm.packet_size);
 
         for (i = 0; i < parm.packet_size; ++i)
+        {
             ASSERT(buf_write_u8(&buf, get_random() & 0xFF));
+        }
 
         for (i = 0; i < parm.n_packets; ++i)
+        {
             multi_bcast(m, &buf, NULL, NULL);
+        }
 
         gc_free(&gc);
     }
@@ -3375,6 +3384,7 @@ tunnel_server(struct context *top)
 
 #else  /* if P2MP_SERVER */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* P2MP_SERVER */
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 0cf1ddd..36c9fab 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -142,7 +142,8 @@ gen_nonce(unsigned char *nonce)
     /* Generates 8 random bytes to be used as client nonce */
     int i;
 
-    for (i = 0; i<8; i++) {
+    for (i = 0; i<8; i++)
+    {
         nonce[i] = (unsigned char)get_random();
     }
 }
@@ -153,7 +154,10 @@ my_strupr(unsigned char *str)
     /* converts string to uppercase in place */
     unsigned char *tmp = str;
 
-    do *str = toupper(*str); while (*(++str));
+    do
+    {
+        *str = toupper(*str);
+    } while (*(++str));
     return tmp;
 }
 
@@ -192,7 +196,8 @@ utf8_to_utf16LE(uint8_t *dst, int dst_len, const char *src)
         }
 
         /* The cases all fall through. */
-        switch (extraBytes) {
+        switch (extraBytes)
+        {
             case 5: ch += *usrc++; ch <<= 6;
 
             case 4: ch += *usrc++; ch <<= 6;
@@ -518,6 +523,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
 
 #else  /* if NTLM */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* if NTLM */
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index b4ccc4d..e720f6c 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -430,6 +430,7 @@ process_received_occ_msg(struct context *c)
 
 #else  /* ifdef ENABLE_OCC */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ifdef ENABLE_OCC */
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 888acda..3cb33b6 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -332,7 +332,8 @@ openvpn_main(int argc, char *argv[])
 
 #ifdef _WIN32
 int
-wmain(int argc, wchar_t *wargv[]) {
+wmain(int argc, wchar_t *wargv[])
+{
     char **argv;
     int ret;
     int i;
@@ -361,7 +362,8 @@ wmain(int argc, wchar_t *wargv[]) {
 }
 #else  /* ifdef _WIN32 */
 int
-main(int argc, char *argv[]) {
+main(int argc, char *argv[])
+{
     return openvpn_main(argc, argv);
 }
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 953e376..9bdd68e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -999,7 +999,9 @@ setenv_settings(struct env_set *es, const struct options *o)
     {
         int i;
         for (i = 0; i < o->connection_list->len; ++i)
+        {
             setenv_connection_entry(es, o->connection_list->array[i], i+1);
+        }
     }
     else
     {
@@ -1761,7 +1763,9 @@ show_settings(const struct options *o)
     {
         int i;
         for (i = 0; i<MAX_PARMS; i++)
+        {
             SHOW_INT(remote_cert_ku[i]);
+        }
     }
     SHOW_STR(remote_cert_eku);
     SHOW_INT(ssl_flags);
@@ -1789,22 +1793,30 @@ show_settings(const struct options *o)
     {
         int i;
         for (i = 0; i<MAX_PARMS && o->pkcs11_providers[i] != NULL; i++)
+        {
             SHOW_PARM(pkcs11_providers, o->pkcs11_providers[i], "%s");
+        }
     }
     {
         int i;
         for (i = 0; i<MAX_PARMS; i++)
+        {
             SHOW_PARM(pkcs11_protected_authentication, o->pkcs11_protected_authentication[i] ? "ENABLED" : "DISABLED", "%s");
+        }
     }
     {
         int i;
         for (i = 0; i<MAX_PARMS; i++)
+        {
             SHOW_PARM(pkcs11_private_mode, o->pkcs11_private_mode[i], "%08x");
+        }
     }
     {
         int i;
         for (i = 0; i<MAX_PARMS; i++)
+        {
             SHOW_PARM(pkcs11_cert_private, o->pkcs11_cert_private[i] ? "ENABLED" : "DISABLED", "%s");
+        }
     }
     SHOW_INT(pkcs11_pin_cache_period);
     SHOW_STR(pkcs11_id);
@@ -2939,7 +2951,9 @@ options_postprocess_verify(const struct options *o)
     {
         int i;
         for (i = 0; i < o->connection_list->len; ++i)
+        {
             options_postprocess_verify_ce(o, o->connection_list->array[i]);
+        }
     }
     else
     {
@@ -2990,7 +3004,9 @@ options_postprocess_mutate(struct options *o)
 
     ASSERT(o->connection_list);
     for (i = 0; i < o->connection_list->len; ++i)
+    {
         options_postprocess_mutate_ce(o, o->connection_list->array[i]);
+    }
 
 #ifdef ENABLE_CRYPTO
     if (o->tls_server)
@@ -3792,7 +3808,9 @@ options_warning_safe_scan1(const int msglevel,
     char *p = gc_malloc(OPTION_PARM_SIZE, true, &gc);
 
     while (buf_parse(&b, delim, p, OPTION_PARM_SIZE))
+    {
         options_warning_safe_scan2(msglevel, delim, report_inconsistent, p, b2_src, b1_name, b2_name);
+    }
 
     gc_free(&gc);
 }
@@ -4419,7 +4437,10 @@ read_inline_file(struct in_src *is, const char *close_tag, struct gc_arena *gc)
     {
         char *line_ptr = line;
         /* Remove leading spaces */
-        while (isspace(*line_ptr)) line_ptr++;
+        while (isspace(*line_ptr))
+        {
+            line_ptr++;
+        }
         if (!strncmp(line_ptr, close_tag, strlen(close_tag)))
         {
             endtagfound = true;
@@ -5309,18 +5330,24 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         /* Find out how many options to be ignored */
         for (i = 1; p[i]; i++)
+        {
             numignored++;
+        }
 
         /* add number of options already ignored */
         for (i = 0; options->ignore_unknown_option
              && options->ignore_unknown_option[i]; i++)
+        {
             numignored++;
+        }
 
         /* Allocate array */
         ALLOC_ARRAY_GC(ignore, const char *, numignored+1, &options->gc);
         for (i = 0; options->ignore_unknown_option
              && options->ignore_unknown_option[i]; i++)
+        {
             ignore[i] = options->ignore_unknown_option[i];
+        }
 
         options->ignore_unknown_option = ignore;
 
@@ -6004,7 +6031,8 @@ add_option(struct options *options,
             struct http_custom_header *custom_header = NULL;
             int i;
             /* Find the first free header */
-            for (i = 0; i < MAX_CUSTOM_HTTP_HEADER; i++) {
+            for (i = 0; i < MAX_CUSTOM_HTTP_HEADER; i++)
+            {
                 if (!ho->custom_headers[i].name)
                 {
                     custom_header = &ho->custom_headers[i];
@@ -7897,7 +7925,9 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
+        {
             sscanf(p[j], "%x", &(options->remote_cert_ku[j-1]));
+        }
     }
     else if (streq(p[0], "remote-cert-eku") && p[1] && !p[2])
     {
@@ -8026,10 +8056,16 @@ add_option(struct options *options,
         if (strncmp("ext:", s, 4) != 0)
         {
             size_t i = 0;
-            while (s[i] && !isupper(s[i])) i++;
+            while (s[i] && !isupper(s[i]))
+            {
+                i++;
+            }
             if (strlen(s) == i)
             {
-                while ((*s = toupper(*s)) != '\0') s++;
+                while ((*s = toupper(*s)) != '\0')
+                {
+                    s++;
+                }
                 msg(M_WARN, "DEPRECATED FEATURE: automatically upcased the "
                     "--x509-username-field parameter to '%s'; please update your"
                     "configuration", p[1]);
@@ -8083,7 +8119,9 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
+        {
             options->pkcs11_providers[j-1] = p[j];
+        }
     }
     else if (streq(p[0], "pkcs11-protected-authentication"))
     {
@@ -8092,7 +8130,9 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
+        {
             options->pkcs11_protected_authentication[j-1] = atoi(p[j]) != 0 ? 1 : 0;
+        }
     }
     else if (streq(p[0], "pkcs11-private-mode") && p[1])
     {
@@ -8101,7 +8141,9 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
+        {
             sscanf(p[j], "%x", &(options->pkcs11_private_mode[j-1]));
+        }
     }
     else if (streq(p[0], "pkcs11-cert-private"))
     {
@@ -8110,7 +8152,9 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
+        {
             options->pkcs11_cert_private[j-1] = atoi(p[j]) != 0 ? 1 : 0;
+        }
     }
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
     {
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index eede63d..ad066b6 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -289,7 +289,8 @@ tv_within_sigma(const struct timeval *t1, const struct timeval *t2, unsigned int
  * called again.
  */
 static inline void
-interval_earliest_wakeup(interval_t *wakeup, time_t at, time_t current) {
+interval_earliest_wakeup(interval_t *wakeup, time_t at, time_t current)
+{
     if (at > current)
     {
         const interval_t delta = (interval_t) (at - current);
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index fe13e1d..e34c228 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -629,7 +629,8 @@ packet_id_interactive_test()
 
     packet_id_init(&pid, seq_backtrack, time_backtrack);
 
-    while (true) {
+    while (true)
+    {
         char buf[80];
         if (!fgets(buf, sizeof(buf), stdin))
         {
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index 51e051a..3603f4e 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -147,12 +147,14 @@ push_perf_index(int pindex)
     {
         int i;
         for (i = 0; i < sindex; ++i)
+        {
             if (perf_set.stack[i] == pindex)
             {
                 perf_print_state(M_INFO);
                 msg(M_FATAL, "PERF: push_perf_index %s failed",
                     metric_names [pindex]);
             }
+        }
 
         perf_set.stack[sindex] = pindex;
         perf_set.stack_len = newlen;
@@ -321,7 +323,8 @@ perf_print_state(int lev)
 #else  /* ifdef ENABLE_PERFORMANCE_METRICS */
 #ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif
 #endif /* ifdef ENABLE_PERFORMANCE_METRICS */
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index f0430a1..a670843 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -76,13 +76,16 @@ void perf_output_results(void);
 #else  /* ifdef ENABLE_PERFORMANCE_METRICS */
 
 static inline void
-perf_push(int type) {
+perf_push(int type)
+{
 }
 static inline void
-perf_pop(void) {
+perf_pop(void)
+{
 }
 static inline void
-perf_output_results(void) {
+perf_output_results(void)
+{
 }
 
 #endif /* ifdef ENABLE_PERFORMANCE_METRICS */
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 6858846..3e494e5 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -45,21 +45,24 @@
 
 static
 time_t
-__mytime(void) {
+__mytime(void)
+{
     return openvpn_time(NULL);
 }
 
 #if !defined(_WIN32)
 static
 int
-__mygettimeofday(struct timeval *tv) {
+__mygettimeofday(struct timeval *tv)
+{
     return gettimeofday(tv, NULL);
 }
 #endif
 
 static
 void
-__mysleep(const unsigned long usec) {
+__mysleep(const unsigned long usec)
+{
 #if defined(_WIN32)
     Sleep(usec/1000);
 #else
@@ -84,10 +87,12 @@ static
 unsigned
 _pkcs11_msg_pkcs112openvpn(
     const unsigned flags
-    ) {
+    )
+{
     unsigned openvpn_flags;
 
-    switch (flags) {
+    switch (flags)
+    {
         case PKCS11H_LOG_DEBUG2:
             openvpn_flags = D_PKCS11_DEBUG;
             break;
@@ -124,7 +129,8 @@ static
 unsigned
 _pkcs11_msg_openvpn2pkcs11(
     const unsigned flags
-    ) {
+    )
+{
     unsigned pkcs11_flags;
 
     if ((flags & D_PKCS11_DEBUG) != 0)
@@ -166,7 +172,8 @@ _pkcs11_openvpn_log(
     unsigned flags,
     const char *const szFormat,
     va_list args
-    ) {
+    )
+{
     char Buffer[10*1024];
 
     (void)global_data;
@@ -184,7 +191,8 @@ _pkcs11_openvpn_token_prompt(
     void *const user_data,
     const pkcs11h_token_id_t token,
     const unsigned retry
-    ) {
+    )
+{
     struct user_pass token_resp;
 
     (void)global_data;
@@ -229,7 +237,8 @@ _pkcs11_openvpn_pin_prompt(
     const unsigned retry,
     char *const pin,
     const size_t pin_max
-    ) {
+    )
+{
     struct user_pass token_pass;
     char prompt[1024];
 
@@ -275,7 +284,8 @@ bool
 pkcs11_initialize(
     const bool protected_auth,
     const int nPINCachePeriod
-    ) {
+    )
+{
     CK_RV rv = CKR_FUNCTION_FAILED;
 
     dmsg(
@@ -347,7 +357,8 @@ cleanup:
 }
 
 void
-pkcs11_terminate() {
+pkcs11_terminate()
+{
     dmsg(
         D_PKCS11_DEBUG,
         "PKCS#11: pkcs11_terminate - entered"
@@ -367,7 +378,8 @@ pkcs11_addProvider(
     const bool protected_auth,
     const unsigned private_mode,
     const bool cert_private
-    ) {
+    )
+{
     CK_RV rv = CKR_OK;
 
     ASSERT(provider!=NULL);
@@ -411,12 +423,14 @@ pkcs11_addProvider(
 }
 
 int
-pkcs11_logout() {
+pkcs11_logout()
+{
     return pkcs11h_logout() == CKR_OK;
 }
 
 int
-pkcs11_management_id_count() {
+pkcs11_management_id_count()
+{
     pkcs11h_certificate_id_list_t id_list = NULL;
     pkcs11h_certificate_id_list_t t = NULL;
     CK_RV rv = CKR_OK;
@@ -441,7 +455,8 @@ pkcs11_management_id_count() {
         goto cleanup;
     }
 
-    for (count = 0, t = id_list; t != NULL; t = t->next) {
+    for (count = 0, t = id_list; t != NULL; t = t->next)
+    {
         count++;
     }
 
@@ -467,7 +482,8 @@ pkcs11_management_id_get(
     const int index,
     char **id,
     char **base64
-    ) {
+    )
+{
     pkcs11h_certificate_id_list_t id_list = NULL;
     pkcs11h_certificate_id_list_t entry = NULL;
 #if 0 /* certificate_id seems to be unused -- JY */
@@ -511,7 +527,8 @@ pkcs11_management_id_get(
 
     entry = id_list;
     count = 0;
-    while (entry != NULL && count != index) {
+    while (entry != NULL && count != index)
+    {
         count++;
         entry = entry->next;
     }
@@ -653,7 +670,8 @@ tls_ctx_use_pkcs11(
     struct tls_root_ctx *const ssl_ctx,
     bool pkcs11_id_management,
     const char *const pkcs11_id
-    ) {
+    )
+{
     pkcs11h_certificate_id_t certificate_id = NULL;
     pkcs11h_certificate_t certificate = NULL;
     CK_RV rv = CKR_OK;
@@ -784,7 +802,8 @@ _pkcs11_openvpn_show_pkcs11_ids_pin_prompt(
     const unsigned retry,
     char *const pin,
     const size_t pin_max
-    ) {
+    )
+{
     struct gc_arena gc = gc_new();
     struct buffer pass_prompt = alloc_buf_gc(128, &gc);
 
@@ -817,7 +836,8 @@ void
 show_pkcs11_ids(
     const char *const provider,
     bool cert_private
-    ) {
+    )
+{
     struct gc_arena gc = gc_new();
     pkcs11h_certificate_id_list_t user_certificates = NULL;
     pkcs11h_certificate_id_list_t current = NULL;
@@ -888,7 +908,8 @@ show_pkcs11_ids(
             "--pkcs11-id option please remember to use single quote mark.\n"
         )
         );
-    for (current = user_certificates; current != NULL; current = current->next) {
+    for (current = user_certificates; current != NULL; current = current->next)
+    {
         pkcs11h_certificate_t certificate = NULL;
         char *dn = NULL;
         char serial[1024] = {0};
@@ -1006,7 +1027,8 @@ cleanup:
 #else  /* if defined(ENABLE_PKCS11) */
 #ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif
 #endif /* ENABLE_PKCS11 */
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 17eb2d8..e530c0c 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -745,7 +745,9 @@ plugin_common_close(struct plugin_common *pc)
         int i;
 
         for (i = 0; i < pc->n; ++i)
+        {
             plugin_close_item(&pc->plugins[i]);
+        }
         free(pc);
     }
 }
@@ -883,7 +885,9 @@ plugin_abort(void)
         int i;
 
         for (i = 0; i < pc->n; ++i)
+        {
             plugin_abort_item(&pc->plugins[i]);
+        }
     }
 }
 
@@ -964,7 +968,9 @@ plugin_return_get_column(const struct plugin_return *src,
 
     dest->n = 0;
     for (i = 0; i < src->n; ++i)
+    {
         dest->list[i] = openvpn_plugin_string_list_find(src->list[i], colname);
+    }
     dest->n = i;
 }
 
@@ -973,7 +979,9 @@ plugin_return_free(struct plugin_return *pr)
 {
     int i;
     for (i = 0; i < pr->n; ++i)
+    {
         openvpn_plugin_string_list_free(pr->list[i]);
+    }
     pr->n = 0;
 }
 
@@ -1003,6 +1011,7 @@ plugin_return_print(const int msglevel, const char *prefix, const struct plugin_
 
 #else  /* ifdef ENABLE_PLUGIN */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ENABLE_PLUGIN */
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index aa0bc2b..9543a9d 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -215,7 +215,9 @@ ifconfig_pool_free(struct ifconfig_pool *pool)
     {
         int i;
         for (i = 0; i < pool->size; ++i)
+        {
             ifconfig_pool_entry_free(&pool->list[i], true);
+        }
         free(pool->list);
         free(pool);
     }
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index dd327a2..b0ed327 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -381,7 +381,9 @@ get_key_value(const char *str,       /* source string */
     bool escape = false;
 
     for (c = max_key_len-1; (*str && (*str != '=') && c--); )
+    {
         *key++ = *str++;
+    }
     *key = '\0';
 
     if ('=' != *str++)
@@ -475,7 +477,9 @@ get_pa_var(const char *key, const char *pa, struct gc_arena *gc)
             ++content;
         }
         while (*content && isspace(*content))
+        {
             ++content;
+        }
     }
 }
 
@@ -774,7 +778,8 @@ establish_http_proxy_passthru(struct http_proxy_info *p,
 
             /* receive and discard everything else */
             while (recv_line(sd, NULL, 0, 2, true, NULL, signal_received))
-                ;
+            {
+            }
 
             /* now send the phase 3 reply */
 
@@ -1041,7 +1046,8 @@ establish_http_proxy_passthru(struct http_proxy_info *p,
      * start of the OpenVPN data stream (put it in lookahead).
      */
     while (recv_line(sd, NULL, 0, 2, false, lookahead, signal_received))
-        ;
+    {
+    }
 
     /* reset queried_creds so that we don't think that the next creds request is due to an auth error */
     p->queried_creds = false;
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 57cdd78..9de974b 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -112,10 +112,12 @@ reliable_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)
 {
     int i;
     for (i = 0; i < ack->len; ++i)
+    {
         if (ack->packet_id[i] == pid)
         {
             return true;
         }
+    }
     return false;
 }
 
@@ -242,7 +244,9 @@ reliable_ack_write(struct reliable_ack *ack,
         ASSERT(session_id_defined(sid));
         ASSERT(session_id_write(sid, &sub));
         for (i = 0, j = n; j < ack->len; )
+        {
             ack->packet_id[i++] = ack->packet_id[j++];
+        }
         ack->len = i;
     }
 
@@ -802,6 +806,7 @@ reliable_debug_print(const struct reliable *rel, char *desc)
 
 #else  /* ifdef ENABLE_CRYPTO */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ENABLE_CRYPTO */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0c93dcd..223cb5f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1281,7 +1281,9 @@ print_route_options(const struct route_option_list *rol,
             (rol->flags & RG_LOCAL) != 0);
     }
     for (ro = rol->routes; ro; ro = ro->next)
+    {
         print_route_option(ro, level);
+    }
 }
 
 void
@@ -1375,7 +1377,9 @@ print_routes(const struct route_list *rl, int level)
 {
     struct route_ipv4 *r;
     for (r = rl->routes; r; r = r->next)
+    {
         print_route(r, level);
+    }
 }
 
 static void
@@ -1404,7 +1408,9 @@ setenv_routes(struct env_set *es, const struct route_list *rl)
     int i = 1;
     struct route_ipv4 *r;
     for (r = rl->routes; r; r = r->next)
+    {
         setenv_route(es, r, i++);
+    }
 }
 
 static void
@@ -1433,7 +1439,9 @@ setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6)
     int i = 1;
     struct route_ipv6 *r6;
     for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
+    {
         setenv_route_ipv6(es, r6, i++);
+    }
 }
 
 /*
@@ -2623,7 +2631,9 @@ test_routes(const struct route_list *rl, const struct tuntap *tt)
         {
             struct route_ipv4 *r;
             for (r = rl->routes, len = 0; r; r = r->next, ++len)
+            {
                 test_route_helper(&ret, &count, &good, &ambig, adapters, r->gateway);
+            }
 
             if ((rl->flags & RG_ENABLE) && (rl->spec.flags & RTSA_REMOTE_ENDPOINT))
             {
@@ -3608,7 +3618,8 @@ get_default_gateway(struct route_gateway_info *rgi)
         msg(M_WARN, "GDG: problem writing to routing socket");
         goto done;
     }
-    do {
+    do
+    {
         l = read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
     } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
     close(sockfd);
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 03ee8cd..d6836ab 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -354,7 +354,8 @@ bool del_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt);
 
 #else  /* ifdef _WIN32 */
 static inline bool
-test_routes(const struct route_list *rl, const struct tuntap *tt) {
+test_routes(const struct route_list *rl, const struct tuntap *tt)
+{
     return true;
 }
 #endif
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 610bfa4..8a9eb3f 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -377,7 +377,9 @@ schedule_add_modify(struct schedule *s, struct schedule_entry *e)
      * keeps the tree balanced.  Move the node up the tree until
      * its own priority is greater than that of its parent */
     while (e->parent && e->parent->pri > e->pri)
+    {
         schedule_rotate_up(s, e);
+    }
 }
 
 /*
@@ -623,7 +625,9 @@ schedule_print_work(struct schedule_entry *e, int indent)
     struct gc_arena gc = gc_new();
     int i;
     for (i = 0; i < indent; ++i)
+    {
         printf(" ");
+    }
     if (e)
     {
         printf("%s [%u] e=" ptr_format ", p=" ptr_format " lt=" ptr_format " gt=" ptr_format "\n",
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index b23f0f4..04caf39 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -64,6 +64,7 @@ session_id_print(const struct session_id *sid, struct gc_arena *gc)
 
 #else  /* ifdef ENABLE_CRYPTO */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ENABLE_CRYPTO */
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index eb459ef..bb936ac 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -98,6 +98,7 @@ shaper_msg(struct shaper *s)
 
 #else  /* ifdef ENABLE_FEATURE_SHAPER */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ENABLE_FEATURE_SHAPER */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index ae12832..82d0967 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -205,7 +205,9 @@ do_preresolve_host(struct context *c,
         {
             struct cached_dns_entry *prev = c->c1.dns_cache;
             while (prev->next)
+            {
                 prev = prev->next;
+            }
             prev->next = ph;
         }
 
@@ -2008,7 +2010,8 @@ static void
 phase2_tcp_client(struct link_socket *sock, struct signal_info *sig_info)
 {
     bool proxy_retry = false;
-    do {
+    do
+    {
         socket_connect(&sock->sd,
                        sock->info.lsa->current_remote->ai_addr,
                        get_server_poll_remaining_time(sock->server_poll_timeout),
@@ -2364,7 +2367,8 @@ link_socket_bad_incoming_addr(struct buffer *buf,
                 (int)from_addr->dest.addr.sa.sa_family,
                 print_sockaddr_ex(info->lsa->remote_list->ai_addr,":",PS_SHOW_PORT, &gc));
             /* print additional remote addresses */
-            for (ai = info->lsa->remote_list->ai_next; ai; ai = ai->ai_next) {
+            for (ai = info->lsa->remote_list->ai_next; ai; ai = ai->ai_next)
+            {
                 msg(D_LINK_ERRORS,"or from peer address: %s",
                     print_sockaddr_ex(ai->ai_addr,":",PS_SHOW_PORT, &gc));
             }
@@ -3053,10 +3057,12 @@ ascii2proto(const char *proto_name)
 {
     int i;
     for (i = 0; i < SIZE(proto_names); ++i)
+    {
         if (!strcmp(proto_name, proto_names[i].short_form))
         {
             return proto_names[i].proto;
         }
+    }
     return -1;
 }
 
@@ -3065,10 +3071,12 @@ ascii2af(const char *proto_name)
 {
     int i;
     for (i = 0; i < SIZE(proto_names); ++i)
+    {
         if (!strcmp(proto_name, proto_names[i].short_form))
         {
             return proto_names[i].proto_af;
         }
+    }
     return 0;
 }
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 63e601e..3d96aab 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -623,7 +623,8 @@ addr_defined(const struct openvpn_sockaddr *addr)
     {
         return 0;
     }
-    switch (addr->addr.sa.sa_family) {
+    switch (addr->addr.sa.sa_family)
+    {
         case AF_INET: return addr->addr.in4.sin_addr.s_addr != 0;
 
         case AF_INET6: return !IN6_IS_ADDR_UNSPECIFIED(&addr->addr.in6.sin6_addr);
@@ -639,7 +640,8 @@ addr_local(const struct sockaddr *addr)
     {
         return false;
     }
-    switch (addr->sa_family) {
+    switch (addr->sa_family)
+    {
         case AF_INET:
             return ((const struct sockaddr_in *)addr)->sin_addr.s_addr == htonl(INADDR_LOOPBACK);
 
@@ -660,7 +662,8 @@ addr_defined_ipi(const struct link_socket_actual *lsa)
     {
         return 0;
     }
-    switch (lsa->dest.addr.sa.sa_family) {
+    switch (lsa->dest.addr.sa.sa_family)
+    {
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
         case AF_INET: return lsa->pi.in4.ipi_spec_dst.s_addr != 0;
 
@@ -687,7 +690,8 @@ link_socket_actual_defined(const struct link_socket_actual *act)
 static inline bool
 addr_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
 {
-    switch (a1->addr.sa.sa_family) {
+    switch (a1->addr.sa.sa_family)
+    {
         case AF_INET:
             return a1->addr.in4.sin_addr.s_addr == a2->addr.in4.sin_addr.s_addr;
 
@@ -781,7 +785,8 @@ addrlist_port_match(const struct openvpn_sockaddr *a1, const struct addrinfo *a2
 static inline bool
 addr_port_match(const struct openvpn_sockaddr *a1, const struct openvpn_sockaddr *a2)
 {
-    switch (a1->addr.sa.sa_family) {
+    switch (a1->addr.sa.sa_family)
+    {
         case AF_INET:
             return a1->addr.in4.sin_addr.s_addr == a2->addr.in4.sin_addr.s_addr
                    && a1->addr.in4.sin_port == a2->addr.in4.sin_port;
@@ -818,7 +823,8 @@ addrlist_match_proto(const struct openvpn_sockaddr *a1,
 static inline void
 addr_zero_host(struct openvpn_sockaddr *addr)
 {
-    switch (addr->addr.sa.sa_family) {
+    switch (addr->addr.sa.sa_family)
+    {
         case AF_INET:
             addr->addr.in4.sin_addr.s_addr = 0;
             break;
@@ -846,7 +852,8 @@ int addr_guess_family(sa_family_t af,const char *name);
 static inline int
 af_addr_size(sa_family_t af)
 {
-    switch (af) {
+    switch (af)
+    {
         case AF_INET: return sizeof(struct sockaddr_in);
 
         case AF_INET6: return sizeof(struct sockaddr_in6);
@@ -919,7 +926,8 @@ link_socket_verify_incoming_addr(struct buffer *buf,
 {
     if (buf->len > 0)
     {
-        switch (from_addr->dest.addr.sa.sa_family) {
+        switch (from_addr->dest.addr.sa.sa_family)
+        {
             case AF_INET6:
             case AF_INET:
                 if (!link_socket_actual_defined(from_addr))
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 012db81..2876ef8 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -269,10 +269,12 @@ static void
 key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len);
 
 const tls_cipher_name_pair *
-tls_get_cipher_name_pair(const char *cipher_name, size_t len) {
+tls_get_cipher_name_pair(const char *cipher_name, size_t len)
+{
     const tls_cipher_name_pair *pair = tls_cipher_name_translation_table;
 
-    while (pair->openssl_name != NULL) {
+    while (pair->openssl_name != NULL)
+    {
         if ((strlen(pair->openssl_name) == len && 0 == memcmp(cipher_name, pair->openssl_name, len))
             || (strlen(pair->iana_name) == len && 0 == memcmp(cipher_name, pair->iana_name, len)))
         {
@@ -1068,7 +1070,9 @@ tls_session_init(struct tls_multi *multi, struct tls_session *session)
 
     /* Randomize session # if it is 0 */
     while (!session_id_defined(&session->session_id))
+    {
         session_id_random(&session->session_id);
+    }
 
     /* Are we a TLS server or client? */
     ASSERT(session->opt->key_method >= 1);
@@ -1130,7 +1134,9 @@ tls_session_free(struct tls_session *session, bool clear)
     free_buf(&session->tls_wrap.work);
 
     for (i = 0; i < KS_SIZE; ++i)
+    {
         key_state_free(&session->key[i], false);
+    }
 
     if (session->common_name)
     {
@@ -1187,7 +1193,8 @@ reset_session(struct tls_multi *multi, struct tls_session *session)
  * called again.
  */
 static inline void
-compute_earliest_wakeup(interval_t *earliest, interval_t seconds_from_now) {
+compute_earliest_wakeup(interval_t *earliest, interval_t seconds_from_now)
+{
     if (seconds_from_now < *earliest)
     {
         *earliest = seconds_from_now;
@@ -1357,7 +1364,9 @@ tls_multi_free(struct tls_multi *multi, bool clear)
     free(multi->remote_ciphername);
 
     for (i = 0; i < TM_SIZE; ++i)
+    {
         tls_session_free(&multi->session[i], false);
+    }
 
     if (clear)
     {
@@ -1703,7 +1712,9 @@ tls1_PRF(const uint8_t *label,
     tls1_P_hash(sha1,S2,len,label,label_len,out2,olen);
 
     for (i = 0; i<olen; i++)
+    {
         out1[i] ^= out2[i];
+    }
 
     secure_memzero(out2, olen);
 
@@ -1853,7 +1864,8 @@ exit:
 }
 
 static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len) {
+key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)
+{
     const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
 
     /* Only use implicit IV in AEAD cipher mode, where HMAC key is not used */
@@ -4059,7 +4071,8 @@ tls_peer_info_ncp_ver(const char *peer_info)
 }
 
 bool
-tls_check_ncp_cipher_list(const char *list) {
+tls_check_ncp_cipher_list(const char *list)
+{
     bool unsupported_cipher_found = false;
 
     ASSERT(list);
@@ -4204,6 +4217,7 @@ done:
 
 #else  /* if defined(ENABLE_CRYPTO) */
 static void
-dummy(void) {
+dummy(void)
+{
 }
 #endif /* ENABLE_CRYPTO */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 5c84e30..ba8dadf 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -185,7 +185,8 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 }
 
 static const char *
-tls_translate_cipher_name(const char *cipher_name) {
+tls_translate_cipher_name(const char *cipher_name)
+{
     const tls_cipher_name_pair *pair = tls_get_cipher_name_pair(cipher_name, strlen(cipher_name));
 
     if (NULL == pair)
@@ -222,10 +223,12 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
     /* Get number of ciphers */
     for (i = 0, cipher_count = 1; i < ciphers_len; i++)
+    {
         if (ciphers[i] == ':')
         {
             cipher_count++;
         }
+    }
 
     /* Allocate an array for them */
     ALLOC_ARRAY_CLEAR(ctx->allowed_ciphers, int, cipher_count+1)
@@ -833,7 +836,8 @@ tls_version_max(void)
  *                      Must be a valid pointer.
  */
 static void
-tls_version_to_major_minor(int tls_ver, int *major, int *minor) {
+tls_version_to_major_minor(int tls_ver, int *major, int *minor)
+{
     ASSERT(major);
     ASSERT(minor);
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index eae1e22..8266595 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -321,7 +321,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
     /* Translate IANA cipher suite names to OpenSSL names */
     begin_of_cipher = end_of_cipher = 0;
-    for (; begin_of_cipher < strlen(ciphers); begin_of_cipher = end_of_cipher) {
+    for (; begin_of_cipher < strlen(ciphers); begin_of_cipher = end_of_cipher)
+    {
         end_of_cipher += strcspn(&ciphers[begin_of_cipher], ":");
         cipher_pair = tls_get_cipher_name_pair(&ciphers[begin_of_cipher], end_of_cipher - begin_of_cipher);
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 334eb29..9f12ab8 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -90,8 +90,12 @@ tls_deauthenticate(struct tls_multi *multi)
     {
         int i, j;
         for (i = 0; i < TM_SIZE; ++i)
+        {
             for (j = 0; j < KS_SIZE; ++j)
+            {
                 multi->session[i].key[j].authenticated = false;
+            }
+        }
     }
 }
 
@@ -248,7 +252,9 @@ cert_hash_free(struct cert_hash_set *chs)
     {
         int i;
         for (i = 0; i < MAX_CERT_DEPTH; ++i)
+        {
             free(chs->ch[i]);
+        }
         free(chs);
     }
 }
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index f01569f..4068dd3 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -269,10 +269,12 @@ asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
     char *val;
 
     for (i = 0; i < orig->len; ++i)
+    {
         if (orig->p[i] == '\0')
         {
             return "ERROR: embedded null value";
         }
+    }
     val = gc_malloc(orig->len+1, false, gc);
     memcpy(val, orig->p, orig->len);
     val[orig->len] = '\0';
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index e9692a0..274e2bb 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -193,7 +193,8 @@ extract_x509_field_ssl(X509_NAME *x509, const char *field_name, char *out,
 
     ASSERT(size > 0);
     *out = '\0';
-    do {
+    do
+    {
         lastpos = tmp;
         tmp = X509_NAME_get_index_by_NID(x509, nid, lastpos);
     } while (tmp > -1);
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index c227b09..804c279 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -44,7 +44,8 @@ tls_crypt_buf_overhead(void)
 
 void
 tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
-                   const char *key_inline, bool tls_server) {
+                   const char *key_inline, bool tls_server)
+{
     const int key_direction = tls_server ?
                               KEY_DIRECTION_NORMAL : KEY_DIRECTION_INVERSE;
 
@@ -79,7 +80,8 @@ tls_crypt_adjust_frame_parameters(struct frame *frame)
 
 bool
 tls_crypt_wrap(const struct buffer *src, struct buffer *dst,
-               struct crypto_options *opt) {
+               struct crypto_options *opt)
+{
     const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
     struct gc_arena gc;
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index fda91bf..f49ecd3 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -688,7 +688,8 @@ init_tun(const struct options *o,
              * make sure they do not clash with our virtual subnet.
              */
 
-            for (curele = local_public; curele; curele = curele->ai_next) {
+            for (curele = local_public; curele; curele = curele->ai_next)
+            {
                 if (curele->ai_family == AF_INET)
                 {
                     check_addr_clash("local",
@@ -699,7 +700,8 @@ init_tun(const struct options *o,
                 }
             }
 
-            for (curele = remote_public; curele; curele = curele->ai_next) {
+            for (curele = remote_public; curele; curele = curele->ai_next)
+            {
                 if (curele->ai_family == AF_INET)
                 {
                     check_addr_clash("remote",
@@ -1030,7 +1032,8 @@ do_ifconfig(struct tuntap *tt,
         struct buffer out = alloc_buf_gc(64, &gc);
 
         char *top;
-        switch (tt->topology) {
+        switch (tt->topology)
+        {
             case TOP_NET30:
                 top = "net30";
                 break;
@@ -1829,12 +1832,14 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     /* Prefer IPv6 DNS servers,
      * Android will use the DNS server in the order we specify*/
-    for (int i = 0; i < tt->options.dns6_len; i++) {
+    for (int i = 0; i < tt->options.dns6_len; i++)
+    {
         management_android_control(management, "DNS6SERVER",
                                    print_in6_addr(tt->options.dns6[i], 0, &gc));
     }
 
-    for (int i = 0; i < tt->options.dns_len; i++) {
+    for (int i = 0; i < tt->options.dns_len; i++)
+    {
         management_android_control(management, "DNSSERVER",
                                    print_in_addr_t(tt->options.dns[i], 0, &gc));
     }
@@ -2248,7 +2253,9 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     {
         ptr = dev;
         while (*ptr && !isdigit((int) *ptr))
+        {
             ptr++;
+        }
         ppa = atoi(ptr);
     }
 
@@ -3271,7 +3278,10 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     {
         /* ensure that dev name is "tap+<digits>" *only* */
         p = &dev[3];
-        while (isdigit(*p) ) p++;
+        while (isdigit(*p) )
+        {
+            p++;
+        }
         if (*p != '\0')
         {
             msg( M_FATAL, "TAP device name must be '--dev tapNNNN'" );
@@ -5449,7 +5459,9 @@ write_dhcp_u32_array(struct buffer *buf, const int type, const uint32_t *data, c
         buf_write_u8(buf, type);
         buf_write_u8(buf, size);
         for (i = 0; i < len; ++i)
+        {
             buf_write_u32(buf, data[i]);
+        }
     }
 }
 
@@ -6281,10 +6293,12 @@ ascii2ipset(const char *name)
     int i;
     ASSERT(IPW32_SET_N == SIZE(ipset_names));
     for (i = 0; i < IPW32_SET_N; ++i)
+    {
         if (!strcmp(name, ipset_names[i].short_form))
         {
             return i;
         }
+    }
     return -1;
 }
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index e26f54d..18e7aee 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -569,7 +569,8 @@ win32_keyboard_get(struct win32_signal *ws)
     if (HANDLE_DEFINED(ws->in.read))
     {
         INPUT_RECORD ir;
-        do {
+        do
+        {
             DWORD n;
             if (!keyboard_input_available(ws))
             {
@@ -681,7 +682,8 @@ win32_pause(struct win32_signal *ws)
     {
         int status;
         msg(M_INFO|M_NOPREFIX, "Press any key to continue...");
-        do {
+        do
+        {
             status = WaitForSingleObject(ws->in.read, INFINITE);
         } while (!win32_keyboard_get(ws));
     }
@@ -984,7 +986,9 @@ env_block(const struct env_set *es)
         bool path_seen = false;
 
         for (e = es->list; e != NULL; e = e->next)
+        {
             nchars += strlen(e->string) + 1;
+        }
 
         nchars += strlen(force_path)+1;
 
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 6be6c6d..b9a377a 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -293,7 +293,8 @@ ServiceStartAutomatic(DWORD dwArgc, LPTSTR *lpszArgv)
         /*
          * Loop over each config file
          */
-        do {
+        do
+        {
             HANDLE log_handle = NULL;
             STARTUPINFO start_info;
             PROCESS_INFORMATION proc_info;
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index dbe2b9b..11b475c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -215,7 +215,9 @@ AsyncPipeOp(async_op_t op, HANDLE pipe, LPVOID buffer, DWORD size, DWORD count,
 
     handles[0] = io_event;
     for (i = 0; i < count; i++)
+    {
         handles[i + 1] = events[i];
+    }
 
     res = WaitForMultipleObjects(count + 1, handles, FALSE,
                                  op == peek ? INFINITE : IO_TIMEOUT);
@@ -1840,7 +1842,8 @@ ServiceStartInteractive(DWORD dwArgc, LPTSTR *lpszArgv)
     PHANDLE handles = NULL;
     DWORD handle_count;
     BOOL
-    CmpHandle(LPVOID item, LPVOID hnd) {
+    CmpHandle(LPVOID item, LPVOID hnd)
+    {
         return item == hnd;
     }
 
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index 4f8fb0a..724a437 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -78,7 +78,8 @@ searchandreplace(const char *tosearch, const char *searchfor, const char *replac
         return strdup(tosearch);
     }
 
-    while (scratch) {
+    while (scratch)
+    {
         strncat(temp,searching,scratch-searching);
         strcat(temp,replacewith);
 
@@ -117,7 +118,9 @@ string_array_len(const char *array[])
     if (array)
     {
         while (array[i])
+        {
             ++i;
+        }
     }
     return i;
 }
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index ae85ecb..ab6b483 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -116,7 +116,9 @@ string_array_len(const char *array[])
     if (array)
     {
         while (array[i])
+        {
             ++i;
+        }
     }
     return i;
 }
-- 
2.7.4


