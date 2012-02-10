From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 10 Feb 2012 15:13:42 +0100
Message-ID: <1328883222-25300-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1323280731-26083-1-git-send-email-heiko.hund@...1489...>
References: <1323280731-26083-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2] handle Windows unicode paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Openvpn for Windows is not compiled as a Unicode binary and thus cannot
handle paths which contain non-ASCII characters using the argv vector.
Characters that are not present in the system codepage are simply replaced
with a question mark, e.g. if started as 'openvpn --config =D0=B4=D0=BE=D0=
=BC=D0=BE=D0=B9.ovpn'
the file '?????.ovpn' is tried to be opened as configuration.

The same applies to paths in config files which need to be UTF-8
encoded if they contain non ASCII characters. The option line
'key =D0=BB=D0=B5=D0=B2.pem' will lead to openvpn trying to open '=C3=90=C2=
=BB=C3=90=C2=B5=C3=90=C2=B2.pem' on a
system with codepage 1252.

This patch makes openvpn read the command line in UCS-2 and convert
it to UTF-8 internally. Windows stores names in the filesystem in UCS-2.
When using a paths openvpn converts it from UTF-8 to UCS-2 and uses the
wide character Windows API function.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---

This version of the patch was rebased to current master. It also handles
the access(2) calls introduced in commit 0f2bc0dd by David correctly.

 buffer.c             |    3 +-
 crypto.c             |    6 +-
 error.c              |   17 +-
 manage.c             |    2 +-
 misc.c               |   41 ++++-
 misc.h               |   31 ++++
 options.c            |   37 ++++-
 packet_id.c          |    6 +-
 pf.c                 |    2 +-
 plugin.c             |    3 +-
 ps.c                 |    2 +-
 ssl_openssl.c        |  459 +++++++++++++++++++---------------------------=
----
 ssl_verify.c         |    2 +-
 ssl_verify_openssl.c |    6 +-
 status.c             |   48 ++----
 syshead.h            |    1 +
 win32.c              |   60 ++++++--
 win32.h              |    3 +
 18 files changed, 367 insertions(+), 362 deletions(-)

diff --git a/buffer.c b/buffer.c
index fca6a90..6800e6e 100644
--- a/buffer.c
+++ b/buffer.c
@@ -28,6 +28,7 @@
 #include "buffer.h"
 #include "error.h"
 #include "mtu.h"
+#include "misc.h"
=20
 #include "memdbg.h"
