From: Arne Schwabe <arne@...1227...>
Date: Fri, 19 Mar 2021 15:20:01 +0100
Message-Id: <20210319142001.2201-4-arne@...1227...>
In-Reply-To: <20210319142001.2201-1-arne@...1227...>
References: <20210319142001.2201-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 5/5] Deprecate the --verify-hash option
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

Despite trying to figure out with multiple people what the use case for
this option is, we could not come up with a good one. Checking that only
a specific CA is used can be also done by only using that CA in the --ca
directive.

Although it feels a bit strange to deprecate the option after improving
it with peer-fingerprint patches, all the improvements are needed for
--peer-fingerprint and making them specify to --peer-fingerprint would
have added more (unecessary) changes.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                      | 3 +++
 doc/man-sections/tls-options.rst | 2 +-
 src/openvpn/options.c            | 6 +++---
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index f1674835..732387f2 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -26,6 +26,9 @@ Deprecated features
     This was a very limited and not-well-tested way to run OpenVPN, on TCP
     and TAP mode only.
 
+``verify-hash`` has been deprecated
+    This option has very limited usefulness and should be replaced by either
+    a better ``--ca`` configuration or with a ``--tls-verify`` script.
 
 Overview of changes in 2.5
 ==========================
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 8f5e37cb..00ea063a 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -564,7 +564,7 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   :code:`1.2`.
 
 --verify-hash args
-  Specify SHA1 or SHA256 fingerprint for level-1 cert.
+  **DEPRECATED** Specify SHA1 or SHA256 fingerprint for level-1 cert.
 
   Valid syntax:
   ::
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 27ed813d..1ddcf7bf 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8142,6 +8142,9 @@ add_option(struct options *options,
         int verify_hash_depth = 0;
         if (streq(p[0], "verify-hash"))
         {
+            "DEPRECATED OPTION: The option --verify-hash is deprecated. "
+            "You should switch to the either use the level 1 certificate as "
+            "--ca option, use --tls-verify or use --peer-fingerprint";
             /* verify level 1 cert, i.e. the CA that signed the leaf cert */
             verify_hash_depth = 1;
         }
@@ -8164,9 +8167,6 @@ add_option(struct options *options,
             if ((!p[2] && !is_inline) || (p[2] && streq(p[2], "SHA1")))
             {
                 options->verify_hash_algo = MD_SHA1;
-                msg(M_WARN, "DEPRECATED FEATURE: Usage of SHA1 fingerprints for "
-                    "verify-hash is deprecated. You should switch to the "
-                    "SHA256.");
                 options->verify_hash_algo = SHA_DIGEST_LENGTH;
                 digest_len = SHA_DIGEST_LENGTH;
             }
-- 
2.30.1


