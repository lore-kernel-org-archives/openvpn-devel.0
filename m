From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Jul 2022 14:51:22 +0200
Message-Id: <20220722125122.2441814-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Error out if both remap-usr1 SIGHUP and
 config stdin are used
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

OpenVPN for Android uses config stdin to avoid writing the config
file containing private keys to 'disk'. However using stdin means
that config cannot be reread using SIGHUP. While there might be other
corner cases that trigger SIGHUP, this is an obvious one, so we
error out if we detect this misconfiguration.
---
 src/openvpn/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index abda8c379..e56df7d4c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3680,6 +3680,12 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
         o->verify_hash_no_ca = true;
     }
 
+    if (streq(o->config, "stdin") && o->remap_sigusr1 == SIGHUP)
+    {
+        MSG(M_USAGE, "Options 'config stdin' and 'remap-sigusr SIGHUP' are"
+                     "incompatible with each other.");
+    }
+
     /* check if any option should force disabling DCO */
 #if defined(TARGET_LINUX)
     o->tuntap_options.disable_dco = !dco_check_option_conflict(D_DCO, o);
-- 
2.32.1 (Apple Git-133)


