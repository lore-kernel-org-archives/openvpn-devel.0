From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:34 +0300
Message-Id: <1336850389-23719-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 01/16] cleanup: syshead: remove
	OS_SPECIFIC_DIRSEP in favor of autoconf PATH_SEPARATOR
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/misc.c       |    6 +-----
 src/openvpn/ssl_verify.c |    2 +-
 src/openvpn/syshead.h    |    9 ---------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 2ded9bf..3dd2aa2 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1070,13 +1070,9 @@ gen_path (const char *directory, const char *filename, struct gc_arena *gc)
     {
       const size_t outsize = strlen(safe_filename) + (directory ? strlen (directory) : 0) + 16;
       struct buffer out = alloc_buf_gc (outsize, gc);
-      char dirsep[2];
-
-      dirsep[0] = OS_SPECIFIC_DIRSEP;
-      dirsep[1] = '\0';
 
       if (directory)
-	buf_printf (&out, "%s%s", directory, dirsep);
+	buf_printf (&out, "%s%c", directory, PATH_SEPARATOR);
       buf_printf (&out, "%s", safe_filename);
 
       return BSTR (&out);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 30fb05d..ad46c13 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -545,7 +545,7 @@ verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
 
   char *serial = x509_get_serial(cert, &gc);
 
-  if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, OS_SPECIFIC_DIRSEP, serial))
+  if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, serial))
     {
       msg (D_HANDSHAKE, "VERIFY CRL: filename overflow");
       goto cleanup;
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 3337764..c5dbac6 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -446,15 +446,6 @@
 #endif
 
 /*
- * Directory separation char
- */
-#ifdef WIN32
-#define OS_SPECIFIC_DIRSEP '\\'
-#else
-#define OS_SPECIFIC_DIRSEP '/'
-#endif
-
-/*
  * Define a boolean value based
  * on Win32 status.
  */
-- 
1.7.3.4


