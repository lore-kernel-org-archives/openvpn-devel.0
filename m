From: Arne Schwabe <arne@...1227...>
Date: Fri, 28 Mar 2014 11:07:01 +0100
Message-Id: <1396001222-5033-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix man page and OSCP script:
	tls_serial_{n} is decimal
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

Commit 7d5e26cbb53 fixed extracting serial but did not change the format,
which always has been decimal. This patch fixes the manpage and
OSCP.sh script to conform with the implementation.
---
 contrib/OCSP_check/OCSP_check.sh | 2 +-
 doc/openvpn.8                    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/OCSP_check/OCSP_check.sh b/contrib/OCSP_check/OCSP_check.sh
index 847be45..7e9e1e8 100644
--- a/contrib/OCSP_check/OCSP_check.sh
+++ b/contrib/OCSP_check/OCSP_check.sh
@@ -97,7 +97,7 @@ if [ $check_depth -eq -1 ] || [ $cur_depth -eq $check_depth ]; then
                     "$nonce" \
                     -CAfile "$verify" \
                     -url "$ocsp_url" \
-                    -serial "0x${serial}" 2>/dev/null)
+                    -serial "${serial}" 2>/dev/null)
 
     if [ $? -eq 0 ]; then
       # check that it's good
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3a58317..6dc3f87 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -6080,9 +6080,9 @@ where
 is the verification level.  Only set for TLS connections.  Set prior
 to execution of
 .B \-\-tls-verify
-script. This is in the form of a hex string like "37AB46E0", which is
-suitable for doing serial-based OCSP queries (with OpenSSL, you have
-to prepend "0x" to the string). If something goes wrong while reading
+script. This is in the form of a decimal string like "933971680", which is
+suitable for doing serial-based OCSP queries (with OpenSSL, do not
+prepend "0x" to the string) If something goes wrong while reading
 the value from the certificate it will be an empty string, so your
 code should check that.
 See the contrib/OCSP_check/OCSP_check.sh script for an example.
-- 
1.8.5.2 (Apple Git-48)


