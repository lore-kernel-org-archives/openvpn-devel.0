From: Steffan Karger <steffan@...1856...>
Date: Sat,  1 Jul 2017 13:22:08 +0200
Message-Id: <20170701112208.18803-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Deprecate --no-replay
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

Following the removal of --no-iv, and as suggested by both recent audits
(and done by OpenVPN-NL for 7 years now), it's time to get rid of the
--no-replay option.

The only valid use case I can imagine is to slightly reduce the per-packet
overhead for setups that do not use any authentication mechanism, but I
do not believe that warrants keeping an option around that generally
reduces security and makes our code more complex.

(If this patch is accepted, I'll send a follow-up patch to remove the
option from the master branch.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst           | 8 ++++++++
 doc/openvpn.8         | 4 ++++
 src/openvpn/options.c | 7 ++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 0b2b04dd..39d83a2d 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -306,6 +306,14 @@ Maintainer-visible changes
   i386/i686 builds on RHEL5.
 
 
+Version 2.4.4
+=============
+
+Deprecated features
+-------------------
+- ``--no-replay`` is deprecated and will be removed in OpenVPN 2.5.
+
+
 Version 2.4.3
 =============
 
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 20bdd91b..3600b8fa 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4257,6 +4257,10 @@ supported by OpenSSL.
 .\"*********************************************************
 .TP
 .B \-\-no\-replay
+
+.B DEPRECATED
+This option will be removed in OpenVPN 2.5.
+
 (Advanced) Disable OpenVPN's protection against replay attacks.
 Don't use this option unless you are prepared to make
 a tradeoff of greater efficiency in exchange for less
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a84878ef..5246cb5a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -545,7 +545,7 @@ static const char usage_message[] =
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
 #endif
-    "--no-replay     : Disable replay protection.\n"
+    "--no-replay     : (DEPRECATED) Disable replay protection.\n"
     "--mute-replay-warnings : Silence the output of replay warnings to log file.\n"
     "--replay-window n [t]  : Use a replay protection sliding window of size n\n"
     "                         and a time window of t seconds.\n"
@@ -2484,6 +2484,11 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "NCP cipher list contains unsupported ciphers.");
     }
 
+    if (!options->replay)
+    {
+        msg(M_WARN, "WARNING: --no-replay is DEPRECATED and will be removed in 2.5");
+    }
+
     /*
      * Check consistency of replay options
      */
-- 
2.11.0


