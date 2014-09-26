From: Hubert Kario <hkario@...1347...>
Date: Fri, 26 Sep 2014 12:24:00 +0200
Message-Id: <1411727041-11884-1-git-send-email-hkario@...1347...>
Subject: [Openvpn-devel] [PATCH 1/2] ocsp_check - signature verification and
	cert staus results are separate
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

when openssl returns result of parsing and verification of the
OCSP response, the signature verification is separate from the certificate
status, as such it's necessary to check both of them.

Otherwise results like:

Response Verify Failure
140170966779776:error:27069076:OCSP routines:OCSP_basic_verify:signer certificate not found:ocsp_vfy.c:85:
ca/cert.pem: good
        This Update: Sep 23 12:12:28 2014 GMT

will be accepted as being trustworthy.

Note that "Response verify OK" is printed on stderr, so it can't
be discarded.

Signed-off-by: Hubert Kario <hkario@...1347...>
---
 contrib/OCSP_check/OCSP_check.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_check.sh
index 553c3dc..ce7ec04 100644
--- a/contrib/OCSP_check/OCSP_check.sh
+++ b/contrib/OCSP_check/OCSP_check.sh
@@ -97,12 +97,15 @@ if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
                     "$nonce" \
                     -CAfile "$verify" \
                     -url "$ocsp_url" \
-                    -serial "${serial}" 2>/dev/null)
+                    -serial "${serial}" 2>&1)
 
     if [ $? -eq 0 ]; then
-      # check that it's good
+      # check that the reported status of certificate is ok
       if echo "$status" | grep -Fq "^${serial}: good"; then
-        exit 0
+        # check if signature on the OCSP response verified correctly
+        if echo "$status" | grep -Fq "^Response verify OK"; then
+            exit 0
+        fi
       fi
     fi
   fi
-- 
1.9.3


