From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 19 Jul 2024 15:10:16 +0200
Message-Id: <20240719131016.75042-1-frank@...2641...>
In-Reply-To: <gerrit.1709564073000.Icfc179490d6821e22d14817941fb0bad667c713f@...2715...>
References: <gerrit.1709564073000.Icfc179490d6821e22d14817941fb0bad667c713f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Avoid SIGUSR1 to SIGHUP when the
 configuration is read from stdin
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

From: Arne Schwabe <arne@...1227...>

If the configuration is read from stdin, we cannot reread the configuration
as stdin provides the configuration only once. So whenever we hit the
"close_context usr1 to hup" logic, the OpenVPN process will fail as tries
to restart with an empty configuration.

While OpenVPN tries to block  USR1 from normal unix signal, I have observed
cases in my app which sends USR1 from management interface where the
CC_HARD_USR1_TO_HUP logic is trigger and breaking the OpenVPN process.

Change-Id: Icfc179490d6821e22d14817941fb0bad667c713f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/533
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 0e85ebc..a55dde6 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -32,6 +32,7 @@
 #include "multi.h"
 #include "win32.h"
 #include "platform.h"
+#include "string.h"
 
 #include "memdbg.h"
 
@@ -60,9 +61,10 @@
 
     /* set point-to-point mode */
     c->mode = CM_P2P;
-
-    /* initialize tunnel instance */
-    init_instance_handle_signals(c, c->es, CC_HARD_USR1_TO_HUP);
+    /* initialize tunnel instance, avoid SIGHUP when config is stdin since
+     * reading the config from stdin will not work */
+    bool stdin_config = c->options.config && (strcmp(c->options.config, "stdin") == 0);
+    init_instance_handle_signals(c, c->es, stdin_config ? 0 : CC_HARD_USR1_TO_HUP);
     if (IS_SIG(c))
     {
         return;

