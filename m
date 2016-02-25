From: Steffan Karger <steffan@...1856...>
Date: Thu, 25 Feb 2016 15:10:34 +0100
Message-Id: <1456409434-14784-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix OCSP_check.sh
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

As reported in trac #582, the OCSP_check.sh script should use grep -E,
instead of grep -F when it uses ^ in the expression.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 contrib/OCSP_check/OCSP_check.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_check.sh
index 6876c6d..2675788 100644
--- a/contrib/OCSP_check/OCSP_check.sh
+++ b/contrib/OCSP_check/OCSP_check.sh
@@ -105,9 +105,9 @@ if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
           exit 1
       fi
       # check that the reported status of certificate is ok
-      if echo "$status" | grep -Fq "^${serial}: good"; then
+      if echo "$status" | grep -Eq "^${serial}: good"; then
         # check if signature on the OCSP response verified correctly
-        if echo "$status" | grep -Fq "^Response verify OK"; then
+        if echo "$status" | grep -Eq "^Response verify OK"; then
             exit 0
         fi
       fi
-- 
2.5.0


