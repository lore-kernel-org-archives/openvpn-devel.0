From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 23 Feb 2017 11:35:38 +0100
Message-ID: <1487846138-22231-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <20170223092314.GR93896@...1296...>
References: <20170223092314.GR93896@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] OpenSSL: 1.1 fallout - fix configure on old
	autoconf
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

Older versions of autoconf generate an empty "else fi" block for empty
fields in an AC_CHECK_FUNCS() macro.  This breaks on e.g. RHEL6.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 configure.ac | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 546a7d6..79ef52d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -912,9 +912,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 			X509_STORE_get0_objects \
 			X509_OBJECT_free \
 			X509_OBJECT_get_type \
-		],
-		,
-		[]
+		]
 	)
 
 	CFLAGS="${saved_CFLAGS}"
-- 
2.7.4


