From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Nov 2017 23:03:40 +0100
Message-Id: <20171101220342.14648-3-steffan@...1856...>
In-Reply-To: <20171101220342.14648-1-steffan@...1856...>
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/4 v2] pf: reject client if PF plugin is
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
v3: return immediately after registering signal

 src/openvpn/pf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index e1b5b0e7..6e4107c5 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -638,10 +638,12 @@ pf_init_context(struct context *c)
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
+            return;
         }
     }
 #endif /* ifdef PLUGIN_PF */
-- 
2.14.1


