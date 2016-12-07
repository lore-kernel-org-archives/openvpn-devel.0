From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  7 Dec 2016 11:56:57 +0200
Message-Id: <1481104617-3675-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Add "async push" feature to Changes.rst
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
Cc: Lev Stipakov <lev.stipakov@...2164...>

From: Lev Stipakov <lev.stipakov@...2164...>

---
 Changes.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index 843f2bd..44fe346 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -147,6 +147,11 @@ Control channel encryption (``--tls-crypt``)
     channel packets.  Provides more privacy, some obfuscation and poor-man's
     post-quantum security.
 
+Asynchronous push reply
+    If asynchronous authentication is enabled and completed after server received 
+    PUSH_REQUEST message, server sends PUSH_REPLY immediately without waiting for next
+    PUSH_REQUEST. Requires use of ``--enable-async-push`` as configure parameter.
+
 
 Deprecated features
 -------------------
-- 
1.9.1


