Resent-Message-ID: <ZUzBoQlX2Vj0nUxf@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
From: Gert Doering <gert@...1296...>
Date: Wed,  8 Nov 2023 13:49:47 +0100
Message-ID: <20231108124947.76816-3-gert@...1296...>
In-Reply-To: <20231108124947.76816-1-gert@...1296...>
References: <20231108124947.76816-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Fix using to_link buffer after freed
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

When I refactored the tls_state_change method in
9a7b95fda5 I accidentally changed a break into
a return true while it should return a false.

The code here is extremely fragile in the sense
that it assumes that settings a keystate to S_ERROR
cannot have any outgoing buffer or we will have a
use after free.  The previous break and now restored
return false ensure this by skipping any further
tls_process_state loops that might set to ks->S_ERROR
and ensure that the to_link is sent out and cleared
before having more loops in tls_state_change.

CVE: 2023-46850

This affects everyone, even with tls-auth/tls-crypt enabled.

Change-Id: I2a0f1c665d992da8e24a421ff0ddcb40f7945ea8
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e15f951d6..cee4afe19 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2903,7 +2903,13 @@ tls_process_state(struct tls_multi *multi,
                            CONTROL_SEND_ACK_MAX, true);
         *to_link = b;
         dmsg(D_TLS_DEBUG, "Reliable -> TCP/UDP");
-        return true;
+
+        /* This changed the state of the outgoing buffer. In order to avoid
+         * running this function again/further and invalidating the key_state
+         * buffer and accessing the buffer that is now in to_link after it being
+         * freed for a potential error, we shortcircuit exiting of the outer
+         * process here. */
+        return false;
     }
 
     /* Write incoming ciphertext to TLS object */
-- 
2.39.3 (Apple Git-145)


