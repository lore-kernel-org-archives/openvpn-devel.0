From: Gert Doering <gert@...1296...>
Date: Sun, 13 Nov 2016 16:55:35 +0100
Message-Id: <20161113155535.68355-1-gert@...1296...>
In-Reply-To: <1479043047-25883-1-git-send-email-steffan@...1856...>
References: <1479043047-25883-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add in_port_t check to configure.ac
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

commit 8cac9b98d58b97 introduced using in_port_t which is not
available on (all?) mingw build environments.

Add configure check, falling back to uint16_t.

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 357ba29..e44f619 100644
--- a/configure.ac
+++ b/configure.ac
@@ -493,6 +493,12 @@ AC_CHECK_TYPES(
 	[AC_DEFINE([in_addr_t], [uint32_t], [Workaround missing in_addr_t])],
 	[[${SOCKET_INCLUDES}]]
 )
+AC_CHECK_TYPES(
+	[in_port_t],
+	,
+	[AC_DEFINE([in_port_t], [uint16_t], [Workaround missing in_port_t])],
+	[[${SOCKET_INCLUDES}]]
+)
 AC_CHECK_TYPE(
 	[struct iphdr],
 	[AC_DEFINE([HAVE_IPHDR], [1], [struct iphdr needed for IPv6 support])],
-- 
1.9.1


