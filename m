From: Davide Brini <dave_br@...1278...>
Date: Wed, 28 Apr 2010 20:53:51 +0100
Message-Id: <1272484431-14512-1-git-send-email-dave_br@...1278...>
Subject: [Openvpn-devel] [PATCH] OCSP_check.sh: new check logic
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

contrib/OCSP_check/OCSP_check.sh:
  I discovered that, quite surprisingly, the exit status of "openssl ocsp"
  is 0 even if the certificate status is "revoked". This means that the
  logic of the script needs to be rewritten so that it parses the output
  returned by the query and explicitly looks for a

  "0x<serial number>: good"

  line, and exit if either the command has a non-zero exit status, or the
  above line is not found.

  Doing that portably without bashisms requires some juggling around, so
  perhaps the code is slightly less clean now, but it does have many
  comments.

Signed-off-by: Davide Brini <dave_br@...1278...>
---
 contrib/OCSP_check/OCSP_check.sh |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_check.sh
index 2ffe5d6..bec70e1 100644
--- a/contrib/OCSP_check/OCSP_check.sh
+++ b/contrib/OCSP_check/OCSP_check.sh
@@ -63,27 +63,43 @@ fi
 
 # begin
 if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
+
   eval serial="\$tls_serial_${cur_depth}"
 
-  # Check that the serial is not empty
+  # To successfully complete, the following must happen:
+  #
+  # - The serial number must not be empty
+  # - The exit status of "openssl ocsp" must be zero
+  # - The output of the above command must contain the line
+  #   "0x${serial}: good"
+  #
+  # Everything else fails with exit status 1.
+
   if [ -n "$serial" ]; then
 
     # This is only an example; you are encouraged to run this command (without
     # redirections) manually against your or your CA's OCSP server to see how
     # it responds, and adapt accordingly.
-    # Sample output:
+    # Sample output that is assumed here:
     #
     # Response verify OK
     # 0x428740A5: good
     #      This Update: Apr 24 19:38:49 2010 GMT
     #      Next Update: May  2 14:23:42 2010 GMT
 
-    openssl ocsp -issuer "$issuer" \
-                 "$nonce" \
-                 -CAfile "$verify" \
-                 -url "$ocsp_url" \
-                 -serial "0x${serial}" >/dev/null 2>&1
-  else
-    exit 1
+    status=$(openssl ocsp -issuer "$issuer" \
+                    "$nonce" \
+                    -CAfile "$verify" \
+                    -url "$ocsp_url" \
+                    -serial "0x${serial}" 2>/dev/null)
+
+    if [ $? -eq 0 ]; then
+      # check that it's good
+      if echo "$status" | grep -Fq "0x${serial}: good"; then
+        exit 0
+      fi
+    fi
   fi
+  # if we get here, something was wrong
+  exit 1
 fi
-- 
1.6.5.6


