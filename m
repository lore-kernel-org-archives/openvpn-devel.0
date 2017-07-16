From: Antonio Quartulli <a@...2181...>
Date: Sun, 16 Jul 2017 19:58:00 +0800
Message-Id: <20170716115800.26792-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH openvpn-build] add support for aarch64
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
Cc: =?UTF-8?q?Samuli=20Sepp=C3=A4nen?= <samuli.seppanen@...277...>, Antonio Quartulli <a@...2181...>

arm64 is a new platform that is slowly getting its momentum.
Add support for it in the script detecting the openssl target

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 generic/gentoo.config-0.9.8 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/generic/gentoo.config-0.9.8 b/generic/gentoo.config-0.9.8
index 7051886..e5d41bf 100755
--- a/generic/gentoo.config-0.9.8
+++ b/generic/gentoo.config-0.9.8
@@ -40,6 +40,7 @@ if [ "$1" = "test" ] ; then
 		"hppa64-aldsF-linux-gnu5.3    |linux-generic32 -DB_ENDIAN" \
 		"powerpc-gentOO-linux-uclibc  |linux-ppc" \
 		"powerpc64-unk-linux-gnu      |linux-ppc64" \
+		"aarch64-unknown-linux-gnu    |linux-aarch64" \
 	;do
 		CHOST=${c/|*}
 		ret_want=${c/*|}
@@ -62,6 +63,7 @@ fi
 case "${CHOST}" in
 	i*86-*-mingw*|i*86-mingw*|mingw*)	system="mingw";;
 	x86_64-*-mingw*)	system="mingw64";;
+	aarch64-*-linux-*)	system="linux-aarch64";;
 	*-linux*)		system="linux";;
 	*-freebsd*)		system="BSD";;
 	*-solaris*)
-- 
2.13.3


