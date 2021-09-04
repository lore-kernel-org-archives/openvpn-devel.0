From: Antonio Quartulli <a@...2181...>
Date: Sat,  4 Sep 2021 11:56:24 +0200
Message-Id: <20210904095629.6273-3-a@...2181...>
In-Reply-To: <20210904095629.6273-1-a@...2181...>
References: <20210904095629.6273-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/7] compat-mode: allow user to specify
 version to be compatible with
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

This changes introduces the basic inbfrastructure required
to allow the user to specify a specific OpenVPN version to be
compatible with.

Following changes will modify defaults to more modern and safer
values, while allowing backwards-compatible behaviour on demand.

The backwards-compatible behaviour is intructed via the config
knob '--compat-mode' implemented in this patch.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 Changes.rst                          |  6 +++++
 doc/man-sections/generic-options.rst |  9 +++++++
 src/openvpn/options.c                | 37 ++++++++++++++++++++++++++++
 src/openvpn/options.h                |  4 +++
 4 files changed, 56 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index 0323a7f7..f55b0e3e 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -45,6 +45,12 @@ Pending auth support for plugins and scripts
 
     See ``sample/sample-scripts/totpauth.py`` for an example.
 
+Compatibility mode (``--compat-mode``)
+    The modernisation of defaults can impact the compatibility of OpenVPN 2.6.0
+    with older peers. The options ``--compat-mode`` allows UIs to provide users
+    with an easy way to still connect to older servers.
+
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index db39f6e2..63c6227c 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -52,6 +52,15 @@ which mode OpenVPN is configured as.
   BSDs implement a getrandom() or getentropy() syscall that removes the
   need for /dev/urandom to be available.
 
+--compat-mode version
+  This option provides a way to alter the default of OpenVPN to be more
+  compatible with the version ``version`` specified. All of the changes
+  this option does can also be achieved using individual configuration
+  options.
+
+  Note: Using this option reverts defaults to no longer recommended
+  values and should be avoided if possible.
+
 --config file
   Load additional config options from ``file`` where each line corresponds
   to one command line option, but with the leading '--' removed.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0d6b85cf..4d971a56 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3125,6 +3125,29 @@ options_postprocess_cipher(struct options *o)
     }
 }
 
+/**
+ * Returns if we want 'backwards-compatibility' up to (but not included) a
+ * certain version
+ *
+ * @param version   the oldest version that does not compatibility
+ *                  e.g. 20400 for all versions < 2.4.0
+ * @return          whether compatibility should be enabled
+ */
+static bool
+need_compatibility_before(const struct options *o, int version)
+{
+    return o->backwards_compatible != 0 && o->backwards_compatible < version;
+}
+
+/**
+ * Changes default values so that OpenVPN can be compatible with the user
+ * specified version
+ */
+static void
+options_set_backwards_compatible_options(struct options *o)
+{
+}
+
 static void
 options_postprocess_mutate(struct options *o)
 {
@@ -3137,6 +3160,8 @@ options_postprocess_mutate(struct options *o)
     helper_keepalive(o);
     helper_tcp_nodelay(o);
 
+    options_set_backwards_compatible_options(o);
+
     options_postprocess_cipher(o);
     options_postprocess_mutate_invariant(o);
 
@@ -6698,6 +6723,18 @@ add_option(struct options *options,
             setenv_str(es, p[1], p[2] ? p[2] : "");
         }
     }
+    else if (streq(p[0], "compat-mode") && p[1] && !p[3])
+    {
+        unsigned int major, minor, patch;
+        if (!(sscanf(p[1], "%u.%u.%u", &major, &minor, &patch) == 3))
+        {
+            msg(msglevel, "cannot parse version number for --compat-mode: %s",
+                p[1]);
+            goto err;
+        }
+
+        options->backwards_compatible = major * 10000 + minor * 100 + patch;
+    }
     else if (streq(p[0], "setenv-safe") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_SETENV);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b0e40cb7..98c21a2a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -225,6 +225,10 @@ struct options
 
     /* enable forward compatibility for post-2.1 features */
     bool forward_compatible;
+    /** What version we should try to be compatible with as major * 10000 +
+      * minor * 100 + patch, e.g. 2.4.7 => 20407 */
+    unsigned int backwards_compatible;
+
     /* list of options that should be ignored even if unknown */
     const char **ignore_unknown_option;
 
-- 
2.32.0


