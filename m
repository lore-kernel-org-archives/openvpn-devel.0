From: James Yonan <james@...515...>
Date: Thu,  8 May 2014 16:50:35 -0600
Message-Id: <1399589436-8730-6-git-send-email-james@...515...>
In-Reply-To: <1399589436-8730-1-git-send-email-james@...515...>
References: <1399589436-8730-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 5/6] Define PATH_SEPARATOR for MSVC builds.
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
Cc: James Yonan <james@...515...>

Signed-off-by: James Yonan <james@...515...>
---
 config-msvc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config-msvc.h b/config-msvc.h
index 9a95ae6..fa99384 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -76,6 +76,9 @@
 
 #define HAVE_OPENSSL_ENGINE 1
 
+#define PATH_SEPARATOR     '\\'
+#define PATH_SEPARATOR_STR "\\"
+
 #ifndef __cplusplus
 #define inline __inline
 #endif
-- 
1.8.5.5


