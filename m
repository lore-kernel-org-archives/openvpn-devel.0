From: Antonio Quartulli <a@...2181...>
Date: Sat,  4 Sep 2021 11:56:27 +0200
Message-Id: <20210904095629.6273-6-a@...2181...>
In-Reply-To: <20210904095629.6273-1-a@...2181...>
References: <20210904095629.6273-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/7] compat-mode: add --data-cipher-fallback
 auomatically if requested
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

For compatibility with OpenVPN older than 2.4.0, the
'--data-cipher-fallback' argument is automatically added with the same
value as specified by '--cipher'.

This happens only when the user specifies compat-mode with a version
older than 2.4.0.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 doc/man-sections/generic-options.rst | 2 ++
 src/openvpn/options.c                | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 8b26cd1a..3e099e12 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -68,6 +68,8 @@ which mode OpenVPN is configured as.
     to the configuration if no other compression options are present.
   - 2.4.x or lower: The cipher in ``--cipher`` is appended to
     ``--data-ciphers``
+  - 2.3.x or lower: ``--data-cipher-fallback`` is automatically added with
+    the same cipher as ``--cipher``
 
 --config file
   Load additional config options from ``file`` where each line corresponds
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 88ac5bed..f2fb6d64 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3152,6 +3152,13 @@ options_set_backwards_compatible_options(struct options *o)
         append_cipher_to_ncp_list(o, o->ciphername);
     }
 
+    /* Versions < 2.4.0 additionally might be compiled with --enable-small and
+     * not have OCC strings required for "poor man's NCP" */
+    if (o->ciphername && need_compatibility_before(o, 20400))
+    {
+        o->enable_ncp_fallback = true;
+    }
+
     /* Compression is deprecated and we do not want to announce support for it
      * by default anymore, additionally DCO breaks with compression.
      *
-- 
2.32.0


