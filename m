From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 18 Jul 2018 16:27:51 +0200
Message-ID: <1531924073-29243-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1531924073-29243-1-git-send-email-steffan.karger@...1435...>
References: <1531924073-29243-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Minor reliability layer documentation
 fixes
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
Cc: Gert van Dijk <gert.vandijk@...1435...>, Steffan Karger <steffan.karger@...1435...>

From: Gert van Dijk <gert.vandijk@...1435...>

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 doc/doxygen/doc_protocol_overview.h | 2 +-
 src/openvpn/ssl.c                   | 4 ++--
 src/openvpn/ssl.h                   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
index db24d3b..3f48b18 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -134,7 +134,7 @@
  * without wasting resources on attempting a TLS handshake which will
  * ultimately fail.
  *
- * @subsection network_protocol_control_key_methods Control channel key methods and
+ * @subsection network_protocol_control_key_methods Control channel key methods
  *
  * Once the TLS session has been initialized and authenticated, the TLS
  * channel is used to exchange random %key material for bidirectional
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 669f941..dcb5445 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3660,8 +3660,8 @@ tls_pre_decrypt(struct tls_multi *multi,
             }
 
             /*
-             * We have an authenticated packet (if --tls-auth was set).
-             * Now pass to our reliability level which deals with
+             * We have an authenticated control channel packet (if --tls-auth was set).
+             * Now pass to our reliability layer which deals with
              * packet acknowledgements, retransmits, sequencing, etc.
              */
             {
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index a2501c9..72227d9 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -76,7 +76,7 @@
 /*
  * Define number of buffers for send and receive in the reliability layer.
  */
-#define TLS_RELIABLE_N_SEND_BUFFERS  4 /* also window size for reliablity layer */
+#define TLS_RELIABLE_N_SEND_BUFFERS  4 /* also window size for reliability layer */
 #define TLS_RELIABLE_N_REC_BUFFERS   8
 
 /*
-- 
2.7.4


