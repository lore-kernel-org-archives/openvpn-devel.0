From: Gert Doering <gert@...1296...>
Date: Wed,  3 Dec 2025 13:57:34 +0100
Message-ID: <20251203125741.29239-1-gert@...1296...>
In-Reply-To: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
References: <gerrit.1757957943000.I34e6b680618a52003d8408852d415c8aeac01feb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Clarify some code in epoch with better
 comments
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

Change-Id: I34e6b680618a52003d8408852d415c8aeac01feb
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1190
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1190
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 8049b3a..d6b8841 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -97,6 +97,12 @@
         /* IV starts with packet id to make the IV unique for packet */
         if (use_epoch_data_format)
         {
+            /* Note this does not check aead_usage_limit but can overstep it by
+             * a few extra blocks in one extra write. This is not affecting the
+             * security margin as these extra blocks are on a completely
+             * different order of magnitude than the security margin.
+             * The next iteration/call to epoch_check_send_iterate will
+             * iterate the epoch */
             if (!packet_id_write_epoch(&opt->packet_id.send, ctx->epoch, &iv_buffer))
             {
                 msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 72c6821..3842615 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -298,7 +298,7 @@
 
     /** last epoch_key used for generation of the current send data keys.
      * As invariant, the epoch of epoch_key_send is always kept >= the epoch of
-     * epoch_key_recv */
+     * key_ctx_bi.decrypt.epoch  */
     struct epoch_key epoch_key_send;
 
     /** epoch_key used for the highest receive epoch keys */
@@ -309,7 +309,7 @@
 
     /** The limit for AEAD cipher, this is the sum of packets + blocks
      * that are allowed to be used. Will switch to a new epoch if this
-     * limit is reached*/
+     * limit is reached. */
     uint64_t aead_usage_limit;
 
     /** Keeps the future epoch data keys for decryption. The current one

