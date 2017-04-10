From: David Sommerseth <davids@...515...>
Date: Tue, 11 Apr 2017 00:28:28 +0200
Message-Id: <20170410222828.23612-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Make --cipher/--auth none more explicit on
	the risks
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

The warning provided to --cipher and --auth using the 'none' setting may
not have been too clearly understandable to non-developers or people not
fully understanding encryption and cryptography.  This tries to improve
that.

While at it, also break up the long source lines.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/crypto.c | 11 +++++++++--
 src/openvpn/init.c   |  5 ++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 909f725..8a5c723 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -784,7 +784,10 @@ init_key_type(struct key_type *kt, const char *ciphername,
     {
         if (warn)
         {
-            msg(M_WARN, "******* WARNING *******: null cipher specified, no encryption will be used");
+            msg(M_WARN, "******* WARNING *******: '--cipher none' was specified. "
+                "This means NO encryption will be performed and tunnelled "
+                "data WILL be transmitted in clear text over the network! "
+                "PLEASE DO RECONIDER THIS SETTING!");
         }
     }
     if (strcmp(authname, "none") != 0)
@@ -804,7 +807,11 @@ init_key_type(struct key_type *kt, const char *ciphername,
     {
         if (warn)
         {
-            msg(M_WARN, "******* WARNING *******: null MAC specified, no authentication will be used");
+            msg(M_WARN, "******* WARNING *******: '--auth none' was specified. "
+                "This means no authentication will be performed on received "
+                "packets, meaning you CANNOT trust that the data received by "
+                "the remote side have NOT been manipulated. "
+                "PLEASE DO RECONIDER THIS SETTING!");
         }
     }
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0b74f25..86882fe 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2745,7 +2745,10 @@ do_init_crypto_none(const struct context *c)
 {
     ASSERT(!c->options.test_crypto);
     msg(M_WARN,
-        "******* WARNING *******: all encryption and authentication features disabled -- all data will be tunnelled as cleartext");
+        "******* WARNING *******: All encryption and authentication features "
+        "disabled -- All data will be tunnelled as clear text and will not be "
+        "protected against man-in-the-middle changes. "
+        "PLEASE DO RECONIDER THIS CONFIGURATION!");
 }
 #endif /* ifdef ENABLE_CRYPTO */
 
-- 
2.11.0


