From: Richard Bonhomme <tincanteksup@...277...>
Date: Wed,  1 Jul 2020 02:10:18 +0100
Message-Id: <20200701011018.31364-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [Patch] New man page corrections -
 windows-options.rst
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

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 doc/man-sections/windows-options.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst
index 5ae7116c..72424d6b 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -231,7 +231,7 @@ Windows-Specific Options
   directive is not specified, OpenVPN will use the SystemRoot environment
   variable.
 
-  This option have changed behaviour in OpenVPN 2.3. Earlier you had to
+  This option has changed behaviour since OpenVPN 2.3. Earlier you had to
   define ``--win-sys env`` to use the SystemRoot environment variable,
   otherwise it defaulted to :code:`C:\\WINDOWS`. It is not needed to use
   the ``env`` keyword any more, and it will just be ignored. A warning is
@@ -239,7 +239,7 @@ Windows-Specific Options
 
 --windows-driver drv
   Specifies which tun driver to use. Values are :code:`tap-windows6`
-  (default) and :code:`wintun`.  This is Windows-only option.
+  (default) and :code:`wintun`.  This is a Windows-only option.
   :code:`wintun`" requires ``--dev tun`` and the OpenVPN process to run
   elevated, or be invoked using the Interactive Service.
 
-- 
2.17.1


