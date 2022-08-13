From: Arne Schwabe <arne@...1227...>
Date: Sat, 13 Aug 2022 23:11:04 +0200
Message-Id: <20220813211104.411554-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Allow querying DCO status via management
 status
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

This is allows querying the DCO status without doing an error-prone
parsing of the startup log.

Also remove comment that serves no purpose anymore.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 53ee3e1a1..95414429f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -837,7 +837,7 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
 
         status_reset(so);
 
-        if (version == 1) /* WAS: m->status_file_version */
+        if (version == 1)
         {
             /*
              * Status file version 1
@@ -984,6 +984,7 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
                               sep, sep, mbuf_maximum_queued(m->mbuf));
             }
 
+            status_printf(so, "GLOBAL_STATS%cdco_enabled%c%d", sep, sep, dco_enabled(&m->top.options));
             status_printf(so, "END");
         }
         else
-- 
2.32.1 (Apple Git-133)


