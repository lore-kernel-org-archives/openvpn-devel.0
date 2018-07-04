From: Steffan Karger <steffan@...1856...>
Date: Wed,  4 Jul 2018 19:53:56 +0200
Message-Id: <20180704175404.22371-1-steffan@...1856...>
In-Reply-To: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
References: <1512734870-17133-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH v2 1/9] Move file-related functions from
 misc.c to platform.c
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

From: Steffan Karger <steffan.karger@...1435...>

To avoid having to include misc.c - which is a dependency mess - in the
tls-crypt unit tests, move file-handing related functions to platform.c
(which is where other file-related functions already reside).

Note that platform_create_temp_file() needs random.  To avoid including
misc.c in other tests that use platform.c, add a mock get_random().

(Almost every test includes platform.c, because buffer.c depends on it.
That smells like it needs cleanup too, but not in this patch set.)

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/init.c                         |   2 +-
 src/openvpn/misc.c                         | 148 ---------------------
 src/openvpn/misc.h                         |  12 --
 src/openvpn/multi.c                        |  25 ++--
 src/openvpn/pf.c                           |   4 +-
 src/openvpn/platform.c                     | 148 +++++++++++++++++++++
 src/openvpn/platform.h                     |  18 +++
 src/openvpn/plugin.c                       |   6 +-
 src/openvpn/ssl_verify.c                   |  12 +-
 tests/unit_tests/openvpn/Makefile.am       |   4 +
 tests/unit_tests/openvpn/mock_get_random.c |  36 +++++
 11 files changed, 233 insertions(+), 182 deletions(-)
 create mode 100644 tests/unit_tests/openvpn/mock_get_random.c

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b748357d..f6c8f08e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -807,7 +807,7 @@ init_static(void)
 #ifdef STATUS_PRINTF_TEST
     {
         struct gc_arena gc = gc_new();
-        const char *tmp_file = create_temp_file("/tmp", "foo", &gc);
+        const char *tmp_file = platform_create_temp_file("/tmp", "foo", &gc);
         struct status_output *so = status_open(tmp_file, 0, -1, NULL, STATUS_OUTPUT_WRITE);
         status_printf(so, "%s", "foo");
         status_printf(so, "%s", "bar");
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index fc68027f..85cdc95d 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -313,87 +313,6 @@ openvpn_popen(const struct argv *a,  const struct env_set *es)
     return ret;
 }
 
