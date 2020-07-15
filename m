From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:11 +0200
Message-Id: <20200715223013.11726-15-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 14/16] doc/man: Update --txqueuelen default
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

From: Richard Bonhomme <tincanteksup@...277...>

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/advanced-options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index dbf7799c..9b96e406 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -103,5 +103,5 @@ used when debugging or testing out special usage scenarios.
 
 --txqueuelen n
   *(Linux only)* Set the TX queue length on the TUN/TAP interface.
-  Currently defaults to 100.
+  Currently defaults to operating system default.
 
-- 
2.26.0


