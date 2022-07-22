From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Jul 2022 15:46:52 +0200
Message-Id: <20220722134652.2446598-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix segfault when no --config argument is
 given
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

Commit 4df5003 introduced a check against options->config but
did not ensure that this varialbe is non-null.
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b9de2e5d0..a68a2991f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3680,7 +3680,7 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
         o->verify_hash_no_ca = true;
     }
 
-    if (streq(o->config, "stdin") && o->remap_sigusr1 == SIGHUP)
+    if (o->config && streq(o->config, "stdin") && o->remap_sigusr1 == SIGHUP)
     {
         msg(M_USAGE, "Options 'config stdin' and 'remap-usr1 SIGHUP' are "
             "incompatible with each other.");
-- 
2.32.1 (Apple Git-133)


