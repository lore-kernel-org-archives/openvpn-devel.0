MIME-Version: 1.0
Date: Thu, 8 Aug 2013 13:56:38 -0400
Message-ID: <CANfRfr0GEw0KJT2XpFu6zGmhKpWOQah_PU2hdROD0FDRktZfVQ@...278...>
From: Jesse Glick <jglick@...1836...>
Subject: [Openvpn-devel] [PATCH 1/2] Allow use of NetBeans without saving
	nbproject/ directory.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index a04afff..3a2f384
--- a/.gitignore
+++ b/.gitignore
@@ -54,3 +54,4 @@ tests/t_client.sh
 tests/t_client-*-20??????-??????/
 src/openvpn/openvpn
 config-version.h
+nbproject
-- 
1.8.1.2

