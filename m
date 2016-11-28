From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 28 Nov 2016 15:53:21 +0100
Message-ID: <1480344801-27855-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1480344801-27855-1-git-send-email-steffan.karger@...1435...>
References: <1480344801-27855-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Unconditionally enable TLS_AGGREGATE_ACK
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This define has been enabled by default since 2005, and was not
configurable through ./configure (but just by changing ssl.h).  Let's
get rid of it.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl.c | 18 ------------------
 src/openvpn/ssl.h |  9 +--------
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 991515b..fd278a2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2639,22 +2639,6 @@ tls_process (struct tls_multi *multi,
 	  break;
 	}
 
-#ifndef TLS_AGGREGATE_ACK
-      /* Send 1 or more ACKs (each received control packet gets one ACK) */
-      if (!to_link->len && !reliable_ack_empty (ks->rec_ack))
-	{
-	  buf = &ks->ack_write_buf;
-	  ASSERT (buf_init (buf, FRAME_HEADROOM (&multi->opt.frame)));
-	  write_control_auth (session, ks, buf, to_link_addr, P_ACK_V1,
-			      RELIABLE_ACK_SIZE, false);
-	  *to_link = *buf;
-	  active = true;
-	  state_change = true;
-	  dmsg (D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
-	  break;
-	}
-#endif
-
       /* Write incoming ciphertext to TLS object */
       buf = reliable_get_buf_sequenced (ks->rec_reliable);
       if (buf)
@@ -2799,7 +2783,6 @@ tls_process (struct tls_multi *multi,
 
   update_time ();
 
-#ifdef TLS_AGGREGATE_ACK
   /* Send 1 or more ACKs (each received control packet gets one ACK) */
   if (!to_link->len && !reliable_ack_empty (ks->rec_ack))
     {
@@ -2811,7 +2794,6 @@ tls_process (struct tls_multi *multi,
       active = true;
       dmsg (D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
     }
-#endif
 
   /* When should we wake up again? */
   {
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 047eb24..c971b75 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -70,15 +70,8 @@
 #define P_FIRST_OPCODE                 1
 #define P_LAST_OPCODE                  9
 
-/* Should we aggregate TLS
- * acknowledgements, and tack them onto
- * control packets? */
-#define TLS_AGGREGATE_ACK
-
 /*
- * If TLS_AGGREGATE_ACK, set the
- * max number of acknowledgments that
- * can "hitch a ride" on an outgoing
+ * Set the max number of acknowledgments that can "hitch a ride" on an outgoing
  * non-P_ACK_V1 control packet.
  */
 #define CONTROL_SEND_ACK_MAX 4
-- 
2.7.4


