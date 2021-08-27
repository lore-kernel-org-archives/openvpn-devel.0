From: Antonio Quartulli <a@...2181...>
Date: Fri, 27 Aug 2021 16:55:29 +0200
Message-Id: <20210827145529.19867-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] man/protocol-options: add missing ending
 metachar
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
Cc: Antonio Quartulli <a@...2181...>, David Sommerseth <davids@...515...>

A code string terminating character (`) is missing, thus leading to the
following warning:

man-sections/protocol-options.rst:99: (WARNING/2) Inline interpreted text or phrase reference start-string without end-string.

Add missing char at the end of the code word.

Cc: David Sommerseth <davids@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 doc/man-sections/protocol-options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 5ae780e1..05366011 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -99,7 +99,7 @@ configured in a compatible way between both the local and remote side.
   Especially :code:`stub-v2` is essentially identical to no compression and
   no compression framing as its header indicates IP version 5 in a tun setup
   and can (ab)used to complete disable compression to clients. (See the
-  :code:`migrate option below)
+  :code:`migrate option below`)
 
   If the ``algorithm`` parameter is :code:`stub`, :code:`stub-v2` or empty,
   compression will be turned off, but the packet framing for compression
-- 
2.31.1


