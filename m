From: Antonio Quartulli <a@...2181...>
Date: Sun, 16 Jul 2017 18:47:14 +0800
Message-Id: <20170716104714.2113-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH openvpn-build] fix test when white space is
 present
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

For some CHOST ret_want and ret_got may contain a whitespace.
Add double quotes around ret_want to avoid messing up the test.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 generic/gentoo.config-0.9.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/generic/gentoo.config-0.9.8 b/generic/gentoo.config-0.9.8
index 2361ae6..7051886 100755
--- a/generic/gentoo.config-0.9.8
+++ b/generic/gentoo.config-0.9.8
@@ -45,7 +45,7 @@ if [ "$1" = "test" ] ; then
 		ret_want=${c/*|}
 		ret_got=$(CHOST=${CHOST} "$0")
 
-		if [ ${ret_want} = "${ret_got}" ] ; then
+		if [ "${ret_want}" = "${ret_got}" ] ; then
 			echo "PASS: ${CHOST}"
 		else
 			echo "FAIL: ${CHOST}"
-- 
2.13.3


