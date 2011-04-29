From: David Sommerseth <davids@...1347...>
Date: Fri, 29 Apr 2011 13:34:13 +0200
Message-Id: <1304076853-17601-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Fix const declarations in plug-in v3 structs
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
Cc: David Sommerseth <davids@...1347...>

Microsoft Visual Studio complains about const char const **ptr declarations
and expects them to be be const char ** const ptr.  The latter is what was the
intention, that neither the pointer nor the value(s) it points at can be changed.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 openvpn-plugin.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/openvpn-plugin.h b/openvpn-plugin.h
index 5c82daf..24aa36c 100644
--- a/openvpn-plugin.h
+++ b/openvpn-plugin.h
@@ -203,8 +203,8 @@ struct openvpn_plugin_string_list
 struct openvpn_plugin_args_open_in
 {
   const int type_mask;
-  const char const **argv;
-  const char const **envp;
+  const char ** const argv;
+  const char ** const envp;
 };
 
 
@@ -267,8 +267,8 @@ struct openvpn_plugin_args_open_return
 struct openvpn_plugin_args_func_in
 {
   const int type;
-  const char const **argv;
-  const char const **envp;
+  const char ** const argv;
+  const char ** const envp;
   openvpn_plugin_handle_t handle;
   void *per_client_context;
   int current_cert_depth;
-- 
1.7.4.4


