From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:46 +0200
Message-Id: <20220624083809.23487-3-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 02/25] dco: add helper function to detect if
 DCO is enabled or not
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.h | 20 ++++++++++++++++++++
 src/openvpn/tun.h     |  1 +
 2 files changed, 21 insertions(+)

diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c2937dc3..8152e755 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -879,4 +879,24 @@ void options_string_import(struct options *options,
 
 bool key_is_external(const struct options *options);
 
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+
+/**
+ * Returns whether the current configuration has dco enabled.
+ */
+static inline bool
+dco_enabled(const struct options *o)
+{
+    return !o->tuntap_options.disable_dco;
+}
+
+#else /* if defined(ENABLE_DCO) && defined(TARGET_LINUX) */
+
+static inline bool
+dco_enabled(const struct options *o)
+{
+    return false;
+}
+
+#endif
 #endif /* ifndef OPTIONS_H */
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 60cd574d..5fcea590 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -139,6 +139,7 @@ struct tuntap_options {
 
 struct tuntap_options {
     int txqueuelen;
+    bool disable_dco;
 };
 
 #else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
-- 
2.35.1


