From: Steffan Karger <steffan@...1856...>
Date: Sat,  1 Jul 2017 13:29:51 +0200
Message-Id: <20170701112951.19119-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Deprecate --keysize
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

The --keysize option can only be used with already deprecated ciphers,
such as CAST5, RC2 or BF.  Deviating from the default keysize is
generally not a good idea (see man page text), and otherwise only
complicates our code.

(If this patch is accepted, I'll send a follow-up patch to remove the
option from the master branch.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst           | 1 +
 doc/openvpn.8         | 4 ++++
 src/openvpn/options.c | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index 39d83a2d..fdb56752 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -313,6 +313,7 @@ Deprecated features
 -------------------
 - ``--no-replay`` is deprecated and will be removed in OpenVPN 2.5.
 
+- ``--keysize`` is deprecated and will be removed in OpenVPN 2.5.
 
 Version 2.4.3
 =============
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3600b8fa..c373c2af 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4217,6 +4217,10 @@ negotiation.
 .\"*********************************************************
 .TP
 .B \-\-keysize n
+
+.B DEPRECATED
+This option will be removed in OpenVPN 2.5.
+
 Size of cipher key in bits (optional).
 If unspecified, defaults to cipher-specific default.  The
 .B \-\-show\-ciphers
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5246cb5a..95fdcc77 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2489,6 +2489,11 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_WARN, "WARNING: --no-replay is DEPRECATED and will be removed in 2.5");
     }
 
+    if (options->keysize)
+    {
+        msg(M_WARN, "WARNING: --keysize is DEPRECATED and will be removed in 2.5");
+    }
+
     /*
      * Check consistency of replay options
      */
-- 
2.11.0


