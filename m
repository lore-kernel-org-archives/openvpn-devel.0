From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:31 +0200
Message-Id: <1330546342-17794-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 01/52] build: version should not contain '-'
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 version.m4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/version.m4 b/version.m4
index 9f15247..ff9b35f 100644
--- a/version.m4
+++ b/version.m4
@@ -1,5 +1,5 @@
 dnl define the OpenVPN version
-define(PRODUCT_VERSION,[2.3-alpha1])
+define(PRODUCT_VERSION,[2.3_alpha1])
 dnl define the TAP version
 define(PRODUCT_TAP_ID,[tap0901])
 define(PRODUCT_TAP_WIN32_MIN_MAJOR,[9])
-- 
1.7.3.4


