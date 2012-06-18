From: Arne Schwabe <arne@...1227...>
Date: Mon, 18 Jun 2012 20:39:04 +0200
Message-Id: <1340044749-10694-2-git-send-email-arne@...1227...>
In-Reply-To: <1340044749-10694-1-git-send-email-arne@...1227...>
References: <1340044749-10694-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/6] Only use tmpdir if tmp_dir is really
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
 src/openvpn/options.c |    7 +++++--
 src/openvpn/options.h |    4 +++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1cb6068..5d6ff85 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -858,6 +858,8 @@ init_options (struct options *o, const bool init_gc)
   o->pkcs11_pin_cache_period = -1;
 #endif			/* ENABLE_PKCS11 */
 
+/* tmp is only used in P2MP server context */    
+#if P2MP_SERVER
   /* Set default --tmp-dir */
 #ifdef WIN32
   /* On Windows, find temp dir via enviroment variables */
@@ -869,6 +871,7 @@ init_options (struct options *o, const bool init_gc)
           o->tmp_dir = "/tmp";
   }
 #endif /* WIN32 */
+#endif /* P2MP_SERVER */
 }
 
 void
@@ -2766,8 +2769,6 @@ options_postprocess_filechecks (struct options *options)
                              R_OK|X_OK, "--chroot directory");
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->writepid,
                              R_OK|W_OK, "--writepid");
-  errs |= check_file_access (CHKACC_FILE, options->tmp_dir,
-                             R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
 
   /* ** Log related ** */
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->status_file,
@@ -2781,6 +2782,8 @@ options_postprocess_filechecks (struct options *options)
 #if P2MP_SERVER
   errs |= check_file_access (CHKACC_FILE, options->client_config_dir,
                              R_OK|X_OK, "--client-config-dir");
+  errs |= check_file_access (CHKACC_FILE, options->tmp_dir,
+                             R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
 
   /* ** Script hooks that accept an optionally quoted and/or escaped executable path, ** */
   /* ** optionally followed by arguments ** */
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9b6adea..ee0c69d 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -399,11 +399,13 @@ struct options
   struct plugin_option_list *plugin_list;
 #endif
 
-  const char *tmp_dir;
+
 
 #if P2MP
 
 #if P2MP_SERVER
+  /* the tmp dir is for now only used in the P2P server context */
+  const char *tmp_dir;
   bool server_defined;
   in_addr_t server_network;
   in_addr_t server_netmask;
-- 
1.7.7.5 (Apple Git-26)


