From: Antonio Quartulli <a@...2181...>
Date: Sat,  4 Sep 2021 11:56:25 +0200
Message-Id: <20210904095629.6273-4-a@...2181...>
In-Reply-To: <20210904095629.6273-1-a@...2181...>
References: <20210904095629.6273-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/7] reject compression by default
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

With this change the value of '--allow-compression- is set to 'no'.
Therefore compression is not enabled by default and cannot be enabled
by the server either.

This change is in line with the current rend of not recommending
compression over VPN tunnels for security reasons (check Voracle).

Of top of that compression is mostly useless nowadays, therefore
there is not real reason to enable it.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 Changes.rst                          |  7 +++++++
 doc/man-sections/generic-options.rst |  6 ++++++
 src/openvpn/comp.h                   |  1 +
 src/openvpn/options.c                | 11 +++++++++++
 4 files changed, 25 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index f55b0e3e..65b838b9 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -71,6 +71,13 @@ Deprecated features
     This option mainly served a role as debug option when NCP was first
     introduced. It should now no longer be necessary.
 
+Compression no longer enabled by default
+    Unless an explicit compression option is specified in the configuration,
+    ``--allow-compression`` defaults to ``no`` in OpeNVPN 2.6.0.
+    By default, OpenVPN 2.5 still allowed a server to enable compression by
+    pushing compression related options.
+
+
 Overview of changes in 2.5
 ==========================
 
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 63c6227c..a8d24572 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -61,6 +61,12 @@ which mode OpenVPN is configured as.
   Note: Using this option reverts defaults to no longer recommended
   values and should be avoided if possible.
 
+  The following table details what defaults are changed depending on the
+  version specified.
+
+  - 2.5.x or lower: ``--allow-compression asym`` is automatically added
+    to the configuration if no other compression options are present.
+
 --config file
   Load additional config options from ``file`` where each line corresponds
   to one command line option, but with the leading '--' removed.
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index cd4f0e1a..619a574e 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -59,6 +59,7 @@
 #define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
                                             * we still accept other compressions to be pushed */
 #define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
+#define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly set to allow assymetric compression */
 
 
 /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4d971a56..21c76a69 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3146,6 +3146,16 @@ need_compatibility_before(const struct options *o, int version)
 static void
 options_set_backwards_compatible_options(struct options *o)
 {
+    /* Compression is deprecated and we do not want to announce support for it
+     * by default anymore, additionally DCO breaks with compression.
+     *
+     * Disable compression by default starting with 2.6.0 if no other
+     * compression related option has been explicitly set */
+    if (!comp_non_stub_enabled(&o->comp) && !need_compatibility_before(o, 20600)
+        && (o->comp.flags == 0))
+    {
+        o->comp.flags = COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
+    }
 }
 
 static void
@@ -7732,6 +7742,7 @@ add_option(struct options *options,
         else if (streq(p[1], "asym"))
         {
             options->comp.flags &= ~COMP_F_ALLOW_COMPRESS;
+            options->comp.flags |= COMP_F_ALLOW_ASYM;
         }
         else if (streq(p[1], "yes"))
         {
-- 
2.32.0


