From: selva.nair@...277...
Date: Wed, 27 Jul 2022 23:45:07 -0400
Message-Id: <20220728034508.15180-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Do not skip ERROR:/SUCCESS: response
 from management interface
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

Generally we expect a response of SUCCESS: or ERROR: to every
command sent to the management interface. But, while in
the management-hold state, sending "signal foo" returns only
the following reply (with foo = SIGHUP, SIGUSR1 etc.):

>HOLD:Waiting for hold release:0

Fix by always responding

ERROR: signal 'foo' is currently ignored"
followed by the above line.

Though this is seldom seen in practice[*], such violation of the
protocol could stall clients like the GUI. So fix it.

[*] One way this happens is with SIGHUP sent before the daemon
is on hold state which it enters before the SIGHUP is received.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/manage.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5d58c662..27aa49a8 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -426,14 +426,11 @@ man_signal(struct management *man, const char *name)
         }
         else
         {
+            msg(M_CLIENT, "ERROR: signal '%s' is currently ignored", name);
             if (man->persist.special_state_msg)
             {
                 msg(M_CLIENT, "%s", man->persist.special_state_msg);
             }
-            else
-            {
-                msg(M_CLIENT, "ERROR: signal '%s' is currently ignored", name);
-            }
         }
     }
     else
-- 
2.30.2


