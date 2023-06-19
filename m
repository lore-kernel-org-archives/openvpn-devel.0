From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 19 Jun 2023 15:29:31 +0200
Message-Id: <20230619132934.76085-2-frank@...2641...>
In-Reply-To: <20230619132934.76085-1-frank@...2641...>
References: <20230614102115.138724-1-frank@...2641...>
 <20230619132934.76085-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] dist: add more missing files only used
 in the MSVC build
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

So it is possible to build with MSVC from the release
tarballs.

Fixes #344.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 build/msvc/msvc-generate/Makefile.am | 1 +
 src/openvpn/Makefile.am              | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

Note: unchanged from previous submission

diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generate/Makefile.am
index 9d04326d..fe13b370 100644
--- a/build/msvc/msvc-generate/Makefile.am
+++ b/build/msvc/msvc-generate/Makefile.am
@@ -13,6 +13,7 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 dist_noinst_DATA = \
+	git-version.py \
 	msvc-generate.vcxproj \
 	Makefile.mak \
 	msvc-generate.js \
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index a8e44528..2f979914 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -16,7 +16,8 @@ MAINTAINERCLEANFILES = \
 
 EXTRA_DIST = \
 	openvpn.vcxproj \
-	openvpn.manifest
+	openvpn.manifest \
+	vcpkg.json
 
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include \
-- 
2.34.1