-
-/* return true if filename can be opened for read */
-bool
-test_file(const char *filename)
-{
-    bool ret = false;
-    if (filename)
-    {
-        FILE *fp = platform_fopen(filename, "r");
-        if (fp)
-        {
-            fclose(fp);
-            ret = true;
-        }
-        else
-        {
-            if (openvpn_errno() == EACCES)
-            {
-                msg( M_WARN | M_ERRNO, "Could not access file '%s'", filename);
-            }
-        }
-    }
-
-    dmsg(D_TEST_FILE, "TEST FILE '%s' [%d]",
-         filename ? filename : "UNDEF",
-         ret);
-
-    return ret;
-}
-
-/* create a temporary filename in directory */
-const char *
-create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
-{
-    int fd;
-    const char *retfname = NULL;
-    unsigned int attempts = 0;
-    char fname[256] = { 0 };
-    const char *fname_fmt = PACKAGE "_%.*s_%08lx%08lx.tmp";
-    const int max_prefix_len = sizeof(fname) - (sizeof(PACKAGE) + 7 + (2 * 8));
-
-    while (attempts < 6)
-    {
-        ++attempts;
-
-        if (!openvpn_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len,
-                              prefix, (unsigned long) get_random(),
-                              (unsigned long) get_random()))
-        {
-            msg(M_WARN, "ERROR: temporary filename too long");
-            return NULL;
-        }
-
-        retfname = gen_path(directory, fname, gc);
-        if (!retfname)
-        {
-            msg(M_WARN, "Failed to create temporary filename and path");
-            return NULL;
-        }
-
-        /* Atomically create the file.  Errors out if the file already
-         * exists.  */
-        fd = platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);
-        if (fd != -1)
-        {
-            close(fd);
-            return retfname;
-        }
-        else if (fd == -1 && errno != EEXIST)
-        {
-            /* Something else went wrong, no need to retry.  */
-            msg(M_WARN | M_ERRNO, "Could not create temporary file '%s'",
-                retfname);
-            return NULL;
-        }
-    }
-
-    msg(M_WARN, "Failed to create temporary file after %i attempts", attempts);
-    return NULL;
-}
-
 /*
  * Prepend a random string to hostname to prevent DNS caching.
  * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.gov.
@@ -415,73 +334,6 @@ hostname_randomize(const char *hostname, struct gc_arena *gc)
 #undef n_rnd_bytes
 }
 
-/*
- * Put a directory and filename together.
- */
-const char *
-gen_path(const char *directory, const char *filename, struct gc_arena *gc)
-{
-#ifdef _WIN32
-    const int CC_PATH_RESERVED = CC_LESS_THAN|CC_GREATER_THAN|CC_COLON
-                                 |CC_DOUBLE_QUOTE|CC_SLASH|CC_BACKSLASH|CC_PIPE|CC_QUESTION_MARK|CC_ASTERISK;
-#else
-    const int CC_PATH_RESERVED = CC_SLASH;
-#endif
-
-    if (!gc)
-    {
-        return NULL; /* Would leak memory otherwise */
-    }
-
-    const char *safe_filename = string_mod_const(filename, CC_PRINT, CC_PATH_RESERVED, '_', gc);
-
-    if (safe_filename
-        && strcmp(safe_filename, ".")
-        && strcmp(safe_filename, "..")
-#ifdef _WIN32
-        && win_safe_filename(safe_filename)
-#endif
-        )
-    {
-        const size_t outsize = strlen(safe_filename) + (directory ? strlen(directory) : 0) + 16;
-        struct buffer out = alloc_buf_gc(outsize, gc);
-        char dirsep[2];
-
-        dirsep[0] = OS_SPECIFIC_DIRSEP;
-        dirsep[1] = '\0';
-
-        if (directory)
-        {
-            buf_printf(&out, "%s%s", directory, dirsep);
-        }
-        buf_printf(&out, "%s", safe_filename);
-
-        return BSTR(&out);
-    }
-    else
-    {
-        return NULL;
-    }
-}
-
-bool
-absolute_pathname(const char *pathname)
-{
-    if (pathname)
-    {
-        const int c = pathname[0];
-#ifdef _WIN32
-        return c == '\\' || (isalpha(c) && pathname[1] == ':' && pathname[2] == '\\');
-#else
-        return c == '/';
-#endif
-    }
-    else
-    {
-        return false;
-    }
-}
-
 /*
  * Get and store a username/password
  */
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 5680c274..c23d4cd1 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -79,18 +79,6 @@ const char **make_extended_arg_array(char **p, struct gc_arena *gc);
 /* an analogue to the random() function, but use OpenSSL functions if available */
 long int get_random(void);
 
