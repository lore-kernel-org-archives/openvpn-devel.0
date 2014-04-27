From: Steffan Karger <steffan@...1856...>
Date: Sun, 27 Apr 2014 10:49:21 +0200
Message-Id: <1398588561-18964-2-git-send-email-steffan@...1856...>
In-Reply-To: <1398588561-18964-1-git-send-email-steffan@...1856...>
References: <1398588561-18964-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] Fix OCSP_check.sh to also use decimal
	for stdout verification.
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

This is an extra fix needed on top of 959d607, which already changes the
serial parameter to correctly use decimal representation.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 contrib/OCSP_check/OCSP_check.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_check.sh
index 7e9e1e8..553c3dc 100644
--- a/contrib/OCSP_check/OCSP_check.sh
+++ b/contrib/OCSP_check/OCSP_check.sh
@@ -71,7 +71,7 @@ if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
   # - The serial number must not be empty
   # - The exit status of "openssl ocsp" must be zero
   # - The output of the above command must contain the line
-  #   "0x${serial}: good"
+  #   "${serial}: good"
   #
   # Everything else fails with exit status 1.
 
@@ -83,7 +83,7 @@ if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
     # Sample output that is assumed here:
     #
     # Response verify OK
-    # 0x428740A5: good
+    # 4287405: good
     #      This Update: Apr 24 19:38:49 2010 GMT
     #      Next Update: May  2 14:23:42 2010 GMT
     #
@@ -101,7 +101,7 @@ if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
 
     if [ $? -eq 0 ]; then
       # check that it's good
-      if echo "$status" | grep -Fq "0x${serial}: good"; then
+      if echo "$status" | grep -Fq "^${serial}: good"; then
         exit 0
       fi
     fi
-- 
1.8.3.2


