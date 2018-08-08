From: selva.nair@...277...
Date: Tue,  7 Aug 2018 22:44:30 -0400
Message-Id: <1533696271-21799-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] Bump version of openvpn plugin argument
 structs to 5
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

From: Selva Nair <selva.nair@...277...>

This was missed in commit 6690769f78bbfb889fef2a54088d979896c87d51
that exported base64_encode and base64_decode() functions.

Also check the version is >= 5 in auth-pam plugin to ensure
that the base64_decode function pointer can be referenced.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 include/openvpn-plugin.h.in     | 5 +++--
 src/plugins/auth-pam/auth-pam.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 5b64cbb..103844f 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -219,10 +219,11 @@ struct openvpn_plugin_string_list
  *           OpenVPN to plug-ins.
  *
  *    4      Exported secure_memzero() as plugin_secure_memzero()
- *           Exported openvpn_base64_encode() as plugin_base64_encode()
+ *
+ *    5      Exported openvpn_base64_encode() as plugin_base64_encode()
  *           Exported openvpn_base64_decode() as plugin_base64_decode()
  */
-#define OPENVPN_PLUGINv3_STRUCTVER 4
+#define OPENVPN_PLUGINv3_STRUCTVER 5
 
 /**
  * Definitions needed for the plug-in callback functions.
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 3d564a9..1324307 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -356,8 +356,8 @@ openvpn_plugin_open_v3(const int v3structver,
     const char **argv = args->argv;
     const char **envp = args->envp;
 
-    /* Check API compatibility -- struct version 4 or higher needed */
-    if (v3structver < 4)
+    /* Check API compatibility -- struct version 5 or higher needed */
+    if (v3structver < 5)
     {
         fprintf(stderr, "AUTH-PAM: This plugin is incompatible with the running version of OpenVPN\n");
         return OPENVPN_PLUGIN_FUNC_ERROR;
-- 
2.6.2