=20
@@ -1073,7 +1074,7 @@ buffer_list_advance (struct buffer_list *ol, int n)
 struct buffer_list *
 buffer_list_file (const char *fn, int max_line_len)
 {
-  FILE *fp =3D fopen (fn, "r");
+  FILE *fp =3D openvpn_fopen (fn, "r");
   struct buffer_list *bl =3D NULL;
=20
   if (fp)
diff --git a/crypto.c b/crypto.c
index e628578..5af92a0 100644
--- a/crypto.c
+++ b/crypto.c
@@ -862,7 +862,7 @@ read_key_file (struct key2 *key2, const char *file, con=
st unsigned int flags)
 #endif
     {
       in =3D alloc_buf_gc (2048, &gc);
-      fd =3D open (file, O_RDONLY);
+      fd =3D openvpn_open (file, O_RDONLY, 0);
       if (fd =3D=3D -1)
 	msg (M_ERR, "Cannot open file key file '%s'", file);
       size =3D read (fd, in.data, in.capacity);
@@ -1023,7 +1023,7 @@ read_passphrase_hash (const char *passphrase_file,
     const int min_passphrase_size =3D 8;
     uint8_t buf[64];
     int total_size =3D 0;
-    int fd =3D open (passphrase_file, O_RDONLY);
+    int fd =3D openvpn_open (passphrase_file, O_RDONLY, 0);
=20
     if (fd =3D=3D -1)
       msg (M_ERR, "Cannot open passphrase file: '%s'", passphrase_file);
@@ -1073,7 +1073,7 @@ write_key_file (const int nkeys, const char *filename)
   const int bytes_per_line =3D 16;
=20
   /* open key file */
-  fd =3D open (filename, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR);
+  fd =3D openvpn_open (filename, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S=
_IWUSR);
=20
   if (fd =3D=3D -1)
     msg (M_ERR, "Cannot open shared secret file '%s' for write", filename);
diff --git a/error.c b/error.c
index 06b383f..ede33d0 100644
--- a/error.c
+++ b/error.c
@@ -465,6 +465,7 @@ redirect_stdout_stderr (const char *file, bool append)
 #if defined(WIN32)
   if (!std_redir)
     {
+      struct gc_arena gc =3D gc_new ();
       HANDLE log_handle;
       int log_fd;
=20
@@ -473,13 +474,15 @@ redirect_stdout_stderr (const char *file, bool append)
       saAttr.bInheritHandle =3D TRUE;=20
       saAttr.lpSecurityDescriptor =3D NULL;=20
=20
-      log_handle =3D CreateFile (file,
-			       GENERIC_WRITE,
-			       FILE_SHARE_READ,
-			       &saAttr,
-			       append ? OPEN_ALWAYS : CREATE_ALWAYS,
-			       FILE_ATTRIBUTE_NORMAL,
-			       NULL);
+      log_handle =3D CreateFileW (wide_string (file, &gc),
+                                GENERIC_WRITE,
+                                FILE_SHARE_READ,
+                                &saAttr,
+                                append ? OPEN_ALWAYS : CREATE_ALWAYS,
+                                FILE_ATTRIBUTE_NORMAL,
+                                NULL);
+
+      gc_free (&gc);
=20
       if (log_handle =3D=3D INVALID_HANDLE_VALUE)
 	{
diff --git a/manage.c b/manage.c
index ce6fae7..23e32db 100644
--- a/manage.c
+++ b/manage.c
@@ -1423,7 +1423,7 @@ man_record_peer_info (struct management *man)
 	    {
 	      const in_addr_t a =3D ntohl (addr.sin_addr.s_addr);
 	      const int p =3D ntohs (addr.sin_port);
-	      FILE *fp =3D fopen (man->settings.write_peer_info_file, "w");
+	      FILE *fp =3D openvpn_fopen (man->settings.write_peer_info_file, "w"=
);
 	      if (fp)
 		{
 		  fprintf (fp, "%s\n%d\n", print_in_addr_t (a, 0, &gc), p);
diff --git a/misc.c b/misc.c
index 1aa1be4..58096fa 100644
--- a/misc.c
+++ b/misc.c
@@ -246,7 +246,7 @@ get_pid_file (const char* filename, struct pid_state *s=
tate)
   CLEAR (*state);
   if (filename)
     {
-      state->fp =3D fopen (filename, "w");
+      state->fp =3D openvpn_fopen (filename, "w");
       if (!state->fp)
 	msg (M_ERR, "Open error on pid file %s", filename);
       state->filename =3D filename;
@@ -356,7 +356,15 @@ int
 openvpn_chdir (const char* dir)
 {
 #ifdef HAVE_CHDIR
+#ifdef TARGET_WIN32
+  int res;
+  struct gc_arena gc =3D gc_new ();
+  res =3D _wchdir (wide_string (dir, &gc));
+  gc_free (&gc);
+  return res;
+#else
   return chdir (dir);
+#endif
 #else
   return -1;
 #endif
@@ -571,6 +579,7 @@ openvpn_system (const char *command, const struct env_s=
et *es, unsigned int flag
 {
 #ifdef HAVE_SYSTEM
   int ret;
+  struct gc_arena gc;
=20
   perf_push (PERF_SCRIPT);
=20
@@ -589,7 +598,13 @@ openvpn_system (const char *command, const struct env_=
set *es, unsigned int flag
   /*
    * execute the command
    */
+#ifdef TARGET_WIN32
+  gc =3D gc_new ();
+  ret =3D _wsystem (wide_string (command, &gc));
+  gc_free (&gc);
+#else
   ret =3D system (command);
+#endif
=20
   /* debugging */
   dmsg (D_SCRIPT, "SYSTEM return=3D%u", ret);
@@ -609,6 +624,19 @@ openvpn_system (const char *command, const struct env_=
set *es, unsigned int flag
 #endif
 }
=20
+int
+openvpn_access (const char *path, int mode)
+{
+#ifdef TARGET_WIN32
+  struct gc_arena gc =3D gc_new ();
+  int ret =3D _waccess (wide_string (path, &gc), mode);
+  gc_free (&gc);
+  return ret;
+#else
+  return access (path, mode);
+#endif
+}
+
 /*
  * Run execve() inside a fork(), duping stdout.  Designed to replicate the=
 semantics of popen() but
  * in a safer way that doesn't require the invocation of a shell or the ri=
sks
@@ -1200,7 +1228,7 @@ test_file (const char *filename)
   bool ret =3D false;
   if (filename)
     {
-      FILE *fp =3D fopen (filename, "r");
+      FILE *fp =3D openvpn_fopen (filename, "r");
       if (fp)
 	{
 	  fclose (fp);
@@ -1248,7 +1276,7 @@ create_temp_file (const char *directory, const char *=
prefix, struct gc_arena *gc
=20
       /* Atomically create the file.  Errors out if the file already
          exists.  */
-      fd =3D open (retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUS=
R);
+      fd =3D openvpn_open (retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR =
| S_IWUSR);
       if (fd !=3D -1)
         {
           close (fd);
@@ -1349,7 +1377,10 @@ bool
 delete_file (const char *filename)
 {
 #if defined(WIN32)
-  return (DeleteFile (filename) !=3D 0);
+  struct gc_arena gc =3D gc_new ();
+  BOOL ret =3D DeleteFileW (wide_string (filename, &gc));
+  gc_free (&gc);
+  return (ret !=3D 0);
 #elif defined(HAVE_UNLINK)
   return (unlink (filename) =3D=3D 0);
 #else
@@ -1647,7 +1678,7 @@ get_user_pass_cr (struct user_pass *up,
=20
 	  warn_if_group_others_accessible (auth_file);
=20
-	  fp =3D fopen (auth_file, "r");
+	  fp =3D openvpn_fopen (auth_file, "r");
 	  if (!fp)
 	    msg (M_ERR, "Error opening '%s' auth file: %s", prefix, auth_file);
=20
diff --git a/misc.h b/misc.h
index b1badd9..2413f53 100644
--- a/misc.h
+++ b/misc.h
@@ -136,6 +136,7 @@ int openvpn_execve (const struct argv *a, const struct =
env_set *es, const unsign
 bool openvpn_execve_check (const struct argv *a, const struct env_set *es,=
 const unsigned int flags, const char *error_message);
 bool openvpn_execve_allowed (const unsigned int flags);
 int openvpn_system (const char *command, const struct env_set *es, unsigne=
d int flags);
+int openvpn_access (const char *path, int mode);
=20
 static inline bool
 openvpn_run_script (const struct argv *a, const struct env_set *es, const =
unsigned int flags, const char *hook)
@@ -146,6 +147,36 @@ openvpn_run_script (const struct argv *a, const struct=
 env_set *es, const unsign
   return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
 };
=20
+#ifdef TARGET_WIN32
+FILE * openvpn_fopen (const char *path, const char *mode);
+#else
+static inline FILE *
+openvpn_fopen (const char *path, const char *mode)
+{
+  return fopen (path, mode);
+}
+#endif
+
+#ifdef TARGET_WIN32
+int openvpn_open (const char *path, int flags, mode_t mode);
+#else
+static inline int
+openvpn_open (const char *path, int flags, mode_t mode)
+{
+  return open (path, flags, mode);
+}
+#endif
+
+#ifdef TARGET_WIN32
+int openvpn_stat (const char *path, struct stat *buf);
+#else
+static inline int
+openvpn_stat (const char *path, struct stat *buf)
+{
+  return stat (path, buf);
+}
+#endif
+
 #ifdef HAVE_STRERROR
 /* a thread-safe version of strerror */
 const char* strerror_ts (int errnum, struct gc_arena *gc);
diff --git a/options.c b/options.c
index a0b3431..42b0b52 100644
--- a/options.c
+++ b/options.c
@@ -2620,18 +2620,18 @@ check_file_access(const int type, const char *file,=
 const int mode, const char *
       char *fullpath =3D strdup(file);  /* POSIX dirname() implementaion m=
ay modify its arguments */
       char *dirpath =3D dirname(fullpath);
=20
-      if (access (dirpath, mode|X_OK) !=3D 0)
+      if (openvpn_access (dirpath, mode|X_OK) !=3D 0)
           errcode =3D errno;
       free(fullpath);
     }
=20
   /* Is the file itself accessible? */
-  if (!errcode && (type & CHKACC_FILE) && (access (file, mode) !=3D 0) )
+  if (!errcode && (type & CHKACC_FILE) && (openvpn_access (file, mode) !=
=3D 0) )
       errcode =3D errno;
=20
   /* If the file exists and is accessible, is it writable? */
-  if (!errcode && (type & CHKACC_FILEXSTWR) && (access (file, F_OK) =3D=3D=
 0) )
-    if (access (file, W_OK) !=3D 0)
+  if (!errcode && (type & CHKACC_FILEXSTWR) && (openvpn_access (file, F_OK=
) =3D=3D 0) )
+    if (openvpn_access (file, W_OK) !=3D 0)
       errcode =3D errno;
=20
   /* Scream if an error is found */
@@ -3737,7 +3737,7 @@ read_config_file (struct options *options,
       if (streq (file, "stdin"))
 	fp =3D stdin;
       else
-	fp =3D fopen (file, "r");
+	fp =3D openvpn_fopen (file, "r");
       if (fp)
 	{
 	  line_num =3D 0;
@@ -3814,6 +3814,33 @@ parse_argv (struct options *options,
 {
   int i, j;
=20
+#ifdef WIN32
+  /*
+   * Windows replaces Unicode characters in argv[] that are not present
+   * in the current codepage with '?'. Get the wide char command line and
+   * convert it to UTF-8 ourselves.
+   */
+  int wargc;
+  WCHAR **wargv;
+  char **uargv;
+
+  wargv =3D CommandLineToArgvW (GetCommandLineW (), &wargc);
+  if (wargv =3D=3D NULL || wargc !=3D argc)
+    usage ();
+
+  uargv =3D gc_malloc (wargc * sizeof (*uargv), false, &options->gc);
+
+  for (i =3D 0; i < wargc; i++)
+    {
+      int n =3D WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, NULL, 0, NU=
LL, NULL);
+      uargv[i] =3D gc_malloc (n, false, &options->gc);
+      WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, uargv[i], n, NULL, NU=
LL);
+    }
+
+  LocalFree (wargv);
+  argv =3D uargv;
+#endif
+
   /* usage message */
   if (argc <=3D 1)
     usage ();
diff --git a/packet_id.c b/packet_id.c
index 024b4f3..ba8973a 100644
--- a/packet_id.c
+++ b/packet_id.c
@@ -362,9 +362,9 @@ packet_id_persist_load (struct packet_id_persist *p, co=
nst char *filename)
   if (!packet_id_persist_enabled (p))
     {
       /* open packet-id persist file for both read and write */
-      p->fd =3D open (filename,
-		    O_CREAT | O_RDWR | O_BINARY,
-		    S_IRUSR | S_IWUSR);
+      p->fd =3D openvpn_open (filename,
+                            O_CREAT | O_RDWR | O_BINARY,
+                            S_IRUSR | S_IWUSR);
       if (p->fd =3D=3D -1)
 	{
 	  msg (D_PID_PERSIST | M_ERRNO,
diff --git a/pf.c b/pf.c
index 79915fa..a0e9fc8 100644
--- a/pf.c
+++ b/pf.c
@@ -499,7 +499,7 @@ pf_check_reload (struct context *c)
       && event_timeout_trigger (&c->c2.pf.reload, &c->c2.timeval, ETT_DEFA=
ULT))
     {
       struct stat s;
-      if (!stat (c->c2.pf.filename, &s))
+      if (!openvpn_stat (c->c2.pf.filename, &s))
 	{
 	  if (s.st_mtime > c->c2.pf.file_last_mod)
 	    {
diff --git a/plugin.c b/plugin.c
index 737a868..4cc9c36 100644
--- a/plugin.c
+++ b/plugin.c
@@ -30,6 +30,7 @@
 #include "error.h"
 #include "misc.h"
 #include "plugin.h"
+#include "win32.h"
=20
 #include "memdbg.h"
=20
@@ -222,7 +223,7 @@ plugin_init_item (struct plugin *p, const struct plugin=
_option *o)
 #elif defined(USE_LOAD_LIBRARY)
=20
   rel =3D !absolute_pathname (p->so_pathname);
-  p->module =3D LoadLibrary (p->so_pathname);
+  p->module =3D LoadLibraryW (wide_string (p->so_pathname, &gc));
   if (!p->module)
     msg (M_ERR, "PLUGIN_INIT: could not load plugin DLL: %s", p->so_pathna=
me);
=20
diff --git a/ps.c b/ps.c
index 98a20ad..182925b 100644
--- a/ps.c
+++ b/ps.c
@@ -331,7 +331,7 @@ journal_add (const char *journal_dir, struct proxy_conn=
ection *pc, struct proxy_
       check_malloc_return (jfn);
       openvpn_snprintf (jfn, fnlen, "%s/%s", journal_dir, t);
       dmsg (D_PS_PROXY_DEBUG, "PORT SHARE PROXY: client origin %s -> %s", =
jfn, f);
-      fd =3D open (jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | =
S_IRGRP);
+      fd =3D openvpn_open (jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_=
IWUSR | S_IRGRP);
       if (fd !=3D -1)
 	{
 	  write(fd, f, strlen(f));
diff --git a/ssl_openssl.c b/ssl_openssl.c
index b95944c..1267e6b 100644
--- a/ssl_openssl.c
+++ b/ssl_openssl.c
@@ -274,7 +274,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const cha=
r *pkcs12_file,
 #endif
     {
       /* Load the PKCS #12 file */
-      if (!(fp =3D fopen(pkcs12_file, "rb")))
+      if (!(fp =3D openvpn_fopen(pkcs12_file, "rb")))
 	msg(M_SSLERR, "Error opening file %s", pkcs12_file);
       p12 =3D d2i_PKCS12_fp(fp, NULL);
       fclose(fp);
@@ -343,46 +343,20 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, cons=
t char *cryptoapi_cert)
 }
 #endif /* WIN32 */
=20
-/*
- * Based on SSL_CTX_use_certificate_file, return an x509 object for the
- * given file.
- */
-static int
-tls_ctx_read_certificate_file(SSL_CTX *ctx, const char *file, X509 **x509)
+static void
+tls_ctx_add_extra_certs (struct tls_root_ctx *ctx, BIO *bio)
 {
-  BIO *in;
-  int ret=3D0;
-  X509 *x=3DNULL;
-
-  in=3DBIO_new(BIO_s_file_internal());
-  if (in =3D=3D NULL)
-    {
-      SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_BUF_LIB);
-      goto end;
-    }
-
-  if (BIO_read_filename(in,file) <=3D 0)
-    {
-      SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_SYS_LIB);
-      goto end;
-    }
-
-  x =3D PEM_read_bio_X509(in, NULL, ctx->default_passwd_callback,
-    ctx->default_passwd_callback_userdata);
-  if (x =3D=3D NULL)
+  X509 *cert;
+  for (;;)
     {
-      SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_PEM_LIB);
-      goto end;
+      cert =3D NULL;
+      if (!PEM_read_bio_X509 (bio, &cert, 0, NULL)) /* takes ownership of =
cert */
+        break;
+      if (!cert)
+        msg (M_SSLERR, "Error reading extra certificate");
+      if (SSL_CTX_add_extra_chain_cert(ctx->ctx, cert) !=3D 1)
+        msg (M_SSLERR, "Error adding extra certificate");
     }
-
- end:
-  if (in !=3D NULL)
-    BIO_free(in);
-  if (x509)
-    *x509 =3D x;
-  else if (x)
-    X509_free (x);
-  return(ret);
 }
=20
 void
@@ -393,48 +367,57 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, con=
st char *cert_file,
     X509 **x509
     )
 {
-  ASSERT(NULL !=3D ctx);
+  BIO *in =3D NULL;
+  X509 *x =3D NULL;
+  int ret =3D 0;
+  bool inline_file =3D false;
+
+  ASSERT (NULL !=3D ctx);
   if (NULL !=3D x509)
-    ASSERT(NULL =3D=3D *x509);
+    ASSERT (NULL =3D=3D *x509);
=20
 #if ENABLE_INLINE_FILES
-  if (!strcmp (cert_file, INLINE_FILE_TAG) && cert_file_inline)
-    {
-      BIO *in =3D NULL;
-      X509 *x =3D NULL;
-      int ret =3D 0;
+  inline_file =3D (strcmp (cert_file, INLINE_FILE_TAG) =3D=3D 0);
=20
-      in =3D BIO_new_mem_buf ((char *)cert_file_inline, -1);
-      if (in)
-	{
-	  x =3D PEM_read_bio_X509 (in,
-			     NULL,
-			     ctx->ctx->default_passwd_callback,
-			     ctx->ctx->default_passwd_callback_userdata);
-	  BIO_free (in);
-	  if (x) {
-	    ret =3D SSL_CTX_use_certificate(ctx->ctx, x);
-	    if (x509)
-	      *x509 =3D x;
-	    else
-	      X509_free (x);
-	  }
-	}
-
-      if (!ret)
-        msg (M_SSLERR, "Cannot load inline certificate file");
-    }
+  if (inline_file && cert_file_inline)
+    in =3D BIO_new_mem_buf ((char *)cert_file_inline, -1);
   else
 #endif /* ENABLE_INLINE_FILES */
+    in =3D BIO_new_file (cert_file, "r");
+
+  if (in =3D=3D NULL)
     {
-      if (!SSL_CTX_use_certificate_chain_file (ctx->ctx, cert_file))
-	msg (M_SSLERR, "Cannot load certificate file %s", cert_file);
-      if (x509)
-	{
-	  if (!tls_ctx_read_certificate_file(ctx->ctx, cert_file, x509))
-	    msg (M_SSLERR, "Cannot load certificate file %s", cert_file);
-	}
+      SSLerr (SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_SYS_LIB);
+      goto end;
+    }
+
+  x =3D PEM_read_bio_X509 (in, NULL, ctx->ctx->default_passwd_callback,
+                         ctx->ctx->default_passwd_callback_userdata);
+  if (x =3D=3D NULL)
+    {
+      SSLerr (SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_PEM_LIB);
+      goto end;
     }
+
+  ret =3D SSL_CTX_use_certificate (ctx->ctx, x);
+  if (ret)
+    tls_ctx_add_extra_certs (ctx, in);
+
+end:
+  if (!ret)
+    {
+      if (inline_file)
+        msg (M_SSLERR, "Cannot load inline certificate file");
+      else
+        msg (M_SSLERR, "Cannot load certificate file %s", cert_file);
+    }
+
+  if (in !=3D NULL)
+    BIO_free(in);
+  if (x509)
+    *x509 =3D x;
+  else if (x)
+    X509_free (x);
 }
=20
 void
@@ -443,36 +426,6 @@ tls_ctx_free_cert_file (X509 *x509)
   X509_free(x509);
 }
=20
-#if ENABLE_INLINE_FILES
-static int
-use_inline_PrivateKey_file (SSL_CTX *ctx, const char *key_string)
-{
-  BIO *in =3D NULL;
-  EVP_PKEY *pkey =3D NULL;
-  int ret =3D 0;
-
-  in =3D BIO_new_mem_buf ((char *)key_string, -1);
-  if (!in)
-    goto end;
-
-  pkey =3D PEM_read_bio_PrivateKey (in,
-				  NULL,
-				  ctx->default_passwd_callback,
-				  ctx->default_passwd_callback_userdata);
-  if (!pkey)
-    goto end;
-
-  ret =3D SSL_CTX_use_PrivateKey (ctx, pkey);
-
- end:
-  if (pkey)
-    EVP_PKEY_free (pkey);
-  if (in)
-    BIO_free (in);
-  return ret;
-}
-#endif /* ENABLE_INLINE_FILES */
-
 int
 tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
 #if ENABLE_INLINE_FILES
@@ -481,35 +434,53 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, con=
st char *priv_key_file
     )
 {
   int status;
+  SSL_CTX *ssl_ctx =3D NULL;
+  BIO *in =3D NULL;
+  EVP_PKEY *pkey =3D NULL;
+  int ret =3D 1;
=20
   ASSERT(NULL !=3D ctx);
=20
+  ssl_ctx =3D ctx->ctx;
+
 #if ENABLE_INLINE_FILES
   if (!strcmp (priv_key_file, INLINE_FILE_TAG) && priv_key_file_inline)
-    {
-      status =3D use_inline_PrivateKey_file (ctx->ctx, priv_key_file_inlin=
e);
-    }
+    in =3D BIO_new_mem_buf ((char *)priv_key_file_inline, -1);
   else
 #endif /* ENABLE_INLINE_FILES */
-    {
-      status =3D SSL_CTX_use_PrivateKey_file (ctx->ctx, priv_key_file, SSL=
_FILETYPE_PEM);
-    }
-  if (!status)
+    in =3D BIO_new_file (priv_key_file, "r");
+
+  if (!in)
+    goto end;
+
+  pkey =3D PEM_read_bio_PrivateKey (in, NULL,
+                                  ssl_ctx->default_passwd_callback,
+                                  ssl_ctx->default_passwd_callback_userdat=
a);
+  if (!pkey)
+    goto end;
+
+  if (!SSL_CTX_use_PrivateKey (ssl_ctx, pkey))
     {
 #ifdef ENABLE_MANAGEMENT
       if (management && (ERR_GET_REASON (ERR_peek_error()) =3D=3D EVP_R_BA=
D_DECRYPT))
-	  management_auth_failure (management, UP_TYPE_PRIVATE_KEY, NULL);
+          management_auth_failure (management, UP_TYPE_PRIVATE_KEY, NULL);
 #endif
       msg (M_WARN|M_SSL, "Cannot load private key file %s", priv_key_file);
-      return 1;
+      goto end;
     }
   warn_if_group_others_accessible (priv_key_file);
=20
   /* Check Private Key */
-  if (!SSL_CTX_check_private_key (ctx->ctx))
+  if (!SSL_CTX_check_private_key (ssl_ctx))
     msg (M_SSLERR, "Private key does not match the certificate");
-  return 0;
+  ret =3D 0;
=20
+end:
+  if (pkey)
+    EVP_PKEY_free (pkey);
+  if (in)
+    BIO_free (in);
+  return ret;
 }
=20
 #ifdef MANAGMENT_EXTERNAL_KEY
@@ -650,111 +621,11 @@ tls_ctx_use_external_private_key (struct tls_root_ct=
x *ctx, X509 *cert)
=20
 #endif
=20
-#if ENABLE_INLINE_FILES
-static int
-xname_cmp(const X509_NAME * const *a, const X509_NAME * const *b)
-{
-  return(X509_NAME_cmp(*a,*b));
-}
-
-static STACK_OF(X509_NAME) *
-use_inline_load_client_CA_file (SSL_CTX *ctx, const char *ca_string)
-{
-  BIO *in =3D NULL;
-  X509 *x =3D NULL;
-  X509_NAME *xn =3D NULL;
-  STACK_OF(X509_NAME) *ret =3D NULL, *sk;
-
-  sk=3Dsk_X509_NAME_new(xname_cmp);
-
-  in =3D BIO_new_mem_buf ((char *)ca_string, -1);
-  if (!in)
-    goto err;
-
-  if ((sk =3D=3D NULL) || (in =3D=3D NULL))
-    goto err;
-
-  for (;;)
-    {
-      if (PEM_read_bio_X509(in,&x,NULL,NULL) =3D=3D NULL)
-	break;
-      if (ret =3D=3D NULL)
-	{
-	  ret =3D sk_X509_NAME_new_null();
-	  if (ret =3D=3D NULL)
-	    goto err;
-	}
-      if ((xn=3DX509_get_subject_name(x)) =3D=3D NULL) goto err;
-      /* check for duplicates */
-      xn=3DX509_NAME_dup(xn);
-      if (xn =3D=3D NULL) goto err;
-      if (sk_X509_NAME_find(sk,xn) >=3D 0)
-	X509_NAME_free(xn);
-      else
-	{
-	  sk_X509_NAME_push(sk,xn);
-	  sk_X509_NAME_push(ret,xn);
-	}
-    }
-
-  if (0)
-    {
-    err:
-      if (ret !=3D NULL) sk_X509_NAME_pop_free(ret,X509_NAME_free);
-      ret=3DNULL;
-    }
-  if (sk !=3D NULL) sk_X509_NAME_free(sk);
-  if (in !=3D NULL) BIO_free(in);
-  if (x !=3D NULL) X509_free(x);
-  if (ret !=3D NULL)
-    ERR_clear_error();
-  return(ret);
-}
-
 static int
-use_inline_load_verify_locations (SSL_CTX *ctx, const char *ca_string)
+sk_x509_name_cmp(const X509_NAME * const *a, const X509_NAME * const *b)
 {
-  X509_STORE *store =3D NULL;
-  X509* cert =3D NULL;
-  BIO *in =3D NULL;
-  int ret =3D 0;
-
-  in =3D BIO_new_mem_buf ((char *)ca_string, -1);
-  if (!in)
-    goto err;
-
-  for (;;)
-    {
-      if (!PEM_read_bio_X509 (in, &cert, 0, NULL))
-	{
-	  ret =3D 1;
-	  break;
-	}
-      if (!cert)
-	break;
-
-      store =3D SSL_CTX_get_cert_store (ctx);
-      if (!store)
-	break;
-
-      if (!X509_STORE_add_cert (store, cert))
-	break;
-
-      if (cert)
-	{
-	  X509_free (cert);
-	  cert =3D NULL;
-	}
-    }
-
- err:
-  if (cert)
-    X509_free (cert);
-  if (in)
-    BIO_free (in);
-  return ret;
+  return X509_NAME_cmp (*a, *b);
 }
-#endif /* ENABLE_INLINE_FILES */
=20
 void
 tls_ctx_load_ca (struct tls_root_ctx *ctx, const char *ca_file,
@@ -764,66 +635,99 @@ tls_ctx_load_ca (struct tls_root_ctx *ctx, const char=
 *ca_file,
     const char *ca_path, bool tls_server
     )
 {
-  int status;
+  STACK_OF(X509_INFO) *info_stack =3D NULL;
+  STACK_OF(X509_NAME) *cert_names =3D NULL;
+  X509_LOOKUP *lookup =3D NULL;
+  X509_STORE *store =3D NULL;
+  X509_NAME *xn =3D NULL;
+  BIO *in =3D NULL;
+  int i, added =3D 0;
=20
   ASSERT(NULL !=3D ctx);
=20
+  store =3D SSL_CTX_get_cert_store(ctx->ctx);
+  if (!store)
+    msg(M_SSLERR, "Cannot get certificate store (SSL_CTX_get_cert_store)");
+
+  /* Try to add certificates and CRLs from ca_file */
+  if (ca_file)
+    {
 #if ENABLE_INLINE_FILES
-  if (ca_file && !strcmp (ca_file, INLINE_FILE_TAG) && ca_file_inline)
-	{
-	  status =3D use_inline_load_verify_locations (ctx->ctx, ca_file_inline);
-	}
-  else
+      if (!strcmp (ca_file, INLINE_FILE_TAG) && ca_file_inline)
+        in =3D BIO_new_mem_buf ((char *)ca_file_inline, -1);
+      else
 #endif
-	{
-	  /* Load CA file for verifying peer supplied certificate */
-	  status =3D SSL_CTX_load_verify_locations (ctx->ctx, ca_file, ca_path);
-	}
+        in =3D BIO_new_file (ca_file, "r");
=20
-  if (!status)
-	msg (M_SSLERR, "Cannot load CA certificate file %s path %s (SSL_CTX_load_=
verify_locations)", np(ca_file), np(ca_path));
+      if (in)
+        info_stack =3D PEM_X509_INFO_read_bio (in, NULL, NULL, NULL);
+
+      if (info_stack)
+        {
+          for (i =3D 0; i < sk_X509_INFO_num (info_stack); i++)
+            {
+              X509_INFO *info =3D sk_X509_INFO_value (info_stack, i);
+              if (info->crl)
+                  X509_STORE_add_crl (store, info->crl);
+
+              if (info->x509)
+                {
+                  X509_STORE_add_cert (store, info->x509);
+                  added++;
+
+                  if (!tls_server)
+                    continue;
+
+                  /* Use names of CAs as a client CA list */
+                  if (cert_names =3D=3D NULL)
+                    {
+                      cert_names =3D sk_X509_NAME_new (sk_x509_name_cmp);
+                      if (!cert_names)
+                        continue;
+                    }
+
+                  xn =3D X509_get_subject_name (info->x509);
+                  if (!xn)
+                    continue;
+
+                  /* Don't add duplicate CA names */
+                  if (sk_X509_NAME_find (cert_names, xn) =3D=3D -1)
+                    {
+                      xn =3D X509_NAME_dup (xn);
+                      if (!xn)
+                        continue;
+                      sk_X509_NAME_push (cert_names, xn);
+                    }
+                }
+            }
+          sk_X509_INFO_pop_free (info_stack, X509_INFO_free);
+        }
+
+      if (tls_server)
+        SSL_CTX_set_client_CA_list (ctx->ctx, cert_names);
+
+      if (!added || (tls_server && sk_X509_NAME_num (cert_names) !=3D adde=
d))
+        msg (M_SSLERR, "Cannot load CA certificate file %s", np(ca_file));
+      if (in)
+        BIO_free (in);
+    }
=20
   /* Set a store for certs (CA & CRL) with a lookup on the "capath" hash d=
irectory */
-  if (ca_path) {
-    X509_STORE *store =3D SSL_CTX_get_cert_store(ctx->ctx);
-
-    if (store)
-	  {
-	    X509_LOOKUP *lookup =3D X509_STORE_add_lookup(store, X509_LOOKUP_hash=
_dir());
-	    if (!X509_LOOKUP_add_dir(lookup, ca_path, X509_FILETYPE_PEM))
-	      X509_LOOKUP_add_dir(lookup, NULL, X509_FILETYPE_DEFAULT);
-	    else
-	      msg(M_WARN, "WARNING: experimental option --capath %s", ca_path);
+  if (ca_path)
+    {
+      lookup =3D X509_STORE_add_lookup (store, X509_LOOKUP_hash_dir ());
+      if (lookup && X509_LOOKUP_add_dir (lookup, ca_path, X509_FILETYPE_PE=
M))
+        msg(M_WARN, "WARNING: experimental option --capath %s", ca_path);
+      else
+        msg(M_SSLERR, "Cannot add lookup at --capath %s", ca_path);
 #if OPENSSL_VERSION_NUMBER >=3D 0x00907000L
-	    X509_STORE_set_flags(store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_C=
HECK_ALL);
+      X509_STORE_set_flags (store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL=
_CHECK_ALL);
 #else
-	    msg(M_WARN, "WARNING: this version of OpenSSL cannot handle CRL files=
 in capath");
-#endif
-	  }
-	else
-      msg(M_SSLERR, "Cannot get certificate store (SSL_CTX_get_cert_store)=
");
-  }
-
-  /* Load names of CAs from file and use it as a client CA list */
-  if (ca_file && tls_server) {
-    STACK_OF(X509_NAME) *cert_names =3D NULL;
-#if ENABLE_INLINE_FILES
-	if (!strcmp (ca_file, INLINE_FILE_TAG) && ca_file_inline)
-	  {
-	    cert_names =3D use_inline_load_client_CA_file (ctx->ctx, ca_file_inli=
ne);
-	  }
-	else
+      msg(M_WARN, "WARNING: this version of OpenSSL cannot handle CRL file=
s in capath");
 #endif
-	  {
-	    cert_names =3D SSL_load_client_CA_file (ca_file);
-	  }
-    if (!cert_names)
-      msg (M_SSLERR, "Cannot load CA certificate file %s (SSL_load_client_=
CA_file)", ca_file);
-    SSL_CTX_set_client_CA_list (ctx->ctx, cert_names);
-  }
+    }
 }
=20
-
 void
 tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, const char *extra_cert=
s_file
 #if ENABLE_INLINE_FILES
@@ -831,31 +735,20 @@ tls_ctx_load_extra_certs (struct tls_root_ctx *ctx, c=
onst char *extra_certs_file
 #endif
     )
 {
-  BIO *bio;
-  X509 *cert;
+  BIO *in;
 #if ENABLE_INLINE_FILES
   if (!strcmp (extra_certs_file, INLINE_FILE_TAG) && extra_certs_file_inli=
ne)
-    {
-      bio =3D BIO_new_mem_buf ((char *)extra_certs_file_inline, -1);
-    }
+    in =3D BIO_new_mem_buf ((char *)extra_certs_file_inline, -1);
   else
 #endif
-    {
-      bio =3D BIO_new(BIO_s_file());
-      if (BIO_read_filename(bio, extra_certs_file) <=3D 0)
-	msg (M_SSLERR, "Cannot load extra-certs file: %s", extra_certs_file);
-    }
-  for (;;)
-    {
-      cert =3D NULL;
-      if (!PEM_read_bio_X509 (bio, &cert, 0, NULL)) /* takes ownership of =
cert */
-	break;
-      if (!cert)
-	msg (M_SSLERR, "Error reading extra-certs certificate");
-      if (SSL_CTX_add_extra_chain_cert(ctx->ctx, cert) !=3D 1)
-	msg (M_SSLERR, "Error adding extra-certs certificate");
-    }
-  BIO_free (bio);
+    in =3D BIO_new_file (extra_certs_file, "r");
+
+  if (in =3D=3D NULL)
+    msg (M_SSLERR, "Cannot load extra-certs file: %s", extra_certs_file);
+  else
+    tls_ctx_add_extra_certs (ctx, in);
+
+  BIO_free (in);
 }
=20
 /* **************************************
diff --git a/ssl_verify.c b/ssl_verify.c
index 37d4982..a7b361f 100644
--- a/ssl_verify.c
+++ b/ssl_verify.c
@@ -545,7 +545,7 @@ verify_check_crl_dir(const char *crl_dir, x509_cert_t *=
cert)
       x509_free_serial(serial);
       return FAILURE;
     }
-  fd =3D open (fn, O_RDONLY);
+  fd =3D openvpn_open (fn, O_RDONLY, 0);
   if (fd >=3D 0)
     {
       msg (D_HANDSHAKE, "VERIFY CRL: certificate serial number %s is revok=
ed", serial);
diff --git a/ssl_verify_openssl.c b/ssl_verify_openssl.c
index b2c01a3..200a570 100644
--- a/ssl_verify_openssl.c
+++ b/ssl_verify_openssl.c
@@ -584,13 +584,9 @@ x509_verify_crl(const char *crl_file, X509 *peer_cert,=
 const char *subject)
   int n,i;
   result_t retval =3D FAILURE;
=20
-  in=3DBIO_new(BIO_s_file());
+  in =3D BIO_new_file (crl_file, "r");
=20
   if (in =3D=3D NULL) {
-    msg (M_ERR, "CRL: BIO err");
-    goto end;
-  }
-  if (BIO_read_filename(in, crl_file) <=3D 0) {
     msg (M_ERR, "CRL: cannot read: %s", crl_file);
     goto end;
   }
diff --git a/status.c b/status.c
index 4bbea28..5f32a83 100644
--- a/status.c
+++ b/status.c
@@ -67,45 +67,27 @@ status_open (const char *filename,
       buf_reset (&so->read_buf);
       event_timeout_clear (&so->et);
       if (filename)
-	{
-	  switch (so->flags)
-	    {
-#ifdef _MSC_VER
+        {
+          switch (so->flags)
+            {
             case STATUS_OUTPUT_WRITE:
-              so->fd =3D open (filename,
-                             O_CREAT | O_TRUNC | O_WRONLY,
-			     _S_IREAD | _S_IWRITE);
+              so->fd =3D openvpn_open (filename,
+                                     O_CREAT | O_TRUNC | O_WRONLY,
+                                     S_IRUSR | S_IWUSR);
               break;
             case STATUS_OUTPUT_READ:
-              so->fd =3D open (filename,
-                             O_RDONLY,
-			     _S_IREAD | _S_IWRITE);
+              so->fd =3D openvpn_open (filename,
+                                     O_RDONLY,
+                                     S_IRUSR | S_IWUSR);
               break;
             case STATUS_OUTPUT_READ|STATUS_OUTPUT_WRITE:
-              so->fd =3D open (filename,
-                             O_CREAT | O_RDWR,
-			     _S_IREAD | _S_IWRITE);
+              so->fd =3D openvpn_open (filename,
+                                     O_CREAT | O_RDWR,
+                                     S_IRUSR | S_IWUSR);
               break;
-#else
-	    case STATUS_OUTPUT_WRITE:
-	      so->fd =3D open (filename,
-			     O_CREAT | O_TRUNC | O_WRONLY,
-			     S_IRUSR | S_IWUSR);
-	      break;
-	    case STATUS_OUTPUT_READ:
-	      so->fd =3D open (filename,
-			     O_RDONLY,
-			     S_IRUSR | S_IWUSR);
-	      break;
-	    case STATUS_OUTPUT_READ|STATUS_OUTPUT_WRITE:
-	      so->fd =3D open (filename,
-			     O_CREAT | O_RDWR,
-			     S_IRUSR | S_IWUSR);
-	      break;
-#endif
-	    default:
-	      ASSERT (0);
-	    }
+            default:
+              ASSERT (0);
+            }
 	  if (so->fd >=3D 0)
 	    {
 	      so->filename =3D string_alloc (filename, NULL);
diff --git a/syshead.h b/syshead.h
index f121114..71d5d00 100644
--- a/syshead.h
+++ b/syshead.h
@@ -356,6 +356,7 @@
 #include <iphlpapi.h>
 #include <ntddndis.h>
 #include <wininet.h>
+#include <shellapi.h>
 /* The following two headers are needed of PF_INET6 */
 #include <winsock2.h>
 #include <ws2tcpip.h>
diff --git a/win32.c b/win32.c
index 2cc8c2a..5b38918 100644
--- a/win32.c
+++ b/win32.c
@@ -931,8 +931,8 @@ env_block (const struct env_set *es)
     return NULL;
 }
=20
-static char *
-cmd_line (const struct argv *a)
+static WCHAR *
+wide_cmd_line (const struct argv *a, struct gc_arena *gc)
 {
   size_t nchars =3D 1;
   size_t maxlen =3D 0;
@@ -952,9 +952,9 @@ cmd_line (const struct argv *a)
 	maxlen =3D len;
     }
=20
-  work =3D (char *) malloc (maxlen + 1);
+  work =3D gc_malloc (maxlen + 1, false, gc);
   check_malloc_return (work);
-  buf =3D alloc_buf (nchars);
+  buf =3D alloc_buf_gc (nchars, gc);
=20
   for (i =3D 0; i < a->argc; ++i)
     {
@@ -969,8 +969,7 @@ cmd_line (const struct argv *a)
 	buf_printf (&buf, "\"%s\"", work);
     }
=20
-  free (work);
-  return BSTR(&buf);
+  return wide_string (BSTR (&buf), gc);
 }
=20
 /*
@@ -988,23 +987,24 @@ openvpn_execve (const struct argv *a, const struct en=
v_set *es, const unsigned i
 	{
 	  if (script_method =3D=3D SM_EXECVE)
 	    {
-	      STARTUPINFO start_info;
+	      struct gc_arena gc =3D gc_new ();
+	      STARTUPINFOW start_info;
 	      PROCESS_INFORMATION proc_info;
=20
 	      char *env =3D env_block (es);
-	      char *cl =3D cmd_line (a);
-	      char *cmd =3D a->argv[0];
+	      WCHAR *cl =3D wide_cmd_line (a, &gc);
+	      WCHAR *cmd =3D wide_string (a->argv[0], &gc);
=20
 	      CLEAR (start_info);
 	      CLEAR (proc_info);
=20
 	      /* fill in STARTUPINFO struct */
-	      GetStartupInfo(&start_info);
+	      GetStartupInfoW(&start_info);
 	      start_info.cb =3D sizeof(start_info);
 	      start_info.dwFlags =3D STARTF_USESHOWWINDOW;
 	      start_info.wShowWindow =3D SW_HIDE;
=20
-	      if (CreateProcess (cmd, cl, NULL, NULL, FALSE, 0, env, NULL, &start=
_info, &proc_info))
+	      if (CreateProcessW (cmd, cl, NULL, NULL, FALSE, 0, env, NULL, &star=
t_info, &proc_info))
 		{
 		  DWORD exit_status =3D 0;
 		  CloseHandle (proc_info.hThread);
@@ -1019,8 +1019,8 @@ openvpn_execve (const struct argv *a, const struct en=
v_set *es, const unsigned i
 		{
 		  msg (M_WARN|M_ERRNO, "openvpn_execve: CreateProcess %s failed", cmd);
 		}
-	      free (cl);
 	      free (env);
+	      gc_free (&gc);
 	    }
 	  else if (script_method =3D=3D SM_SYSTEM)
 	    {
@@ -1045,6 +1045,42 @@ openvpn_execve (const struct argv *a, const struct e=
nv_set *es, const unsigned i
   return ret;
 }
=20
+WCHAR *
+wide_string (const char* utf8, struct gc_arena *gc)
+{
+  int n =3D MultiByteToWideChar (CP_UTF8, 0, utf8, -1, NULL, 0);
+  WCHAR *ucs16 =3D gc_malloc (n * sizeof (WCHAR), false, gc);
+  MultiByteToWideChar (CP_UTF8, 0, utf8, -1, ucs16, n);
+  return ucs16;
+}
+
+FILE *
+openvpn_fopen (const char *path, const char *mode)
+{
+  struct gc_arena gc =3D gc_new ();
+  FILE *f =3D _wfopen (wide_string (path, &gc), wide_string (mode, &gc));
+  gc_free (&gc);
+  return f;
+}
+
+int
+openvpn_open (const char *path, int flags, mode_t mode)
+{
+  struct gc_arena gc =3D gc_new ();
+  int fd =3D _wopen (wide_string (path, &gc), flags, mode);
+  gc_free (&gc);
+  return fd;
+}
+
+int
+openvpn_stat (const char *path, struct stat *buf)
+{
+  struct gc_arena gc =3D gc_new ();
+  int res =3D wstat (wide_string (path, &gc), buf);
+  gc_free (&gc);
+  return res;
+}
+
 /*
  * call ourself in another process
  */
diff --git a/win32.h b/win32.h
index 23c04be..2492e35 100644
--- a/win32.h
+++ b/win32.h
@@ -286,5 +286,8 @@ int openvpn_inet_pton(int af, const char *src, void *ds=
t);
 /* Find temporary directory */
 const char *win_get_tempdir();
=20
+/* Convert a string from UTF-8 to UCS-2 */
+WCHAR *wide_string (const char* utf8, struct gc_arena *gc);
+
 #endif
 #endif
--=20
1.7.8.3


