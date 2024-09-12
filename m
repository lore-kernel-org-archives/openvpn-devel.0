From: Gert Doering <gert@...1296...>
Date: Thu, 12 Sep 2024 18:53:39 +0200
Message-ID: <20240912165339.21058-1-gert@...1296...>
In-Reply-To: <gerrit.1726132028000.Ife50e37cd49d55ec81a70319a524ffeaf0625a56@...2715...>
References: <gerrit.1726132028000.Ife50e37cd49d55ec81a70319a524ffeaf0625a56@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco: mark peer as deleted from kernel
 after receiving CMD_DEL_PEER notification
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

some extra DCO calls may be made after receiving the DEL_PEER
notification (i.e. due to timeout), but this will result in
an error message due to the peer having disappeared already.

An extra call might be, for example, an explicit DEL_PEER
in the attempt of cleaning the peer state.

For this reason, inform userspace that there is no peer in
kernel anymore and prevent errors which may result confusing.

Change-Id: Ife50e37cd49d55ec81a70319a524ffeaf0625a56
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/744
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 40b7cc4..374ba47 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1256,6 +1256,8 @@
     switch (dco->dco_message_type)
     {
         case OVPN_CMD_DEL_PEER:
+            /* peer is gone, unset ID to prevent more kernel calls */
+            c->c2.tls_multi->dco_peer_id = -1;
             if (dco->dco_del_peer_reason == OVPN_DEL_PEER_REASON_EXPIRED)
             {
                 msg(D_DCO_DEBUG, "%s: received peer expired notification of for peer-id "

