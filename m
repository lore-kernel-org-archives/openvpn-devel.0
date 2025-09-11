From: Gert Doering <gert@...1296...>
Date: Thu, 11 Sep 2025 22:12:16 +0200
Message-ID: <20250911201222.25382-1-gert@...1296...>
In-Reply-To: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
References: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dco: add standard mi prefix handling to
 multi_process_incoming_dco()
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

From: Antonio Quartulli <antonio@...2726...>

Our code generally expects functions that deal with a multi instance
to set up a log prefix at the beginning with set_prefix(mi) and clear
it at the end with clear_prefix().

Add the calls to multi_process_incoming_dco() in a similar way to
what is done for multi_process_incoming_link() - handling "link
events" and "dco events" the same, with correct prefix in the
function and no leftover prefix afterwards.

Github: closes OpenVPN/openvpn#799
Change-Id: I1ad5df0f6785ffe9becd9f83329a9335d1a36f24
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1116
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 85975ff..40c7f8f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3294,6 +3294,7 @@
     if ((peer_id < m->max_clients) && (m->instances[peer_id]))
     {
         mi = m->instances[peer_id];
+        set_prefix(mi);
         if (dco->dco_message_type == OVPN_CMD_DEL_PEER)
         {
             process_incoming_del_peer(m, mi, dco);
@@ -3311,6 +3312,7 @@
         {
             tls_session_soft_reset(mi->context.c2.tls_multi);
         }
+        clear_prefix();
     }
     else
     {