-/* return true if filename can be opened for read */
-bool test_file(const char *filename);
-
-/* create a temporary file in directory, returns the filename of the created file */
-const char *create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc);
-
-/* put a directory and filename together */
-const char *gen_path(const char *directory, const char *filename, struct gc_arena *gc);
-
-/* return true if pathname is absolute */
-bool absolute_pathname(const char *pathname);
-
 /* prepend a random prefix to hostname */
 const char *hostname_randomize(const char *hostname, struct gc_arena *gc);
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3da8c110..2944eef2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1642,7 +1642,7 @@ multi_client_connect_post(struct multi_context *m,
                           unsigned int *option_types_found)
 {
     /* Did script generate a dynamic config file? */
-    if (test_file(dc_file))
+    if (platform_test_file(dc_file))
     {
         options_server_import(&mi->context.options,
                               dc_file,
@@ -1829,12 +1829,13 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         {
             const char *ccd_file;
 
-            ccd_file = gen_path(mi->context.options.client_config_dir,
-                                tls_common_name(mi->context.c2.tls_multi, false),
-                                &gc);
+            ccd_file = platform_gen_path(mi->context.options.client_config_dir,
+                                         tls_common_name(mi->context.c2.tls_multi,
+                                                         false),
+                                         &gc);
 
             /* try common-name file */
-            if (test_file(ccd_file))
+            if (platform_test_file(ccd_file))
             {
                 options_server_import(&mi->context.options,
                                       ccd_file,
@@ -1845,11 +1846,11 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
             }
             else /* try default file */
             {
-                ccd_file = gen_path(mi->context.options.client_config_dir,
-                                    CCD_DEFAULT,
-                                    &gc);
+                ccd_file = platform_gen_path(mi->context.options.client_config_dir,
+                                             CCD_DEFAULT,
+                                             &gc);
 
-                if (test_file(ccd_file))
+                if (platform_test_file(ccd_file))
                 {
                     options_server_import(&mi->context.options,
                                           ccd_file,
@@ -1879,7 +1880,8 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
         {
             struct argv argv = argv_new();
-            const char *dc_file = create_temp_file(mi->context.options.tmp_dir, "cc", &gc);
+            const char *dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
+                                                            "cc", &gc);
 
             if (!dc_file)
             {
@@ -1941,7 +1943,8 @@ script_depr_failed:
 
             setenv_str(mi->context.c2.es, "script_type", "client-connect");
 
-            dc_file = create_temp_file(mi->context.options.tmp_dir, "cc", &gc);
+            dc_file = platform_create_temp_file(mi->context.options.tmp_dir,
+                                                "cc", &gc);
             if (!dc_file)
             {
                 cc_succeeded = false;
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index cb22a1cb..d4e405a8 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -621,8 +621,8 @@ pf_init_context(struct context *c)
 #ifdef PLUGIN_PF
     if (plugin_defined(c->plugins, OPENVPN_PLUGIN_ENABLE_PF))
     {
-        c->c2.pf.filename = create_temp_file(c->options.tmp_dir, "pf",
-                                             &c->c2.gc);
+        c->c2.pf.filename = platform_create_temp_file(c->options.tmp_dir, "pf",
+                                                      &c->c2.gc);
         if (c->c2.pf.filename)
         {
             setenv_str(c->c2.es, "pf_file", c->c2.pf.filename);
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index fbffd0f0..5ecccf1c 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -31,6 +31,7 @@
 
 #include "buffer.h"
 #include "error.h"
+#include "misc.h"
 #include "win32.h"
 
 #include "memdbg.h"
@@ -335,3 +336,150 @@ platform_stat(const char *path, platform_stat_t *buf)
 #endif
 }
 
+/* create a temporary filename in directory */
+const char *
+platform_create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
+{
+    int fd;
+    const char *retfname = NULL;
+    unsigned int attempts = 0;
+    char fname[256] = { 0 };
+    const char *fname_fmt = PACKAGE "_%.*s_%08lx%08lx.tmp";
+    const int max_prefix_len = sizeof(fname) - (sizeof(PACKAGE) + 7 + (2 * 8));
+
+    while (attempts < 6)
+    {
+        ++attempts;
+
+        if (!openvpn_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len,
+                              prefix, (unsigned long) get_random(),
+                              (unsigned long) get_random()))
+        {
+            msg(M_WARN, "ERROR: temporary filename too long");
+            return NULL;
+        }
+
+        retfname = platform_gen_path(directory, fname, gc);
+        if (!retfname)
+        {
+            msg(M_WARN, "Failed to create temporary filename and path");
+            return NULL;
+        }
+
+        /* Atomically create the file.  Errors out if the file already
+         * exists.  */
+        fd = platform_open(retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR);
+        if (fd != -1)
+        {
+            close(fd);
+            return retfname;
+        }
+        else if (fd == -1 && errno != EEXIST)
+        {
+            /* Something else went wrong, no need to retry.  */
+            msg(M_WARN | M_ERRNO, "Could not create temporary file '%s'",
+                retfname);
+            return NULL;
+        }
+    }
+
+    msg(M_WARN, "Failed to create temporary file after %i attempts", attempts);
+    return NULL;
+}
+
+/*
+ * Put a directory and filename together.
+ */
+const char *
+platform_gen_path(const char *directory, const char *filename,
+                  struct gc_arena *gc)
+{
+#ifdef _WIN32
+    const int CC_PATH_RESERVED = CC_LESS_THAN|CC_GREATER_THAN|CC_COLON
+                                 |CC_DOUBLE_QUOTE|CC_SLASH|CC_BACKSLASH|CC_PIPE|CC_QUESTION_MARK|CC_ASTERISK;
+#else
+    const int CC_PATH_RESERVED = CC_SLASH;
+#endif
+
+    if (!gc)
+    {
+        return NULL; /* Would leak memory otherwise */
+    }
+
+    const char *safe_filename = string_mod_const(filename, CC_PRINT, CC_PATH_RESERVED, '_', gc);
+
+    if (safe_filename
+        && strcmp(safe_filename, ".")
+        && strcmp(safe_filename, "..")
+#ifdef _WIN32
+        && win_safe_filename(safe_filename)
+#endif
+        )
+    {
+        const size_t outsize = strlen(safe_filename) + (directory ? strlen(directory) : 0) + 16;
+        struct buffer out = alloc_buf_gc(outsize, gc);
+        char dirsep[2];
+
+        dirsep[0] = OS_SPECIFIC_DIRSEP;
+        dirsep[1] = '\0';
+
+        if (directory)
+        {
+            buf_printf(&out, "%s%s", directory, dirsep);
+        }
+        buf_printf(&out, "%s", safe_filename);
+
+        return BSTR(&out);
+    }
+    else
+    {
+        return NULL;
+    }
+}
+
+bool
+platform_absolute_pathname(const char *pathname)
+{
+    if (pathname)
+    {
+        const int c = pathname[0];
+#ifdef _WIN32
+        return c == '\\' || (isalpha(c) && pathname[1] == ':' && pathname[2] == '\\');
+#else
+        return c == '/';
+#endif
+    }
+    else
+    {
+        return false;
+    }
+}
+
+/* return true if filename can be opened for read */
+bool
+platform_test_file(const char *filename)
+{
+    bool ret = false;
+    if (filename)
+    {
+        FILE *fp = platform_fopen(filename, "r");
+        if (fp)
+        {
+            fclose(fp);
+            ret = true;
+        }
+        else
+        {
+            if (openvpn_errno() == EACCES)
+            {
+                msg( M_WARN | M_ERRNO, "Could not access file '%s'", filename);
+            }
+        }
+    }
+
+    dmsg(D_TEST_FILE, "TEST FILE '%s' [%d]",
+         filename ? filename : "UNDEF",
+         ret);
+
+    return ret;
+}
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 288937df..091fc9c4 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -49,6 +49,7 @@
 #endif
 
 #include "basic.h"
+#include "buffer.h"
 
 /* Get/Set UID of process */
 
@@ -143,4 +144,21 @@ typedef struct stat platform_stat_t;
 #endif
 int platform_stat(const char *path, platform_stat_t *buf);
 
+/**
+ * Create a temporary file in directory, returns the filename of the created
+ * file.
+ */
+const char *platform_create_temp_file(const char *directory, const char *prefix,
+                                      struct gc_arena *gc);
+
+/** Put a directory and filename together. */
+const char *platform_gen_path(const char *directory, const char *filename,
+                              struct gc_arena *gc);
+
+/** Return true if pathname is absolute. */
+bool platform_absolute_pathname(const char *pathname);
+
+/** Return true if filename can be opened for read. */
+bool platform_test_file(const char *filename);
+
 #endif /* ifndef PLATFORM_H */
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 0f091ef5..3e7d2b2a 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -249,7 +249,7 @@ plugin_init_item(struct plugin *p, const struct plugin_option *o)
      * was parsed.
      *
      */
-    if (!absolute_pathname(p->so_pathname)
+    if (!platform_absolute_pathname(p->so_pathname)
         && p->so_pathname[0] != '.')
     {
         char full[PATH_MAX];
@@ -259,7 +259,7 @@ plugin_init_item(struct plugin *p, const struct plugin_option *o)
     }
     else
     {
-        rel = !absolute_pathname(p->so_pathname);
+        rel = !platform_absolute_pathname(p->so_pathname);
         p->handle = dlopen(p->so_pathname, RTLD_NOW);
     }
     if (!p->handle)
@@ -271,7 +271,7 @@ plugin_init_item(struct plugin *p, const struct plugin_option *o)
 
 #else  /* ifndef _WIN32 */
 
-    rel = !absolute_pathname(p->so_pathname);
+    rel = !platform_absolute_pathname(p->so_pathname);
     p->module = LoadLibraryW(wide_string(p->so_pathname, &gc));
     if (!p->module)
     {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 25395b27..a3699252 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -547,7 +547,7 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
 
     /* create tmp file to store peer cert */
     if (!tmp_dir
-        || !(peercert_filename = create_temp_file(tmp_dir, "pcf", gc)))
+        || !(peercert_filename = platform_create_temp_file(tmp_dir, "pcf", gc)))
     {
         msg(M_NONFATAL, "Failed to create peer cert file");
         return NULL;
@@ -890,7 +890,7 @@ key_state_gen_auth_control_file(struct key_state *ks, const struct tls_options *
     struct gc_arena gc = gc_new();
 
     key_state_rm_auth_control_file(ks);
-    const char *acf = create_temp_file(opt->tmp_dir, "acf", &gc);
+    const char *acf = platform_create_temp_file(opt->tmp_dir, "acf", &gc);
     if (acf)
     {
         ks->auth_control_file = string_alloc(acf, NULL);
@@ -1103,7 +1103,8 @@ verify_user_pass_script(struct tls_session *session, const struct user_pass *up)
         {
             struct status_output *so;
 
-            tmp_file = create_temp_file(session->opt->tmp_dir, "up", &gc);
+            tmp_file = platform_create_temp_file(session->opt->tmp_dir, "up",
+                                                 &gc);
             if (tmp_file)
             {
                 so = status_open(tmp_file, 0, -1, NULL, STATUS_OUTPUT_WRITE);
@@ -1513,8 +1514,9 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
         struct gc_arena gc = gc_new();
 
         const char *cn = session->common_name;
-        const char *path = gen_path(session->opt->client_config_dir_exclusive, cn, &gc);
-        if (!cn || !strcmp(cn, CCD_DEFAULT) || !test_file(path))
+        const char *path = platform_gen_path(session->opt->client_config_dir_exclusive,
+                                             cn, &gc);
+        if (!cn || !strcmp(cn, CCD_DEFAULT) || !platform_test_file(path))
         {
             ks->authenticated = false;
             wipe_auth_token(multi);
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 23d758b7..db4d46e1 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -19,6 +19,7 @@ argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir) \
 argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line \
 	$(OPTIONAL_CRYPTO_LIBS)
 argv_testdriver_SOURCES = test_argv.c mock_msg.c \
+	mock_get_random.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/argv.c
@@ -26,6 +27,7 @@ argv_testdriver_SOURCES = test_argv.c mock_msg.c \
 buffer_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
 buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line
 buffer_testdriver_SOURCES = test_buffer.c mock_msg.c \
+	mock_get_random.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/platform.c
 
@@ -35,6 +37,7 @@ packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 packet_id_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c \
+	mock_get_random.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
@@ -46,6 +49,7 @@ tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
 tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c \
+	$(openvpn_srcdir)/base64.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/crypto.c \
 	$(openvpn_srcdir)/crypto_mbedtls.c \
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c
new file mode 100644
index 00000000..da92a9bb
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -0,0 +1,36 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2017 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <stdarg.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+unsigned long
+get_random(void)
+{
+    /* rand() is not very random, but it's C99 and this is just for testing */
+    return rand();
+}
-- 
2.17.1


