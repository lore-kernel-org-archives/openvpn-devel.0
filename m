From: Frank Lichtenheld <frank@...2641...>
Date: Sat, 27 May 2023 11:55:04 +0200
Message-Id: <20230527095504.17915-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] msvc-generate: include version.m4.in in
 tarball
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

Fixes openvpn#344

Change-Id: I7d8a25df8ef62a1e46fdb4a2358972eb4419c564
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 build/msvc/msvc-generate/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generate/Makefile.am
index aa4f0dae..9d04326d 100644
--- a/build/msvc/msvc-generate/Makefile.am
+++ b/build/msvc/msvc-generate/Makefile.am
@@ -15,4 +15,5 @@ MAINTAINERCLEANFILES = \
 dist_noinst_DATA = \
 	msvc-generate.vcxproj \
 	Makefile.mak \
-	msvc-generate.js
+	msvc-generate.js \
+	version.m4.in
-- 
2.34.1


