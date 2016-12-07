From: Steffan Karger <steffan@...1856...>
Date: Wed,  7 Dec 2016 20:20:47 +0100
Message-Id: <1481138447-6292-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Deprecate --no-iv
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

This fixes the bug of supporting --no-iv (since we're only accepting
bugfixes in the current release phase ;) ).

The --no-iv function decreases security if used (CBC *requires*
unpredictable IVs, other modes don't allow --no-iv at all), and even marginally
decreases other user's security by adding unwanted complexity to our code.
Let's get rid of this.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst           | 2 ++
 doc/openvpn.8         | 4 ++++
 src/openvpn/options.c | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index 843f2bd..4fb5ab5 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -171,6 +171,8 @@ Deprecated features
   X.509 subject formatting must be updated to the standardized formatting.  See
   the man page for more information.
 
+- ``--no-iv`` is deprecated in 2.4 and will be remove in 2.5.
+
 User-visible Changes
 --------------------
 - For certificate DNs with duplicate fields, e.g. "OU=one,OU=two", both fields
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 290a441..e5619c0 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4399,6 +4399,10 @@ This option only makes sense when replay protection is enabled
 .\"*********************************************************
 .TP
 .B \-\-no\-iv
+
+.B DEPRECATED
+This option will be removed in OpenVPN 2.5.
+
 (Advanced) Disable OpenVPN's use of IV (cipher initialization vector).
 Don't use this option unless you are prepared to make
 a tradeoff of greater efficiency in exchange for less
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4c4b160..8961eca 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2238,6 +2238,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
     {
       msg (M_USAGE, "--no-iv not allowed when NCP is enabled.");
     }
+  if (!options->use_iv)
+    {
+      msg (M_WARN, "WARNING: --no-iv is deprecated and will be removed in 2.5");
+    }
 
   /*
    * Check consistency of replay options
-- 
2.7.4


