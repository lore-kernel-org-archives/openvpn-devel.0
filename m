From: Steffan Karger <steffan@...1856...>
Date: Fri, 29 Sep 2017 18:24:58 +0200
Message-Id: <20170929162458.16514-1-steffan@...1856...>
In-Reply-To: <cda9d511-43b5-cc6f-ead0-017f0f869e61@...2181...>
References: <cda9d511-43b5-cc6f-ead0-017f0f869e61@...2181...>
Subject: [Openvpn-devel] [PATCH 0/2] Reject client if PF plugin is
 configured, but init fails
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

This changes the behavior for pf plugins: instead of just not initializing
the firewall rules and happily continuing, this now rejects the client in
the case of an (unlikely) failure to initialize the pf.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/pf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 5cb002bf..29231b67 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -639,10 +639,11 @@ pf_init_context(struct context *c)
                 }
 #endif
             }
-            else
-            {
-                msg(M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled");
-            }
+        }
+        if (!c->c2.pf.enabled)
+        {
+            msg(M_WARN, "WARNING: failed to init PF plugin, rejecting client.");
+            register_signal(c, SIGUSR1, "plugin-pf-init-failed");
         }
     }
 #endif /* ifdef PLUGIN_PF */
-- 
2.11.0


