From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 2 Apr 2012 09:28:04 +0200
Message-ID: <1333351687-3732-3-git-send-email-dejong@...1435...>
In-Reply-To: <1333351687-3732-1-git-send-email-dejong@...1435...>
References: <1333351687-3732-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/6] Use POLARSSL_CFLAGS instead of
	POLARSSL_CRYPTO_CFLAGS in configure.ac
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

Ensured that the used variable name actually matches the one advertised by configure.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index ef34697..70c51e7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -821,7 +821,7 @@ case "${with_crypto_library}" in
 	polarssl)
 		have_crypto_crypto="${have_polarssl_crypto}"
 		have_crypto_ssl="${have_polarssl_ssl}"
-		CRYPTO_CRYPTO_CFLAGS="${POLARSSL_CRYPTO_CFLAGS}"
+		CRYPTO_CRYPTO_CFLAGS="${POLARSSL_CFLAGS}"
 		CRYPTO_CRYPTO_LIBS="${POLARSSL_LIBS}"
 		AC_DEFINE([ENABLE_CRYPTO_POLARSSL], [1], [Use PolarSSL library])
 		;;
-- 
1.7.5.4


