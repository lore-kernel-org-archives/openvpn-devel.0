From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Oct 2018 19:52:15 +0200
Message-Id: <20181007175215.25009-1-steffan@...1856...>
In-Reply-To: <20181007130123.GD962@...1296...>
References: <20181007130123.GD962@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Don't print OCC warnings about
 'key-method', 'keydir' and 'tls-auth'
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

From: Steffan Karger <steffan.karger@...1435...>

Like 'proto', a mismatch in key-method, keydir or tls-auth would fail
before we ever get to the point where we can print this warning.

This prepares for removing these from the occ string later on, but also
prepares for tls-crypt-v2, which allows a server to support tls-auth and
tls-crypt-v2 connections in parallel. Such a server will send 'keydir'
and 'tls-auth' in the occ string. This change removes the spurious
warnings about that in the client log.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: use strprefix instead of strcmp, and add tun-ipv6.

 src/openvpn/options.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2199af53..45c5ea64 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3788,11 +3788,15 @@ options_warning_safe_scan2(const int msglevel,
                            const char *b1_name,
                            const char *b2_name)
 {
-    /* we will stop sending 'proto xxx' in OCC in a future version
-     * (because it's not useful), and to reduce questions when
-     * interoperating, we start not-printing a warning about it today
+    /* We will stop sending 'key-method', 'keydir', 'proto' and 'tls-auth' in
+     * OCC in a future version (because it's not useful). To reduce questions
+     * when interoperating, we no longer printing a warning about it.
      */
-    if (strncmp(p1, "proto ", 6) == 0)
+    if (strprefix(p1, "key-method ")
+        || strprefix(p1, "keydir ")
+        || strprefix(p1, "proto ")
+        || strprefix(p1, "tls-auth ")
+        || strprefix(p1, "tun-ipv6 "))
     {
         return;
     }
-- 
2.17.1


