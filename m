From: Richard Bonhomme <tincanteksup@...277...>
Date: Tue, 30 Jun 2020 00:08:39 +0100
Message-Id: <20200629230839.24765-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [Patch][New-man] Update --txqueuelen default
 setting (Now OS default)
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
 doc/man-sections/advanced-options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index dbf7799c..9b96e406 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -104,4 +104,4 @@ used when debugging or testing out special usage scenarios.
 --txqueuelen n
   *(Linux only)* Set the TX queue length on the TUN/TAP interface.
-  Currently defaults to 100.
+  Currently defaults to operating system default.
 
-- 
2.17.1


