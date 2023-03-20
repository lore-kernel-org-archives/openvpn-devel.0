From: Arne Schwabe <arne@...1227...>
Date: Mon, 20 Mar 2023 17:55:38 +0100
Message-Id: <20230320165538.902965-1-arne@...1227...>
In-Reply-To: <20230301134449.2810039-1-arne@...1227...>
References: <20230301134449.2810039-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Improve description of compat-mode
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

Explicitly say that the version specified is the one of the peer and not
the version we try to emulate.

Patch v2: Improve grammar.
Change-Id: I3bd27a8d34d8cb4896a3b78508b7d16911571543

Change-Id: If4fb45b3426f5e0dbe6c87d5bd05681b9d733827
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/generic-options.rst | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index c827651d6..97e1b5aa6 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -53,10 +53,17 @@ which mode OpenVPN is configured as.
   need for /dev/urandom to be available.
 
 --compat-mode version
-  This option provides a way to alter the default of OpenVPN to be more
-  compatible with the version ``version`` specified. All of the changes
-  this option does can also be achieved using individual configuration
-  options.
+  This option provides a convenient way to alter the defaults of OpenVPN
+  to be more compatible with the version ``version`` specified. All of
+  the changes this option applies can also be achieved using individual
+  configuration options.
+
+  The version specified with this option is the version of OpenVPN peer
+  OpenVPN should try to be compatible with. In general OpenVPN should be
+  compatible with the last two previous version without this option. E.g.
+  OpenVPN 2.6.0 should be compatible with 2.5.x and 2.4.x without this option.
+  However, there might be some edge cases that still require this option even
+  in these cases.
 
   Note: Using this option reverts defaults to no longer recommended
   values and should be avoided if possible.
@@ -67,12 +74,15 @@ which mode OpenVPN is configured as.
   - 2.5.x or lower: ``--allow-compression asym`` is automatically added
     to the configuration if no other compression options are present.
   - 2.4.x or lower: The cipher in ``--cipher`` is appended to
-    ``--data-ciphers``
+    ``--data-ciphers``.
   - 2.3.x or lower: ``--data-cipher-fallback`` is automatically added with
-    the same cipher as ``--cipher``
+    the same cipher as ``--cipher``.
   - 2.3.6 or lower: ``--tls-version-min 1.0`` is added to the configuration
     when ``--tls-version-min`` is not explicitly set.
 
+  If not required, this is option should be avoided. Setting this option can
+  lower security or disable features like data-channel offloading.
+
 --config file
   Load additional config options from ``file`` where each line corresponds
   to one command line option, but with the leading :code:`--` removed.
-- 
2.37.1 (Apple Git-137.1)


