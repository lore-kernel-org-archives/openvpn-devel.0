From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:15 +0100
Message-Id: <1454874438-5081-8-git-send-email-steffan@...1856...>
In-Reply-To: <1454874438-5081-1-git-send-email-steffan@...1856...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 07/10] Create separate function for replay
	check
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

In preparation for AEAD cipher modes, which will need the same
functionality.

Should not change any behaviour.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c | 52 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e92125e..9c0c353 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -232,6 +232,41 @@ err:
   return;
 }
 
+/**
+ * Check packet ID for replay, and perform replay administration.
+ *
+ * @param opt	Crypto options for this packet, contains replay state.
+ * @param pin	Packet ID read from packet.
+ * @param error_prefix	Prefix to use when printing error messages.
+ * @param gc	Garbage collector to use.
+ *
+ * @return true if packet ID is validated to be not a replay, false otherwise.
+ */
+static bool crypto_check_replay(struct crypto_options *opt,
+    const struct packet_id_net *pin, const char *error_prefix,
+    struct gc_arena *gc) {
+  bool ret = false;
+  packet_id_reap_test (&opt->packet_id.rec);
+  if (packet_id_test (&opt->packet_id.rec, pin))
+    {
+      packet_id_add (&opt->packet_id.rec, pin);
+      if (opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FORM))
+	packet_id_persist_save_obj (opt->pid_persist, &opt->packet_id);
+      ret = true;
+    }
+  else
+    {
+      if (!(opt->flags & CO_MUTE_REPLAY_WARNINGS))
+	{
+	  msg (D_REPLAY_ERRORS, "%s: bad packet ID (may be a replay): %s -- "
+	      "see the man page entry for --no-replay and --replay-window for "
+	      "more info or silence this warning with --mute-replay-warnings",
+	      error_prefix, packet_id_net_print (pin, true, gc));
+	}
+    }
+  return ret;
+}
+
 /*
  * If (opt->flags & CO_USE_IV) is not NULL, we will read an IV from the packet.
  *
@@ -373,22 +408,9 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 	    }
 	}
       
-      if (have_pin)
+      if (have_pin && !crypto_check_replay(opt, &pin, error_prefix, &gc))
 	{
-	  packet_id_reap_test (&opt->packet_id.rec);
-	  if (packet_id_test (&opt->packet_id.rec, &pin))
-	    {
-	      packet_id_add (&opt->packet_id.rec, &pin);
-	      if (opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FORM))
-		packet_id_persist_save_obj (opt->pid_persist, &opt->packet_id);
-	    }
-	  else
-	    {
-	      if (!(opt->flags & CO_MUTE_REPLAY_WARNINGS))
-	      msg (D_REPLAY_ERRORS, "%s: bad packet ID (may be a replay): %s -- see the man page entry for --no-replay and --replay-window for more info or silence this warning with --mute-replay-warnings",
-		   error_prefix, packet_id_net_print (&pin, true, &gc));
-	      goto error_exit;
-	    }
+	  goto error_exit;
 	}
       *buf = work;
     }
-- 
2.5.0


