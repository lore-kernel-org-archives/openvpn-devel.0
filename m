From: selva.nair@...277...
Date: Tue, 20 Mar 2018 01:03:43 -0400
Message-Id: <1521522224-18829-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] Persist management-query-remote and
 proxy prompts
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

Currently this prompt is only output once, not re-written to the
management interface when the management client connects. It is thus
not seen by a client that connects after the prompt is output or one that
disconnects and reconnects. This leads to a deadlock: the daemon waiting
for the "remote" command from the client, the latter not aware of it.

Resolve by adding the ">REMOTE" and ">PROXY" prompt to
man.persist.special_state_msg as done for other persisted prompts such
as ">PASSWORD"

Signed-off-by: Selva Nair <selva.nair@...277...>
---
This is a bug fix so could go into 2.4 and master.

 src/openvpn/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 36c1a4c..413563a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -269,6 +269,7 @@ ce_management_query_proxy(struct context *c)
             buf_printf(&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
                        (proto_is_udp(ce->proto) ? "UDP" : "TCP"), np(ce->remote));
             management_notify_generic(management, BSTR(&out));
+            management->persist.special_state_msg = BSTR(&out);
         }
         ce->flags |= CE_MAN_QUERY_PROXY;
         while (ce->flags & CE_MAN_QUERY_PROXY)
@@ -280,6 +281,7 @@ ce_management_query_proxy(struct context *c)
                 break;
             }
         }
+        management->persist.special_state_msg = NULL;
         gc_free(&gc);
     }
 
@@ -349,6 +351,7 @@ ce_management_query_remote(struct context *c)
         buf_printf(&out, ">REMOTE:%s,%s,%s", np(ce->remote), ce->remote_port,
                    proto2ascii(ce->proto, ce->af, false));
         management_notify_generic(management, BSTR(&out));
+        management->persist.special_state_msg = BSTR(&out);
 
         ce->flags &= ~(CE_MAN_QUERY_REMOTE_MASK << CE_MAN_QUERY_REMOTE_SHIFT);
         ce->flags |= (CE_MAN_QUERY_REMOTE_QUERY << CE_MAN_QUERY_REMOTE_SHIFT);
@@ -362,6 +365,7 @@ ce_management_query_remote(struct context *c)
                 break;
             }
         }
+        management->persist.special_state_msg = NULL;
     }
     gc_free(&gc);
 
-- 
2.6.2


