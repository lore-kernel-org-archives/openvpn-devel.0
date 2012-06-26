From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 26 Jun 2012 17:03:26 +0300
Message-Id: <1340719406-12157-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz3e6j+t5BPqpUa6iTErsVzm9Nof4EtP+atx9vvBKNsobw@...278...>
References: <CAOazyz3e6j+t5BPqpUa6iTErsVzm9Nof4EtP+atx9vvBKNsobw@...278...>
Subject: [Openvpn-devel] [PATCH] build: plugins: set defaults using a
	complex logic
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

pam cannot be compiled on OpenBSD and Windows.
down-root cannot be compiled on Windows.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index db19d4a..d3d974d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -195,16 +195,27 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[plugin-auth-pam],
-	[AS_HELP_STRING([--disable-plugin-auth-pam], [disable auth-pam plugin @<:@default=yes@:>@])],
+	[AS_HELP_STRING([--disable-plugin-auth-pam], [disable auth-pam plugin @<:@default=platform specific@:>@])],
 	,
-	[enable_plugin_auth_pam="yes"]
+	[
+		case "$host" in
+			*-*-openbsd*) enable_plugin_auth_pam="no";;
+			*-mingw*) enable_plugin_auth_pam="no";;
+			*) enable_plugin_auth_pam="yes";;
+		esac
+	]
 )
 
 AC_ARG_ENABLE(
 	[plugin-down-root],
-	[AS_HELP_STRING([--disable-plugin-down-root], [disable down-root plugin @<:@default=yes@:>@])],
+	[AS_HELP_STRING([--disable-plugin-down-root], [disable down-root plugin @<:@default=platform specific@:>@])],
 	,
-	[enable_plugin_down_root="yes"]
+	[
+		case "$host" in
+			*-mingw*) enable_plugin_down_root="no";;
+			*) enable_plugin_down_root="yes";;
+		esac
+	]
 )
 
 AC_ARG_ENABLE(
-- 
1.7.3.4


