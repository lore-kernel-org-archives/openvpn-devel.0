From: Kristof Provost <kprovost@...2661...>
Date: Wed, 13 Jul 2022 10:34:04 +0200
Message-Id: <20220713083404.13227-2-kprovost@...2661...>
In-Reply-To: <20220713083404.13227-1-kprovost@...2661...>
References: <20220713083404.13227-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Handle exceeding 'max-clients'
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

If 'max-clients' is set multi_create_instance() can return NULL (for any
client that would take us over the client limit).

If mi is NULL we don't add it to the hash map, but we do potentially
dereference it to increment the session count.
Do not attempt to do so if 'mi == NULL'.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/mudp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 0810fada..0cbca1a9 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -241,15 +241,16 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
                         hash_add_fast(hash, bucket, &mi->real, hv, mi);
                         mi->did_real_hash = true;
                         multi_assign_peer_id(m, mi);
-                    }
-                    /* If we have a session id already, ensure that the
-                     * state is using the same */
-                    if (session_id_defined(&state.server_session_id)
-                        && session_id_defined((&state.peer_session_id)))
-                    {
-                        mi->context.c2.tls_multi->n_sessions++;
-                        struct tls_session *session = &mi->context.c2.tls_multi->session[TM_ACTIVE];
-                        session_skip_to_pre_start(session, &state, &m->top.c2.from);
+
+                        /* If we have a session id already, ensure that the
+                         * state is using the same */
+                        if (session_id_defined(&state.server_session_id)
+                            && session_id_defined((&state.peer_session_id)))
+                        {
+                            mi->context.c2.tls_multi->n_sessions++;
+                            struct tls_session *session = &mi->context.c2.tls_multi->session[TM_ACTIVE];
+                            session_skip_to_pre_start(session, &state, &m->top.c2.from);
+                        }
                     }
                 }
                 else
-- 
2.37.0


