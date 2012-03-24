From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 24 Mar 2012 09:58:37 +0200
Message-Id: <1332575918-3384-6-git-send-email-alon.barlev@...277...>
In-Reply-To: <4F6D06C5.3030408@...1114...>
References: <4F6D06C5.3030408@...1114...>
Subject: [Openvpn-devel] [PATCH 5/6] build: enable lzo by default
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9a6ff29..bd84c0f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,9 +41,9 @@ AC_USE_SYSTEM_EXTENSIONS
 
 AC_ARG_ENABLE(
 	[lzo],
-	[AS_HELP_STRING([--enable-lzo], [enable LZO compression support @<:@default=no@:>@])],
+	[AS_HELP_STRING([--disable-lzo], [disable LZO compression support @<:@default=yes@:>@])],
 	,
-	[enable_lzo="no"]
+	[enable_lzo="yes"]
 )
 
 AC_ARG_ENABLE(
-- 
1.7.3.4


