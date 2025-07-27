From: Gert Doering <gert@...1296...>
Date: Sun, 27 Jul 2025 12:24:15 +0200
Message-ID: <20250727102420.25284-1-gert@...1296...>
In-Reply-To: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
References: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco: drop client prefix after DCO
 PEER_FLOAT notification
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

multi_process_float() will possibly float a client and
also generate and set its new prefix.

However, after processing the PEER_FLOAT_NTF message, we
were not clearing the prefix, thus effectivly making
the generated prefix permanent until the next set_prefix()
call.

Clear the prefix right after calling multi_process_float()
to avoid printing messages with the wrong prefix.

Github: closes OpenVPN/openvpn#799
Change-Id: I1ad5df0f6785ffe9becd9f83329a9335d1a36f24
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1116
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c90ed5b..44210cb 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3417,6 +3417,10 @@
                                         &m->top.c2.from.dest,
                                         (struct sockaddr *)&dco->dco_float_peer_ss);
             multi_process_float(m, mi, mi->context.c2.link_sockets[0]);
+            /* multi_process_float() generated and set a new peer prefix, but we
+             * don't to keep it at this point.
+             */
+            clear_prefix();
             CLEAR(dco->dco_float_peer_ss);
         }
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_WIN32) */

