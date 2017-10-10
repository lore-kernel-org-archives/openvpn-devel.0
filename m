From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:25 +0200
Message-Id: <20171010231130.6832-8-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH 08/13] MSVC meta files added to .gitignore
 list
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

From: Simon Rozman <simon@...2293...>

---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 30e289b..4543674 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,6 +17,7 @@
 Release
 Debug
 Win32-Output
+.vs
 .deps
 .libs
 Makefile
@@ -55,6 +56,7 @@ distro/systemd/*.service
 sample/sample-keys/sample-ca/
 vendor/.build
 vendor/dist
+build/msvc/msvc-generate/version.m4
 
 tests/t_client.sh
 tests/t_client-*-20??????-??????/
-- 
2.9.0.windows.1


