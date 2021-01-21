From: Gert Doering <gert@...1296...>
Date: Thu, 21 Jan 2021 14:39:29 +0100
Message-Id: <20210121133929.20186-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Make OPENVPN_PLUGIN_ENABLE_PF failures FATAL
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

Without this patch, if openpn is using a plugin that provides
OPENVPN_PLUGIN_ENABLE_PF but then fails (returns OPENVPN_PLUGIN_FUNC_ERROR),
OpenVPN will crash on a NULL pointer reference.

The underlying cause is (likely) the refactoring work regarding
CAS_SUCCEEDED etc., and that nobody adjusted the pf.c code accordingly
(it tries to sent itself a SIGUSR1, which tries to tear down the
client MI instance, but since it is not fully set up yet at this
point, things explode).  Full details on the call chain in Trac...

Since we intend to remove pf in 2.6, but we still do not want OpenVPN
to ever SIGSEGV, change the requirements for the plugins to "MUST SUCCEED",
so if the plugin ENABLE_PF call fails, abort openvpn with a M_FATAL
message.

Trac: #1377

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/pf.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index f9bbfb50..3f472ef4 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -639,8 +639,17 @@ pf_init_context(struct context *c)
         }
         if (!c->c2.pf.enabled)
         {
-            msg(M_WARN, "WARNING: failed to init PF plugin, rejecting client.");
-            register_signal(c, SIGUSR1, "plugin-pf-init-failed");
+            /* At some point in openvpn history, this code just printed a
+             * warning and signalled itself (SIGUSR1, "plugin-pf-init-failed")
+             * to terminate the client instance.  This got broken at one of
+             * the client auth state refactorings (leading to SIGSEGV crashes)
+             * and due to "pf will be removed anyway" reasons the easiest way
+             * to prevent crashes is to REQUIRE that plugins succeed - so if
+             * the plugin fails, we cleanly abort OpenVPN
+             *
+             * see also: https://community.openvpn.net/openvpn/ticket/1377
+             */
+            msg(M_FATAL, "FATAL: failed to init PF plugin, must succeed.");
             return;
         }
     }
-- 
2.26.2


