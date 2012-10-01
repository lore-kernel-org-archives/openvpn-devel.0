MIME-Version: 1.0
Date: Mon, 1 Oct 2012 14:47:02 -0400
Message-ID: <CAAUdgR8VZjaO0-thFPVoQkbZ1DNG3rx+gtYYLqyfocp3yns==w@...278...>
From: Kenneth Rose <ken+openvpn@...1776...>
Subject: [Openvpn-devel] [PATCH] Fix v3 plugins to support returning values
	back to OpenVPN.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

There's a small implementation issue with the V3 plugin API
implementation.  V3 plugins cannot return data back to OpenVPN using
openvpn_plugin_args_func_return since
openvpn_plugin_args_func_return.return_list is always NULL.

This patch makes the behaviour identical to the V2 API (return_list is
again a proper out parameter).

Signed-off-by: Kenneth Rose <ken+openvpn@...1776...>
---
 src/openvpn/plugin.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index d785dae..944d833 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -376,10 +376,10 @@ plugin_open_item (struct plugin *p,
         struct openvpn_plugin_args_open_return retargs;

         CLEAR(retargs);
+        retargs.return_list = retlist;
         if ((*p->open3)(OPENVPN_PLUGINv3_STRUCTVER, &args, &retargs)
== OPENVPN_PLUGIN_FUNC_SUCCESS) {
           p->plugin_type_mask = retargs.type_mask;
           p->plugin_handle = retargs.handle;
-          retlist = retargs.return_list;
         } else {
           p->plugin_handle = NULL;
         }
@@ -458,8 +458,8 @@ plugin_call_item (const struct plugin *p,
         struct openvpn_plugin_args_func_return retargs;

         CLEAR(retargs);
+        retargs.return_list = retlist;
         status = (*p->func3)(OPENVPN_PLUGINv3_STRUCTVER, &args, &retargs);
-        retlist = retargs.return_list;
       } else if (p->func2)
 	status = (*p->func2)(p->plugin_handle, type, (const char **)a.argv,
envp, per_client_context, retlist);
       else if (p->func1)
-- 
1.7.4.4

