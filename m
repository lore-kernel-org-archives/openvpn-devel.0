From: Gert van Dijk <gert@...2298...>
Date: Sat, 11 Nov 2017 17:11:22 +0100
Message-Id: <20171111161122.30087-2-gert@...2298...>
In-Reply-To: <20171111161122.30087-1-gert@...2298...>
References: <20171111161122.30087-1-gert@...2298...>
Subject: [Openvpn-devel] [PATCH 2/2] Add negotiated cipher to status file
 format 2 and 3
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

With NCP turned off, this will still display the cipher used.

Trac: #814

Signed-off-by: Gert van Dijk <gert@...2298...>
---
 doc/openvpn.8       |  2 +-
 src/openvpn/multi.c | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 267497fd..00dbff6f 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2477,7 +2477,7 @@ Connected Since.
 .B 2
 \-\- a more reliable format for external processing. Compared to version 1, the
 client list contains some additional fields: Virtual Address, Virtual IPv6
-Address, Username, Client ID, Peer ID.
+Address, Username, Client ID, Peer ID, Data Channel Cipher.
 Future versions may extend the number of fields.
 .br
 .B 3
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 82a0b9d9..dfad582f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -50,6 +50,8 @@
 #include "forward-inline.h"
 #include "pf-inline.h"
 
+#include "crypto_backend.h"
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -940,8 +942,8 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
              */
             status_printf(so, "TITLE%c%s", sep, title_string);
             status_printf(so, "TIME%c%s%c%u", sep, time_string(now, 0, false, &gc_top), sep, (unsigned int)now);
-            status_printf(so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer ID",
-                          sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
+            status_printf(so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cVirtual IPv6 Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID%cPeer ID%cData Channel Cipher",
+                          sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
             hash_iterator_init(m->hash, &hi);
             while ((he = hash_iterator_next(&hi)))
             {
@@ -956,7 +958,7 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
 #else
                                   ""
 #endif
-                                  "%c%" PRIu32,
+                                  "%c%" PRIu32 "%c%s",
                                   sep, tls_common_name(mi->context.c2.tls_multi, false),
                                   sep, mroute_addr_print(&mi->real, &gc),
                                   sep, print_in_addr_t(mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc),
@@ -971,7 +973,8 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
 #else
                                   sep,
 #endif
-                                  sep, mi->context.c2.tls_multi ? mi->context.c2.tls_multi->peer_id : UINT32_MAX);
+                                  sep, mi->context.c2.tls_multi ? mi->context.c2.tls_multi->peer_id : UINT32_MAX,
+                                  sep, translate_cipher_name_to_openvpn(mi->context.options.ciphername));
                 }
                 gc_free(&gc);
             }
-- 
2.15.0


