From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 2 Apr 2012 09:28:07 +0200
Message-ID: <1333351687-3732-6-git-send-email-dejong@...1435...>
In-Reply-To: <1333351687-3732-1-git-send-email-dejong@...1435...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/6] Updated README.polarssl with build
	system changes.
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 README.polarssl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.polarssl b/README.polarssl
index 77a9575..ab7c2d7 100644
--- a/README.polarssl
+++ b/README.polarssl
@@ -3,11 +3,11 @@ instructions:
 
 To Build and Install,
 
-	./configure --with-ssl-type=polarssl
+	./configure --with-crypto-library=polarssl
 	make
 	make install
 
-This version depends on at least PolarSSL v0.99.
+This version depends on at least PolarSSL v1.1.
 
 *************************************************************************
 
-- 
1.7.5.4


