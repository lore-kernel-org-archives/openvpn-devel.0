From: Hubert Kario <hkario@...1347...>
Date: Fri, 26 Sep 2014 12:24:01 +0200
Message-Id: <1411727041-11884-2-git-send-email-hkario@...1347...>
In-Reply-To: <1411727041-11884-1-git-send-email-hkario@...1347...>
References: <1411727041-11884-1-git-send-email-hkario@...1347...>
Subject: [Openvpn-devel] [PATCH 2/2] ocsp_check - double check if ocsp
	didn't report any errors in execution
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

in case the reposnses are too old, ocsp tool can return text like this:

Response verify OK
ca/cert.pem: WARNING: Status times invalid.
139990703290240:error:2707307D:OCSP routines:OCSP_check_validity:status expired:ocsp_cl.c:358:
good
        This Update: Sep 21 12:12:48 2014 GMT
        Next Update: Sep 22 12:12:48 2014 GMT

light change in buffering can cause "verify OK" and "ca/cert.pem: good"
to be placed in a way that matching will be valid
---
 contrib/OCSP_check/OCSP_check.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_check.sh
index ce7ec04..6876c6d 100644
--- a/contrib/OCSP_check/OCSP_check.sh
+++ b/contrib/OCSP_check/OCSP_check.sh
@@ -100,6 +100,10 @@ if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
                     -serial "${serial}" 2>&1)
 
     if [ $? -eq 0 ]; then
+      # check if ocsp didn't report any errors
+      if echo "$status" | grep -Eq "(error|fail)"; then
+          exit 1
+      fi
       # check that the reported status of certificate is ok
       if echo "$status" | grep -Fq "^${serial}: good"; then
         # check if signature on the OCSP response verified correctly
-- 
1.9.3


