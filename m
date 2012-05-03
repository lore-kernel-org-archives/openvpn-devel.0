From: David Sommerseth <dazo@...384...>
Date: Thu,  3 May 2012 11:10:40 +0200
Message-Id: <1336036240-23838-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] Remove two unused functions
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

From: David Sommerseth <davids@...1347...>

Both is_persist_option() and is_stateful_restart() functions where never
used anywhere in the code.  Remove them.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/options.c |   16 ----------------
 src/openvpn/options.h |    3 ---
 2 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7769625..c182d12 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1047,22 +1047,6 @@ string_substitute (const char *src, int from, int to, struct gc_arena *gc)
   return ret;
 }
 
-bool
-is_persist_option (const struct options *o)
-{
-  return o->persist_tun
-      || o->persist_key
-      || o->persist_local_ip
-      || o->persist_remote_ip
-    ;
-}
-
-bool
-is_stateful_restart (const struct options *o)
-{
-  return is_persist_option (o) || connection_list_defined (o);
-}
-
 #ifdef ENABLE_SSL
 static uint8_t *
 parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_arena *gc)
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 1be3dfa..cc3e47a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -749,9 +749,6 @@ bool apply_push_options (struct options *options,
 			 unsigned int *option_types_found,
 			 struct env_set *es);
 
-bool is_persist_option (const struct options *o);
-bool is_stateful_restart (const struct options *o);
-
 void options_detach (struct options *o);
 
 void options_server_import (struct options *o,
-- 
1.7.4.4


