From: chipitsine@...277...
Date: Sat, 29 Jun 2019 00:46:36 +0500
Message-Id: <20190628194637.5038-2-chipitsine@...277...>
In-Reply-To: <20190628194637.5038-1-chipitsine@...277...>
References: <20190628194637.5038-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] travis-ci: fix osx builds
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

From: Ilya Shipitsin <chipitsine@...277...>

cached homebrew required update, so lzo was not installed.
enforce updating homebrew

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index a8ec3a18..7a074d34 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -78,6 +78,7 @@ addons:
     update: true
     packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man2html, mingw-w64]
   homebrew:
+    update: true
     packages: [ lzo ]
 
 cache:
-- 
2.20.1


