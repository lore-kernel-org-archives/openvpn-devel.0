From: Gert Doering <gert@...1296...>
Date: Tue, 28 Apr 2015 13:04:23 +0200
Message-Id: <1430219063-12291-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Print helpful error message on
	--mktun/--rmtun if not available.
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

OpenVPN only supports --mktun/--rmtun to create/destroy persistant
tunnels on Linux.  On BSD OSes, "ifconfig tun0 create" can do the
same job, so we do not actually need to support it - but the previous
error message ("unknown option") wasn't helpful.  So always accept
the option now, and on non-supported systems, direct user to manpage.

Trac #85

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c    | 10 ++++++++--
 src/openvpn/options.c |  2 --
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b97d2da..42cb3e2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -887,7 +887,6 @@ do_genkey (const struct options * options)
 bool
 do_persist_tuntap (const struct options *options)
 {
-#ifdef ENABLE_FEATURE_TUN_PERSIST
   if (options->persist_config)
     {
       /* sanity check on options for --mktun or --rmtun */
@@ -901,14 +900,21 @@ do_persist_tuntap (const struct options *options)
 	)
 	msg (M_FATAL|M_OPTERR,
 	     "options --mktun or --rmtun should only be used together with --dev");
+#ifdef ENABLE_FEATURE_TUN_PERSIST
       tuncfg (options->dev, options->dev_type, options->dev_node,
 	      options->persist_mode,
 	      options->username, options->groupname, &options->tuntap_options);
       if (options->persist_mode && options->lladdr)
         set_lladdr(options->dev, options->lladdr, NULL);
       return true;
-    }
+#else
+      msg( M_FATAL|M_OPTERR,
+	"options --mktun and --rmtun are not available on your operating "
+	"system.  Please check 'man tun' (or 'tap'), whether your system "
+        "supports using 'ifconfig %s create' / 'destroy' to create/remove "
+        "persistant tunnel interfaces.", options->dev );
 #endif
+    }
   return false;
 }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e8cf06a..4f27336 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7023,7 +7023,6 @@ add_option (struct options *options,
       options->pkcs11_id_management = true;
     }
 #endif
-#ifdef ENABLE_FEATURE_TUN_PERSIST
   else if (streq (p[0], "rmtun"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -7036,7 +7035,6 @@ add_option (struct options *options,
       options->persist_config = true;
       options->persist_mode = 1;
     }
-#endif
   else if (streq (p[0], "peer-id"))
     {
       VERIFY_PERMISSION (OPT_P_PEER_ID);
-- 
2.2.2


