From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 28 Dec 2022 18:13:14 +0100
Message-Id: <20221228171314.133115-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] options.c: update usage description of
 --cipher
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

GCC with -O3 complains:
warning: ‘%s’ directive argument is null [-Wformat-overflow=]

And indeed:
--cipher alg    : Encrypt packets with cipher algorithm alg
                  (default=(null)).

Since there is no real default anymore, remove it.
While here also indicate the somewhat-deprecated status
of the option.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7395019e..ee378304 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -543,8 +543,8 @@ static const char usage_message[] =
     "                  digest algorithm alg (default=%s).\n"
     "                  (usually adds 16 or 20 bytes per packet)\n"
     "                  Set alg=none to disable authentication.\n"
-    "--cipher alg    : Encrypt packets with cipher algorithm alg\n"
-    "                  (default=%s).\n"
+    "--cipher alg    : Encrypt packets with cipher algorithm alg.\n"
+    "                  You should usually use --data-ciphers instead.\n"
     "                  Set alg=none to disable encryption.\n"
     "--data-ciphers list : List of ciphers that are allowed to be negotiated.\n"
 #ifndef ENABLE_CRYPTO_MBEDTLS
@@ -4779,7 +4779,7 @@ usage(void)
             o.ce.local_port, o.ce.remote_port,
             TUN_MTU_DEFAULT, TAP_MTU_EXTRA_DEFAULT,
             o.verbosity,
-            o.authname, o.ciphername,
+            o.authname,
             o.replay_window, o.replay_time,
             o.tls_timeout, o.renegotiate_seconds,
             o.handshake_window, o.transition_window);
-- 
2.34.1


