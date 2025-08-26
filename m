From: Gert Doering <gert@...1296...>
Date: Tue, 26 Aug 2025 20:49:29 +0200
Message-ID: <20250826184935.22110-1-gert@...1296...>
In-Reply-To: <gerrit.1753360288000.I89820c76e2e099f7acb817c71c8aeb83736ac556@...2715...>
References: <gerrit.1753360288000.I89820c76e2e099f7acb817c71c8aeb83736ac556@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8] crypto: Make sure crypto flags are
 treated as unsigned
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

From: Frank Lichtenheld <frank@...2641...>

crypto_options.flags is already unsigned, make sure the
flags are as well to avoid spurious conversion warnings.

Change-Id: I89820c76e2e099f7acb817c71c8aeb83736ac556
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1103
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index cee4145..efd7f60 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -342,39 +342,39 @@
      *   keeping state between successive
      *   OpenVPN process startups. */
 
-#define CO_PACKET_ID_LONG_FORM         (1 << 0)
+#define CO_PACKET_ID_LONG_FORM         (1u << 0)
     /**< Bit-flag indicating whether to use
      *   OpenVPN's long packet ID format. */
-#define CO_IGNORE_PACKET_ID            (1 << 1)
+#define CO_IGNORE_PACKET_ID            (1u << 1)
     /**< Bit-flag indicating whether to ignore
      *   the packet ID of a received packet.
      *   This flag is used during processing
      *   of the first packet received from a
      *   client. */
-#define CO_MUTE_REPLAY_WARNINGS        (1 << 2)
+#define CO_MUTE_REPLAY_WARNINGS        (1u << 2)
     /**< Bit-flag indicating not to display
      *   replay warnings. */
-#define CO_USE_TLS_KEY_MATERIAL_EXPORT (1 << 3)
+#define CO_USE_TLS_KEY_MATERIAL_EXPORT (1u << 3)
     /**< Bit-flag indicating that data channel key derivation
      * is done using TLS keying material export [RFC5705]
      */
-#define CO_RESEND_WKC                  (1 << 4)
+#define CO_RESEND_WKC                  (1u << 4)
     /**< Bit-flag indicating that the client is expected to
      * resend the wrapped client key with the 2nd packet (packet-id 1)
      * like with the HARD_RESET_CLIENT_V3 packet */
-#define CO_FORCE_TLSCRYPTV2_COOKIE     (1 << 5)
+#define CO_FORCE_TLSCRYPTV2_COOKIE     (1u << 5)
     /**< Bit-flag indicating that we do not allow clients that do
      * not support resending the wrapped client key (WKc) with the
      * third packet of the three-way handshake */
-#define CO_USE_CC_EXIT_NOTIFY          (1 << 6)
+#define CO_USE_CC_EXIT_NOTIFY          (1u << 6)
     /**< Bit-flag indicating that explicit exit notifies should be
      * sent via the control channel instead of using an OCC message
      */
-#define CO_USE_DYNAMIC_TLS_CRYPT       (1 << 7)
+#define CO_USE_DYNAMIC_TLS_CRYPT       (1u << 7)
     /**< Bit-flag indicating that renegotiations are using tls-crypt
      *   with a TLS-EKM derived key.
      */
-#define CO_EPOCH_DATA_KEY_FORMAT       (1 << 8)
+#define CO_EPOCH_DATA_KEY_FORMAT       (1u << 8)
     /**< Bit-flag indicating the epoch the data format. This format
      * has the AEAD tag at the end of the packet and is using a longer
      * 64-bit packet id that is split into a 16 bit epoch and 48 bit

