MIME-Version: 1.0
From: Daniel Kaldor <daniel@...2518...>
Date: Wed, 3 Jul 2019 15:50:41 +0100
Message-ID: <CAL3L06F7YvNHSFxWXrMFZf_8fSjmCH-RkMn1GXmLu7cW-G1=nw@...278...>
Subject: [Openvpn-devel] [PATCH 1/1] Exit management interface loop early on
 receiving 'remote MOD' message.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

OpenVPN using management interface and running with
'management-query-remote' in the config will wait for a 'remote MOD'
or 'remote ACCEPT' message before continuing with connection.

Logs indicate that this stage of the connection process currently
takes ~1s to complete.
This seems to be because the management interface polling loop is
being run once unnecessarily after receiving 'remote MOD' message, and
is only exiting after 1s timeout is reached on final polling loop.

This change exits the polling loop early, immediately after receiving
'remote MOD' message and removes 1s delay in connection.


---
 src/openvpn/manage.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2d86dad..7343e8b 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3348,7 +3348,13 @@ management_event_loop_n_seconds(struct
management *man, int sec)
         /* run command processing event loop */
         do
         {
-            man_standalone_event_loop(man, &signal_received, expire);
+            int status = -1;
+
+            status = man_standalone_event_loop(man, &signal_received, expire);
+            if (status > 0)
+            {
+                return;
+            }
             if (!signal_received)
             {
                 man_check_for_signals(&signal_received);
--
2.9.3 (Apple Git-75)

