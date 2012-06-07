From: Alon Bar-Lev <alon.barlev@...277...>
Date: Thu,  7 Jun 2012 12:37:04 +0300
Message-Id: <1339061824-16542-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz3gNKF8OmTjm+rb_8-Wi0pzuihwh5u_85X-3sgsb3Bqfw@...278...>
References: <CAOazyz3gNKF8OmTjm+rb_8-Wi0pzuihwh5u_85X-3sgsb3Bqfw@...278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] build: support =polarssl-1.1.0
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Repoted-by: Samuli Seppänen <samuli@...515...>
Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 339164f..9511317 100644
--- a/configure.ac
+++ b/configure.ac
@@ -755,7 +755,7 @@ if test "${with_crypto_library}" = "polarssl" ; then
 #include <polarssl/version.h>
 			]],
 			[[
-#if POLARSSL_VERSION_NUMBER <= 0x01010000
+#if POLARSSL_VERSION_NUMBER < 0x01010000
 #error invalid version
 #endif
 			]]
-- 
1.7.3.4


