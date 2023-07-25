From: Antonio Quartulli <a@...2181...>
Date: Tue, 25 Jul 2023 08:58:40 +0200
Message-ID: <20230725065840.24568-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] configure.ac: fix typ0 in LIBCAPNG_CFALGS
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
Cc: Antonio Quartulli <a@...2181...>, Matt Whitlock <gentoo@...2743...>

Reported-by: Matt Whitlock <gentoo@...2743...>
Change-Id: Ic473fbc447741e54a9aac83c70bc4e6d87d91080
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 5ab1d0df..2f65cbd5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -869,7 +869,7 @@ case "$host" in
 		)
 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not found!])])
 
-		CFLAGS="${CFLAGS} ${LIBCAPNG_CFALGS}"
+		CFLAGS="${CFLAGS} ${LIBCAPNG_CFLAGS}"
 		LIBS="${LIBS} ${LIBCAPNG_LIBS}"
 		AC_DEFINE(HAVE_LIBCAPNG, 1, [Enable libcap-ng support])
 	;;
-- 
2.41.0


