From: Gert Doering <gert@...1296...>
Date: Wed, 15 Nov 2023 11:33:31 +0100
Message-ID: <20231115103331.18050-1-gert@...1296...>
In-Reply-To: <gerrit.1699712500000.I226a73d47a2b1b29f7ec175ce23a806593abc2ac@...2715...>
References: <gerrit.1699712500000.I226a73d47a2b1b29f7ec175ce23a806593abc2ac@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Do not check key_state buffers that are
 in S_UNDEF state
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

When a key_state is in S_UNDEF the send_reliable is not initialised. So
checking it might access invalid memory or null pointers.

Github: fixes OpenVPN/openvpn#449

Change-Id: I226a73d47a2b1b29f7ec175ce23a806593abc2ac
[a@...2181...: add check for !send_reliable and message]
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/426
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cee4afe..b4cd8f5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3189,6 +3189,22 @@
     for (int i = 0; i < KS_SIZE; i++)
     {
         struct key_state *ks = &session->key[i];
+        if (ks->state == S_UNDEF)
+        {
+            continue;
+        }
+
+        /* we don't expect send_reliable to be NULL when state is
+         * not S_UNDEF, but people have reported crashes nonetheless,
+         * therefore we better catch this event, report and exit.
+         */
+        if (!ks->send_reliable)
+        {
+            msg(M_FATAL, "ERROR: session->key[%d]->send_reliable is NULL "
+                "while key state is %s. Exiting.",
+                i, state_name(ks->state));
+        }
+
         for (int j = 0; j < ks->send_reliable->size; j++)
         {
             if (ks->send_reliable->array[i].buf.data == dataptr)

