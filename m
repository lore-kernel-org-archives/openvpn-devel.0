From: selva.nair@...277...
Date: Thu, 20 Feb 2020 22:00:28 -0500
Message-Id: <1582254028-7763-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1521522224-18829-1-git-send-email-selva.nair@...277...>
References: <1521522224-18829-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Persist management-query-remote and
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
v2: bump and rebase to master

 src/openvpn/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1cfffbb..b4781a2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -271,6 +271,7 @@ ce_management_query_proxy(struct context *c)
             buf_printf(&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
                        (proto_is_udp(ce->proto) ? "UDP" : "TCP"), np(ce->remote));
             management_notify_generic(management, BSTR(&out));
+            management->persist.special_state_msg = BSTR(&out);
         }
         ce->flags |= CE_MAN_QUERY_PROXY;
         while (ce->flags & CE_MAN_QUERY_PROXY)
@@ -282,6 +283,7 @@ ce_management_query_proxy(struct context *c)
                 break;
             }
         }
+        management->persist.special_state_msg = NULL;
         gc_free(&gc);
     }
 
@@ -351,6 +353,7 @@ ce_management_query_remote(struct context *c)
         buf_printf(&out, ">REMOTE:%s,%s,%s", np(ce->remote), ce->remote_port,
                    proto2ascii(ce->proto, ce->af, false));
         management_notify_generic(management, BSTR(&out));
+        management->persist.special_state_msg = BSTR(&out);
 
         ce->flags &= ~(CE_MAN_QUERY_REMOTE_MASK << CE_MAN_QUERY_REMOTE_SHIFT);
         ce->flags |= (CE_MAN_QUERY_REMOTE_QUERY << CE_MAN_QUERY_REMOTE_SHIFT);
@@ -364,6 +367,7 @@ ce_management_query_remote(struct context *c)
                 break;
             }
         }
+        management->persist.special_state_msg = NULL;
     }
     gc_free(&gc);
 
-- 
2.1.4


