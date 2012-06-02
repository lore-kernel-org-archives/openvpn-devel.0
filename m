From: Arne Schwabe <arne@...1227...>
Date: Sat,  2 Jun 2012 15:03:38 +0200
Message-Id: <1338642223-20324-4-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-1-git-send-email-arne@...1227...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/8] Only use tmpdir if tmp_dir is really
	used.
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

This fixes starting openvpn compiled as client only version of systems that have no /tmp (Android). --tmp-dir could only be set if P2MP_SERVER has been enabled too.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c |   12 ++++++++----
 src/openvpn/options.h |    2 ++
 src/openvpn/syshead.h |    1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8e5d3b9..71d43b7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -862,6 +862,7 @@ init_options (struct options *o, const bool init_gc)
   o->pkcs11_pin_cache_period = -1;
 #endif			/* ENABLE_PKCS11 */
 
+#ifdef ENABLE_TMPDIR
   /* Set default --tmp-dir */
 #ifdef WIN32
   /* On Windows, find temp dir via enviroment variables */
@@ -873,6 +874,7 @@ init_options (struct options *o, const bool init_gc)
           o->tmp_dir = "/tmp";
   }
 #endif /* WIN32 */
+#endif /* ENABLE_TMPDIR */
 }
 
 void
@@ -2759,19 +2761,21 @@ options_postprocess_filechecks (struct options *options)
                              options->management_user_pass, R_OK,
                              "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
-#if P2MP
+#if ENABLE_TMPDIR
   errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
                              options->auth_user_pass_file, R_OK,
                              "--auth-user-pass");
-#endif /* P2MP */
+
+  errs |= check_file_access (CHKACC_FILE, options->tmp_dir,
+                             R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
+
+#endif /* ENABLE_TMPDIR */
 
   /* ** System related ** */
   errs |= check_file_access (CHKACC_FILE, options->chroot_dir,
                              R_OK|X_OK, "--chroot directory");
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->writepid,
                              R_OK|W_OK, "--writepid");
-  errs |= check_file_access (CHKACC_FILE, options->tmp_dir,
-                             R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
 
   /* ** Log related ** */
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->status_file,
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index cc3e47a..50d42fb 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -403,7 +403,9 @@ struct options
   struct plugin_option_list *plugin_list;
 #endif
 
+#ifdef ENABLE_TMPDIR
   const char *tmp_dir;
+#endif
 
 #if P2MP
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 3337764..f5c8774 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -506,6 +506,7 @@ socket_defined (const socket_descriptor_t sd)
 
 #if P2MP && !defined(ENABLE_CLIENT_ONLY)
 #define P2MP_SERVER 1
+#define ENABLE_TMPDIR 1
 #else
 #define P2MP_SERVER 0
 #endif
-- 
1.7.7.5 (Apple Git-26)


