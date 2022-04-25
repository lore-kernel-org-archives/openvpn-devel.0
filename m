From: Arne Schwabe <arne@...1227...>
Date: Mon, 25 Apr 2022 14:27:09 +0200
Message-Id: <20220425122709.4148015-1-arne@...1227...>
In-Reply-To: <20220422134038.3801239-4-arne@...1227...>
References: <20220422134038.3801239-4-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Move pre decrypt lite check to its own
 function
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

This prepares for extending this function with the HMAC based session ID
check.

Replace the check for m->top.c2.tls_auth_standalone with an ASSERT as this
code path is only used in multi udp server and OpenVPN initialises the
tls_auth_standalone always for the TOP context (CF_INIT_TLS_AUTH_STANDALONE),
even for the tcp m2mp server that does not use it).

Patch v2: replace if with ASSERT

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mudp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 4fbe3c1a3..780ca171d 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -39,6 +39,17 @@
 #include <sys/inotify.h>
 #endif
 
+static bool
+do_pre_decrypt_check(struct multi_context *m)
+{
+    ASSERT(m->top.c2.tls_auth_standalone);
+    if (!tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
+    {
+        return false;
+    }
+    return true;
+}
+
 /*
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
@@ -95,8 +106,7 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
         }
         if (!mi)
         {
-            if (!m->top.c2.tls_auth_standalone
-                || tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
+            if (do_pre_decrypt_check(m))
             {
                 if (frequency_limit_event_allowed(m->new_connection_limiter))
                 {
-- 
2.32.0 (Apple Git-132)


