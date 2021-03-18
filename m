From: Maximilian Fillinger <maximilian.fillinger@...1435...>
Date: Thu, 18 Mar 2021 19:27:30 +0000
Message-ID: <AM0PR04MB53313168AE080837CBFD8ECDB1699@...2601...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] reliable: retransmit if 3 follow-up ACKs
 are received
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi!

I'm currently preparing the OpenVPN-NL 2.5 release at Fox-IT. (We're a
bit behind the times...) I thought that one of our patches, by Steffan
Karger, could be useful in regular OpenVPN. He said that he hadn't
submitted it yet, and thought it would be a good idea to ask.

The patch increases the performance of the control channel when there is
a small amount of packet loss by resending packets more aggressively. In
reliable_send, packets are resent before the timeout expires if at least
3 later packets have been ACK'd.

The reasoning is that if we receive ACKs for later packets, the
connection seems to be functional and we should be able to try again.

This policy is similar to many TCP implementations.

Please let me know if you think this is useful, and if you would like me
to make any changes to the patch.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/reliable.c | 14 +++++++++++---
 src/openvpn/reliable.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 6c1f2da1..04d053bd 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -41,6 +41,8 @@
=20
 #include "memdbg.h"
=20
+#define N_ACK_RETRANSMIT 3
+
 /*
  * verify that test - base < extent while allowing for base or test wrapar=
ound
  */
@@ -382,7 +384,10 @@ reliable_send_purge(struct reliable *rel, const struct=
 reliable_ack *ack)
                 }
 #endif
                 e->active =3D false;
-                break;
+            }
+            else if (e->active && e->packet_id < pid)
+            {
+                e->n_acks++;
             }
         }
     }
@@ -555,7 +560,7 @@ reliable_can_send(const struct reliable *rel)
         if (e->active)
         {
             ++n_active;
-            if (now >=3D e->next_try)
+            if (now >=3D e->next_try || e->n_acks >=3D N_ACK_RETRANSMIT)
             {
                 ++n_current;
             }
@@ -581,7 +586,8 @@ reliable_send(struct reliable *rel, int *opcode)
     for (i =3D 0; i < rel->size; ++i)
     {
         struct reliable_entry *e =3D &rel->array[i];
-        if (e->active && local_now >=3D e->next_try)
+        if (e->active
+            && (e->n_acks >=3D N_ACK_RETRANSMIT || local_now >=3D e->next_=
try))
         {
             if (!best || reliable_pid_min(e->packet_id, best->packet_id))
             {
@@ -599,6 +605,7 @@ reliable_send(struct reliable *rel, int *opcode)
         /* constant timeout, no backoff */
         best->next_try =3D local_now + best->timeout;
 #endif
+        best->n_acks =3D 0;
         *opcode =3D best->opcode;
         dmsg(D_REL_DEBUG, "ACK reliable_send ID " packet_id_format " (size=
=3D%d to=3D%d)",
              (packet_id_print_type)best->packet_id, best->buf.len,
@@ -686,6 +693,7 @@ reliable_mark_active_incoming(struct reliable *rel, str=
uct buffer *buf,
             e->opcode =3D opcode;
             e->next_try =3D 0;
             e->timeout =3D 0;
+            e->n_acks =3D 0;
             dmsg(D_REL_DEBUG, "ACK mark active incoming ID " packet_id_for=
mat, (packet_id_print_type)e->packet_id);
             return;
         }
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index a84d4290..bf0b561b 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -72,6 +72,7 @@ struct reliable_entry
     interval_t timeout;
     time_t next_try;
     packet_id_type packet_id;
+    size_t n_acks;
     int opcode;
     struct buffer buf;
 };
--=20
2.11.0

