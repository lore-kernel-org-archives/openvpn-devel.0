From: Steffan Karger <steffan@...1856...>
Date: Thu, 11 May 2017 23:13:41 +0200
Message-Id: <1494537221-12050-3-git-send-email-steffan@...1856...>
In-Reply-To: <1494537221-12050-1-git-send-email-steffan@...1856...>
References: <1494537221-12050-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 3/3 (release/2.2)] Drop packets instead of
	assert out if packet id rolls over (CVE-2017-7479)
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

From: Steffan Karger <steffan.karger@...1435...>

Previously, if a mode was selected where packet ids are not allowed to roll
over, but renegotiation does not succeed for some reason (e.g. no password
entered in time, certificate expired or a malicious peer that refuses the
renegotiaion on purpose) we would continue to use the old keys.  Until the
packet ID would roll over and we would ASSERT() out.

Given that this can be triggered on purpose by an authenticated peer, this
is a fix for an authenticated remote DoS vulnerability.  An attack is
rather inefficient though; a peer would need to get us to send 2^32
packets (min-size packet is IP+UDP+OPCODE+PID+TAG (no payload), results in
(20+8+1+4+16)*2^32 bytes, or approx. 196 GB).

This is a fix for finding 5.2 from the OSTIF / Quarkslab audit.

This patch was cherry-picked from b727643c (release/2.3).

CVE: 2017-7479
Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 crypto.c    | 18 +++++++++++++-----
 packet_id.c | 22 ++++++++++++++++------
 packet_id.h |  1 +
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/crypto.c b/crypto.c
index b7b2f01..b1a8a02 100644
--- a/crypto.c
+++ b/crypto.c
@@ -117,9 +117,11 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 		prng_bytes (iv_buf, iv_size);
 
 	      /* Put packet ID in plaintext buffer or IV, depending on cipher mode */
-	      if (opt->packet_id)
+	      if (opt->packet_id
+		  && !packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true))
 		{
-		  ASSERT (packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
+		  msg (D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+		  goto err;
 		}
 	    }
 	  else if (mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE)
@@ -131,7 +133,11 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 
 	      memset (iv_buf, 0, iv_size);
 	      buf_set_write (&b, iv_buf, iv_size);
-	      ASSERT (packet_id_write (&opt->packet_id->send, &b, true, false));
+	      if (!packet_id_write (&opt->packet_id->send, &b, true, false))
+		{
+		  msg (D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+		  goto err;
+		}
 	    }
 	  else /* We only support CBC, CFB, or OFB modes right now */
 	    {
@@ -187,9 +193,11 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	}
       else				/* No Encryption */
 	{
-	  if (opt->packet_id)
+	  if (opt->packet_id
+	      && !packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true))
 	    {
-	      ASSERT (packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
+	      msg (D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+	      goto err;
 	    }
 	  work = *buf;
 	}
diff --git a/packet_id.c b/packet_id.c
index d190074..a579726 100644
--- a/packet_id.c
+++ b/packet_id.c
@@ -248,27 +248,37 @@ packet_id_read (struct packet_id_net *pin, struct buffer *buf, bool long_form)
   return true;
 }
 
-static void
+static bool
 packet_id_send_update(struct packet_id_send *p, bool long_form)
 {
   if (!p->time)
     {
       p->time = now;
     }
-  p->id++;
-  if (!p->id)
+  if (p->id == PACKET_ID_MAX)
     {
-      ASSERT(long_form);
+      /* Packet ID only allowed to roll over if using long form and time has
+       * moved forward since last roll over.
+       */
+      if (!long_form || now <= p->time)
+        {
+            return false;
+        }
       p->time = now;
-      p->id = 1;
+      p->id = 0;
     }
+    p->id++;
+    return true;
 }
 
 bool
 packet_id_write (struct packet_id_send *p, struct buffer *buf, bool long_form,
         bool prepend)
 {
-  packet_id_send_update(p, long_form);
+  if (!packet_id_send_update(p, long_form))
+    {
+      return false;
+    }
 
   const packet_id_type net_id = htonpid(p->id);
   const net_time_t net_time = htontime(p->time);
diff --git a/packet_id.h b/packet_id.h
index 59b7a7b..7d70840 100644
--- a/packet_id.h
+++ b/packet_id.h
@@ -50,6 +50,7 @@
  * to for network transmission.
  */
 typedef uint32_t packet_id_type;
+#define PACKET_ID_MAX UINT32_MAX
 typedef uint32_t net_time_t;
 
 /*
-- 
2.7.4


