From: David Sommerseth <davids@...515...>
Date: Tue, 13 Dec 2016 13:16:56 +0100
Message-Id: <1481631416-15377-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Changes.rst:  Mainatiner update on C99
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

Mention for maintainers that we've moved to build with -std=c99 by
default.  Also document that 32-bit RHEL5 builds will need -std=gnu99
to be buildable.
---
 Changes.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index a5002dd..056bcec 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -291,3 +291,9 @@ Maintainer-visible changes
 - Linux distributions using systemd is highly encouraged to ship these new unit
   files instead of older ones, to provide a unified behaviour across systemd
   based Linux distributions.
+
+- With OpenVPN v2.4, the project have moved over to depend on and actively use
+  the official C99 standard (-std=c99).  This may on some older compiler/libc
+  headers combinations fail.  On most of these situations it is recommended to
+  do use -std=gnu99 in CFLAGS.  This is known to be needed when doing
+  i386/i686 builds on RHEL5.
-- 
1.8.3.1


