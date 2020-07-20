From: David Sommerseth <davids@...515...>
Date: Mon, 20 Jul 2020 12:38:22 +0200
Message-Id: <20200720103822.26088-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] travis: Fix make distcheck failure
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

Since commit f500c49c8e0, the man page and html documentation need to be
generated when building out of the git repository, as both openvpn.8 and
openvpn.8.html will be shipped pregenerated inside the tarball generated
by 'make dist'.

Travis was lacking the python-docutils package, which made the
'make distcheck' build test fail.

Signed-off-by: David Sommerseth <davids@...515...>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 925d09ea..b154277e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -111,7 +111,7 @@ jobs:
 addons:
   apt:
     update: true
-    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man2html, mingw-w64, clang-9, libcmocka-dev ]
+    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man2html, mingw-w64, clang-9, libcmocka-dev, python3-docutils ]
   homebrew:
     update: true
     packages: [ lzo, lz4, cmocka ]
-- 
2.26.0


