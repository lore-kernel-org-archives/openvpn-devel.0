From: Antonio Quartulli <a@...2181...>
Date: Sat,  1 May 2021 15:06:40 +0200
Message-Id: <20210501130640.9330-4-a@...2181...>
In-Reply-To: <20210501130640.9330-1-a@...2181...>
References: <20210501130640.9330-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] windows: list all enum values in switch
 block
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

A switch block in interactive.c is missing the _undo_type_max value
of the neum set, thus triggering a compiler warning.

Due to the logic, this value cannot really be assigned to the variable
being examinated, however, add the missing enum value to silence
the warning.

Fixes:

interactive.c: In function ‘Undo’:
interactive.c:1561:13: warning: enumeration value ‘_undo_type_max’ not handled in switch [-Wswitch]
 1561 |             switch (type)
      |             ^~~~~~

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpnserv/interactive.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ed83d2a3..efd0bc4f 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1594,6 +1594,9 @@ Undo(undo_lists_t *lists)
                                              interface_data->metric_v6);
                     }
                     break;
+                case _undo_type_max:
+                    /* unreachable */
+                    break;
             }
 
             /* Remove from the list and free memory */
-- 
2.26.3


