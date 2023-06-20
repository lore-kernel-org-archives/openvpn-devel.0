From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 20 Jun 2023 15:53:09 +0200
Message-Id: <20230620135310.94455-5-frank@...2641...>
In-Reply-To: <20230620135310.94455-1-frank@...2641...>
References: <20230509111205.138997-1-frank@...2641...>
 <20230620135310.94455-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/5] CMake: Add /Brepro to MSVC link options
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

So that we get reproducible builds.

Change-Id: Iffdd3ac5f266cc7d592ab678afc14c122acbb351
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 CMakeLists.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index bdbc87b8..3cbba5a3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -56,6 +56,7 @@ if (MSVC)
         "$<$<CONFIG:Release>:/Zi>"
         )
     add_link_options(
+        /Brepro
         "$<$<CONFIG:Release>:/LTCG:incremental>"
         "$<$<CONFIG:Release>:/DEBUG:FULL>"
         "$<$<CONFIG:Release>:/OPT:REF>"
-- 
2.34.1


