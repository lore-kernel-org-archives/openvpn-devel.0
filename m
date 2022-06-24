From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:38:04 +0200
Message-Id: <20220624083809.23487-21-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 20/25] dco-win: add platform dependant check
 on incompatible options
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

Some platforms may have different constraints in terms of incompatible
opions, therefore we add a function that explicitly checks those.

Also, add generic option check for when ovpn-dco-win is in use.

Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/dco.c     | 25 +++++++++++++++++++++++++
 src/openvpn/options.c |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 1612a64e..448f29b5 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -190,6 +190,26 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
     }
 }
 
+static bool
+dco_check_option_conflict_platform(int msglevel, const struct options *o)
+{
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
+#endif
+    return true;
+}
+
 static bool
 dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
 {
@@ -228,6 +248,11 @@ dco_check_option_conflict(int msglevel, const struct options *o)
         return false;
     }
 
+    if (!dco_check_option_conflict_platform(msglevel, o))
+    {
+        return false;
+    }
+
     if (dev_type_enum(o->dev, o->dev_type) != DEV_TYPE_TUN)
     {
         msg(msglevel, "Note: dev-type not tun, disabling data channel offload.");
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7b450296..d9da8b8b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2376,6 +2376,11 @@ options_postprocess_verify_ce(const struct options *options,
     {
         msg(M_USAGE, "--windows-driver wintun requires --dev tun");
     }
+
+    if (options->windows_driver == WINDOWS_DRIVER_WINDCO)
+    {
+        dco_check_option_conflict(M_USAGE, options);
+    }
 #endif /* ifdef _WIN32 */
 
     /*
-- 
2.35.1


