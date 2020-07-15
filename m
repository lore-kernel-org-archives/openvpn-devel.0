From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:13 +0200
Message-Id: <20200715223013.11726-17-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 16/16] doc/man: Minor improvements to the
 plug-in section
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

Make the valid syntax clearer and apply proper styling of few
reference strings.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/plugin-options.rst | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/doc/man-sections/plugin-options.rst b/doc/man-sections/plugin-options.rst
index 20b74edd..1beccd3d 100644
--- a/doc/man-sections/plugin-options.rst
+++ b/doc/man-sections/plugin-options.rst
@@ -5,7 +5,15 @@ OpenVPN can be extended by loading external plug-in modules at runtime.  These
 plug-ins must be prebuilt and adhere to the OpenVPN Plug-In API.
 
 --plugin args
-  Loads a given plug-in module.  The ``module-name`` needs to be the first
+  Loads an OpenVPN plug-in module.
+
+  Valid syntax:
+  ::
+
+     plugin module-name
+     plugin module-name "arguments"
+
+  The ``module-name`` needs to be the first
   argument, indicating the plug-in to load.  The second argument is an
   optional init string which will be passed directly to the plug-in.
   If the init consists of multiple arguments it must be enclosed in
@@ -26,8 +34,8 @@ plug-ins must be prebuilt and adhere to the OpenVPN Plug-In API.
      /usr/lib/my/plug.so  /usr/lib/my/plug.so
 
 
-  DEFAULT\_DIR is replaced by the default plug-in directory, which is
-  configured at the build time of OpenVPN. CWD is the current directory
+  ``DEFAULT_DIR`` is replaced by the default plug-in directory, which is
+  configured at the build time of OpenVPN. ``CWD`` is the current directory
   where OpenVPN was started or the directory OpenVPN have switched into
   via the ``--cd`` option before the ``--plugin`` option.
 
-- 
2.26.0


