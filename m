From: Antonio Quartulli <a@...2181...>
Date: Sat, 13 Aug 2022 22:42:19 +0200
Message-Id: <20220813204224.22576-2-a@...2181...>
In-Reply-To: <20220813204224.22576-1-a@...2181...>
References: <20220813204224.22576-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v101 2/7] dco-win: check for incompatible
 options
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
Cc: Antonio Quartulli <a@...2181...>, Lev Stipakov <lev@...515...>

At the moment dco-win doesn't support --persist-tun and --server,
so check for these options at startup time.

Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Lev Stipakov <lev@...515...>
---
Changes from v100:
* improved commit title/message
---
 src/openvpn/dco.c     | 17 +++++++++++++++--
 src/openvpn/options.c |  5 +++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index b342bee1..dcb570f9 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -221,7 +221,20 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
 static bool
 dco_check_option_conflict_platform(int msglevel, const struct options *o)
 {
-#if defined(TARGET_LINUX)
+#if defined(_WIN32)
+    if (o->mode == MODE_SERVER)
+    {
+        msg(msglevel, "Only client and p2p data channel offload is supported "
+            "with ovpn-dco-win.");
+        return false;
+    }
+
+    if (o->persist_tun)
+    {
+        msg(msglevel, "--persist-tun is not supported with ovpn-dco-win.");
+        return false;
+    }
+#elif defined(TARGET_LINUX)
     /* if the device name is fixed, we need to check if an interface with this
      * name already exists. IF it does, it must be a DCO interface, otherwise
      * DCO has to be disabled in order to continue.
@@ -246,7 +259,7 @@ dco_check_option_conflict_platform(int msglevel, const struct options *o)
                 strerror(-ret), ret);
         }
     }
-#endif /* if defined(TARGET_LINUX) */
+#endif /* if defined(_WIN32) */
     return true;
 }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 14cb4cc4..cec6cf10 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2450,6 +2450,11 @@ options_postprocess_verify_ce(const struct options *options,
     {
         msg(M_USAGE, "--windows-driver wintun requires --dev tun");
     }
+
+    if (options->windows_driver == WINDOWS_DRIVER_DCO)
+    {
+        dco_check_option_conflict(M_USAGE, options);
+    }
 #endif /* ifdef _WIN32 */
 
     /*
-- 
2.35.1


