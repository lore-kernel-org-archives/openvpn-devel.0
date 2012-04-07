From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat,  7 Apr 2012 20:40:40 +0300
Message-Id: <1333820440-9573-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] cleanup: plugin: support C++ plugin
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 include/openvpn-plugin.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
index f82f61f..1c80eec 100644
--- a/include/openvpn-plugin.h
+++ b/include/openvpn-plugin.h
@@ -43,6 +43,10 @@ typedef X509 openvpn_x509_cert_t;
 #endif
 #endif
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 /*
  * Plug-in types.  These types correspond to the set of script callbacks
  * supported by OpenVPN.
@@ -724,4 +728,8 @@ OPENVPN_PLUGIN_DEF openvpn_plugin_handle_t OPENVPN_PLUGIN_FUNC(openvpn_plugin_op
 OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v1)
      (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[]);
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif /* OPENVPN_PLUGIN_H_ */
-- 
1.7.3.4


