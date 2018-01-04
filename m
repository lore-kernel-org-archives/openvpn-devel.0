From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 4 Jan 2018 13:07:50 +0100
Message-ID: <1515067670-13094-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Check for more data in control channel
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

If control channel packets arrive quickly after each other, or out of
order, there might be more data available than we can read in one
tls_process() call.  If that happened, and no further control channel
packet arrived (e.g. because the last two packets arrived out-of-order),
we would wait for 16 second ("coarse timer") before we would read the
remaining data.  To avoid that, always schedule ourself again if there
was control channel data, to check whether more data is available.

For mbedtls, we could implement a slightly more elegant "is there more
data?" function, instead of blindly rescheduling.  But I can't find a way
to implement that for OpenSSL, and the current solution is very simple and
still has quite low overhead.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7b42845..15a37a3 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2935,6 +2935,9 @@ tls_process(struct tls_multi *multi,
             {
                 state_change = true;
                 dmsg(D_TLS_DEBUG, "TLS -> Incoming Plaintext");
+
+                /* More data may be available, wake up again asap to check. */
+                *wakeup = 0;
             }
         }
 
-- 
2.7.4


